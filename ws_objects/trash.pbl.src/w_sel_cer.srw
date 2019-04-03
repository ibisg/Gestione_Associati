$PBExportHeader$w_sel_cer.srw
forward
global type w_sel_cer from w_select_rec
end type
end forward

global type w_sel_cer from w_select_rec
integer x = 1134
integer y = 676
integer width = 1435
string title = "Selezione cerimonia"
end type
global w_sel_cer w_sel_cer

event open;call super::open;f_centra ( w_sel_cer )

dw_elenco.SetTransObject ( sqlca )
dw_elenco.Retrieve ( )

end event

on w_sel_cer.create
call super::create
end on

on w_sel_cer.destroy
call super::destroy
end on

type dw_elenco from w_select_rec`dw_elenco within w_sel_cer
integer width = 1408
string dataobject = "d_sel_cer"
end type

event dw_elenco::select_item;call super::select_item;integer i_ret= -1
if row > 0 then

	w_sostituzioni.str_cons.v_data = GetItemDateTime ( row, 1 )
	w_sostituzioni.str_cons.v_citta = GetItemString ( row, 2 )
	w_sostituzioni.str_cons.v_turno = GetItemString ( row, 3 )
	
	w_sostituzioni.dw_header.setItem(1, "data", GetItemDateTime ( row, 1 ))
	w_sostituzioni.calling = true
//	w_sostituzioni.em_data.TriggerEvent ( modified! )
	w_sostituzioni.dw_header.setItem(1, "citta", w_sostituzioni.str_cons.v_citta)
	w_sostituzioni.dw_header.setItem( 1, "turno", w_sostituzioni.str_cons.v_turno)
	
	i_ret= 1
	
end if

CloseWithReturn ( parent, i_ret )

end event
event dw_elenco::dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

CloseWithReturn ( parent, -1 )

return 1

end event

type cb_cancel from w_select_rec`cb_cancel within w_sel_cer
integer x = 718
end type

type cb_ok from w_select_rec`cb_ok within w_sel_cer
integer x = 343
end type

