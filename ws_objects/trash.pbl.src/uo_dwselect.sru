$PBExportHeader$uo_dwselect.sru
$PBExportComments$DataWindow per la selezione di records
forward
global type uo_dwselect from datawindow
end type
end forward

global type uo_dwselect from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event keydown pbm_dwnkey
event select_item ( long row )
end type
global uo_dwselect uo_dwselect

type variables
long il_rows

end variables

forward prototypes
public subroutine of_browse (long al_rows)
end prototypes

public subroutine of_browse (long al_rows);long ll_row

ll_row = GetRow()

if KeyDown(keydownarrow!) then

	if ll_row < al_rows then
		SelectRow ( 0,false )
		SelectRow(ll_row+1,true)
	end if

	if ll_row = al_rows then
		SelectRow ( 0,false )
		SelectRow(ll_row,true)
	end if

	if ll_row < al_rows then
		SelectRow(ll_row ,false)
	end if

end if

if KeyDown(keyuparrow!) then

	if ll_row > 1 then
		SelectRow(0,false)
		SelectRow(ll_row -1,true)
	end if

end if

if KeyDown(keyenter!) then
	this.event select_item ( ll_row )
end if

end subroutine

event clicked;long ll_row

ll_row = row

If ll_row = 0 then Return

selectrow ( 0, FALSE )
selectrow ( ll_row, TRUE )

SetRow ( ll_row )

end event

event doubleclicked;this.event select_item ( row )

end event

event getfocus;il_rows = RowCount ( )

if il_rows > 0 then

	SelectRow(0, false)
	SelectRow(1, true)
	
end if

end event

on uo_dwselect.create
end on

on uo_dwselect.destroy
end on

