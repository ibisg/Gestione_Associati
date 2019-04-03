$PBExportHeader$w_sel_sessione.srw
forward
global type w_sel_sessione from w_select_rec
end type
end forward

global type w_sel_sessione from w_select_rec
integer x = 503
integer y = 628
integer width = 2651
integer height = 1660
string title = "Sessioni d~'esame"
end type
global w_sel_sessione w_sel_sessione

on w_sel_sessione.create
call super::create
end on

on w_sel_sessione.destroy
call super::destroy
end on

event open;call super::open;f_centra ( w_sel_sessione )

dw_elenco.SetTransObject ( sqlca )
if dw_elenco.Retrieve ( ) = -1 then CloseWithReturn ( this, -1 )

end event

type dw_elenco from w_select_rec`dw_elenco within w_sel_sessione
integer width = 2624
integer height = 1368
string dataobject = "d_s_sessione"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_elenco::select_item;call super::select_item;if row > 0 then
	
	if message.StringParm = "esami" then
	
		w_esami.str_es.v_data = GetItemDateTime ( row, 1 )
		w_esami.str_es.v_sede = GetItemString ( row, 2 )
		w_esami.str_es.v_liv = GetItemString ( row, 3 )
		
		w_esami.sle_data.text = f_plain_date ( w_esami.str_es.v_data )
		w_esami.calling = true
		w_esami.sle_data.TriggerEvent ( modified! )
		w_esami.sle_loc.text = w_esami.str_es.v_sede
		w_esami.dw_liv.SetItem ( 1, "esame", w_esami.str_es.v_liv )
		
	else
		
		w_esiti.str_es.v_data = GetItemDateTime ( row, 1 )
		w_esiti.str_es.v_sede = GetItemString ( row, 2 )
		w_esiti.str_es.v_liv = GetItemString ( row, 3 )
		
		w_esiti.em_data.text = string ( date ( w_esiti.str_es.v_data ) )
		w_esiti.sle_loc.text = w_esiti.str_es.v_sede
		w_esiti.dw_liv.SetItem ( 1, "esame", w_esiti.str_es.v_liv )
		
	end if
		
	close ( parent )
	
	return
	
end if

CloseWithReturn ( parent, -1 )

end event

event dw_elenco::dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

CloseWithReturn ( parent, -1 )

return 1

end event

type cb_cancel from w_select_rec`cb_cancel within w_sel_sessione
integer x = 1326
integer y = 1404
end type

type cb_ok from w_select_rec`cb_ok within w_sel_sessione
integer x = 951
integer y = 1404
end type

