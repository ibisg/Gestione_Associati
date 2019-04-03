$PBExportHeader$w_corrispondenza.srw
forward
global type w_corrispondenza from w_centered
end type
type pb_cancella from picturebutton within w_corrispondenza
end type
type pb_aggiorna from picturebutton within w_corrispondenza
end type
type dw_current from datawindow within w_corrispondenza
end type
end forward

global type w_corrispondenza from w_centered
integer width = 2967
integer height = 832
string title = "Indirizzo corrispondenza"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
pb_cancella pb_cancella
pb_aggiorna pb_aggiorna
dw_current dw_current
end type
global w_corrispondenza w_corrispondenza

on w_corrispondenza.create
int iCurrent
call super::create
this.pb_cancella=create pb_cancella
this.pb_aggiorna=create pb_aggiorna
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_cancella
this.Control[iCurrent+2]=this.pb_aggiorna
this.Control[iCurrent+3]=this.dw_current
end on

on w_corrispondenza.destroy
call super::destroy
destroy(this.pb_cancella)
destroy(this.pb_aggiorna)
destroy(this.dw_current)
end on

event open;call super::open;string ls_codice


ls_codice= message.stringParm

dw_current.setTransObject(sqlca)

if dw_current.retrieve(ls_codice)= 0 then dw_current.insertRow(0)
	
dw_current.setFocus()
	
end event

type pb_cancella from picturebutton within w_corrispondenza
integer x = 2427
integer y = 360
integer width = 402
integer height = 224
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
boolean originalsize = true
alignment htextalign = left!
end type

type pb_aggiorna from picturebutton within w_corrispondenza
integer x = 2427
integer y = 112
integer width = 402
integer height = 224
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
boolean originalsize = true
alignment htextalign = left!
end type

type dw_current from datawindow within w_corrispondenza
integer x = 32
integer y = 28
integer width = 2272
integer height = 616
integer taborder = 10
string title = "none"
string dataobject = "dw_corrispondenza"
boolean border = false
boolean livescroll = true
end type

