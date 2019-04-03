$PBExportHeader$w_ricerca-estesa.srw
forward
global type w_ricerca-estesa from w_centered
end type
type dw_estesa from uodw_generica within w_ricerca-estesa
end type
end forward

global type w_ricerca-estesa from w_centered
integer width = 3543
integer height = 1568
boolean minbox = false
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
dw_estesa dw_estesa
end type
global w_ricerca-estesa w_ricerca-estesa

on w_ricerca-estesa.create
int iCurrent
call super::create
this.dw_estesa=create dw_estesa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_estesa
end on

on w_ricerca-estesa.destroy
call super::destroy
destroy(this.dw_estesa)
end on

type dw_estesa from uodw_generica within w_ricerca-estesa
integer width = 3470
integer taborder = 10
string dataobject = "dw_ricerca_estesa"
boolean hsplitscroll = true
end type

