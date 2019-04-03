$PBExportHeader$w_ordina_old.srw
forward
global type w_ordina_old from w_centered
end type
type dw_source from datawindow within w_ordina_old
end type
type dw_target from datawindow within w_ordina_old
end type
type cb_applica from commandbutton within w_ordina_old
end type
type cb_annulla from commandbutton within w_ordina_old
end type
type st_1 from statictext within w_ordina_old
end type
type st_2 from statictext within w_ordina_old
end type
type st_3 from statictext within w_ordina_old
end type
end forward

global type w_ordina_old from w_centered
integer width = 1669
integer height = 1164
string title = "Ordina"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Form!"
boolean clientedge = true
dw_source dw_source
dw_target dw_target
cb_applica cb_applica
cb_annulla cb_annulla
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_ordina_old w_ordina_old

type variables
string ls_column

long li_availablerow, li_sortingrow, li_tgtrow, li_numcol

dataWindow dw_passed
end variables

forward prototypes
public function string wf_sort_order (ref datawindow dw_tosort)
end prototypes

public function string wf_sort_order (ref datawindow dw_tosort);if isNull(dw_tosort.rowCount()) or dw_tosort.rowCount()= 0 then return ""

long idx, num_colonna

string sort_string, nome_colonna

for idx= 1 to dw_tosort.rowCount()
	
	if idx > 1 then sort_string+= ", "
	
	num_colonna= dw_tosort.getItemNumber(idx, "num_colonna")
	
	nome_colonna= dw_passed.describe("#"+string(num_colonna)+".name")
	
	sort_string+= nome_colonna+" "+dw_tosort.getItemString(idx, "sortorder")
						
next

return sort_string
end function

event open;call super::open;integer i_ret

uint how_many, idx, new_row= 0

string col_name, col_testata, setting

dw_passed= message.powerObjectParm

//setting = dw_passed.Describe("DataWindow.Objects")

how_many= integer(dw_passed.object.dataWindow.column.count)

for idx= 1 to how_many
	
	col_name= dw_passed.describe("#"+string(idx)+".name")
	
	col_testata= dw_passed.describe(col_name+"_t.Text")
	
	if col_testata <> "!" then
		
		new_row++
	
		dw_source.insertRow(new_row)
		
		i_ret= dw_source.setItem(new_row, "num_colonna", idx)
		
		i_ret= dw_source.setItem(new_row, "colonna", col_testata)
		
	end if
	
next
end event

on w_ordina_old.create
int iCurrent
call super::create
this.dw_source=create dw_source
this.dw_target=create dw_target
this.cb_applica=create cb_applica
this.cb_annulla=create cb_annulla
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_source
this.Control[iCurrent+2]=this.dw_target
this.Control[iCurrent+3]=this.cb_applica
this.Control[iCurrent+4]=this.cb_annulla
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
end on

on w_ordina_old.destroy
call super::destroy
destroy(this.dw_source)
destroy(this.dw_target)
destroy(this.cb_applica)
destroy(this.cb_annulla)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type dw_source from datawindow within w_ordina_old
integer x = 23
integer y = 116
integer width = 709
integer height = 812
integer taborder = 10
string dragicon = "row.ico"
string dataobject = "dw_tosort"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if isNull(dwo) or isNull(row) or row= 0 then return

if dwo.name= 'colonna' then
	
	li_availablerow= row
	
	this.drag(begin!)
	
end if
end event

event dragdrop;long ll_new_row
integer li_rc
dragObject ldrg_object

ldrg_object= draggedObject()

if typeOf(ldrg_object)= dataWindow! then

	if ldrg_object.className()= "dw_source" then
		
		li_rc= this.drag(cancel!)
		
		return
		
	end if
	
end if

if li_sortingrow > 0 then
	
	li_rc= dw_target.rowsMove(li_sortingrow, li_sortingrow, &
										primary!, this, li_numcol /*this.rowCount()+1*/, primary!)
										
end if

dw_target.drag(end!)
end event

event itemfocuschanged;//this.SelectRow(0, FALSE)
//
//this.SetRow(row)
//
//this.SelectRow(row, TRUE)
//
//ls_column= this.getText()
//
//messageBox("test", "row= "+string(row))
end event

event losefocus;//this.Drag(End!)
end event

type dw_target from datawindow within w_ordina_old
integer x = 741
integer y = 116
integer width = 882
integer height = 812
integer taborder = 10
string dragicon = "row.ico"
string dataobject = "dw_colonne"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if isNull(dwo) or isNUll(row) or row= 0 then return

if dwo.name= 'colonna' then
	
	li_numcol= this.getItemNumber(row, "num_colonna")
	
	li_sortingrow= row
	
	this.drag(begin!)
	
end if
end event

event dragdrop;long ll_new_row
integer li_rc
dragObject ldrg_object

ldrg_object= draggedObject()

if typeOf(ldrg_object)= dataWindow! then

	if ldrg_object.className()= "dw_target" then
		
		if li_sortingrow > 0 then
	
			li_rc= this.rowsMove(li_sortingrow, li_sortingrow, &
												primary!, this, li_tgtrow+1 /*this.rowCount()+1*/, primary!)
										
		end if
		
	else
		
//		li_rc= this.drag(cancel!)
//		
//		return
		if li_availablerow > 0 then
			
			if dw_target.rowCount() > 0 then
				
				li_tgtrow= dw_target.rowCount()+1
				
			else
				
				li_tgtrow= 1
			
			end if
	
			li_rc= dw_source.rowsMove(li_availablerow, li_availablerow, &
												primary!, this, li_tgtrow /*this.rowCount()+1*/, primary!)
										
		end if
		
	end if
	
end if

//if li_availablerow > 0 then
//	
//	li_rc= dw_source.rowsMove(li_availablerow, li_availablerow, &
//										primary!, this, li_tgtrow+1 /*this.rowCount()+1*/, primary!)
//										
//end if

dw_target.drag(end!)
end event

event dragwithin;li_tgtrow= row
end event

type cb_applica from commandbutton within w_ordina_old
integer x = 741
integer y = 952
integer width = 293
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Applica"
boolean default = true
end type

event clicked;closeWithReturn(parent, wf_sort_order(dw_target))
end event

type cb_annulla from commandbutton within w_ordina_old
integer x = 1330
integer y = 952
integer width = 293
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "A&nnulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type st_1 from statictext within w_ordina_old
integer x = 23
integer y = 48
integer width = 507
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Colonne disponibili"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ordina_old
integer x = 741
integer y = 48
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "Ordinamento"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ordina_old
integer x = 1280
integer y = 48
integer width = 279
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "Asc. o Disc."
boolean focusrectangle = false
end type

