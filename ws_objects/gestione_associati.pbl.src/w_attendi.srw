$PBExportHeader$w_attendi.srw
forward
global type w_attendi from w_centered
end type
type p_1 from picture within w_attendi
end type
end forward

global type w_attendi from w_centered
integer width = 1582
integer height = 956
boolean resizable = false
long backcolor = 81324524
string icon = "Information!"
boolean center = true
p_1 p_1
end type
global w_attendi w_attendi

on w_attendi.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_attendi.destroy
call super::destroy
destroy(this.p_1)
end on

type p_1 from picture within w_attendi
integer x = 960
integer y = 20
integer width = 585
integer height = 512
boolean originalsize = true
string picturename = "Snoopy_Writing.JPG"
boolean focusrectangle = false
end type

