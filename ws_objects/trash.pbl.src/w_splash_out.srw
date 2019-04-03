$PBExportHeader$w_splash_out.srw
forward
global type w_splash_out from window
end type
type p_splash from picture within w_splash_out
end type
end forward

global type w_splash_out from window
integer width = 1975
integer height = 1316
windowtype windowtype = response!
long backcolor = 67108864
boolean clientedge = true
boolean center = true
windowanimationstyle openanimation = fadeanimation!
windowanimationstyle closeanimation = fadeanimation!
integer animationtime = 300
p_splash p_splash
end type
global w_splash_out w_splash_out

event open;timer (3)
end event

event timer;close(this)
end event

on w_splash_out.create
this.p_splash=create p_splash
this.Control[]={this.p_splash}
end on

on w_splash_out.destroy
destroy(this.p_splash)
end on

type p_splash from picture within w_splash_out
integer width = 1943
integer height = 1276
boolean originalsize = true
string picturename = "\\Rmtsrv1\pubblica\gds bkup\chuckandsnoopy_piccola.jpg"
boolean map3dcolors = true
end type

