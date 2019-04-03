$PBExportHeader$w_ricercapercomuni_old.srw
forward
global type w_ricercapercomuni_old from window
end type
type ddlb_filtro from dropdownlistbox within w_ricercapercomuni_old
end type
type st_3 from statictext within w_ricercapercomuni_old
end type
type ddlb_localita from dropdownlistbox within w_ricercapercomuni_old
end type
type cb_dom from commandbutton within w_ricercapercomuni_old
end type
type sle_filtro from singlelineedit within w_ricercapercomuni_old
end type
type pb_ordina from picturebutton within w_ricercapercomuni_old
end type
type sle_struttura from singlelineedit within w_ricercapercomuni_old
end type
type st_2 from statictext within w_ricercapercomuni_old
end type
type st_1 from statictext within w_ricercapercomuni_old
end type
type pb_go from picturebutton within w_ricercapercomuni_old
end type
type cbx_resp from checkbox within w_ricercapercomuni_old
end type
type ddlb_provincia from dropdownlistbox within w_ricercapercomuni_old
end type
type ddlb_regione from dropdownlistbox within w_ricercapercomuni_old
end type
type dw_current from datawindow within w_ricercapercomuni_old
end type
type gb_criteri from groupbox within w_ricercapercomuni_old
end type
type gb_filtro from groupbox within w_ricercapercomuni_old
end type
end forward

global type w_ricercapercomuni_old from window
integer width = 4763
integer height = 2108
boolean titlebar = true
string title = "Ricerca per località"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
event type integer ue_report ( integer ai_tipo )
ddlb_filtro ddlb_filtro
st_3 st_3
ddlb_localita ddlb_localita
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
global w_ricercapercomuni_old w_ricercapercomuni_old

type variables
boolean ib_cap= true
string is_regione, is_provincia, is_comune, is_localita
end variables

event type integer ue_report(integer ai_tipo);string ls_object, ls_sqlsyntax, ls_sql

if ai_tipo= 1 then
	
	ls_object='dctb_localita_anno'
	
else
	
	ls_object= 'dgraph_localita_anno'
	
end if

if is_regione = "" then return 0

integer li_pos

li_pos= pos(is_regione, "'", 1)

if li_pos > 0 then is_regione= trim(mid(is_regione, 1, li_pos - 1)+"'"+mid(is_regione, li_pos, len(is_regione) ) )

if is_provincia= "" then
	ls_sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"'"
else
	
	if is_localita= "" then
		ls_sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"' and tab_comuni.provincia= '"+trim(is_provincia)+"'"	
	else
		ls_sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"' and tab_comuni.provincia= '"+trim(is_provincia)+"' and tab_comuni.comune= '"+trim(is_localita)+"'"
	end if
	
end if

s_preview s_preview_s

s_preview_s.ib_dwcreate= false
s_preview_s.doretrieve= false
s_preview_s.dataObject= ls_object
s_preview_s.criterio= ls_sqlsyntax

openWithParm(w_preview_ricercapercomuni, s_preview_s)

w_preview_ricercapercomuni.uodw_current.retrieve()

return 0






end event

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

on w_ricercapercomuni_old.create
this.ddlb_filtro=create ddlb_filtro
this.st_3=create st_3
this.ddlb_localita=create ddlb_localita
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
this.Control[]={this.ddlb_filtro,&
this.st_3,&
this.ddlb_localita,&
this.cb_dom,&
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

on w_ricercapercomuni_old.destroy
destroy(this.ddlb_filtro)
destroy(this.st_3)
destroy(this.ddlb_localita)
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

type ddlb_filtro from dropdownlistbox within w_ricercapercomuni_old
boolean visible = false
integer x = 3374
integer y = 64
integer width = 539
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string item[] = {"Il C.A.P. è","L~'indirizzo contiene"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ib_cap= false
if index= 1 then ib_cap= true

sle_filtro.enabled= false
if index > 0 then sle_filtro.enabled= true
end event

type st_3 from statictext within w_ricercapercomuni_old
integer x = 1509
integer y = 84
integer width = 206
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Località:"
boolean focusrectangle = false
end type

type ddlb_localita from dropdownlistbox within w_ricercapercomuni_old
integer x = 1719
integer y = 64
integer width = 864
integer height = 900
integer taborder = 60
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

event selectionchanged;if index= 0 then return 
is_localita= this.Text(index)
end event

type cb_dom from commandbutton within w_ricercapercomuni_old
boolean visible = false
integer x = 4375
integer y = 60
integer width = 229
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Applica"
boolean default = true
end type

event clicked;string ls_filter

parent.setRedraw(false)

if ib_cap= true then
	
	if sle_filtro.text= "" then
		ls_filter= ""
	else
		ls_filter= " match(cap_dom, '"+sle_filtro.text+"')"	
	end if
	
else

	if sle_filtro.text= "" then
		ls_filter= ""
	else
		ls_filter= " match(ind_dom, '"+sle_filtro.text+"')"	
	end if
	
end if

// eventualmente aggiunge la condizione sulla responsabilità

if cbx_resp.checked= true then
	if sle_filtro.text= "" then
		ls_filter= " cod_att_ist_1 > '000' OR cod_att_ist_2 > '000' "
	else
		ls_filter += " and (cod_att_ist_1 > '000' OR cod_att_ist_2 > '000') "
	end if
end if

dw_current.setFilter(ls_filter)

dw_current.filter()

long ll_found

ll_found = dw_current.Find("comune='"+is_comune+"' ", 1, dw_current.RowCount())

if ll_found > 0 then dw_current.expand(ll_found,1)

parent.setRedraw(true)
end event

type sle_filtro from singlelineedit within w_ricercapercomuni_old
boolean visible = false
integer x = 3927
integer y = 60
integer width = 443
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type pb_ordina from picturebutton within w_ricercapercomuni_old
integer x = 2743
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

type sle_struttura from singlelineedit within w_ricercapercomuni_old
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
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_ricercapercomuni_old
integer x = 946
integer y = 84
integer width = 238
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

type st_1 from statictext within w_ricercapercomuni_old
integer x = 18
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

type pb_go from picturebutton within w_ricercapercomuni_old
integer x = 2592
integer y = 60
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

type cbx_resp from checkbox within w_ricercapercomuni_old
boolean visible = false
integer x = 2898
integer y = 76
integer width = 462
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

event clicked;//string ls_filter
//
//parent.setRedraw(false)
//
//if this.checked= true then
//	ls_filter= " cod_att_ist_1 > '000' OR cod_att_ist_2 > '000' "
//else
//	ls_filter= ""
//end if
//
//dw_current.setFilter(ls_filter)
//
//dw_current.filter()
//
//long ll_found
//
//ll_found = dw_current.Find("comune='"+is_comune+"' ", 1, dw_current.RowCount())
//
//if ll_found > 0 then dw_current.expand(ll_found,1)
//
//parent.setRedraw(true)
end event

type ddlb_provincia from dropdownlistbox within w_ricercapercomuni_old
integer x = 1184
integer y = 64
integer width = 306
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
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;integer li_index= 1
string ls_localita

if index= 0 then return 
is_provincia= this.Text(index)
cbx_resp.visible= false
cb_dom.visible= false
sle_filtro.visible= false
sle_struttura.text= ""

is_localita= ""

ddlb_localita.reset()

declare localita_cur cursor for
select distinct comune
from tab_comuni
where cod_com > "000000" and regione= :is_regione and provincia= :is_provincia
order by comune;

open localita_cur;
if trap_sql(sqlca, "OPENCUR01")< 0  then return -1

do while sqlca.sqlcode <> 100
	fetch localita_cur into :ls_localita;
		if trap_sql(sqlca, "OPENCUR02") < 0 then exit
		ddlb_localita.InsertItem ( ls_localita,  li_index )
		li_index++
loop

close localita_cur;
if trap_sql(sqlca, "OPENCUR03") < 0 then return -1

return 0

end event

type ddlb_regione from dropdownlistbox within w_ricercapercomuni_old
integer x = 251
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
ddlb_filtro.visible= false

is_provincia= ""
is_localita= ""
sle_struttura.text= ""
ddlb_provincia.reset()
ddlb_localita.reset()

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

type dw_current from datawindow within w_ricercapercomuni_old
integer y = 224
integer width = 4626
integer height = 1376
integer taborder = 50
string title = "none"
string dataobject = "tvdw_ricerca"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;if is_regione = "" then return

is_regione= trim(f_replace_chars( is_regione, "'", "''"))

is_localita= trim(f_replace_chars( is_localita, "'", "''"))

//integer li_pos
//
//li_pos= pos(is_regione, "'", 1)
//
//if li_pos > 0 then is_regione= trim(mid(is_regione, 1, li_pos - 1)+"'"+mid(is_regione, li_pos, len(is_regione) ) )

if is_provincia= "" then
	sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"'"
else
	
	if is_localita= "" then
		sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"' and tab_comuni.provincia= '"+trim(is_provincia)+"'"	
	else
		sqlsyntax+= " and tab_comuni.regione= '"+ trim(is_regione)+"' and tab_comuni.provincia= '"+trim(is_provincia)+"' and tab_comuni.comune= '"+trim(is_localita)+"'"
	end if
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

event retrieveend;if rowcount= 0 then return

cb_dom.visible= true
sle_filtro.visible= true
cbx_resp.visible= true
ddlb_filtro.visible= true
end event

event rbuttondown;m_ricercapercomuni lm_ricercapercomuni

lm_ricercapercomuni= create m_ricercapercomuni

lm_ricercapercomuni.PopMenu(PointerX(), PointerY())
end event

type gb_criteri from groupbox within w_ricercapercomuni_old
integer width = 2720
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

type gb_filtro from groupbox within w_ricercapercomuni_old
integer x = 2875
integer width = 1742
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

