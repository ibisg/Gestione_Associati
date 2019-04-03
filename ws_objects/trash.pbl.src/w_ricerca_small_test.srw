$PBExportHeader$w_ricerca_small_test.srw
forward
global type w_ricerca_small_test from w_centered
end type
type cb_1 from commandbutton within w_ricerca_small_test
end type
type uodw_current from uodw_generica within w_ricerca_small_test
end type
type cb_importa from commandbutton within w_ricerca_small_test
end type
type cb_dbcancel from commandbutton within w_ricerca_small_test
end type
type cb_query from commandbutton within w_ricerca_small_test
end type
type cb_annulla from commandbutton within w_ricerca_small_test
end type
end forward

global type w_ricerca_small_test from w_centered
integer width = 3570
integer height = 1996
string title = "Ricerca"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
cb_1 cb_1
uodw_current uodw_current
cb_importa cb_importa
cb_dbcancel cb_dbcancel
cb_query cb_query
cb_annulla cb_annulla
end type
global w_ricerca_small_test w_ricerca_small_test

type variables
boolean ib_resize= false, ib_dbcancel
s_strade is_strade_s
end variables

event open;call super::open;uodw_current.setRowFocusIndicator(focusRect!)

uodw_current.SetTransObject ( sqlca )

uodw_current.Object.DataWindow.QueryMode= 'yes'

uodw_current.SetFocus ( )
end event

event resize;call super::resize;if ib_resize= true then uodw_current.height= this.height - 180
end event

on w_ricerca_small_test.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uodw_current=create uodw_current
this.cb_importa=create cb_importa
this.cb_dbcancel=create cb_dbcancel
this.cb_query=create cb_query
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uodw_current
this.Control[iCurrent+3]=this.cb_importa
this.Control[iCurrent+4]=this.cb_dbcancel
this.Control[iCurrent+5]=this.cb_query
this.Control[iCurrent+6]=this.cb_annulla
end on

on w_ricerca_small_test.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.uodw_current)
destroy(this.cb_importa)
destroy(this.cb_dbcancel)
destroy(this.cb_query)
destroy(this.cb_annulla)
end on

type cb_1 from commandbutton within w_ricerca_small_test
integer x = 2971
integer y = 896
integer width = 558
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Estrazione"
boolean default = true
end type

event clicked;parent.setRedraw(false)
uodw_current.uof_esegui(gc_ricerca)
parent.setRedraw(true)
end event

type uodw_current from uodw_generica within w_ricerca_small_test
integer x = 23
integer width = 2907
integer taborder = 10
string dataobject = "dw_sel_aventidiritto"
boolean ib_isgrid = true
boolean ib_querymode = true
end type

type cb_importa from commandbutton within w_ricerca_small_test
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
string text = "Importa"
boolean cancel = true
end type

event clicked;uodw_current.triggerEvent(doubleClicked!)
end event

type cb_dbcancel from commandbutton within w_ricerca_small_test
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
string text = "Annulla l~'estrazione"
boolean cancel = true
end type

event clicked;ib_dbcancel= true
end event

type cb_query from commandbutton within w_ricerca_small_test
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
string text = "Estrazione"
boolean default = true
end type

event clicked;long ll_rows

setPointer(hourGlass!)

uodw_current.setRedraw(false)

ricerca:	if uodw_current.Object.DataWindow.QueryMode= 'yes' then
	
				cb_annulla.enabled= false
				cb_importa.enabled= false
			
				uodw_current.acceptText()
				uodw_current.Object.DataWindow.QueryMode= 'no' 
				cb_dbcancel.enabled= true
				ll_rows= uodw_current.retrieve(is_strade_s.cod_com)
				cb_dbcancel.enabled= false
				cb_query.text= "Ricerca"
				if ll_rows = 0 then
					messageBox(parent.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					uodw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
				cb_importa.enabled= true
				
			else
			//	dw_current.reset()
				cb_query.text= "Estrazione"
				uodw_current.Object.DataWindow.QueryClear= 'yes'
				uodw_current.Object.DataWindow.QueryMode= 'yes' 
				
				cb_importa.enabled= false
				cb_dbcancel.enabled= false
		end if

uodw_current.setRedraw(true)

cb_annulla.enabled= true

uodw_current.setFocus()

end event

type cb_annulla from commandbutton within w_ricerca_small_test
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
string text = "Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

