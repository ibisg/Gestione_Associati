$PBExportHeader$w_ricercanominativa.srw
forward
global type w_ricercanominativa from window
end type
type cb_chiudi from commandbutton within w_ricercanominativa
end type
type cb_dbcancel from commandbutton within w_ricercanominativa
end type
type cb_query from commandbutton within w_ricercanominativa
end type
type dw_current from datawindow within w_ricercanominativa
end type
end forward

global type w_ricercanominativa from window
integer width = 2926
integer height = 1876
boolean titlebar = true
string title = "Ricerca niominativa"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Query5!"
boolean clientedge = true
cb_chiudi cb_chiudi
cb_dbcancel cb_dbcancel
cb_query cb_query
dw_current dw_current
end type
global w_ricercanominativa w_ricercanominativa

type variables
s_ricercanominativa is_ricercanominativa_s

boolean ib_dbcancel
end variables

on w_ricercanominativa.create
this.cb_chiudi=create cb_chiudi
this.cb_dbcancel=create cb_dbcancel
this.cb_query=create cb_query
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.cb_dbcancel,&
this.cb_query,&
this.dw_current}
end on

on w_ricercanominativa.destroy
destroy(this.cb_chiudi)
destroy(this.cb_dbcancel)
destroy(this.cb_query)
destroy(this.dw_current)
end on

event open;f_centra(w_ricercanominativa)

dw_current.setTransObject(sqlca)

cb_query.triggerEvent(clicked!)
end event

type cb_chiudi from commandbutton within w_ricercanominativa
integer x = 2432
integer y = 1552
integer width = 425
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;is_ricercanominativa_s.sede=""

closeWithReturn(parent, is_ricercanominativa_s)
end event

type cb_dbcancel from commandbutton within w_ricercanominativa
integer x = 1998
integer y = 1552
integer width = 425
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla estrazione"
end type

event clicked;ib_dbcancel= true
end event

type cb_query from commandbutton within w_ricercanominativa
integer x = 1563
integer y = 1552
integer width = 425
integer height = 112
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

event clicked;long ll_rows

setPointer(hourGlass!)

dw_current.setRedraw(false)

ricerca:	if dw_current.Object.DataWindow.QueryMode= 'yes' then
	
				dw_current.acceptText()
				dw_current.Object.DataWindow.QueryMode= 'no' 
				cb_dbcancel.enabled= true
				ll_rows= dw_current.retrieve()
				cb_dbcancel.enabled= false
				cb_query.text= "Ricerca"
				if ll_rows = 0 then
					messageBox(parent.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					dw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
			else
			//	dw_current.reset()
				cb_query.text= "Estrazione"
				dw_current.Object.DataWindow.QueryClear= 'yes'
				dw_current.Object.DataWindow.QueryMode= 'yes' 
			
				cb_dbcancel.enabled= false
		end if

dw_current.setRedraw(true)

dw_current.setFocus()
end event

type dw_current from datawindow within w_ricercanominativa
integer width = 2857
integer height = 1476
integer taborder = 10
string title = "none"
string dataobject = "dw_ricercanominativa"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;if row <= 0 then return 0

is_ricercanominativa_s.data_esame= this.getItemDatetime(row, "data_esame")
is_ricercanominativa_s.sede= this.getItemString(row, "sede")
is_ricercanominativa_s.cod_studio= this.getItemString(row, "cod_studio")
is_ricercanominativa_s.codice_membro= this.getItemNumber(row, "codice_membro")
is_ricercanominativa_s.cod_dip= this.getItemString(row, "cod_dip")
is_ricercanominativa_s.cognome= this.getItemString(row, "cognome")
is_ricercanominativa_s.nome= this.getItemString(row, "nome")

closeWithReturn(parent, is_ricercanominativa_s)

end event

event retrieverow;yield()

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)
	
SetSqlPreview ( sqlsyntax )
end event
