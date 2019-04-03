$PBExportHeader$w_ricerca_responsabili_sheet.srw
forward
global type w_ricerca_responsabili_sheet from w_ricerca_sheet
end type
type dw_lev_resp from datawindow within w_ricerca_responsabili_sheet
end type
end forward

global type w_ricerca_responsabili_sheet from w_ricerca_sheet
integer width = 3666
string title = "Responsabili"
dw_lev_resp dw_lev_resp
end type
global w_ricerca_responsabili_sheet w_ricerca_responsabili_sheet

type variables
integer ii_min=100, ii_max=899
string is_dis, is_filter
end variables

on w_ricerca_responsabili_sheet.create
int iCurrent
call super::create
this.dw_lev_resp=create dw_lev_resp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lev_resp
end on

on w_ricerca_responsabili_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_lev_resp)
end on

event resize;dw_current.width= this.width - 120
dw_current.height= this.height -180 - dw_current.y
end event

event ue_queryon;call super::ue_queryon;dw_lev_resp.enabled= false
dw_lev_resp.reset()
dw_current.setColumn("cognome")

return 0
end event

type dw_current from w_ricerca_sheet`dw_current within w_ricerca_responsabili_sheet
integer y = 264
string dataobject = "dw_responsabili"
end type

event dw_current::retrieveend;call super::retrieveend;if rowcount > 0 then
	dw_lev_resp.enabled= true
	dw_lev_resp.insertRow(0)
end if
end event

type dw_lev_resp from datawindow within w_ricerca_responsabili_sheet
integer x = 32
integer y = 36
integer width = 2574
integer height = 224
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_lev_resp"
boolean border = false
boolean livescroll = true
end type

event itemchanged;choose case dwo.name
		
	case "minimo"
		
		ii_min = integer ( data )
		
	case "massimo"
		
		ii_max = integer ( data )
		
	case "cbx_dis"
		
		if this.getItemString(row, "cbx_dis")= 'S' then
			is_dis =" and  flag_dis=~'N~'"
		else
			is_dis =""
		end if
		
end choose

if ii_max < ii_min then
	MessageBox ( "Errore", "Incongruenza dati", Exclamation! )
	return
end if

is_filter = "(number(cod_att_ist_1) >= " + string ( ii_min ) + " and number(cod_att_ist_1) <= " + string ( ii_max )+is_dis+&
				") OR (number(cod_att_ist_2) >= " + string ( ii_min ) + " and number(cod_att_ist_2) <= " + string ( ii_max )+is_dis+")"

dw_current.SetFilter ( is_filter )
dw_current.Filter ( )
end event

