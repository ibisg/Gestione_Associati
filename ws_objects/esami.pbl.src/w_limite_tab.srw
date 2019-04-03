$PBExportHeader$w_limite_tab.srw
forward
global type w_limite_tab from window
end type
type cb_applica from commandbutton within w_limite_tab
end type
type em_soglia from editmask within w_limite_tab
end type
type st_voto from statictext within w_limite_tab
end type
end forward

global type w_limite_tab from window
integer width = 1559
integer height = 888
boolean titlebar = true
string title = "Inserimento voto minimo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_applica cb_applica
em_soglia em_soglia
st_voto st_voto
end type
global w_limite_tab w_limite_tab

event open;decimal ld_id
integer li_soglia

ld_id= message.doubleParm

select distinct soglia into :li_soglia from esami where id= :ld_id;

if trap_sql(sqlca, "INSMINIMO01") < 0 then return -1

em_soglia.text= string(li_soglia)


end event

on w_limite_tab.create
this.cb_applica=create cb_applica
this.em_soglia=create em_soglia
this.st_voto=create st_voto
this.Control[]={this.cb_applica,&
this.em_soglia,&
this.st_voto}
end on

on w_limite_tab.destroy
destroy(this.cb_applica)
destroy(this.em_soglia)
destroy(this.st_voto)
end on

type cb_applica from commandbutton within w_limite_tab
integer x = 539
integer y = 624
integer width = 398
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Applica"
end type

event clicked;integer li_soglia

li_soglia= integer(em_soglia.text)

closeWithReturn(w_limite_tab, li_soglia)
end event

type em_soglia from editmask within w_limite_tab
integer x = 416
integer y = 280
integer width = 645
integer height = 284
integer taborder = 30
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean spin = true
double increment = 1
string minmax = "1~~100"
end type

event modified;if integer(this.text) < 0 or integer(this.text) > 250 then
		messageBox(parent.title, "Votazione al di fuori dei limiti ( 0 - 250 )", information!)
		return 
	end if

if this.text= '0' then
	cb_applica.enabled= false
else
	cb_applica.enabled= true	
end if
end event

type st_voto from statictext within w_limite_tab
integer x = 27
integer y = 68
integer width = 1422
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserire il voto minimo ( tra 0 e 250 )"
boolean focusrectangle = false
end type

