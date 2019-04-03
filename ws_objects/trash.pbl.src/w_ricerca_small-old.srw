$PBExportHeader$w_ricerca_small-old.srw
forward
global type w_ricerca_small-old from w_centered
end type
type dw_current from datawindow within w_ricerca_small-old
end type
type cb_importa from commandbutton within w_ricerca_small-old
end type
type cb_dbcancel from commandbutton within w_ricerca_small-old
end type
type cb_query from commandbutton within w_ricerca_small-old
end type
type cb_annulla from commandbutton within w_ricerca_small-old
end type
end forward

global type w_ricerca_small-old from w_centered
integer width = 3570
integer height = 1996
string title = "Ricerca"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
dw_current dw_current
cb_importa cb_importa
cb_dbcancel cb_dbcancel
cb_query cb_query
cb_annulla cb_annulla
end type
global w_ricerca_small-old w_ricerca_small-old

type variables
boolean ib_resize= false, ib_dbcancel, ib_sqluselike, ib_selectrow
s_strade is_strade_s
end variables

event open;call super::open;dw_current.setRowFocusIndicator(focusRect!)

dw_current.SetTransObject ( sqlca )

dw_current.Object.DataWindow.QueryMode= 'yes'

dw_current.SetFocus ( )
end event

event resize;call super::resize;if ib_resize= true then dw_current.height= this.height - 180
end event

on w_ricerca_small-old.create
int iCurrent
call super::create
this.dw_current=create dw_current
this.cb_importa=create cb_importa
this.cb_dbcancel=create cb_dbcancel
this.cb_query=create cb_query
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.cb_dbcancel
this.Control[iCurrent+4]=this.cb_query
this.Control[iCurrent+5]=this.cb_annulla
end on

on w_ricerca_small-old.destroy
call super::destroy
destroy(this.dw_current)
destroy(this.cb_importa)
destroy(this.cb_dbcancel)
destroy(this.cb_query)
destroy(this.cb_annulla)
end on

type dw_current from datawindow within w_ricerca_small-old
integer width = 2907
integer height = 1380
integer taborder = 20
string title = "none"
string dataobject = "dw_ricerca_associati"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)
		
	SetSqlPreview ( sqlsyntax )
end if
end event

event rowfocuschanged;if ib_selectrow then f_select_current_row(this)
end event

type cb_importa from commandbutton within w_ricerca_small-old
integer x = 2962
integer y = 688
integer width = 558
integer height = 192
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "4-Importa"
boolean cancel = true
end type

event clicked;dw_current.triggerEvent(doubleClicked!)
end event

type cb_dbcancel from commandbutton within w_ricerca_small-old
integer x = 2962
integer y = 472
integer width = 558
integer height = 192
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "3-Annulla l~'estrazione"
boolean cancel = true
end type

event clicked;ib_dbcancel= true
end event

type cb_query from commandbutton within w_ricerca_small-old
integer x = 2962
integer y = 24
integer width = 558
integer height = 192
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "1-Estrazione"
boolean default = true
end type

event clicked;long ll_rows

setPointer(hourGlass!)

dw_current.setRedraw(false)

ricerca:	if dw_current.Object.DataWindow.QueryMode= 'yes' then
	
				cb_annulla.enabled= false
				cb_importa.enabled= false
			
				dw_current.acceptText()
				dw_current.Object.DataWindow.QueryMode= 'no' 
				cb_dbcancel.enabled= true
				ll_rows= dw_current.retrieve(is_strade_s.cod_com)
				cb_dbcancel.enabled= false
				cb_query.text= "Ricerca"
				if ll_rows = 0 then
					messageBox(parent.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					dw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
				cb_importa.enabled= true
				
			else
			//	dw_current.reset()
				cb_query.text= "Estrazione"
				dw_current.Object.DataWindow.QueryClear= 'yes'
				dw_current.Object.DataWindow.QueryMode= 'yes' 
				
				cb_importa.enabled= false
				cb_dbcancel.enabled= false
		end if

dw_current.setRedraw(true)

cb_annulla.enabled= true

dw_current.setFocus()

end event

type cb_annulla from commandbutton within w_ricerca_small-old
integer x = 2962
integer y = 256
integer width = 558
integer height = 192
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "2-Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

