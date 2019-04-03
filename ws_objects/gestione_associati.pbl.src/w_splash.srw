$PBExportHeader$w_splash.srw
forward
global type w_splash from window
end type
type p_splash from picture within w_splash
end type
end forward

global type w_splash from window
integer width = 1975
integer height = 1316
windowtype windowtype = response!
long backcolor = 67108864
boolean clientedge = true
boolean center = true
integer animationtime = 50
p_splash p_splash
end type
global w_splash w_splash

event open;timer (2)
end event

event timer;close(this)
end event

on w_splash.create
this.p_splash=create p_splash
this.Control[]={this.p_splash}
end on

on w_splash.destroy
destroy(this.p_splash)
end on

type p_splash from picture within w_splash
integer width = 1943
integer height = 1276
boolean originalsize = true
string picturename = "chuckandsnoopy_piccola.jpg"
boolean map3dcolors = true
end type

