$PBExportHeader$w_rga_azioni.srw
forward
global type w_rga_azioni from window
end type
type pb_annulla from picturebutton within w_rga_azioni
end type
type pb_cancella from picturebutton within w_rga_azioni
end type
type pb_esegui from picturebutton within w_rga_azioni
end type
type mle_variazione from multilineedit within w_rga_azioni
end type
type st_1 from statictext within w_rga_azioni
end type
end forward

global type w_rga_azioni from window
integer width = 2130
integer height = 1828
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean center = true
pb_annulla pb_annulla
pb_cancella pb_cancella
pb_esegui pb_esegui
mle_variazione mle_variazione
st_1 st_1
end type
global w_rga_azioni w_rga_azioni

event open;mle_variazione.text= message.stringParm


end event

on w_rga_azioni.create
this.pb_annulla=create pb_annulla
this.pb_cancella=create pb_cancella
this.pb_esegui=create pb_esegui
this.mle_variazione=create mle_variazione
this.st_1=create st_1
this.Control[]={this.pb_annulla,&
this.pb_cancella,&
this.pb_esegui,&
this.mle_variazione,&
this.st_1}
end on

on w_rga_azioni.destroy
destroy(this.pb_annulla)
destroy(this.pb_cancella)
destroy(this.pb_esegui)
destroy(this.mle_variazione)
destroy(this.st_1)
end on

type pb_annulla from picturebutton within w_rga_azioni
integer x = 73
integer y = 1484
integer width = 1979
integer height = 260
integer taborder = 30
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Esci senza eseguire operazioni"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16777215
long backcolor = 16711680
end type

event clicked;closeWithReturn(parent, 'A')
end event

type pb_cancella from picturebutton within w_rga_azioni
integer x = 73
integer y = 1160
integer width = 1979
integer height = 260
integer taborder = 60
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancella la richiesta"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16777215
long backcolor = 255
end type

event clicked;
closeWithReturn(parent, 'C')
end event

type pb_esegui from picturebutton within w_rga_azioni
integer x = 73
integer y = 836
integer width = 1979
integer height = 260
integer taborder = 50
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Esegui la variazione"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16777215
long backcolor = 8421376
end type

event clicked;closeWithReturn(parent, 'E')
end event

type mle_variazione from multilineedit within w_rga_azioni
integer x = 73
integer y = 72
integer width = 1979
integer height = 704
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rga_azioni
integer x = 73
integer y = 12
integer width = 658
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Variazione richiesta:"
boolean focusrectangle = false
end type

