$PBExportHeader$w_cerca_strade_old.srw
forward
global type w_cerca_strade_old from w_centered
end type
type cb_annulla from commandbutton within w_cerca_strade_old
end type
type dw_current from datawindow within w_cerca_strade_old
end type
type mle_warning from multilineedit within w_cerca_strade_old
end type
type cb_selcap from commandbutton within w_cerca_strade_old
end type
type cb_seltutto from commandbutton within w_cerca_strade_old
end type
type cb_query from commandbutton within w_cerca_strade_old
end type
type st_1 from statictext within w_cerca_strade_old
end type
end forward

global type w_cerca_strade_old from w_centered
integer width = 3799
integer height = 1660
long backcolor = 81324524
cb_annulla cb_annulla
dw_current dw_current
mle_warning mle_warning
cb_selcap cb_selcap
cb_seltutto cb_seltutto
cb_query cb_query
st_1 st_1
end type
global w_cerca_strade_old w_cerca_strade_old

type variables
string is_codcom
end variables

event open;call super::open;dw_current.setRowFocusIndicator(focusRect!)

dw_current.SetTransObject ( sqlca )

is_codcom = message.stringParm

dw_current.Object.DataWindow.QueryMode= 'yes'


//
//dw_elenco.Retrieve ( str_parm.v_com )
//		
dw_current.SetFocus ( )
end event

on w_cerca_strade_old.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.dw_current=create dw_current
this.mle_warning=create mle_warning
this.cb_selcap=create cb_selcap
this.cb_seltutto=create cb_seltutto
this.cb_query=create cb_query
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.dw_current
this.Control[iCurrent+3]=this.mle_warning
this.Control[iCurrent+4]=this.cb_selcap
this.Control[iCurrent+5]=this.cb_seltutto
this.Control[iCurrent+6]=this.cb_query
this.Control[iCurrent+7]=this.st_1
end on

on w_cerca_strade_old.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.dw_current)
destroy(this.mle_warning)
destroy(this.cb_selcap)
destroy(this.cb_seltutto)
destroy(this.cb_query)
destroy(this.st_1)
end on

type cb_annulla from commandbutton within w_cerca_strade_old
integer x = 2962
integer y = 948
integer width = 558
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annulla"
boolean cancel = true
end type

event clicked;s_strade s_strade_s

setNull(s_strade_s.cap)

closeWithReturn(parent, s_strade_s)
end event

type dw_current from datawindow within w_cerca_strade_old
integer x = 32
integer y = 124
integer width = 2907
integer height = 1380
integer taborder = 10
string title = "none"
string dataobject = "dw_cerca_strade"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)
	
SetSqlPreview ( sqlsyntax )
end event

type mle_warning from multilineedit within w_cerca_strade_old
integer x = 2953
integer y = 616
integer width = 558
integer height = 308
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388736
long backcolor = 81324524
string text = "(Attenzione: inserendo un nuovo indirizzo in automatico ricordarsi di inserire manualmente il nuovo numero civico)"
boolean border = false
end type

type cb_selcap from commandbutton within w_cerca_strade_old
integer x = 2962
integer y = 460
integer width = 558
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Inserisci solo C.A.P."
end type

event clicked;s_strade s_strade_s

s_strade_s.strada= ""
s_strade_s.tipo= ""
s_strade_s.cap= dw_current.getItemString(dw_current.getRow(), "cap")

closeWithReturn(parent, s_strade_s)
end event

type cb_seltutto from commandbutton within w_cerca_strade_old
integer x = 2962
integer y = 292
integer width = 558
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Inserisci strada e C.A.P."
end type

event clicked;s_strade s_strade_s

s_strade_s.strada= dw_current.getItemString(dw_current.getRow(), "strada")
s_strade_s.tipo= dw_current.getItemString(dw_current.getRow(), "tipo")
s_strade_s.cap= dw_current.getItemString(dw_current.getRow(), "cap")

closeWithReturn(parent, s_strade_s)
end event

type cb_query from commandbutton within w_cerca_strade_old
integer x = 2962
integer y = 124
integer width = 558
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Estrazione"
boolean default = true
end type

event clicked;long ll_rows

dw_current.setRedraw(false)

if dw_current.Object.DataWindow.QueryMode= 'yes' then
	
	cb_annulla.enabled= false

	dw_current.acceptText()
	dw_current.Object.DataWindow.QueryMode= 'no' 
	ll_rows= dw_current.retrieve(is_codcom)
	cb_query.text= "Ricerca"
	cb_selcap.enabled= true
	cb_seltutto.enabled= true
	
else
//	dw_current.reset()
	cb_query.text= "Estrazione"
	cb_selcap.enabled= false
	cb_seltutto.enabled= false
	dw_current.Object.DataWindow.QueryClear= 'yes'
	dw_current.Object.DataWindow.QueryMode= 'yes' 
end if

dw_current.setRedraw(true)

cb_annulla.enabled= true

dw_current.setFocus()

end event

type st_1 from statictext within w_cerca_strade_old
integer x = 46
integer y = 32
integer width = 3168
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Inserire parte del nome della strada cercata e fare un click sul tasto Estrazione; per es. per cercare ~"VIA VINCENZO BELLINI~" inserire  ~"BELLINI~" ."
boolean focusrectangle = false
end type

