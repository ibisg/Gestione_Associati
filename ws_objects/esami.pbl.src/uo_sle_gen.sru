$PBExportHeader$uo_sle_gen.sru
forward
global type uo_sle_gen from singlelineedit
end type
end forward

global type uo_sle_gen from singlelineedit
int Width=887
int Height=81
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=31514848
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global uo_sle_gen uo_sle_gen

event modified;this.text = trim ( this.text )

end event

event getfocus;this.SelectText(1, Len(this.text))

end event

