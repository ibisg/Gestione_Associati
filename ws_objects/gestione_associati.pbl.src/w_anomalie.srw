$PBExportHeader$w_anomalie.srw
forward
global type w_anomalie from w_generica_sheet
end type
type tab_anomalie from tab within w_anomalie
end type
type tabpage_gruppi from userobject within tab_anomalie
end type
type uodw_1 from uodw_generica within tabpage_gruppi
end type
type tabpage_gruppi from userobject within tab_anomalie
uodw_1 uodw_1
end type
type tabpage_gruppivuoti from userobject within tab_anomalie
end type
type uodw_2 from uodw_generica within tabpage_gruppivuoti
end type
type tabpage_gruppivuoti from userobject within tab_anomalie
uodw_2 uodw_2
end type
type tabpage_trasferimenti from userobject within tab_anomalie
end type
type uodw_3 from uodw_generica within tabpage_trasferimenti
end type
type tabpage_trasferimenti from userobject within tab_anomalie
uodw_3 uodw_3
end type
type tabpage_deposito from userobject within tab_anomalie
end type
type uodw_4 from uodw_generica within tabpage_deposito
end type
type tabpage_deposito from userobject within tab_anomalie
uodw_4 uodw_4
end type
type tab_anomalie from tab within w_anomalie
tabpage_gruppi tabpage_gruppi
tabpage_gruppivuoti tabpage_gruppivuoti
tabpage_trasferimenti tabpage_trasferimenti
tabpage_deposito tabpage_deposito
end type
end forward

global type w_anomalie from w_generica_sheet
integer width = 5458
integer height = 1744
string menuname = ""
boolean toolbarinsheet = true
tab_anomalie tab_anomalie
end type
global w_anomalie w_anomalie

type variables
m_preview_anomalie im_preview_anomalie
end variables

on w_anomalie.create
int iCurrent
call super::create
this.tab_anomalie=create tab_anomalie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_anomalie
end on

on w_anomalie.destroy
call super::destroy
destroy(this.tab_anomalie)
end on

event open;call super::open;is_assegnastruttura_s= message.powerObjectParm
im_preview_anomalie= create m_preview

tab_anomalie.selectTab(1)

end event

event resize;call super::resize;tab_anomalie.height= this.height - 180
tab_anomalie.width= this.width - 120
end event

type uodw_current from w_generica_sheet`uodw_current within w_anomalie
end type

type tab_anomalie from tab within w_anomalie
integer width = 5349
integer height = 1540
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean showpicture = false
integer selectedtab = 1
tabpage_gruppi tabpage_gruppi
tabpage_gruppivuoti tabpage_gruppivuoti
tabpage_trasferimenti tabpage_trasferimenti
tabpage_deposito tabpage_deposito
end type

event selectionchanged;choose case newindex
		
	case 1
		
		this.tabpage_gruppi.uodw_1.height= this.height -160 - this.tabpage_gruppi.uodw_1.y
		this.tabpage_gruppi.uodw_1.setTransObject(sqlca)
		this.tabpage_gruppi.uodw_1.retrieve()		
		
	case 2
		
		this.tabpage_gruppivuoti.uodw_2.height= this.height -160 - this.tabpage_gruppivuoti.uodw_2.y
		this.tabpage_gruppivuoti.uodw_2.setTransObject(sqlca)
		this.tabpage_gruppivuoti.uodw_2.retrieve()				
		
	case 3
		
		this.tabpage_trasferimenti.uodw_3.height= this.height -160 - this.tabpage_trasferimenti.uodw_3.y
		this.tabpage_trasferimenti.uodw_3.setTransObject(sqlca)
		this.tabpage_trasferimenti.uodw_3.retrieve()
				
	case 4
		
		this.tabpage_deposito.uodw_4.height= this.height -160 - this.tabpage_deposito.uodw_4.y
		this.tabpage_deposito.uodw_4.setTransObject(sqlca)
		this.tabpage_deposito.uodw_4.retrieve()				
		
		
end choose
end event

on tab_anomalie.create
this.tabpage_gruppi=create tabpage_gruppi
this.tabpage_gruppivuoti=create tabpage_gruppivuoti
this.tabpage_trasferimenti=create tabpage_trasferimenti
this.tabpage_deposito=create tabpage_deposito
this.Control[]={this.tabpage_gruppi,&
this.tabpage_gruppivuoti,&
this.tabpage_trasferimenti,&
this.tabpage_deposito}
end on

on tab_anomalie.destroy
destroy(this.tabpage_gruppi)
destroy(this.tabpage_gruppivuoti)
destroy(this.tabpage_trasferimenti)
destroy(this.tabpage_deposito)
end on

type tabpage_gruppi from userobject within tab_anomalie
integer x = 18
integer y = 100
integer width = 5312
integer height = 1424
long backcolor = 67108864
string text = "Gruppi senza responsabili"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_1 uodw_1
end type

on tabpage_gruppi.create
this.uodw_1=create uodw_1
this.Control[]={this.uodw_1}
end on

on tabpage_gruppi.destroy
destroy(this.uodw_1)
end on

type uodw_1 from uodw_generica within tabpage_gruppi
integer width = 4951
integer taborder = 10
string dataobject = "dw_anomalie_gsr"
boolean maxbox = false
string icon = "Application5!"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
end type

event doubleclicked;call super::doubleclicked;string ls_struttura

ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))

//end if

SetPointer ( hourglass! )

if ls_struttura <> "" and isValid(is_assegnastruttura_s.aw_struttura_tv) then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

event sqlpreview;call super::sqlpreview;integer li_idx, li_pos
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " s7.vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " s7.vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )
end event

event rbuttondown;call super::rbuttondown;im_preview_anomalie.iuodw_generica= uodw_1
im_preview_anomalie.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

type tabpage_gruppivuoti from userobject within tab_anomalie
integer x = 18
integer y = 100
integer width = 5312
integer height = 1424
long backcolor = 67108864
string text = "Gruppi vuoti"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_2 uodw_2
end type

on tabpage_gruppivuoti.create
this.uodw_2=create uodw_2
this.Control[]={this.uodw_2}
end on

on tabpage_gruppivuoti.destroy
destroy(this.uodw_2)
end on

type uodw_2 from uodw_generica within tabpage_gruppivuoti
integer width = 4969
integer taborder = 10
string dataobject = "dw_anomalie_gruppi_vuoti"
boolean maxbox = false
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;string ls_struttura

ls_struttura=trim(this.getItemString(this.getRow(), "vc_nodo"))

//end if

SetPointer ( hourglass! )

if ls_struttura <> "" and isValid(is_assegnastruttura_s.aw_struttura_tv) then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

event sqlpreview;call super::sqlpreview;integer li_idx, li_pos
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " s.vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " s.vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )
end event

event rbuttondown;call super::rbuttondown;im_preview_anomalie.iuodw_generica= uodw_2
im_preview_anomalie.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

type tabpage_trasferimenti from userobject within tab_anomalie
integer x = 18
integer y = 100
integer width = 5312
integer height = 1424
long backcolor = 67108864
string text = "Trasferimenti: la responsabilità è confermata?"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_3 uodw_3
end type

on tabpage_trasferimenti.create
this.uodw_3=create uodw_3
this.Control[]={this.uodw_3}
end on

on tabpage_trasferimenti.destroy
destroy(this.uodw_3)
end on

type uodw_3 from uodw_generica within tabpage_trasferimenti
integer width = 5312
integer taborder = 10
string dataobject = "dw_anomalie_responsabilita"
boolean maxbox = false
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;string ls_struttura

ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

//end if

SetPointer ( hourglass! )

if ls_struttura <> "" and isValid(is_assegnastruttura_s.aw_struttura_tv) then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

event sqlpreview;call super::sqlpreview;integer li_idx, li_pos
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )
end event

event rbuttondown;call super::rbuttondown;im_preview_anomalie.iuodw_generica= uodw_3
im_preview_anomalie.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

type tabpage_deposito from userobject within tab_anomalie
integer x = 18
integer y = 100
integer width = 5312
integer height = 1424
long backcolor = 67108864
string text = "Gohonzon in deposito temporaneo da più di tre anni"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_4 uodw_4
end type

on tabpage_deposito.create
this.uodw_4=create uodw_4
this.Control[]={this.uodw_4}
end on

on tabpage_deposito.destroy
destroy(this.uodw_4)
end on

type uodw_4 from uodw_generica within tabpage_deposito
integer width = 3794
integer taborder = 10
string dataobject = "dw_anomalie_gohonzon_rdt"
boolean maxbox = false
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
end type

event doubleclicked;call super::doubleclicked;string ls_struttura

ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

//end if

SetPointer ( hourglass! )

if ls_struttura <> "" and isValid(is_assegnastruttura_s.aw_struttura_tv) then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

event sqlpreview;call super::sqlpreview;integer li_idx, li_pos
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )
end event

event rbuttondown;call super::rbuttondown;im_preview_anomalie.iuodw_generica= uodw_4
im_preview_anomalie.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

