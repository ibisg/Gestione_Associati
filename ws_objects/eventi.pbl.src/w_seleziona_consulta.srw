$PBExportHeader$w_seleziona_consulta.srw
forward
global type w_seleziona_consulta from window
end type
type cb_importa from commandbutton within w_seleziona_consulta
end type
type cb_annulla from commandbutton within w_seleziona_consulta
end type
type dw_current from datawindow within w_seleziona_consulta
end type
end forward

global type w_seleziona_consulta from window
integer width = 1303
integer height = 868
boolean titlebar = true
string title = "Seleziona divisioni"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_importa cb_importa
cb_annulla cb_annulla
dw_current dw_current
end type
global w_seleziona_consulta w_seleziona_consulta

event open;dw_current.setTransObject(sqlca)
dw_current.retrieve()
end event

on w_seleziona_consulta.create
this.cb_importa=create cb_importa
this.cb_annulla=create cb_annulla
this.dw_current=create dw_current
this.Control[]={this.cb_importa,&
this.cb_annulla,&
this.dw_current}
end on

on w_seleziona_consulta.destroy
destroy(this.cb_importa)
destroy(this.cb_annulla)
destroy(this.dw_current)
end on

type cb_importa from commandbutton within w_seleziona_consulta
integer x = 457
integer y = 600
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
end type

event clicked;long ll_idx
string ls_filter, ls_ok, ls_div

for ll_idx= 1 to dw_current.rowCount()
	
	ls_ok= dw_current.getItemString(ll_idx, "ok")
	ls_div= dw_current.getItemString(ll_idx, "cod_div")
	
	if ls_ok= '1'  then
		 
		 if len(ls_filter)= 0 then
			
			ls_filter= "cod_div= '"+ls_div+"' "
			
		else
			
			ls_filter += " or cod_div='"+ls_div+"' "
			
		end if
		
	end if
	
next

closeWithReturn(parent, ls_filter)
end event

type cb_annulla from commandbutton within w_seleziona_consulta
integer x = 914
integer y = 600
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closeWithReturn(parent, "")
end event

type dw_current from datawindow within w_seleziona_consulta
integer width = 1257
integer height = 584
integer taborder = 10
string title = "none"
string dataobject = "dw_seleziona_div"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

