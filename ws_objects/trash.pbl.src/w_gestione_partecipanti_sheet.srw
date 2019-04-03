$PBExportHeader$w_gestione_partecipanti_sheet.srw
forward
global type w_gestione_partecipanti_sheet from w_gestione_archivio_sheet
end type
type dw_ricerca from datawindow within w_gestione_partecipanti_sheet
end type
type gb_ricerca from groupbox within w_gestione_partecipanti_sheet
end type
end forward

global type w_gestione_partecipanti_sheet from w_gestione_archivio_sheet
integer width = 4261
integer height = 2808
string title = "Gestione partecipanti"
string menuname = "m_gestione_partecipanti_sheet"
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event type long ue_insert_esterni ( )
event ue_reset ( )
event type integer ue_ricerca_membri ( )
dw_ricerca dw_ricerca
gb_ricerca gb_ricerca
end type
global w_gestione_partecipanti_sheet w_gestione_partecipanti_sheet

type variables
boolean ib_partecipante_esterno= false
dataWindowChild dwc_posti_bus_a, dwc_posti_bus_r
string is_corso, is_turno

integer ii_status

long il_codice_part
end variables

event ue_insert_esterni;ib_partecipante_esterno= true

gb_ricerca.visible= false
dw_ricerca.visible= false

long ll_row

ll_row= dw_current.insertRow(0)

dw_current.enabled= true

dw_current.Object.DataWindow.ReadOnly="No"

dw_current.setFocus()

return ll_row
end event

event ue_reset;call super::clicked
dw_ricerca.Object.DataWindow.QueryMode = "no"
dw_ricerca.reset()
gb_ricerca.visible= false
dw_ricerca.visible= false

m_gestione_partecipanti_sheet.m_gestionearchivio.m_inserimentopartecipantiesterni.enabled= true

ib_partecipante_esterno= false

ii_status= IDLE

end event

event ue_ricerca_membri;integer li_ret

ib_dbcancel= false

dw_ricerca.setTransObject(sqlca_src)

retry: 
if  dw_ricerca.Object.DataWindow.QueryMode= 'no' then
	dw_ricerca.setRedraw(false)
	dw_ricerca.reset()
	dw_ricerca.Object.DataWindow.QueryClear= 'yes'
	dw_ricerca.Object.DataWindow.QueryMode= 'yes'
	dw_ricerca.setRedraw(true)
	dw_ricerca.setFocus()
	return 0
else
	long ll_rows
	dw_ricerca.acceptText()
	dw_ricerca.Object.DataWindow.QueryMode= 'no'
	
	open(w_wait_annulla)
	
	ll_rows= dw_ricerca.retrieve()
	
	close(w_wait_annulla)
	
		if  ll_rows= 0 then
			messageBox(this.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
			goto retry
		end if
		
		return 0
end if

end event

on w_gestione_partecipanti_sheet.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_gestione_partecipanti_sheet" then this.MenuID = create m_gestione_partecipanti_sheet
this.dw_ricerca=create dw_ricerca
this.gb_ricerca=create gb_ricerca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ricerca
this.Control[iCurrent+2]=this.gb_ricerca
end on

on w_gestione_partecipanti_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_ricerca)
destroy(this.gb_ricerca)
end on

event ue_insertend;call super::ue_insertend;dw_current.Object.DataWindow.ReadOnly="Yes"

dw_ricerca.Object.DataWindow.QueryClear = "yes"
dw_ricerca.Object.DataWindow.QueryMode = "yes"
gb_ricerca.visible= true
dw_ricerca.visible= true
dw_ricerca.enabled= true
dw_ricerca.reset()

dw_ricerca.setRow(1)
dw_ricerca.setFocus()

return 0

end event

event ue_myretrieve;return dw_current.retrieve(gs_corsocorrente)
end event

event open;call super::open;integer li_ret
string ls_where
	
is_corso= mid(gs_corsocorrente, 1, 6)
is_turno= mid(gs_corsocorrente, 7, 10)

dw_current.setTransObject(sqlca)

dw_ricerca.setTransObject(sqlca_src)
end event

event resize;dw_current.x= (this.workSpaceWidth()/2 - dw_current.width/2) -36

gb_ricerca.x=  this.workSpaceWidth()/2 - gb_ricerca.width/2

dw_ricerca.x= this.workSpaceWidth()/2 - dw_ricerca.width/2

gb_ricerca.height= this.height - gb_ricerca.y - 180

dw_ricerca.height= this.height - dw_ricerca.y - 200
end event

event ue_actionend;call super::ue_actionend;if ab_search= false then
	dw_current.Object.DataWindow.ReadOnly="No"
	ii_status= SEARCHING
end if
return 0
end event

event ue_queryon;call super::ue_queryon;dw_current.enabled= true
dw_current.setFocus()
return 0
end event

event ue_update;call super::ue_update;long li_ret

li_ret= ancestorreturnvalue

if li_ret = -1 then goto skippa // Manca un dato obbligatorio o un dato con formato errato...

if li_ret = -2 then goto skippa // Un errore nell'update...

this.setRedraw(false)

//dw_current.reset()

if ii_status= DELETING or ii_status= SEARCHING then goto skippa

if ib_partecipante_esterno= false then
	event  ue_insert()
else
	event  ue_insert_esterni()
end if

ii_status= IDLE

skippa: this.setRedraw(true)

return li_ret
end event

event ue_delete;il_codice_part=  dw_current.getItemNumber(dw_current.getRow(), "codice_part")

ii_status= DELETING

// ritorna 	1 se la cancellazione è andata a buon fine, 
// 			0 se c.s. + se non ci sono altre righe da cancellare, 
// 		    -1 se la cancellazione non è andata a buon fine.
integer li_ret
li_ret= dw_current.deleteRow(0)
if li_ret < 0 then return -1
if dw_current.rowCount()= 0 then
	return 0
else
	return 1
end if
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_gestione_partecipanti_sheet
event type integer ue_insert_esterni ( )
integer x = 18
integer y = 4
integer width = 3712
integer height = 1580
string dataobject = "dw_gestione_partecipanti"
boolean border = false
boolean hsplitscroll = false
borderstyle borderstyle = stylebox!
end type

event updatestart;call super::updatestart;dw_ricerca.enabled= false

if ii_status= DELETING then
	
	update stanze
	set codice_part= null, flg_man= 'N'
	where codice_part= :il_codice_part;
	if trap_sql(sqlca, "UPDSTART01") < 0 then return -1
	
	update posti_bus_a
	set codice_part= null, flag_man= 'N'
	where codice_part= :il_codice_part;
	if trap_sql(sqlca, "UPDSTART02") < 0 then return -1
	
	update posti_bus_r
	set codice_part= null, flag_man= 'N'
	where codice_part= :il_codice_part;
	if trap_sql(sqlca, "UPDSTART03") < 0 then return -1
	
	return 0 // sto cancellando un record e non devo aggiornare i campi...
	
end if

//long ll_codice_part
//
//ll_codice_part= this.getItemNumber(dw_current.getRow(), "codice_part")

if  this.getItemNumber(dw_current.getRow(), "codice_part")= 0 then
	
	long ll_code
	
	SELECT contatore_partecipanti
	  INTO :ll_code
	  FROM turni HOLDLOCK
	 WHERE cod_corso = :is_corso and
	 			cod_turno= :is_turno;
	if trap_sql(sqlca, "COUNTER01") < 0 then return -1
	 
	 if IsNull ( ll_code ) or ll_code= 0 then
		ll_code = 1
	else
		ll_code += 1
	end if
	
	dw_current.setItem(dw_current.getRow(), "cod_corso", mid(gs_corsocorrente, 1, 6))
	dw_current.setItem(dw_current.getRow(), "cod_turno", mid(gs_corsocorrente, 7, 10))
	
	dw_current.SetItem ( dw_current.getRow(), "codice_part", ll_code )
	
	update turni set contatore_partecipanti= :ll_code
		 where cod_corso = :is_corso and
	 				cod_turno= :is_turno;
	if trap_sql(sqlca, "COUNTER02") < 0 then return -1 
	
//else
	
//	update stanze
//	set codice_part= null, flg_man= null
//	where codice_part= :ll_codice_part;
//	if trap_sql(sqlca, "UPDSTART01") < 0 then return -1
//	
//	update posti_bus_a
//	set codice_part= null, flag_man= null
//	where codice_part= :ll_codice_part;
//	if trap_sql(sqlca, "UPDSTART02") < 0 then return -1
//	
//	update posti_bus_r
//	set codice_part= null, flag_man= null
//	where codice_part= :ll_codice_part;
//	if trap_sql(sqlca, "UPDSTART03") < 0 then return -1
	
end if
end event
event dw_current::itemchanged;call super::itemchanged;if dwo.name= "cod_div" then
	if mod(integer(data), 2)= 0 then
		this.setItem(row, "sesso", 'F')
	else
		this.setItem(row, "sesso", 'M')
	end if
end if
end event

event dw_current::retrieveend;call super::retrieveend;if rowCount > 1 then // visualizza una grid con alcuni dati dei partecipanti registrati che rientrano nei criteri di ricerca...

	messageBox(parent.title, "Attenzione: sono stati estratti "+string(rowCount)+ " partecipanti che rispondono ai criteri di ricerca impostati."+&
										"~nVerificare quale dei " +string(rowCount)+ " è quello di interesse o ripetere la ricerca con più elementi.")
	return 0
	
end if

end event

event dw_current::scrollvertical;call super::scrollvertical;this.scrollToRow(long(this.Object.dataWindow.FirstRowOnPage))
end event

event dw_current::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)

if sqltype= PreviewSelect! then sqlsyntax +=  " and  partecipanti.cod_corso= '"+is_corso+"' and partecipanti.cod_turno= '"+is_turno+"'"

SetSqlPreview ( sqlsyntax)
end event

type dw_ricerca from datawindow within w_gestione_partecipanti_sheet
boolean visible = false
integer x = 50
integer y = 1636
integer width = 3712
integer height = 840
integer taborder = 20
boolean enabled = false
string title = "none"
string dataobject = "dw_ricerca_segreteria"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_ricerca, false)

SetSqlPreview ( sqlsyntax)
end event

event rowfocuschanged;f_select_current_row (this)
end event

event dw_ricerca::doubleclicked;call super::doubleclicked;call super::doubleclicked;long ll_row, ll_codice_membro, ll_quanti
string ls_att, ls_cod_dip

if row <= 0 then return 0

ll_codice_membro= this.getItemNumber(row, "codice_membro")
ls_cod_dip=  this.getItemString(row, "cod_dip")

select Count(*)
into :ll_quanti
from partecipanti
where codice_membro= :ll_codice_membro and
			cod_dip= :ls_cod_dip and
			cod_corso+cod_turno= :gs_corsocorrente;
if trap_sql(sqlca, "DOUBLECLICK01") <  0 then return -1

if isNull(ll_quanti) then ll_quanti= 0

if ll_quanti > 0 then
	messageBox(parent.title, "Il partecipante "+this.getItemString(row, "cognome")+" "+this.getItemString(row, "nome")+" è già stato inserito.")
	return 0
end if

ll_row = dw_current.GetRow ( )
dw_current.SetItem ( ll_row, "cognome", this.getItemString(row, "cognome") )
dw_current.SetItem ( ll_row, "nome", this.getItemString(row, "nome") )
dw_current.SetItem ( ll_row, "data_nasc", this.getItemDateTime(row, "data_nas") )
dw_current.SetItem ( ll_row, "cod_div", this.getItemString(row, "cod_div") )
dw_current.SetItem ( ll_row, "codice_membro", this.getItemNumber(row, "codice_membro") )
dw_current.SetItem ( ll_row, "cod_dip", this.getItemString(row, "cod_dip") )

if mod(integer(this.getItemString(row, "cod_div")), 2)= 0 then
		dw_current.setItem(ll_row, "sesso", 'F')
	else
		dw_current.setItem(ll_row, "sesso", 'M')
end if

choose case mid( this.getItemString(row, "cod_att_ist_1"), 1, 1) 
	case '0'
		ls_att= '0'
	case '1'
		ls_att= '07'
	case '2'
		ls_att= '06'
	case '3'
		ls_att= '05'
	case '4'
		ls_att= '04'
	case '5'
		ls_att= '03'
	case '6'
		ls_att= '02'
	case '7'
		ls_att= '01'
	case '8'
		ls_att= '08'
end choose

dw_current.SetItem ( ll_row, "posizione", ls_att )

dw_current.setItem(ll_row, "cod_corso", mid(gs_corsocorrente, 1, 6))
dw_current.setItem(ll_row, "cod_turno", mid(gs_corsocorrente, 7, 10))
dw_current.SetItem ( ll_row, "indirizzo", this.getItemString(row, "ind_dom") )
dw_current.SetItem ( ll_row, "cap", this.getItemString(row, "cap_dom") )
dw_current.SetItem ( ll_row, "citta", this.getItemString(row, "comune") )
dw_current.SetItem ( ll_row, "prov", this.getItemString(row, "provincia") )
dw_current.SetItem ( ll_row, "tel_1", this.getItemString(row, "num_tel") )
dw_current.SetItem ( ll_row, "tel_2", this.getItemString(row, "num_tel_2") )
dw_current.SetItem ( ll_row, "sigla_org", this.getItemString(row, "sigla_org") )

m_gestione_partecipanti_sheet.m_gestionearchivio.m_salva.enabled= true

dw_current.Object.DataWindow.ReadOnly="No"

dw_current.setFocus()

return 0
end event

event retrieverow;if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

event editchanged;m_gestione_partecipanti_sheet.m_gestionearchivio.m_ricercamembri.enabled= true
end event

type gb_ricerca from groupbox within w_gestione_partecipanti_sheet
boolean visible = false
integer x = 32
integer y = 1572
integer width = 3767
integer height = 980
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Ricerca in DB segreteria"
borderstyle borderstyle = stylelowered!
end type

