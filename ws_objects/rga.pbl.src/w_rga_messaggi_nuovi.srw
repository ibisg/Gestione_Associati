$PBExportHeader$w_rga_messaggi_nuovi.srw
forward
global type w_rga_messaggi_nuovi from window
end type
type cb_annulla from commandbutton within w_rga_messaggi_nuovi
end type
type cb_invia from commandbutton within w_rga_messaggi_nuovi
end type
type dw_rga_messaggi_nuovi from datawindow within w_rga_messaggi_nuovi
end type
end forward

global type w_rga_messaggi_nuovi from window
integer width = 2405
integer height = 1660
boolean titlebar = true
string title = "Nuovi messaggi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "DataPipeline!"
boolean center = true
cb_annulla cb_annulla
cb_invia cb_invia
dw_rga_messaggi_nuovi dw_rga_messaggi_nuovi
end type
global w_rga_messaggi_nuovi w_rga_messaggi_nuovi

type variables
string is_nodo
end variables

on w_rga_messaggi_nuovi.create
this.cb_annulla=create cb_annulla
this.cb_invia=create cb_invia
this.dw_rga_messaggi_nuovi=create dw_rga_messaggi_nuovi
this.Control[]={this.cb_annulla,&
this.cb_invia,&
this.dw_rga_messaggi_nuovi}
end on

on w_rga_messaggi_nuovi.destroy
destroy(this.cb_annulla)
destroy(this.cb_invia)
destroy(this.dw_rga_messaggi_nuovi)
end on

event open;s_messaggi ls_messaggi_s

ls_messaggi_s= message.powerObjectParm

is_nodo= ls_messaggi_s.vc_nodo

dw_rga_messaggi_nuovi.setTransObject(sqlca)

dw_rga_messaggi_nuovi.insertRow(0)

dw_rga_messaggi_nuovi.setItem(1, "vc_nodo", is_nodo)

dw_rga_messaggi_nuovi.setItem(1, "flag_letto", 0)

dw_rga_messaggi_nuovi.setItem(1, "mittente", 'S')

dw_rga_messaggi_nuovi.setItem(1, "oggetto", ls_messaggi_s.oggetto)

end event

type cb_annulla from commandbutton within w_rga_messaggi_nuovi
integer x = 2071
integer y = 1456
integer width = 283
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_invia from commandbutton within w_rga_messaggi_nuovi
integer x = 1056
integer y = 1452
integer width = 283
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Invia"
end type

event clicked;if dw_rga_messaggi_nuovi.update()= 1 then
	commit;
	open(w_message)
else
	open(w_message_negative)
	rollback;
end if
close(parent)
	
end event

type dw_rga_messaggi_nuovi from datawindow within w_rga_messaggi_nuovi
integer x = 46
integer width = 2309
integer height = 1420
integer taborder = 20
string title = "none"
string dataobject = "dw_rga_messaggi_nuovi"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;if dwo.name= "b_invia" then
	
	integer li_ret
	
	//li_ret= uodw_messaggi.uof_aggiorna()
	
	this.update()
	
	closeWithReturn(parent, li_ret)
	
end if

if dwo.name= "b_annulla" then
	
	closeWithReturn(parent, -1)
	
end if
end event

