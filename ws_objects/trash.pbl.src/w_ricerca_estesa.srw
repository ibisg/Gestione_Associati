$PBExportHeader$w_ricerca_estesa.srw
forward
global type w_ricerca_estesa from w_centered
end type
type dw_estesa from uodw_generica within w_ricerca_estesa
end type
end forward

global type w_ricerca_estesa from w_centered
integer width = 3570
integer height = 1568
string title = ""
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
dw_estesa dw_estesa
end type
global w_ricerca_estesa w_ricerca_estesa

on w_ricerca_estesa.create
int iCurrent
call super::create
this.dw_estesa=create dw_estesa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_estesa
end on

on w_ricerca_estesa.destroy
call super::destroy
destroy(this.dw_estesa)
end on

event resize;call super::resize;dw_estesa.width= this.width - 120
end event

type dw_estesa from uodw_generica within w_ricerca_estesa
integer width = 3470
integer taborder = 10
string dataobject = "dw_ricerca_estesa"
boolean hsplitscroll = true
end type

