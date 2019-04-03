$PBExportHeader$w_adesione_sessione.srw
forward
global type w_adesione_sessione from window
end type
type uodw_current from uodw_generica within w_adesione_sessione
end type
type cb_annulla from commandbutton within w_adesione_sessione
end type
end forward

global type w_adesione_sessione from window
integer width = 2039
integer height = 1528
boolean titlebar = true
string title = "Adesione ad una sessione d~'esame"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean center = true
uodw_current uodw_current
cb_annulla cb_annulla
end type
global w_adesione_sessione w_adesione_sessione

type variables
s_adesioni is_adesioni_s
end variables

on w_adesione_sessione.create
this.uodw_current=create uodw_current
this.cb_annulla=create cb_annulla
this.Control[]={this.uodw_current,&
this.cb_annulla}
end on

on w_adesione_sessione.destroy
destroy(this.uodw_current)
destroy(this.cb_annulla)
end on

event open;integer li_livello
long ll_row

li_livello= message.doubleParm

uodw_current.setTransObject(sqlca)

ll_row= uodw_current.retrieve(li_livello)

if ll_row= 0 then
	
	messageBox(this.title, "Nessuna sessione d'esame disponibile.")
	
	is_adesioni_s.tipo_evento= -1

	closeWithReturn(this, is_adesioni_s)
	
end if
end event

type uodw_current from uodw_generica within w_adesione_sessione
integer taborder = 10
string dataobject = "dw_adesione_sessione"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;
is_adesioni_s.data_evento= this.getItemDatetime(row, "data_evento")
is_adesioni_s.data_cerimonia_soglia= this.getItemDatetime(row, "data_cerimonia_soglia")
is_adesioni_s.data_ultimo_esame= this.getItemDatetime(row, "data_ultimo_esame")
is_adesioni_s.id_sessione= this.getItemDecimal(row, "id")
is_adesioni_s.tipo_evento= this.getItemNumber(row, "tipo_evento")

closeWithReturn(parent, is_adesioni_s)
end event

type cb_annulla from commandbutton within w_adesione_sessione
integer x = 1591
integer y = 1288
integer width = 343
integer height = 124
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

