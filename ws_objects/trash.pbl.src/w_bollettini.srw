$PBExportHeader$w_bollettini.srw
forward
global type w_bollettini from w_centered
end type
type dw_current from datawindow within w_bollettini
end type
end forward

global type w_bollettini from w_centered
integer width = 4553
integer height = 2280
string title = "Bollettini"
long backcolor = 81324524
string icon = "Query5!"
boolean clientedge = true
event type long ue_open ( )
dw_current dw_current
end type
global w_bollettini w_bollettini

type variables
s_bollettini is_bollettini_s
end variables

event type long ue_open();long ll_rows

ll_rows= dw_current.retrieve()

if ll_rows= 0 then messageBox(this.title, "Nessun record estratto.", information!)

return ll_rows
end event

on w_bollettini.create
int iCurrent
call super::create
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
end on

on w_bollettini.destroy
call super::destroy
destroy(this.dw_current)
end on

event open;call super::open;string ls_where

is_bollettini_s= message.powerObjectParm

dw_current.setTransObject(sqlca)

dw_current.Object.DataWindow.Print.Preview= 'yes'
dw_current.Object.DataWindow.Print.Preview.Buttons= 'yes'

setPointer(hourGlass!)

event post ue_open()

return 0
end event

event resize;call super::resize;dw_current.height= this.height - 180

dw_current.width= this.width - 60
end event

type dw_current from datawindow within w_bollettini
integer width = 4238
integer height = 1680
integer taborder = 10
string title = "none"
string dataobject = "r_boll_sing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;if is_bollettini_s.tipo_stampa= "N" then // nominativo... 
	sqlsyntax += " and membri_gerarchica.codice='"+is_bollettini_s.criterio+"'"
else // stampa di bollettini per struttura...
	sqlsyntax += " and membri_gerarchica.vc_parent like '"+is_bollettini_s.criterio+"%'"
end if

SetSqlPreview ( sqlsyntax )
end event

