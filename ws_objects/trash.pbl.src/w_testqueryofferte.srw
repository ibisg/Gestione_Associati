$PBExportHeader$w_testqueryofferte.srw
forward
global type w_testqueryofferte from window
end type
type dw_current from datawindow within w_testqueryofferte
end type
type sle_query from singlelineedit within w_testqueryofferte
end type
type cb_1 from commandbutton within w_testqueryofferte
end type
type sle_nodo from singlelineedit within w_testqueryofferte
end type
type sle_livello from singlelineedit within w_testqueryofferte
end type
end forward

global type w_testqueryofferte from window
integer width = 4183
integer height = 2292
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_current dw_current
sle_query sle_query
cb_1 cb_1
sle_nodo sle_nodo
sle_livello sle_livello
end type
global w_testqueryofferte w_testqueryofferte

on w_testqueryofferte.create
this.dw_current=create dw_current
this.sle_query=create sle_query
this.cb_1=create cb_1
this.sle_nodo=create sle_nodo
this.sle_livello=create sle_livello
this.Control[]={this.dw_current,&
this.sle_query,&
this.cb_1,&
this.sle_nodo,&
this.sle_livello}
end on

on w_testqueryofferte.destroy
destroy(this.dw_current)
destroy(this.sle_query)
destroy(this.cb_1)
destroy(this.sle_nodo)
destroy(this.sle_livello)
end on

type dw_current from datawindow within w_testqueryofferte
integer x = 64
integer y = 624
integer width = 3616
integer height = 1420
integer taborder = 50
string title = "none"
string dataobject = "dw_testqueryofferte"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_query from singlelineedit within w_testqueryofferte
integer x = 928
integer y = 420
integer width = 2766
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "query"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_testqueryofferte
integer x = 41
integer y = 420
integer width = 850
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura
long ll_livello, ll_nodo, ll_totale_persone, ll_row
decimal ld_importo, ld_zero

ll_livello= long(sle_livello.text)
ll_nodo= long(sle_nodo.text)
ls_query= f_creaqueryofferte(ll_livello, ll_nodo)

sle_query.text= ls_query

integer Emp_id_var

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

PREPARE SQLSA FROM :ls_query ;

OPEN DYNAMIC my_cursor ;
if trap_sql(sqlca, "QUERY01") < 0 then goto closecur

do while sqlca.sqlcode <> 100
	FETCH my_cursor INTO 
	:ls_status,
	:ld_importo,
	:ld_zero,
	:ll_totale_persone,
	:ls_cod_div,
	:ls_descrizione_struttura;
	if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
	if sqlca.sqlcode= 100 then continue
	
	ll_row= dw_current.insertRow(0)
	dw_current.setItem(ll_row, "status", ls_status)
	dw_current.setItem(ll_row, "importo", ld_importo)
	dw_current.setItem(ll_row, "zero", ld_zero)
	dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
	dw_current.setItem(ll_row, "cod_div", ls_cod_div)
	dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
loop

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1


end event
type sle_nodo from singlelineedit within w_testqueryofferte
integer x = 41
integer y = 256
integer width = 850
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "nodo"
borderstyle borderstyle = stylelowered!
end type

type sle_livello from singlelineedit within w_testqueryofferte
integer x = 41
integer y = 120
integer width = 850
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "livello"
borderstyle borderstyle = stylelowered!
end type

