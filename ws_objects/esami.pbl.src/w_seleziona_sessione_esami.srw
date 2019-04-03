$PBExportHeader$w_seleziona_sessione_esami.srw
forward
global type w_seleziona_sessione_esami from window
end type
type cb_annulla from commandbutton within w_seleziona_sessione_esami
end type
type uodw_sessione_esame from uodw_generica within w_seleziona_sessione_esami
end type
end forward

global type w_seleziona_sessione_esami from window
integer width = 3506
integer height = 1432
boolean titlebar = true
string title = "Selezione della sessione d~'esame per un determinato livello"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
uodw_sessione_esame uodw_sessione_esame
end type
global w_seleziona_sessione_esami w_seleziona_sessione_esami

type variables
s_adesioni is_adesioni_s
end variables

on w_seleziona_sessione_esami.create
this.cb_annulla=create cb_annulla
this.uodw_sessione_esame=create uodw_sessione_esame
this.Control[]={this.cb_annulla,&
this.uodw_sessione_esame}
end on

on w_seleziona_sessione_esami.destroy
destroy(this.cb_annulla)
destroy(this.uodw_sessione_esame)
end on

event open;integer li_tipo

li_tipo= message.doubleParm

uodw_sessione_esame.setTransObject(sqlca)

uodw_sessione_esame.retrieve(li_tipo)
end event

type cb_annulla from commandbutton within w_seleziona_sessione_esami
integer x = 1504
integer y = 1192
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;is_adesioni_s.tipo_evento= -1
closeWithReturn(parent, is_adesioni_s)	
end event

type uodw_sessione_esame from uodw_generica within w_seleziona_sessione_esami
integer x = 5
integer width = 3451
integer height = 1160
integer taborder = 10
string dataobject = "dw_seleziona_sessione_esame"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;if row > 0 then
	
	long ll_row
	
	ll_row= this.getItemNumber(row, "id")
	
	is_adesioni_s.data_evento= this.getItemDatetime(row, "data_evento")
	is_adesioni_s.data_cerimonia_soglia= this.getItemDatetime(row, "data_cerimonia_soglia")
	is_adesioni_s.data_ultimo_esame= this.getItemDatetime(row, "data_ultimo_esame")
	is_adesioni_s.id_sessione= this.getItemDecimal(row, "id")
	is_adesioni_s.tipo_evento= this.getItemNumber(row, "tipo_evento")
	is_adesioni_s.livello_resp_soglia= this.getItemNumber(row, "livello_resp_soglia")
	is_adesioni_s.a_g= this.getItemString(row, "a_g")
	
	closeWithReturn(parent, is_adesioni_s)	
	
end if
end event

