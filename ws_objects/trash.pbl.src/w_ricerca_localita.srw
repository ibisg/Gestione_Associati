$PBExportHeader$w_ricerca_localita.srw
forward
global type w_ricerca_localita from w_centered
end type
type cbx_estesa from checkbox within w_ricerca_localita
end type
type cb_annulla from commandbutton within w_ricerca_localita
end type
type cb_ok from commandbutton within w_ricerca_localita
end type
type dw_current from datawindow within w_ricerca_localita
end type
end forward

global type w_ricerca_localita from w_centered
integer width = 1728
integer height = 1256
string title = "Ricerca località"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
boolean clientedge = true
event type integer ue_seleziona ( long row )
cbx_estesa cbx_estesa
cb_annulla cb_annulla
cb_ok cb_ok
dw_current dw_current
end type
global w_ricerca_localita w_ricerca_localita

type variables
boolean close_with_cb
string vi_cod_com, vi_com, vi_prov
s_parm s_parm_s

s_strade is_strade_s
end variables

event ue_seleziona;integer li_exists
string ls_cap, ls

SetPointer(HourGlass!)

if row > 0 then
	
	is_strade_s.cod_com= dw_current.GetItemString ( row, "cod_com" )
	is_strade_s.comune= dw_current.GetItemString ( row, "comune" )
	is_strade_s.provincia= dw_current.GetItemString ( row, "provincia" )
	ls_cap= dw_current.GetItemString ( row, "cap" )
	
	select count(*)  into :li_exists from cap_generici where cap= :ls_cap;
	if isNull(li_exists) or li_exists= 0 then
		is_strade_s.cap= ls_cap
	else
		is_strade_s.cap= ""
	end if
	
	CloseWithReturn ( this, is_strade_s ) // se cap = "" il cap del comune è generico, apre la finestra di ricerca cap...
	
end if

return -1
end event

on w_ricerca_localita.create
int iCurrent
call super::create
this.cbx_estesa=create cbx_estesa
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_estesa
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_current
end on

on w_ricerca_localita.destroy
call super::destroy
destroy(this.cbx_estesa)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_current)
end on

event open;call super::open;
dw_current.SetTransObject ( sqlca )

s_parm_s = message.PowerObjectParm

if s_parm_s.v_ricerca_estesa then
	
dw_current.SetTransObject ( sqlca )

s_parm_s = message.PowerObjectParm

if s_parm_s.v_ricerca_estesa then
	
	dw_current.Retrieve ( "%"+s_parm_s.v_com ) // cerca per sottostringa interna al nome della località
	
	cbx_estesa.checked= true
	
else

	dw_current.Retrieve ( s_parm_s.v_com )
	
end if
		
dw_current.SetFocus ( )
dw_current.SetTransObject ( sqlca )

s_parm_s = message.PowerObjectParm

if s_parm_s.v_ricerca_estesa then
	
	dw_current.Retrieve ( "%"+s_parm_s.v_com ) // cerca per sottostringa interna al nome della località
	
	cbx_estesa.checked= true
	
else

	dw_current.Retrieve ( s_parm_s.v_com )
	
end if
		
dw_current.SetFocus ( )
dw_current.Retrieve  ( "%"+s_parm_s.v_com ) // cerca per sottostringa interna al nome della località
	
	cbx_estesa.checked= true
	
else

	dw_current.Retrieve ( s_parm_s.v_com )
	
end if
		
dw_current.SetFocus ( )

end event

type cbx_estesa from checkbox within w_ricerca_localita
integer x = 1225
integer y = 992
integer width = 407
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Ricerca estesa"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
	dw_current.Retrieve ( "%"+s_parm_s.v_com ) // cerca per sottostringa interna al nome della località
	
else
	
	dw_current.Retrieve ( s_parm_s.v_com ) // cerca ciò che inizia con il nome dato dall'operatore
		
		
end if
	
	
dw_current.SetFocus ( )
end event

type cb_annulla from commandbutton within w_ricerca_localita
integer x = 814
integer y = 976
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;is_strade_s.cap= "999"
CloseWithReturn ( parent, is_strade_s ) // se cap = "999" annulla l'operazione...
end event

type cb_ok from commandbutton within w_ricerca_localita
integer x = 393
integer y = 976
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;return event ue_seleziona(dw_current.getRow())
end event

type dw_current from datawindow within w_ricerca_localita
integer width = 1682
integer height = 932
integer taborder = 10
string title = "none"
string dataobject = "dw_comuni"
boolean vscrollbar = true
string icon = "Question!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;return parent.event ue_seleziona(row)
end event

