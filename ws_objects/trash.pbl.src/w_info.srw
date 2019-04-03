$PBExportHeader$w_info.srw
forward
global type w_info from window
end type
type cbx_importi from checkbox within w_info
end type
type cb_stampa from commandbutton within w_info
end type
type cb_chiudi from commandbutton within w_info
end type
type dw_current from datawindow within w_info
end type
end forward

global type w_info from window
integer x = 832
integer y = 360
integer width = 3346
integer height = 1464
boolean titlebar = true
string title = "Contributi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cbx_importi cbx_importi
cb_stampa cb_stampa
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_info w_info

on w_info.create
this.cbx_importi=create cbx_importi
this.cb_stampa=create cb_stampa
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cbx_importi,&
this.cb_stampa,&
this.cb_chiudi,&
this.dw_current}
end on

on w_info.destroy
destroy(this.cbx_importi)
destroy(this.cb_stampa)
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

event open;s_famiglia s_cod_s
long l_ret

f_centra ( w_info )

s_cod_s= message.powerObjectParm

dw_current.setTransObject(sqlca)

dw_current.setRedraw(false)

l_ret= dw_current.retrieve(s_cod_s.codice_membro, s_cod_s.cod_dip)

dw_current.Object.importo.Visible= 0

if l_ret > 0 and u_lev = 1 then
		
		cb_stampa.enabled= true
		cbx_importi.visible= true
		
end if

dw_current.setRedraw(true)

return l_ret
		
		


end event

type cbx_importi from checkbox within w_info
boolean visible = false
integer x = 2839
integer y = 480
integer width = 471
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Visualizza importi"
end type

event clicked;integer i_ret

if this.checked= true then
	
	open(w_check_pw)
	
	i_ret= message.doubleParm
	
	if i_ret= 1 then
		
		//visualizza gli importi
		dw_current.Object.importo.Visible= 1
		dw_current.Object.importo_t.Visible= 1
		
	else
		
		this.checked= false
		
	end if
	
else
	
	dw_current.Object.importo.Visible= 0
	dw_current.Object.importo_t.Visible= 0
	
end if
end event
type cb_stampa from commandbutton within w_info
event clicked pbm_bnclicked
integer x = 2839
integer y = 196
integer width = 247
integer height = 108
integer taborder = 2
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Stampa"
end type

event clicked;openWithParm(w_dw_print_options, dw_current)
end event

type cb_chiudi from commandbutton within w_info
event clicked pbm_bnclicked
integer x = 2839
integer y = 320
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_info
integer x = 18
integer y = 12
integer width = 2766
integer height = 1340
integer taborder = 10
string dataobject = "dw_info"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

