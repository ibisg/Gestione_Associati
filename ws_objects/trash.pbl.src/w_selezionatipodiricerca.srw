$PBExportHeader$w_selezionatipodiricerca.srw
forward
global type w_selezionatipodiricerca from window
end type
type cb_annulla from commandbutton within w_selezionatipodiricerca
end type
type cb_seleziona from commandbutton within w_selezionatipodiricerca
end type
type dw_current from datawindow within w_selezionatipodiricerca
end type
end forward

global type w_selezionatipodiricerca from window
integer width = 1499
integer height = 1320
boolean titlebar = true
string title = "Seleziona tipo di ricerca"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
cb_seleziona cb_seleziona
dw_current dw_current
end type
global w_selezionatipodiricerca w_selezionatipodiricerca

on w_selezionatipodiricerca.create
this.cb_annulla=create cb_annulla
this.cb_seleziona=create cb_seleziona
this.dw_current=create dw_current
this.Control[]={this.cb_annulla,&
this.cb_seleziona,&
this.dw_current}
end on

on w_selezionatipodiricerca.destroy
destroy(this.cb_annulla)
destroy(this.cb_seleziona)
destroy(this.dw_current)
end on

event open;integer li_ret
string ls_customreportpath, ls_entries

ls_customreportpath= gs_docdir+"\"+gs_customreportpath
ls_entries= libraryDirectory(ls_customreportpath, DirDataWindow!)

li_ret= dw_current.importString(ls_entries)

if li_ret <= 0 then
	
	messageBox(this.title, "OPEN: Errore N. "+string(li_ret)+" in inportString")
	return 0
	
end if

dw_current.sort()
end event

type cb_annulla from commandbutton within w_selezionatipodiricerca
integer x = 1115
integer y = 1092
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type cb_seleziona from commandbutton within w_selezionatipodiricerca
integer x = 558
integer y = 1092
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
boolean default = true
end type

event clicked;dw_current.triggerEvent( doubleClicked!)
end event

type dw_current from datawindow within w_selezionatipodiricerca
integer width = 1458
integer height = 1056
integer taborder = 10
string title = "none"
string dataobject = "dw_listobjects"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;string ls_dw

ls_dw= this.getItemString(this.getRow(), "col1")

closeWithReturn(parent, ls_dw)
end event

event rowfocuschanged;f_select_current_row(this)
end event

