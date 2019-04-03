$PBExportHeader$w_testricerca.srw
forward
global type w_testricerca from window
end type
type ddlb_1 from dropdownlistbox within w_testricerca
end type
type dw_current from datawindow within w_testricerca
end type
end forward

global type w_testricerca from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
ddlb_1 ddlb_1
dw_current dw_current
end type
global w_testricerca w_testricerca

type variables
dataWindowChild idwc_testricerca
end variables

on w_testricerca.create
this.ddlb_1=create ddlb_1
this.dw_current=create dw_current
this.Control[]={this.ddlb_1,&
this.dw_current}
end on

on w_testricerca.destroy
destroy(this.ddlb_1)
destroy(this.dw_current)
end on

event open;dw_current.getChild("vc_tgt", idwc_testricerca)

idwc_testricerca.setTransObject(sqlca)

//idwc_testricerca.retrieve()

dw_current.insertRow(0)


end event

type ddlb_1 from dropdownlistbox within w_testricerca
integer x = 46
integer y = 16
integer width = 1659
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean allowedit = true
end type

type dw_current from datawindow within w_testricerca
integer x = 1751
integer y = 8
integer width = 1312
integer height = 120
integer taborder = 20
string title = "none"
string dataobject = "dw_testricerca"
end type

event editchanged;//setText(f_replace_string(data, "'", "~'") )
//return 0
long ll_rows
dw_current.getChild("vc_tgt", idwc_testricerca)

idwc_testricerca.setTransObject(sqlca)
ll_rows= idwc_testricerca.retrieve(data+"%")
return 0
end event

