$PBExportHeader$w_loadsgi.srw
forward
global type w_loadsgi from window
end type
type sle_1 from singlelineedit within w_loadsgi
end type
type cb_1 from commandbutton within w_loadsgi
end type
end forward

global type w_loadsgi from window
integer width = 2318
integer height = 1008
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
sle_1 sle_1
cb_1 cb_1
end type
global w_loadsgi w_loadsgi

type variables
transaction sqlca_sgi
end variables

on w_loadsgi.create
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_1}
end on

on w_loadsgi.destroy
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_1 from singlelineedit within w_loadsgi
integer x = 1161
integer y = 488
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_loadsgi
integer x = 1134
integer y = 304
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;string descrizione, desc_breve, ev_tipo
decimal ev_id, ev_prec
datetime dataev
integer i_loop, li_ret
string ls_codice

declare pippo_cur cursor for select codice
from membri_gerarchica where cod_dis= 'ISG'
using sqlca;

open pippo_cur;

if trap_sql( sqlca, "SGI01") < 0 then goto errore

 do while  sqlca.sqlcode <> 100
	
	fetch pippo_cur into :ls_codice;
	
	if sqlca.sqlcode = 100 then continue
	
	li_ret= f_insert_fuori_struttura(ls_codice, 'ISG')
	
	if li_ret= -1 then goto errore
	
	i_loop++
	
	sle_1.text= string(i_loop)
	
loop

commit;

return 0

errore: 

rollback;

return -1
	

end event

