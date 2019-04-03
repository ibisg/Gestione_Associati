$PBExportHeader$w_abilitazioneutentiweb.srw
forward
global type w_abilitazioneutentiweb from window
end type
type cb_chiudi from commandbutton within w_abilitazioneutentiweb
end type
type uodw_current from uodw_generica within w_abilitazioneutentiweb
end type
end forward

global type w_abilitazioneutentiweb from window
integer width = 1829
integer height = 1436
boolean titlebar = true
string title = "Abilitazione utenti"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "UserObject5!"
boolean center = true
cb_chiudi cb_chiudi
uodw_current uodw_current
end type
global w_abilitazioneutentiweb w_abilitazioneutentiweb

type variables
string is_codice
end variables

on w_abilitazioneutentiweb.create
this.cb_chiudi=create cb_chiudi
this.uodw_current=create uodw_current
this.Control[]={this.cb_chiudi,&
this.uodw_current}
end on

on w_abilitazioneutentiweb.destroy
destroy(this.cb_chiudi)
destroy(this.uodw_current)
end on

event closequery;
if uodw_current.uof_modificheincorso()= 3  then return 1 // annulla...

return 0
end event

event open;long ll_row

is_codice= message.stringParm

uodw_current.setTransObject(sqlca)

ll_row= uodw_current.retrieve(is_codice)
end event

type cb_chiudi from commandbutton within w_abilitazioneutentiweb
integer x = 745
integer y = 1140
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type uodw_current from uodw_generica within w_abilitazioneutentiweb
integer width = 1769
integer height = 1032
integer taborder = 10
string dataobject = "dw_abilitazioneutentiweb"
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;call super::buttonclicked;long ll_ret

if dwo.name= "b_aggiorna" then

		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)
		
end if
end event

