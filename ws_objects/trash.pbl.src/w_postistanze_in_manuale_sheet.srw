$PBExportHeader$w_postistanze_in_manuale_sheet.srw
forward
global type w_postistanze_in_manuale_sheet from window
end type
type dw_current from datawindow within w_postistanze_in_manuale_sheet
end type
type dw_partecipanti from datawindow within w_postistanze_in_manuale_sheet
end type
type gb_partecipanti from groupbox within w_postistanze_in_manuale_sheet
end type
type gb_stanze from groupbox within w_postistanze_in_manuale_sheet
end type
end forward

global type w_postistanze_in_manuale_sheet from window
integer width = 5938
integer height = 1892
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
event type integer ue_seleziona_alberghi ( )
event type integer ue_aggiungi_letto ( )
event type integer ue_aggiungi_stanze ( )
event type integer ue_annulla_assegnazioni ( )
dw_current dw_current
dw_partecipanti dw_partecipanti
gb_partecipanti gb_partecipanti
gb_stanze gb_stanze
end type
global w_postistanze_in_manuale_sheet w_postistanze_in_manuale_sheet

type variables
dataWindowChild dwc_partecipanti
long il_null
string is_corso, is_turno, is_albergo, is_where, is_null

end variables

event type integer ue_seleziona_alberghi();long ll_rows
string ls_descrizione

dw_current.getChild("codice_part", dwc_partecipanti)

open(w_selezione_alberghi_stanze)

is_albergo= message.stringParm

if is_albergo= "" then return 0

select descrizione
into :ls_descrizione
from alberghi
where cod_albergo= :is_albergo;
if trap_sql(sqlca, "SELEZALB01") < 0 then return -1

this.title= "Assegnazione manuale posti stanze  per l'albergo "+ls_descrizione

dw_current.reset()

dw_current.setTransObject(sqlca)
dwc_partecipanti.setTransObject(sqlca)

//dwc_partecipanti.retrieve(is_corso, is_turno)

is_where=  " where partecipanti.cod_corso= ~~'"+is_corso+"~~' and partecipanti.cod_turno= ~~'"+is_turno+"~~'"

//is_where=  " and partecipanti.cod_corso= ~~'"+is_corso+"~~' and partecipanti.cod_turno= ~~'"+is_turno+"~~'"
ll_rows= f_mod_select(is_where, dwc_partecipanti)

is_where= " where cod_corso= ~~'"+is_corso+"~~' and cod_turno= ~~'"+is_turno+"~~' and cod_albergo= ~~'"+is_albergo+"~~'"

ll_rows= f_dw_mod_select (false, is_where, dw_current)

return ll_rows

end event

event type integer ue_aggiungi_letto();integer li_quante, li_tipo, li_numero, li_gen, li_idx, li_idx_1, li_num_albergo, li_ret
long ll_row, ll_found
string ls_aggiungi

dw_current.setRedraw(false)

li_tipo= dw_current.getItemNumber(dw_current.getRow(), "num_letti")

li_numero= dw_current.getItemNumber(dw_current.getRow(), "num_stanza")
li_num_albergo= dw_current.getItemNumber(dw_current.getRow(), "num_albergo")
li_gen= dw_current.getItemNumber(dw_current.getRow(), "n_gen")

if li_tipo= 4 then
	messageBox(this.title, "Non è possibile aggiungere un posto letto ad una stanza quadrupla.", exclamation!)
	return -1
else
	li_ret= messageBox(this.title, "Hai richiesto di aggiungere un posto letto alla stanza numero "+string(li_num_albergo)+&
											"~nConfermi?", question!, yesNo!, 2)
	if li_ret= 2 then return 0
end if

ll_row= dw_current.insertRow(dw_current.getRow())
dw_current.setItem(ll_row, "cod_corso", is_corso)
dw_current.setItem(ll_row, "cod_turno", is_turno)
dw_current.setItem(ll_row, "cod_albergo", is_albergo)
dw_current.setItem(ll_row, "num_stanza", li_numero)
dw_current.setItem(ll_row, "num_albergo", li_num_albergo)
dw_current.setItem(ll_row, "num_letti", li_tipo+1)
dw_current.setItem(ll_row, "num_posto", li_tipo+1)
dw_current.setItem(ll_row, "n_gen", li_gen)
dw_current.setItem(ll_row, "flag_agibile", '1')


dw_current.setFilter("num_stanza= "+string(li_numero))
dw_current.filter()
	
	for li_idx= 1 to dw_current.rowCount()
		dw_current.setItem(li_idx, "num_letti", li_tipo+1)
	next

dw_current.setFilter("")
dw_current.filter()

dw_current.groupCalc()

dw_current.sort()

ll_found= dw_current.find("num_stanza= "+string(li_numero)+" and num_posto= "+string(li_tipo+1), 1, dw_current.rowCount() )

dw_current.scrollToRow(ll_found)

dw_current.setRedraw(true)

///////////////// test
m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= true
//m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.triggerEvent(clicked!)
//////////////////// test

return 0
end event

event type integer ue_aggiungi_stanze();integer li_quante, li_tipo, li_numero, li_gen, li_idx, li_idx_1
long ll_row
string ls_aggiungi

open(w_aggiungi_stanze)

ls_aggiungi= message.stringParm

li_quante= integer(mid(ls_aggiungi, 1, len(ls_aggiungi) - 1))

li_tipo= integer(mid(ls_aggiungi, len(ls_aggiungi), len(ls_aggiungi)))

li_numero= dw_current.getItemNumber(dw_current.rowCount(), "num_stanza")
li_gen= dw_current.getItemNumber(dw_current.rowCount(), "n_gen")

dw_current.setRedraw(false)

open(w_wait)
w_wait.st_wait.text= 'Attendere . . .'

for li_idx= 1 to li_quante
	li_numero++
	li_gen++
	for li_idx_1= 1 to li_tipo
		ll_row= dw_current.insertRow(0)
		dw_current.setItem(ll_row, "cod_corso", is_corso)
		dw_current.setItem(ll_row, "cod_turno", is_turno)
		dw_current.setItem(ll_row, "cod_albergo", is_albergo)
		dw_current.setItem(ll_row, "num_stanza", li_numero)
		dw_current.setItem(ll_row, "num_letti", li_tipo)
		dw_current.setItem(ll_row, "num_posto", li_idx_1)
		dw_current.setItem(ll_row, "n_gen", li_gen)
	next
next

dw_current.sort()

dw_current.setRedraw(true)

//choose case li_tipo
//	case 1
//		update alberghi_turni
//		set singole= singole+ :li_quante, n_posti= n_posti + :li_quante
//		where cod_corso= :is_corso and
//					cod_turno= :is_turno and
//						cod_albergo= :is_albergo;
//		
//	case 2
//		update alberghi_turni
//		set doppie= doppie+ :li_quante, n_posti= n_posti + :li_quante*2
//		where cod_corso= :is_corso and
//					cod_turno= :is_turno and
//						cod_albergo= :is_albergo;
//						
//	case 3
//		update alberghi_turni
//		set triple= triple+ :li_quante, n_posti= n_posti + :li_quante*3
//		where cod_corso= :is_corso and
//					cod_turno= :is_turno and
//						cod_albergo= :is_albergo;
//						
//	case 4
//		update alberghi_turni
//		set quadruple= quadruple+ :li_quante, n_posti= n_posti + :li_quante*4
//		where cod_corso= :is_corso and
//					cod_turno= :is_turno and
//						cod_albergo= :is_albergo;
//		
//end choose

close(w_wait)

//if trap_sql(sqlca, "UPDSTANZE01") < 0 then
//	rollback;
//	return -1
//end if

///////////////// test
m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= true
//m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.triggerEvent(clicked!)
//////////////////// test



return 0
end event

event type integer ue_annulla_assegnazioni();// annulla le assegnazioni manuali
update stanze
set codice_part= null, flg_man= "N"
where cod_corso= :is_corso and
				cod_turno= :is_turno and
					cod_albergo= :is_albergo and
						flg_man="M";
					
if trap_sql(sqlca, "ANNULLA01") < 0 then
	rollback;
	trap_sql(sqlca, "ANNULLA02")
	return -1
end if

//if messageBox(this.title, "Confermi l'annullamento delle assegnazioni manualiper questo albergo?", question!, yesNo!, 2)= 2 then return -1

commit;
if trap_sql(sqlca, "ANNULLA03") < 0 then return -1

//dw_current.reset()
//dw_current.retrieve(is_corso, is_turno, is_albergo)
//is_where= " where cod_corso= ~~'"+is_corso+"~~' and cod_turno= ~~'"+is_turno+"~~' and cod_albergo= ~~'"+is_albergo+"~~'"
//ib_ricerca_iniziale= true
//ib_dw_query_mode= true
//m_selezione_alberghi_stanze.m_gestionearchivio.m_ricerca.event clicked()

///
/*ll_rows= */ f_dw_mod_select (false, is_where, dw_current)

m_selezione_alberghi_stanze.m_gestionearchivio.m_cancella.enabled= false
m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= false

return 0
end event

event close;sqlca.autocommit= false
end event

event open;string ls_ar, ls_mezzo
long ll_rows
integer li_nposti, li_singole, li_doppie, li_triple, li_quadruple

setNull(il_null)
setNull(is_null)

dw_current.setRowFocusIndicator(hand!)

is_corso= trim(mid(gs_corsocorrente, 1, 6))
is_turno= trim(mid(gs_corsocorrente, 7, 10))

dw_partecipanti.setTransObject(sqlca)

sqlca.autocommit= true

dw_partecipanti.retrieve(is_corso, is_turno)

post event  ue_seleziona_alberghi()

return 0

end event

event resize;gb_partecipanti.height= this.height - 180
gb_stanze.height=  this.height - 180

dw_partecipanti.height=gb_stanze.height - dw_partecipanti.y - 20
dw_current.height= gb_stanze.height - dw_partecipanti.y - 20
end event

on w_postistanze_in_manuale_sheet.create
this.dw_current=create dw_current
this.dw_partecipanti=create dw_partecipanti
this.gb_partecipanti=create gb_partecipanti
this.gb_stanze=create gb_stanze
this.Control[]={this.dw_current,&
this.dw_partecipanti,&
this.gb_partecipanti,&
this.gb_stanze}
end on

on w_postistanze_in_manuale_sheet.destroy
destroy(this.dw_current)
destroy(this.dw_partecipanti)
destroy(this.gb_partecipanti)
destroy(this.gb_stanze)
end on

type dw_current from datawindow within w_postistanze_in_manuale_sheet
integer x = 2112
integer y = 68
integer width = 3726
integer height = 784
integer taborder = 20
string title = "none"
string dataobject = "dw_stanze"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event buttonclicked;if row <= 0 then return -1

choose case dwo.name
		
	case "b_aggiorna"
		
		if this.update()= 1 then
			open(w_message)
			this.object.b_aggiorna.visible= false
		else
			open(w_message_negative)			
		end if
		
	case "b_filtra"
		
		string ls_filtra
		
		if this.filteredCount() = 0 then
			ls_filtra= " NOT isNull(codice_part)"
			this.object.b_filtra.text= "Tutti"
		else
			ls_filtra= ""
			this.object.b_filtra.text= "Solo posti assegnati"
		end if
		
		this.setFilter(ls_filtra)
		
		this.filter()
		
	case "b_delete"
		
		this.setItem(row, "codice_part", il_null)
		this.setItem(row, "flag_man",  "N" )
		
		this.update()
		
		//m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= true
		
		//if this.update() < 0 then messageBox(parent.title, "Salvataggio non riuscito.", exclamation!)
		
		dw_partecipanti.retrieve(is_corso, is_turno)
		
end choose
end event

event rowfocuschanged;//f_select_current_row(this)
end event

event itemchanged;if dwo.name= "b_delete" then return 0

this.object.b_aggiorna.visible= true
end event

type dw_partecipanti from datawindow within w_postistanze_in_manuale_sheet
integer x = 27
integer y = 68
integer width = 2011
integer height = 776
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_partecipanti_da_sistemare_in_camera"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;if row<= 0 then return

long ll_codice, ll_assegnato
string ls_agibile

ll_codice= this.getItemNumber(row, "codice_part")

if row <= 0 then return

ls_agibile= dw_current.getItemString(dw_current.getRow(), "flag_agibile")

if ls_agibile= '0' then
	messageBox(parent.title, "La stanza non è agibile.", information!)
	return
end if

ll_assegnato= dw_current.getItemNumber(dw_current.getRow(), "codice_part")

if ll_assegnato > 0 then
	messageBox(parent.title, "Il posto è già assegnato. Per riassegnarlo occorre cancellare prima l'attuale occupante della stanza.", information!)
	return
end if

if dw_current.setItem(dw_current.getRow(), "codice_part", ll_codice)= -1 then
	messageBox(parent.title, "Errore in inserimento codice partecipante", exclamation!)
else
	dw_current.setItem(dw_current.getRow(), "flag_man", "M")
	dw_current.update()
	this.deleteRow(row)
//	m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= true
end if

dw_current.setFocus()

return
end event

event rowfocuschanged;f_select_current_row(this)
end event

type gb_partecipanti from groupbox within w_postistanze_in_manuale_sheet
integer width = 2075
integer height = 1696
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Elenco partecipanti"
end type

type gb_stanze from groupbox within w_postistanze_in_manuale_sheet
integer x = 2089
integer width = 3776
integer height = 1696
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Assegnazione stanze"
end type

