$PBExportHeader$w_msgauto.srw
forward
global type w_msgauto from Window
end type
type st_msg from statictext within w_msgauto
end type
end forward

global type w_msgauto from Window
int X=1409
int Y=1117
int Width=1057
int Height=465
boolean TitleBar=true
string Title="Operazione in corso"
long BackColor=12632256
WindowType WindowType=popup!
st_msg st_msg
end type
global w_msgauto w_msgauto

on w_msgauto.create
this.st_msg=create st_msg
this.Control[]={ this.st_msg}
end on

on w_msgauto.destroy
destroy(this.st_msg)
end on

event open;f_centra ( w_msgauto )

st_msg.text = Message.StringParm

timer ( 1.5 )

end event

event timer;timer ( 0 )

close ( this )

end event

type st_msg from statictext within w_msgauto
int X=28
int Y=93
int Width=983
int Height=237
boolean Enabled=false
string Text="Salvataggio effettuato."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

