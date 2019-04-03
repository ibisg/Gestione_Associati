$PBExportHeader$w_ricercapercomuni-old.srw
forward
global type w_ricercapercomuni-old from window
end type
type cb_dom from commandbutton within w_ricercapercomuni-old
end type
type sle_filtro from singlelineedit within w_ricercapercomuni-old
end type
type pb_ordina from picturebutton within w_ricercapercomuni-old
end type
type sle_struttura from singlelineedit within w_ricercapercomuni-old
end type
type st_2 from statictext within w_ricercapercomuni-old
end type
type st_1 from statictext within w_ricercapercomuni-old
end type
type pb_go from picturebutton within w_ricercapercomuni-old
end type
type cbx_resp from checkbox within w_ricercapercomuni-old
end type
type ddlb_provincia from dropdownlistbox within w_ricercapercomuni-old
end type
type ddlb_regione from dropdownlistbox within w_ricercapercomuni-old
end type
type dw_current from datawindow within w_ricercapercomuni-old
end type
type gb_criteri from groupbox within w_ricercapercomuni-old
end type
type gb_filtro from groupbox within w_ricercapercomuni-old
end type
end forward

global type w_ricercapercomuni-old from window
integer width = 3749
integer height = 2108
boolean titlebar = true
string title = "Ricerca per località"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_dom cb_dom
sle_filtro sle_filtro
pb_ordina pb_ordina
sle_struttura sle_struttura
st_2 st_2
st_1 st_1
pb_go pb_go
cbx_resp cbx_resp
ddlb_provincia ddlb_provincia
ddlb_regione ddlb_regione
dw_current dw_current
gb_criteri gb_criteri
gb_filtro gb_filtro
end type
global w_ricercapercomuni-old w_ricercapercomuni-old

type variables
string is_regione, is_provincia, is_comune
end variables

event open;integer li_index= 1
string ls_regione

dw_current.setRowFocusIndicator(hand!)

dw_current.setTransObject(sqlca)

declare regioni_cur cursor for
select distinct regione
from tab_comuni
where cod_com > "000000"
order by regione;

open regioni_cur;
if trap_sql(sqlca, "OPENCUR01")< 0  then return -1

do while sqlca.sqlcode <> 100
	fetch regioni_cur into :ls_regione;
	if trap_sql(sqlca, "OPENCUR02") < 0 then exit
	ddlb_regione.InsertItem ( ls_regione,  li_index )
	li_index++
loop

close regioni_cur;
if trap_sql(sqlca, "OPENCUR03") < 0 then return -1

return 0


end event

on w_ricercapercomuni-old.create
this.cb_dom=create cb_dom
this.sle_filtro=create sle_filtro
this.pb_ordina=create pb_ordina
this.sle_struttura=create sle_struttura
this.st_2=create st_2
this.st_1=create st_1
this.pb_go=create pb_go
this.cbx_resp=create cbx_resp
this.ddlb_provincia=create ddlb_provincia
this.ddlb_regione=create ddlb_regione
this.dw_current=create dw_current
this.gb_criteri=create gb_criteri
this.gb_filtro=create gb_filtro
this.Control[]={this.cb_dom,&
this.sle_filtro,&
this.pb_ordina,&
this.sle_struttura,&
this.st_2,&
this.st_1,&
this.pb_go,&
this.cbx_resp,&
this.ddlb_provincia,&
this.ddlb_regione,&
this.dw_current,&
this.gb_criteri,&
this.gb_filtro}
end on

on w_ricercapercomuni-old.destroy
destroy(this.cb_dom)
destroy(this.sle_filtro)
destroy(this.pb_ordina)
destroy(this.sle_struttura)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_go)
destroy(this.cbx_resp)
destroy(this.ddlb_provincia)
destroy(this.ddlb_regione)
destroy(this.dw_current)
destroy(this.gb_criteri)
destroy(this.gb_filtro)
end on

event resize;dw_current.width= this.width - 120
dw_current.height= this.height - 240 - dw_current.y - sle_struttura.height
sle_struttura.width= dw_current.width
sle_struttura.y= dw_current.y + dw_current.height + 30
end event

type cb_dom from commandbutton within w_ricercapercomuni-old
boolean visible = false
integer x = 535
integer y = 284
integer width = 485
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "L~'indirizzo contiene: "
boolean default = true
end type

event clicked;string ls_filter

parent.setRedraw(false)

if sle_filtro.text= "" then
	ls_filter= ""
else
	ls_filter= "match(ind_dom, '"+sle_filtro.text+"')"	
end if

dw_current.setFilter(ls_filter)

dw_current.filter()

long ll_found

ll_found = dw_current.Find("comune='"+is_comune+"' ", 1, dw_current.RowCount())

if ll_found > 0 then dw_current.expand(ll_found,1)

parent.setRedraw(true)
end event

type sle_filtro from singlelineedit within w_ricercapercomuni-old
boolean visible = false
integer x = 1038
integer y = 288
integer width = 526
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type pb_ordina from picturebutton within w_ricercapercomuni-old
integer x = 1883
integer y = 64
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Sort!"
alignment htextalign = left!
end type

event clicked;long ll_row
string ls_sort_string

if is_comune= "" then return 0

openWithParm(w_ordina, dw_current)
	
	ls_sort_string= message.stringParm
	
	ls_sort_string= " comune A, "+ls_sort_string
	
	parent.setRedraw(false)
	
	if dw_current.setSort(ls_sort_string) < 0 then
		
		parent.setRedraw(true)
		
		messageBox(parent.title, "I criteri di ordinamento non sono~n~n"+&
											"stati correttamente impostati", exclamation!)
											
		return -1
		
	end if
	
dw_current.sort()

dw_current.GroupCalc()

long ll_found

ll_found = dw_current.Find("comune='"+is_comune+"' ", 1, dw_current.RowCount())

if ll_found > 0 then dw_current.expand(ll_found,1)

parent.setRedraw(true)



end event

type sle_struttura from singlelineedit within w_ricercapercomuni-old
integer y = 1660
integer width = 3648
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_ricercapercomuni-old
integer x = 997
integer y = 84
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Provincia:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ricercapercomuni-old
integer x = 59
integer y = 80
integer width = 229
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Regione:"
boolean focusrectangle = false
end type

type pb_go from picturebutton within w_ricercapercomuni-old
integer x = 1687
integer y = 64
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\svil_11\Risorse\doublenextarrow.gif"
alignment htextalign = left!
end type

event clicked;dw_current.retrieve()
end event

type cbx_resp from checkbox within w_ricercapercomuni-old
boolean visible = false
integer x = 27
integer y = 300
integer width = 453
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo responsabili"
boolean lefttext = true
end type

event clicked;string ls_filter

parent.setRedraw(false)

if this.checked= true then
	ls_filter= " cod_att_ist_1 > '000' OR cod_att_ist_2 > '000' "
else
	ls_filter= ""
end if

dw_current.setFilter(ls_filter)

dw_current.filter()

long ll_found

ll_found = dw_current.Find("comune='"+is_comune+"' ", 1, dw_current.RowCount())

if ll_found > 0 then dw_current.expand(ll_found,1)

parent.setRedraw(true)
end event

type ddlb_provincia from dropdownlistbox within w_ricercapercomuni-old
integer x = 1248
integer y = 64
integer width = 411
integer height = 900
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index= 0 then return 
is_provincia= this.Text(index)
end event

type ddlb_regione from dropdownlistbox within w_ricercapercomuni-old
integer x = 297
integer y = 64
integer width = 677
integer height = 900
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;integer li_index= 1
string ls_provincia

if index= 0 then return 
is_regione= this.Text(index)
cbx_resp.visible= false
cb_dom.visible= false
sle_filtro.visible= false

is_provincia= ""
ddlb_provincia.reset()

declare provincie_cur cursor for
select distinct provincia
from tab_comuni
where cod_com > "000000" and regione= :is_regione
order by provincia;

open provincie_cur;
if trap_sql(sqlca, "OPENCUR01")< 0  then return -1

do while sqlca.sqlcode <> 100
	fetch provincie_cur into :ls_provincia;
		if trap_sql(sqlca, "OPENCUR02") < 0 then exit
		ddlb_provincia.InsertItem ( ls_provincia,  li_index )
		li_index++
loop

close provincie_cur;
if trap_sql(sqlca, "OPENCUR03") < 0 then return -1

return 0

end event

type dw_current from datawindow within w_ricercapercomuni-old
integer y = 532
integer width = 3648
integer height = 1080
integer taborder = 50
string title = "none"
string dataobject = "tvdw_ricerca"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;if is_regione = "" then return

integer li_pos

li_pos= pos(is_regione, "'", 1)

if li_pos > 0 then is_regione= trim(mid(is_regione, 1, li_pos - 1)+"'"+mid(is_regione, li_pos, len(is_regione) ) )

if is_provincia= "" then
	sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"'"
else
	sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"' and tab_comuni.provincia= '"+trim(is_provincia)+"'"	
end if

//if cbx_resp.checked= true then sqlsyntax+= " and (cod_att_ist_1 > '000' OR cod_att_ist_2 > '000')"

if this.setSqlPreview(sqlSyntax)= 0 then messageBox(parent.title, "Errore in sqlPreview")
end event

event doubleclicked;string ls_codice
s_ricercanominativa s_ricercanominativa_s

if row <= 0 then return

//ls_codice= this.getItemString(row, "codice")
s_ricercanominativa_s.codice=  	this.getItemString(row, "codice")
s_ricercanominativa_s.cognome= this.getItemString(row, "cognome")
s_ricercanominativa_s.nome=  	this.getItemString(row, "nome")


openWithParm(w_mostra_riferimenti, s_ricercanominativa_s)
end event

event rowfocuschanged;if this.getRow() > 0  then
	parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") )		
//	is_comune= this.getItemString(dw_current.getRow(), "comune")
end if
end event

event expanded;	is_comune= this.getItemString(row, "comune")
	pb_ordina.enabled= true
end event

event collapsed;	is_comune= ""
	pb_ordina.enabled= false
end event

event retrieveend;cb_dom.visible= true
sle_filtro.visible= true
cbx_resp.visible= true
end event

type gb_criteri from groupbox within w_ricercapercomuni-old
integer width = 1838
integer height = 208
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criteri di estrazione"
end type

type gb_filtro from groupbox within w_ricercapercomuni-old
integer y = 220
integer width = 1595
integer height = 208
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtri"
end type

