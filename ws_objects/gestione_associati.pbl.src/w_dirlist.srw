$PBExportHeader$w_dirlist.srw
forward
global type w_dirlist from w_centered
end type
type cb_importa from commandbutton within w_dirlist
end type
type cb_annulla from commandbutton within w_dirlist
end type
type st_dir from statictext within w_dirlist
end type
type lb_dirlist from listbox within w_dirlist
end type
end forward

global type w_dirlist from w_centered
integer height = 1568
string title = "Contenuto cartella"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_importa cb_importa
cb_annulla cb_annulla
st_dir st_dir
lb_dirlist lb_dirlist
end type
global w_dirlist w_dirlist

type variables
string is_filename
end variables

on w_dirlist.create
int iCurrent
call super::create
this.cb_importa=create cb_importa
this.cb_annulla=create cb_annulla
this.st_dir=create st_dir
this.lb_dirlist=create lb_dirlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.st_dir
this.Control[iCurrent+4]=this.lb_dirlist
end on

on w_dirlist.destroy
call super::destroy
destroy(this.cb_importa)
destroy(this.cb_annulla)
destroy(this.st_dir)
destroy(this.lb_dirlist)
end on

event open;call super::open;string ls_path

ls_path= message.stringParm

lb_dirlist.DirList(ls_path, 0, st_dir )

//lb_dirlist.DirList("d:\svil\firme\*.jpg", 0, st_dir )
//listboxname.DirList ( filespec, filetype, st_dir )
end event

type cb_importa from commandbutton within w_dirlist
integer x = 1047
integer y = 1276
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
boolean cancel = true
boolean default = true
end type

event clicked;lb_dirlist.event doubleClicked(lb_dirlist.SelectedIndex ())
end event

type cb_annulla from commandbutton within w_dirlist
integer x = 2103
integer y = 1276
integer width = 402
integer height = 112
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

type st_dir from statictext within w_dirlist
integer y = 1152
integer width = 2496
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type lb_dirlist from listbox within w_dirlist
integer width = 2505
integer height = 1136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;IF is_filename<> "" THEN
	
	is_filename= st_dir.text+"\"+is_filename

	closeWithReturn(parent, is_filename)


END IF
end event

event selectionchanged;lb_DirList.DirSelect(is_filename)
end event

