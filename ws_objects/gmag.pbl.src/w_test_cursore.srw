$PBExportHeader$w_test_cursore.srw
forward
global type w_test_cursore from window
end type
type sle_1 from singlelineedit within w_test_cursore
end type
type cb_1 from commandbutton within w_test_cursore
end type
end forward

global type w_test_cursore from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_1 sle_1
cb_1 cb_1
end type
global w_test_cursore w_test_cursore

on w_test_cursore.create
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_1}
end on

on w_test_cursore.destroy
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_1 from singlelineedit within w_test_cursore
integer x = 288
integer y = 364
integer width = 631
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

type cb_1 from commandbutton within w_test_cursore
integer x = 416
integer y = 100
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

event clicked;integer i_pippo
string s1, s2, s3

declare pippo cursor for
select cod_dip, cod_luogo, cod_sala from eventi;

open pippo;

do 
	
	i_pippo++
	
	fetch pippo into
	:s1, :s2, :s3;
	
	if trap_sql(sqlca, "1") < 0 then return
	
loop while sqlca.sqlcode <> 100

close pippo;

sle_1.text= string( i_pippo )




end event

