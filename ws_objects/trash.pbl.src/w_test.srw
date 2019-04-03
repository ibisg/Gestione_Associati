$PBExportHeader$w_test.srw
forward
global type w_test from window
end type
type dw_ricerca_struttura_tv from datawindow within w_test
end type
end forward

global type w_test from window
integer width = 2533
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_ricerca_struttura_tv dw_ricerca_struttura_tv
end type
global w_test w_test

type variables
dataWindowChild idwc_struttura
end variables

event open;dw_ricerca_struttura_tv.GetChild('nome', idwc_struttura)

//li_ret= idwc_struttura.importString(ls_entries)
//
//idwc_struttura.sort()

idwc_struttura.setTransObject(sqlca)

dw_ricerca_struttura_tv.insertRow(0)

end event

on w_test.create
this.dw_ricerca_struttura_tv=create dw_ricerca_struttura_tv
this.Control[]={this.dw_ricerca_struttura_tv}
end on

on w_test.destroy
destroy(this.dw_ricerca_struttura_tv)
end on

type dw_ricerca_struttura_tv from datawindow within w_test
integer x = 27
integer y = 40
integer width = 2213
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "edw_ricerca_struttura_tv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;idwc_struttura.retrieve("rossi", "%")
end event

