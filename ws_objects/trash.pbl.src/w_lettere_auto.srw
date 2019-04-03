$PBExportHeader$w_lettere_auto.srw
forward
global type w_lettere_auto from w_centered
end type
type cbx_anteprima from checkbox within w_lettere_auto
end type
type st_firma from statictext within w_lettere_auto
end type
type cbx_intestazione from checkbox within w_lettere_auto
end type
type dw_current from datawindow within w_lettere_auto
end type
type gb_header from groupbox within w_lettere_auto
end type
end forward

global type w_lettere_auto from w_centered
integer width = 3790
integer height = 2708
string icon = "Query5!"
cbx_anteprima cbx_anteprima
st_firma st_firma
cbx_intestazione cbx_intestazione
dw_current dw_current
gb_header gb_header
end type
global w_lettere_auto w_lettere_auto

on w_lettere_auto.create
int iCurrent
call super::create
this.cbx_anteprima=create cbx_anteprima
this.st_firma=create st_firma
this.cbx_intestazione=create cbx_intestazione
this.dw_current=create dw_current
this.gb_header=create gb_header
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_anteprima
this.Control[iCurrent+2]=this.st_firma
this.Control[iCurrent+3]=this.cbx_intestazione
this.Control[iCurrent+4]=this.dw_current
this.Control[iCurrent+5]=this.gb_header
end on

on w_lettere_auto.destroy
call super::destroy
destroy(this.cbx_anteprima)
destroy(this.st_firma)
destroy(this.cbx_intestazione)
destroy(this.dw_current)
destroy(this.gb_header)
end on

event resize;call super::resize;//this.height= parent.parentWindow().height - 120
dw_current.height= this.height - 120 - dw_current.y
//dw_current.width= this.width - 120
end event

event open;call super::open;dw_current.setTransObject(sqlca)

dw_current.retrieve(message.stringParm)
end event

type cbx_anteprima from checkbox within w_lettere_auto
integer x = 3223
integer y = 84
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Anteprima"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_current.acceptText()
if this.checked then
	dw_current.Object.DataWindow.Print.Preview= "yes"
else
	dw_current.Object.DataWindow.Print.Preview= "no"	
end if
end event

type st_firma from statictext within w_lettere_auto
integer x = 974
integer y = 100
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Seleziona una firma"
boolean focusrectangle = false
end type

type cbx_intestazione from checkbox within w_lettere_auto
integer x = 23
integer y = 84
integer width = 649
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Stampa l~'intestazione"
boolean checked = true
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_current.object.t_header.visible= this.checked
end event

type dw_current from datawindow within w_lettere_auto
integer y = 256
integer width = 3749
integer height = 2256
integer taborder = 10
string title = "Lettere"
string dataobject = "dw_lettera_presentazione"
boolean vscrollbar = true
string icon = "Query5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;return 2
end event

event buttonclicked;if dwo.name= "b_stampa" then
	this.acceptText()
	openWithParm(w_dw_print_options, dw_current)
end if


end event

type gb_header from groupbox within w_lettere_auto
integer width = 3749
integer height = 220
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

