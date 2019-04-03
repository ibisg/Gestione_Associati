$PBExportHeader$w_doppi.srw
forward
global type w_doppi from Window
end type
type cb_annulla from commandbutton within w_doppi
end type
type st_1 from statictext within w_doppi
end type
type cb_continua from commandbutton within w_doppi
end type
type dw_elenco from datawindow within w_doppi
end type
end forward

global type w_doppi from Window
int X=343
int Y=577
int Width=2972
int Height=1049
boolean TitleBar=true
string Title="Controllare eventuali doppi inserimenti..."
long BackColor=79741120
WindowType WindowType=response!
event ue_open ( )
cb_annulla cb_annulla
st_1 st_1
cb_continua cb_continua
dw_elenco dw_elenco
end type
global w_doppi w_doppi

event ue_open;long nr, nc, ll_rows

beep ( 1 )

ll_rows = w_asp.ds_doppi.RowCount ( )

dw_elenco.SetRedraw ( false )

for nr = 1 to ll_rows
	
	dw_elenco.InsertRow ( 0 )
	
	for nc = 1 to 4
		
		dw_elenco.SetItem ( nr, nc, w_asp.ds_doppi.GetItemString ( nr, nc ) )
		
	next
	
next

dw_elenco.SetRedraw ( true )

end event

on w_doppi.create
this.cb_annulla=create cb_annulla
this.st_1=create st_1
this.cb_continua=create cb_continua
this.dw_elenco=create dw_elenco
this.Control[]={ this.cb_annulla,&
this.st_1,&
this.cb_continua,&
this.dw_elenco}
end on

on w_doppi.destroy
destroy(this.cb_annulla)
destroy(this.st_1)
destroy(this.cb_continua)
destroy(this.dw_elenco)
end on

event open;f_centra ( w_doppi )

PostEvent ( "ue_open" )

end event

type cb_annulla from commandbutton within w_doppi
int X=1482
int Y=781
int Width=545
int Height=109
int TabOrder=30
string Text="Annulla registrazione"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( parent, -1 )

end event

type st_1 from statictext within w_doppi
int X=5
int Y=645
int Width=2958
int Height=77
boolean Enabled=false
string Text="Attenzione: vi sono nominativi uguali o simili già presenti in archivio... "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_continua from commandbutton within w_doppi
int X=915
int Y=781
int Width=545
int Height=109
int TabOrder=20
string Text="Continua"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( parent )

end event

type dw_elenco from datawindow within w_doppi
int Width=2945
int Height=561
int TabOrder=10
string DataObject="d_ext_doppi"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

