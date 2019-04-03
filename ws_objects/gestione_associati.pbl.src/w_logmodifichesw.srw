$PBExportHeader$w_logmodifichesw.srw
forward
global type w_logmodifichesw from window
end type
type cb_chiudi from commandbutton within w_logmodifichesw
end type
type mle_sw from multilineedit within w_logmodifichesw
end type
end forward

global type w_logmodifichesw from window
integer width = 2651
integer height = 1728
boolean titlebar = true
string title = "Visualizzazione modifiche SW"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Information!"
boolean center = true
cb_chiudi cb_chiudi
mle_sw mle_sw
end type
global w_logmodifichesw w_logmodifichesw

event open;integer li_fhandle
string ls_filename, ls_testo

ls_filename= "./docdir/templates/logmodifichesw.txt"

if NOT fileExists(ls_filename) then
	messageBox("Visualizzazione log modifiche SW", "File non presente.", stopSign!)
	return -1
end if
			

li_fhandle= fileOpen(ls_filename, textMode!, read!, shared!)

if li_fhandle= -1 then
	messageBox("Visualizzazione log modifiche SW", "Errore in apertura file", stopSign!)
	return -1
end if
	

if fileReadEx(li_fhandle, ls_testo)= -1 then
	messageBox("Visualizzazione log modifiche SW", "Errore in lettura file", stopSign!)
	return -1
end if

mle_sw.text= ls_testo

return 0


end event

on w_logmodifichesw.create
this.cb_chiudi=create cb_chiudi
this.mle_sw=create mle_sw
this.Control[]={this.cb_chiudi,&
this.mle_sw}
end on

on w_logmodifichesw.destroy
destroy(this.cb_chiudi)
destroy(this.mle_sw)
end on

type cb_chiudi from commandbutton within w_logmodifichesw
integer x = 1147
integer y = 1528
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

type mle_sw from multilineedit within w_logmodifichesw
integer x = 5
integer width = 2629
integer height = 1500
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

