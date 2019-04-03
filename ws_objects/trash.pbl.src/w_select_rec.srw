$PBExportHeader$w_select_rec.srw
forward
global type w_select_rec from Window
end type
type dw_elenco from uo_dwselect within w_select_rec
end type
type cb_cancel from commandbutton within w_select_rec
end type
type cb_ok from commandbutton within w_select_rec
end type
end forward

global type w_select_rec from Window
int X=1084
int Y=541
int Width=1642
int Height=997
boolean TitleBar=true
long BackColor=12632256
WindowType WindowType=response!
dw_elenco dw_elenco
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_select_rec w_select_rec

type variables
Boolean close_with_cb = false

end variables

on w_select_rec.create
this.dw_elenco=create dw_elenco
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={ this.dw_elenco,&
this.cb_cancel,&
this.cb_ok}
end on

on w_select_rec.destroy
destroy(this.dw_elenco)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event closequery;if not close_with_cb then return 1

end event

type dw_elenco from uo_dwselect within w_select_rec
int X=5
int Y=5
int Width=1610
int Height=657
end type

event select_item;call super::select_item;close_with_cb = true

end event

event rowfocuschanged;call super::rowfocuschanged;if this.getRow() <= 0  then return -1

This.SelectRow(0, FALSE)

This.SelectRow(currentrow, TRUE)
end event

type cb_cancel from commandbutton within w_select_rec
int X=819
int Y=721
int Width=353
int Height=109
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close_with_cb = true

CloseWithReturn ( parent, -1 )

end event

type cb_ok from commandbutton within w_select_rec
int X=444
int Y=721
int Width=353
int Height=109
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close_with_cb = true

dw_elenco.Event select_item( dw_elenco.getRow()) //keydown ( KeyEnter!, 0 )

end event

