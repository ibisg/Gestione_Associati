$PBExportHeader$w_esami.srw
forward
global type w_esami from window
end type
type cbx_filtra_datacerimonia from checkbox within w_esami
end type
type cbx_filtra_dataesame from checkbox within w_esami
end type
type em_filtra_datacerimonia from editmask within w_esami
end type
type cb_annullafiltro from commandbutton within w_esami
end type
type cb_filtra from commandbutton within w_esami
end type
type em_filtra_dataesame from editmask within w_esami
end type
type st_1 from statictext within w_esami
end type
type cb_crea from commandbutton within w_esami
end type
type sle_data from singlelineedit within w_esami
end type
type dw_liv from datawindow within w_esami
end type
type cb_annulla from commandbutton within w_esami
end type
type cb_save from commandbutton within w_esami
end type
type cb_estrai from commandbutton within w_esami
end type
type st_30 from statictext within w_esami
end type
type st_31 from statictext within w_esami
end type
type st_26 from statictext within w_esami
end type
type sle_loc from uo_sle_gen within w_esami
end type
type gb_cer from groupbox within w_esami
end type
type dw_elenco from uo_dwselect within w_esami
end type
type gb_dett from groupbox within w_esami
end type
type s_cons from structure within w_esami
end type
end forward

type s_cons from structure
	string		v_codice
	string		v_nomin
	string		v_loc
	datetime		v_data
	string		v_citta
	string		v_turno
	string		v_causale
	string		v_tipo_goh
end type

global type w_esami from window
integer x = 5
integer y = 4
integer width = 4320
integer height = 2356
boolean titlebar = true
string title = "Esami di studio"
string menuname = "m_esami"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event uscita ( )
event clear ( string ls_from )
event type integer save ( )
event search_ses ( )
event query_on ( )
event query_off ( )
event query_start ( )
event ordina ( )
event importa ( )
event stampa ( )
event type integer ue_salva_come ( )
cbx_filtra_datacerimonia cbx_filtra_datacerimonia
cbx_filtra_dataesame cbx_filtra_dataesame
em_filtra_datacerimonia em_filtra_datacerimonia
cb_annullafiltro cb_annullafiltro
cb_filtra cb_filtra
em_filtra_dataesame em_filtra_dataesame
st_1 st_1
cb_crea cb_crea
sle_data sle_data
dw_liv dw_liv
cb_annulla cb_annulla
cb_save cb_save
cb_estrai cb_estrai
st_30 st_30
st_31 st_31
st_26 st_26
sle_loc sle_loc
gb_cer gb_cer
dw_elenco dw_elenco
gb_dett gb_dett
end type
global w_esami w_esami

type variables
boolean ib_closing = false
boolean calling = false

s_esami str_es
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status

DataWindowChild idwc_liv
DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru

end variables

forward prototypes
public function integer f_canc_lista ()
public function string dw_status ()
public function integer query_mode ()
public function integer dw_retrieve ()
public subroutine f_header (integer li_operation)
end prototypes

event ue_open;dw_liv.InsertRow ( 0 )
dw_liv.GetChild ( "esame", idwc_liv )
idwc_liv.SetTransObject ( sqlca )
idwc_liv.Retrieve ( )

SetNull ( str_es.v_data )
SetNull ( str_es.v_sede )
SetNull ( str_es.v_liv )

dw_elenco.SetTransObject ( sqlca )

sle_data.SetFocus ( )

end event

event uscita;ib_closing = true

close ( this )

end event

event clear(string ls_from);if dw_elenco.DataObject = "d_lista" then

	int li_ret
	
	dw_elenco.AcceptText ( )
	
	if dw_elenco.ModifiedCount ( ) > 0 then
		
		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
									 question!, YesNoCancel!, 1 )
																					
		choose case li_ret
				
			case 1
				
				if event save ( ) = -1 then return
				
			case 2
				
			case 3
				
				return
				
		end choose
		
	end if
	
end if

dw_elenco.SetRedraw ( false )
dw_elenco.DataObject = "d_lista"
dw_elenco.SetTransObject ( sqlca )
SetRedraw ( dw_elenco, true )

dw_elenco.visible = false

cb_estrai.visible = false
cb_save.visible = false
cb_annulla.visible = false

cb_estrai.enabled = false
cb_save.enabled = false
cb_annulla.enabled = false

cbx_filtra_dataesame.visible= false
cbx_filtra_datacerimonia.visible= false

em_filtra_dataesame.visible= false
em_filtra_datacerimonia.visible= false
cb_filtra.visible= false
cb_annullafiltro.visible= false

//cb_estrai.text = ""
//cb_save.text = ""
//cb_annulla.text = ""

cb_estrai.visible= false
cb_save.visible= false
cb_annulla.visible= false

cb_crea.enabled= false

m_esami.m_opzioni.m_sessione.enabled = true
m_esami.m_opzioni.m_ordina.enabled = false
m_esami.m_opzioni.m_stampa.enabled = false
m_esami.m_opzioni.m_salvacome.enabled = false

sle_data.enabled = true
sle_loc.enabled = true
dw_liv.enabled = true

sle_data.text = ""
sle_loc.text = ""

dw_liv.SetRedraw ( false )
dw_liv.Reset ( )
dw_liv.InsertRow ( 0 )
dw_liv.SetRedraw ( true )

SetNull ( str_es.v_data )
SetNull ( str_es.v_sede )
SetNull ( str_es.v_liv )
SetNull ( status )

sle_data.SetFocus ( )

gb_dett.text = ""

end event

event save;dw_elenco.SetRedraw ( false )

if dw_elenco.Update ( ) = -1 then
	
	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
		halt close
	end if
	
	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	
	OpenWithParm ( w_msgauto, "Modifiche annullate" )
	
	dw_elenco.SetRedraw ( true )
	
	return -1
	
else
	
	commit;
	
	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
		halt close
	end if

	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
	
	dw_elenco.SetRedraw ( true )
	
	cb_save.enabled = false
	
end if

return 0

end event

event search_ses;long ll_rows

select count ( * )
into :ll_rows
from esami;

if trap_sql ( sqlca, "controllo liste" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	close ( this )
	return
end if

if ll_rows = 0 then 
	MessageBox ( "Esami", "Nessuna lista impostata..." )
	return
end if

OpenWithParm ( w_sel_sessione, "esami" )

if message.DoubleParm = -1 then return

choose case str_es.v_liv
		
	case "01"
		
		SetNull ( is_liv )
		
	case "02"
		
		is_liv = "01"
		
	case "03"
		
		is_liv = "02"
		
	case "04"
		
		is_liv = "03"
		
	case "05"
		
		is_liv = "04"
		
end choose

f_header ( 1 ) // 1 significa che deve estrarre dati già inseriti

end event

event query_on;int li_colnum
string ls_colname, ls_null

dw_elenco.SetRedraw ( false )

//for li_colnum = 3 to 10
//	
//	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
//	dw_elenco.Modify(ls_colname+".Protect=0")
//
//next

dw_elenco.modify ( "flag_ok.visible=0" )
dw_elenco.modify ( "conf_t.visible=0" )
//dw_elenco.Modify ( "DataWindow.Footer.Height='1'" )

query_mode ( )

dw_elenco.SetRedraw ( true )

dw_elenco.SetFocus ( )

cb_estrai.text = "&Estrai"
cb_save.enabled = false
if status = "crea" then cb_annulla.enabled = false

m_esami.m_opzioni.m_ordina.enabled = false
m_esami.m_opzioni.m_stampa.enabled = false
m_esami.m_opzioni.m_salvacome.enabled = false

end event

event query_off;int li_colnum
string ls_colname

if dw_retrieve ( ) = 0 then
	
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	
	return
	
end if

dw_elenco.SetRedraw ( false )

if dw_elenco.RowCount ( ) > 0 then
	
	for li_colnum = 3 to 10
		
		ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
		dw_elenco.Modify(ls_colname+".Protect=1")
		
	next
	
	dw_elenco.modify ( "flag_ok.visible=1" )
	dw_elenco.modify ( "conf_t.visible=1" )
//	dw_elenco.Modify ( "DataWindow.Footer.Height='92'" )
	
end if

dw_elenco.SetRedraw ( true )
dw_elenco.setFocus ( )

cb_estrai.text = "&Cerca"
cb_save.enabled = true
if status = "crea" then cb_annulla.visible = false

m_esami.m_opzioni.m_ordina.enabled = true
m_esami.m_opzioni.m_stampa.enabled = true
m_esami.m_opzioni.m_salvacome.enabled = true

end event

event query_start;if dw_status ( ) = 'no' then
	TriggerEvent ( "query_on" )
else
	TriggerEvent ( "query_off" )
end if

end event

event ordina;OpenWithParm ( w_ordina, dw_elenco )
dw_elenco.SetSort ( message.StringParm )
dw_elenco.Sort ( )

end event

event importa;long ll_rows, ll_count, ll_row

ds_lista = create uo_ds_gen
ds_lista.DataObject = "ds_lista"
ds_lista.SetTransObject ( sqlca )

ll_rows = dw_elenco.RowCount ( )

for ll_count = 1 to ll_rows
	
	if dw_elenco.GetItemString ( ll_count, "flag_ok" ) = "S" then
	
		ds_lista.InsertRow ( 0 )
		ll_row = ds_lista.RowCount ( )
		
		ds_lista.SetItem ( ll_row, "codice_membro", dw_elenco.GetItemNumber ( ll_count, "codice_membro" ) )
		ds_lista.SetItem ( ll_row, "cod_dip", dw_elenco.GetItemString ( ll_count, "cod_dip" ) )
		ds_lista.SetItem ( ll_row, "data_esame", str_es.v_data )
		ds_lista.SetItem ( ll_row, "sede", str_es.v_sede )
		ds_lista.SetItem ( ll_row, "cod_studio", str_es.v_liv )
		ds_lista.SetItem ( ll_row, "esito", "A" )
		ds_lista.SetItem ( ll_row, "flag_ok", "S" )
		
	end if
	
next

if ds_lista.Update ( ) = -1 then
	
	rollback;
	ds_lista.reset ( )
	destroy ds_lista
	OpenWithParm ( w_msgauto, "Importazione annullata" )
	
	return
	
end if

commit;

ds_lista.reset ( )
destroy ds_lista

OpenWithParm ( w_msgauto, "Importazione effettuata" )

status = "modifica"

dw_elenco.SetRedraw ( false )
dw_elenco.DataObject = "d_lista"
dw_elenco.SetTransObject ( sqlca )
dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv )

dw_elenco.SetRedraw ( true )

gb_dett.text = " Lista candidati "

cb_estrai.text = "Aggiorna lista"
cb_save.enabled = false
cb_annulla.text = "Cancella lista"
cb_annulla.enabled = true

m_esami.m_opzioni.m_stampa.enabled = true
m_esami.m_opzioni.m_salvacome.enabled = true

return

end event

event stampa;dw_elenco.SetRedraw ( false )
//dw_elenco.Object.n_pag.visible = 1
//dw_elenco.Object.DataWindow.Footer.Height = 165

OpenWithParm ( w_dw_print_options, this.dw_elenco )

//dw_elenco.Object.n_pag.visible = 0
//dw_elenco.Object.DataWindow.Footer.Height = 85
dw_elenco.SetRedraw ( true )

end event

event ue_salva_come;int li_colnum
string ls_colname, ls_msg

open ( w_aut_print )

if Message.DoubleParm = -1 then return -1

ls_msg = "Salvato su file per " + Message.StringParm

if dw_elenco.SaveAs()= -1 then return -1

f_log ( gs_context, ls_msg )

return 0
end event

public function integer f_canc_lista ();open ( w_wait )

delete from esami
 where data_esame = :str_es.v_data
	and sede = :str_es.v_sede
	and cod_studio = :str_es.v_liv;

close ( w_wait )
	
if trap_sql ( sqlca, "cancellazione lista candidati" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	return -1
else
	commit;
	return 0
end if

return 0

end function

public function string dw_status ();string stato

stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public function integer query_mode ();dw_elenco.dataObject= dw_elenco.dataObject

dw_elenco.setTransObject ( sqlca )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=YES" )

//dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.setRedraw ( true )

w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public function integer dw_retrieve ();long ll_rows
/*
 * estrazione dati in base a definiti criteri...
 */
dw_elenco.acceptText()

w_prelude.SetMicroHelp ( "Estrazione dati..." )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=no" )

//dw_elenco.setTransObject ( sqlca )

ll_rows= dw_elenco.retrieve ( )

// GdS
commit using sqlca;

if ll_rows = 0 then return 0

dw_elenco.setRedraw ( true )

dw_elenco.TriggerEvent ( GetFocus! )

w_prelude.SetMicroHelp ( "" )

return 1
end function

public subroutine f_header (integer li_operation);long ll_found

//if not IsNull ( str_es.v_data ) and not IsNull ( str_es.v_sede ) &
//and not IsNull ( str_es.v_liv ) then

if li_operation= 1 then
	dw_elenco.DataObject = "d_lista"
	dw_elenco.setTransObject(sqlca)
	dw_elenco.SetRedraw ( false )
	ll_found = dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv )
	dw_elenco.SetRedraw ( true )
	
	if ll_found = -1 then
		
		OpenWithParm ( w_msgauto, "Operazione annullata" )
		TriggerEvent ( "clear" )
		return
		
	end if
		
end if

//long ll_quanti
//	select count (*) 
//	into :ll_quanti
//	from esami
//	where data_esame= :str_es.v_data and sede= :str_es.v_sede and cod_studio= :str_es.v_liv;
//	
//	if ll_quanti > 0 then
//		messageBox(this.title, "Sessione di esame già esistente", exclamation!)
//		return
//	end if
	
	sle_data.enabled = false
	sle_loc.enabled = false
	dw_liv.enabled = false
	
	cb_estrai.visible = true
	cb_save.visible = true
	
	dw_elenco.visible = true

	if ll_found > 0 then
		
		gb_dett.Text = " Lista candidati "
		
		status = "modifica"
		
		cb_estrai.text = "Aggiorna lista"
		cb_annulla.visible = true
		cb_annulla.text = "Cancella lista"
		cb_annulla.enabled = true
		
		m_esami.m_opzioni.m_ordina.enabled = true
		m_esami.m_opzioni.m_stampa.enabled = true
		m_esami.m_opzioni.m_salvacome.enabled = true
		
	else
		
		gb_dett.Text = " Nuova sessione - Creazione lista (sono esclusi automaticamente dalle liste i DEC, TAI, DIM e i TFE)"
		
		dw_elenco.SetRedraw ( false )
		dw_elenco.DataObject = "d_import"
		dw_elenco.SetTransObject ( sqlca )
		TriggerEvent ( "query_on" )
		dw_elenco.SetRedraw ( true )
		
		status = "crea"
		
		cb_estrai.text = "&Estrai"
		
		m_esami.m_opzioni.m_ordina.enabled = false
		m_esami.m_opzioni.m_stampa.enabled = false
		m_esami.m_opzioni.m_salvacome.enabled = false
		
	end if
	
	m_esami.m_opzioni.m_sessione.enabled = false
	
	cb_estrai.enabled = true
	cb_save.text = "Ins. in lista"

end subroutine

event dw_retrieve;int li_colnum
string ls_colname, ls_msg

open ( w_aut_print )

//if Message.DoubleParm = -1 then return -1

ls_msg = "Salvato su file per " + Message.StringParm

//if dw_elenco.SaveAs()= -1 then return -1

f_log ( gs_context, ls_msg )

//return 0
end event

on w_esami.create
if this.MenuName = "m_esami" then this.MenuID = create m_esami
this.cbx_filtra_datacerimonia=create cbx_filtra_datacerimonia
this.cbx_filtra_dataesame=create cbx_filtra_dataesame
this.em_filtra_datacerimonia=create em_filtra_datacerimonia
this.cb_annullafiltro=create cb_annullafiltro
this.cb_filtra=create cb_filtra
this.em_filtra_dataesame=create em_filtra_dataesame
this.st_1=create st_1
this.cb_crea=create cb_crea
this.sle_data=create sle_data
this.dw_liv=create dw_liv
this.cb_annulla=create cb_annulla
this.cb_save=create cb_save
this.cb_estrai=create cb_estrai
this.st_30=create st_30
this.st_31=create st_31
this.st_26=create st_26
this.sle_loc=create sle_loc
this.gb_cer=create gb_cer
this.dw_elenco=create dw_elenco
this.gb_dett=create gb_dett
this.Control[]={this.cbx_filtra_datacerimonia,&
this.cbx_filtra_dataesame,&
this.em_filtra_datacerimonia,&
this.cb_annullafiltro,&
this.cb_filtra,&
this.em_filtra_dataesame,&
this.st_1,&
this.cb_crea,&
this.sle_data,&
this.dw_liv,&
this.cb_annulla,&
this.cb_save,&
this.cb_estrai,&
this.st_30,&
this.st_31,&
this.st_26,&
this.sle_loc,&
this.gb_cer,&
this.dw_elenco,&
this.gb_dett}
end on

on w_esami.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_filtra_datacerimonia)
destroy(this.cbx_filtra_dataesame)
destroy(this.em_filtra_datacerimonia)
destroy(this.cb_annullafiltro)
destroy(this.cb_filtra)
destroy(this.em_filtra_dataesame)
destroy(this.st_1)
destroy(this.cb_crea)
destroy(this.sle_data)
destroy(this.dw_liv)
destroy(this.cb_annulla)
destroy(this.cb_save)
destroy(this.cb_estrai)
destroy(this.st_30)
destroy(this.st_31)
destroy(this.st_26)
destroy(this.sle_loc)
destroy(this.gb_cer)
destroy(this.dw_elenco)
destroy(this.gb_dett)
end on

event open;PostEvent ( "ue_open" )

end event

event closequery;if dw_elenco.DataObject = "d_lista" then

	int li_ret
	
	dw_elenco.AcceptText ( )
	
	if dw_elenco.ModifiedCount ( ) > 0 then
		
		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
									 question!, YesNoCancel!, 1 )
																					
		choose case li_ret
				
			case 1
				
				if event save ( ) = -1 then
					ib_closing = false
					return 1
				else
					return 0
				end if
				
			case 2
				
				return 0
				
			case 3
				
				ib_closing = false
				return 1
				
		end choose
		
	end if
	
end if

end event

event activate;gs_context = "Esami di studio"

end event

event resize;gb_dett.width= this.width - 90
dw_elenco.width= gb_dett.width - 400
cb_estrai.x= dw_elenco.width + 80
cb_save.x= dw_elenco.width + 80
cb_annulla.x= dw_elenco.width + 80


gb_dett.height= this.height - 200 - gb_dett.y

dw_elenco.height= gb_dett.height -360

end event

type cbx_filtra_datacerimonia from checkbox within w_esami
boolean visible = false
integer x = 64
integer y = 508
integer width = 1742
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
string text = "Escludi le persone che hanno la data di cerimonia superiore al:"
borderstyle borderstyle = stylelowered!
end type

event clicked;em_filtra_datacerimonia.enabled= this.checked
cb_filtra.enabled= this.checked OR cbx_filtra_dataesame.checked
cb_annullafiltro.enabled= this.checked OR cbx_filtra_dataesame.checked
end event

type cbx_filtra_dataesame from checkbox within w_esami
boolean visible = false
integer x = 64
integer y = 372
integer width = 1975
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
string text = "Escludi le persone che hanno sostenuto l~'esame del livello precedente il:"
borderstyle borderstyle = stylelowered!
end type

event clicked;em_filtra_dataesame.enabled= this.checked

cb_filtra.enabled= this.checked OR cbx_filtra_datacerimonia.checked
cb_annullafiltro.enabled= this.checked OR cbx_filtra_datacerimonia.checked
end event

type em_filtra_datacerimonia from editmask within w_esami
boolean visible = false
integer x = 2048
integer y = 488
integer width = 471
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean spin = true
end type

type cb_annullafiltro from commandbutton within w_esami
boolean visible = false
integer x = 3003
integer y = 424
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Annulla il filtro"
end type

event clicked;string ls_filtra

ls_filtra= ""

em_filtra_dataesame.text= ""
em_filtra_datacerimonia.text= ""

dw_elenco.setFilter(ls_filtra)

dw_elenco.filter()
end event

type cb_filtra from commandbutton within w_esami
boolean visible = false
integer x = 2615
integer y = 424
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Filtra"
end type

event clicked;string ls_filtra, ls_filtra1, ls_filtra2

if cbx_filtra_dataesame.checked= true then

	ls_filtra1= " (data_esame < date('"+em_filtra_dataesame.text+"')  or isNull(data_esame))"
	
	ls_filtra= ls_filtra1
	
end if

if cbx_filtra_datacerimonia.checked= true then

	ls_filtra2= " ( data_cer <= date('"+em_filtra_datacerimonia.text+"') )"
	
	ls_filtra= ls_filtra2
	
end if

if cbx_filtra_dataesame.checked= true and cbx_filtra_datacerimonia.checked= true then
	
	ls_filtra= ls_filtra1+" and "+ ls_filtra2

end if

dw_elenco.setFilter(ls_filtra)

dw_elenco.filter()
end event

type em_filtra_dataesame from editmask within w_esami
boolean visible = false
integer x = 2048
integer y = 352
integer width = 471
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean spin = true
end type

type st_1 from statictext within w_esami
integer x = 3227
integer y = 128
integer width = 146
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "livello"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_crea from commandbutton within w_esami
integer x = 3557
integer y = 104
integer width = 329
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Crea sessione"
boolean default = true
end type

event clicked;f_header ( 0 )

this.enabled= false
end event

type sle_data from singlelineedit within w_esami
integer x = 183
integer y = 112
integer width = 393
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 31514848
boolean autohscroll = false
textcase textcase = upper!
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event modified;string the_date

if len ( trim ( this.text ) ) = 0 then return
	
the_date= this.text

if len( trim ( the_date) ) <> 8 then

	MessageBox ( "Data", "Formato non valido", exclamation! )
	this.text = ''
	this.SetFocus ( )
	return
 
else

	the_date= mid(the_date, 1, 2)+'.'+mid(the_date, 3, 2)+'.'+mid(the_date, 5, 4)
	this.text = the_date
	
end if
		
if not IsDate ( this.text ) then
	MessageBox ( "Attenzione","Data non valida...", exclamation! )
	this.text = ''
	this.SetFocus  ( )
	return
end if

if not calling then
	if date ( this.text ) < today ( ) then
		MessageBox ( "Attenzione", "Data anteriore a quella odierna", Exclamation! )
	end if
else
	calling = false
end if

str_es.v_data = datetime ( date ( this.text ) )

//f_header ( )

return

end event

event other;if len ( trim ( this.text ) ) = 8 then sle_loc.SetFocus ( )

end event

type dw_liv from datawindow within w_esami
integer x = 2670
integer y = 100
integer width = 558
integer height = 112
integer taborder = 30
string dataobject = "d_ext_liv"
boolean border = false
boolean livescroll = true
end type

event itemchanged;str_es.v_liv = data

choose case str_es.v_liv
		
	case "01"
		
		is_liv = "00"
		
	case "02"
		
		is_liv = "01"
		
	case "03"
		
		is_liv = "02"
		
	case "04"
		
		is_liv = "03"
		
	case "05"
		
		is_liv = "04"
		
end choose

long ll_quanti
	select count (*) 
	into :ll_quanti
	from esami
	where data_esame= :str_es.v_data and sede= :str_es.v_sede and cod_studio= :str_es.v_liv;
	
	if ll_quanti > 0 then
		messageBox(this.title, "Sessione di esame già esistente", exclamation!)
		return
	end if
	
	cb_crea.enabled= true

//f_header ( )

end event

type cb_annulla from commandbutton within w_esami
boolean visible = false
integer x = 3566
integer y = 924
integer width = 315
integer height = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
boolean cancel = true
end type

event clicked;cbx_filtra_dataesame.visible= false
cbx_filtra_datacerimonia.visible= false

em_filtra_dataesame.visible= false
em_filtra_datacerimonia.visible= false
cb_filtra.visible= false
cb_annullafiltro.visible= false

if this.text = "Cancella lista" then
	
	if MessageBox ( "Cancellazione lista candidati", "Procedere?", exclamation!, YesNo!, 2 ) = 2 then return
	
		if f_canc_lista ( ) = 0 then
			
			OpenWithParm ( w_msgauto, "Cancellazione effettuata" )
			
			parent.SetRedraw ( false )
			
//			dw_elenco.Reset ( )
//			
//			cb_estrai.enabled = false
//			cb_save.enabled = false
//			cb_annulla.enabled = false
//			
////			cb_estrai.text = ""
////			cb_save.text = ""
////			cb_annulla.text = ""
//
//			cb_estrai.visible= false
//			cb_save.visible= false
//			cb_annulla.visible= false
//			

			parent.TriggerEvent ( "clear" )
			
			parent.SetRedraw ( true )

	
		else
			
			OpenWithParm ( w_msgauto, "Cancellazione annullata" )
			
		end if

	return
	
end if

dw_elenco.DataObject = "d_lista"
dw_elenco.SetTransObject ( sqlca )

f_header ( 1 )

this.text = "Cancella lista"
cb_save.enabled = false

end event

type cb_save from commandbutton within w_esami
boolean visible = false
integer x = 3566
integer y = 792
integer width = 315
integer height = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

event clicked;cbx_filtra_dataesame.visible= false
cbx_filtra_datacerimonia.visible= false

em_filtra_dataesame.visible= false
em_filtra_datacerimonia.visible= false
cb_filtra.visible= false
cb_annullafiltro.visible= false

if this.text = "Ins. in lista" then
	parent.TriggerEvent ( "importa" )
else
	parent.TriggerEvent ( "save" )
end if

end event

type cb_estrai from commandbutton within w_esami
event clicked pbm_bnclicked
boolean visible = false
integer x = 3566
integer y = 612
integer width = 315
integer height = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

event clicked;cbx_filtra_dataesame.visible= false
cbx_filtra_datacerimonia.visible= false

em_filtra_dataesame.visible= false
em_filtra_datacerimonia.visible= false
cb_filtra.visible= false
cb_annullafiltro.visible= false

call super::clicked;if dw_elenco.DataObject = "d_lista" then

	int li_ret
	
	dw_elenco.AcceptText ( )
	
	if dw_elenco.ModifiedCount ( ) > 0 then
		
		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
									 question!, YesNoCancel!, 1 )
																					
		choose case li_ret
				
			case 1
				
				if event save ( ) = -1 then return
				
			case 2
				
			case 3
				
				return
				
		end choose
		
	end if
	
end if

choose case status

	case "crea"
		
		parent.TriggerEvent ( "query_start" )
		
	case "modifica"
		
		dw_elenco.Reset ( )
		dw_elenco.DataObject = "d_import"
		parent.TriggerEvent ( "query_on" )
		cb_annulla.visible= true
		cb_annulla.text = "Torna a lista"
		cb_annulla.enabled = true
		m_esami.m_opzioni.m_stampa.enabled = false
		m_esami.m_opzioni.m_salvacome.enabled = false
		status = "aggiorna"
		gb_dett.text = " Aggiornamento lista "
		dw_elenco.SetFocus ( )
		return
		
	case "aggiorna"
		
		parent.TriggerEvent ( "query_start" )
		
end choose
	
return

end event

type st_30 from statictext within w_esami
integer x = 41
integer y = 116
integer width = 128
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Data:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_31 from statictext within w_esami
integer x = 599
integer y = 116
integer width = 146
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Sede:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_26 from statictext within w_esami
integer x = 2313
integer y = 116
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Ammissione al: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_loc from uo_sle_gen within w_esami
event modified pbm_enmodified
string tag = "Citta"
integer x = 750
integer y = 112
integer width = 1481
integer height = 80
integer taborder = 20
long textcolor = 8388608
integer limit = 60
end type

event modified;str_es.v_sede = trim ( this.text )

if len ( str_es.v_sede ) = 0 then SetNull ( str_es.v_sede )

//f_header ( )

end event

type gb_cer from groupbox within w_esami
integer x = 23
integer y = 12
integer width = 3881
integer height = 248
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = " Sessione di esame"
borderstyle borderstyle = stylelowered!
end type

type dw_elenco from uo_dwselect within w_esami
boolean visible = false
integer x = 41
integer y = 616
integer width = 3502
integer height = 1192
integer taborder = 0
string dataobject = "d_import"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event sqlpreview;call super::sqlpreview;if this.DataObject = "d_import" then

	string ls_stat
	
	if SqlType = PreviewSelect! then
		
		if pos ( SqlSyntax, "WHERE" ) = 0 then
			
			if is_liv <> "00" then
			
				ls_stat = " WHERE membri.flag_dis= 'N' AND" + &
							 " membri.cod_studio = '" + is_liv + "' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "

			else
				
				ls_stat = " WHERE membri.flag_dis= 'N' AND" + &
							 " membri.cod_studio = '00' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "
							 
			end if
				
		else
			
			if not IsNull ( is_liv ) then
			
				ls_stat = " and membri.flag_dis= 'N' AND" + &
							 " membri.cod_studio = '" + is_liv + "' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "

			else
				
				ls_stat =" and membri.flag_dis= 'N' AND" + &
							 " membri.cod_studio = null AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "
							 
			end if
			
		end if	
				
		SetSqlPreview ( SqlSyntax + ls_stat )
		
	end if

end if

end event

event getfocus;if dw_status ( ) = "NO" then
	
	SelectRow(0, false)
	SelectRow(1, true)
	
	il_rows = RowCount()
	
end if

end event

event itemchanged;call super::itemchanged;if this.DataObject = "d_import" then

	if row > 0 AND this.Object.DataWindow.QueryMode='yes' then
	
		CHOOSE CASE dwo.name
				
			CASE "cod_area"
	 
				c_area = f_replace_chars ( this.getText(), "'", "" )
	
			CASE "cod_terr"
	 
				c_terr = f_replace_chars(this.getText(), "'", "")
				
			CASE "cod_cen"

	
				c_cen = f_replace_chars(this.getText(), "'", "")
	
			CASE "cod_cap"
	
				c_cap = f_replace_chars(this.getText(), "'", "")
				
			CASE "cod_sett"
	
				c_sett = f_replace_chars(this.getText(), "'", "")
	
		END CHOOSE
	
	end if
	
else
	
	cb_save.text = "Salva modifiche"
	cb_save.enabled = true

end if

end event

event itemfocuschanged;call super::itemfocuschanged;long l_rows, err_code

string resp_code, ls_col

string where_clause, ls_area, ls_terr, ls_cen, ls_cap, ls_sett, ls_gru

if this.DataObject = "d_import" then

	resp_code= dw_elenco.describe("dataWindow.queryMode")
	
	ls_col = dwo.name
	
	if row < 1 then return
	
	if resp_code = "yes" then
		
		CHOOSE CASE dwo.name
				
			CASE "cod_area"
	 
				where_clause= " where aree.cod_area<>~~'"+"A"+"~~'" 
				
				err_code = this.GetChild ( 'cod_area',idwc_area )
				
				l_rows= f_mod_select(where_clause, idwc_area)
	
			CASE "cod_terr"
	 
				where_clause= " or territori.cod_area=~~'"+c_area+"~~'" 
				

				this.GetChild ( 'cod_terr',idwc_terr )
				
				l_rows= f_mod_select(where_clause, idwc_terr)
	
			CASE "cod_cen"
	 
				where_clause= " or (centri.cod_area=~~'"+c_area+"~~' and centri.cod_terr=~~'"+c_terr+"~~')" 
				
				this.GetChild ( 'cod_cen',idwc_cen )
				
				l_rows= f_mod_select(where_clause, idwc_cen)
	
			CASE "cod_cap"
	
				where_clause= 	" or (capitoli.cod_area=~~'"+c_area+ &
									"~~' and capitoli.cod_terr= ~~'"+c_terr+"~~' and "+ &
									" capitoli.cod_cen= ~~'"+c_cen+"~~')"
									
				this.GetChild ( 'cod_cap',idwc_cap )
				
				l_rows= f_mod_select(where_clause, idwc_cap)
	
			CASE "cod_sett"
	
				where_clause= " or (settori.cod_area= ~~'"+c_area+"~~' and "+ &
								  " settori.cod_terr= ~~'"+c_terr+"~~' and "+ &
								  " settori.cod_cen= ~~'"+c_cen+"~~' and "+&
								  " settori.cod_cap= ~~'"+c_cap+"~~')"
								  
				this.GetChild ( 'cod_sett',idwc_sett )
				
				l_rows= f_mod_select(where_clause, idwc_sett)
	
	
			CASE "cod_gru"
	
				where_clause= " or (gruppi.cod_area= ~~'"+c_area+"~~' and "+ &
								  " gruppi.cod_terr= ~~'"+c_terr+"~~' and "+ &
								  " gruppi.cod_cen= ~~'"+c_cen+"~~' and "+&
								  " gruppi.cod_cap= ~~'"+c_cap+"~~' and "+&
								  " gruppi.cod_sett= ~~'"+c_sett+"~~')"
									 
				this.GetChild ( 'cod_gru',idwc_gru )
				
				l_rows= f_mod_select(where_clause, idwc_gru)
				
	
		END CHOOSE
	
	else
		
	end if
	
end if

end event

event dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event retrievestart;call super::retrievestart;open ( w_wait )

cbx_filtra_dataesame.visible= false
cbx_filtra_datacerimonia.visible= false

em_filtra_dataesame.visible= false
em_filtra_datacerimonia.visible= false
cb_filtra.visible= false
cb_annullafiltro.visible= false
end event

event retrieveend;close ( w_wait )

if dw_elenco.dataobject= 'd_import' then
	cbx_filtra_dataesame.visible= true
	cbx_filtra_datacerimonia.visible= true
	
	em_filtra_dataesame.visible= true
	em_filtra_datacerimonia.visible= true
	cb_filtra.visible= true
	cb_annullafiltro.visible= true
else
	dw_elenco.Object.DataWindow.Print.Preview= "Yes"
end if

end event

event updatestart;call super::updatestart;open ( w_wait )

end event

event updateend;call super::updateend;close ( w_wait )

end event

event editchanged;call super::editchanged;if dwo.name= "data_cer" then 
	f_checkdate(dw_elenco)
end if
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_seleziona" then 
	long ll_idx
	
	if messageBox(parent.title, "Verranno tolti tutti i segni di spunta relativi alle adesioni. Confermi?", question!, yesNo!, 2)= 2 then return 1
	
	for ll_idx= 1 to this.rowCount()
		this.setItem(ll_idx, "flag_ok", "N")
	next

end if
end event
type gb_dett from groupbox within w_esami
integer x = 23
integer y = 284
integer width = 3881
integer height = 1764
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

