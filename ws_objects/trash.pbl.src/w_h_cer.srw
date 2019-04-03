$PBExportHeader$w_h_cer.srw
forward
global type w_h_cer from w_select_rec
end type
end forward

global type w_h_cer from w_select_rec
int X=1075
int Y=717
int Width=1463
int Height=1013
boolean TitleBar=true
string Title="Dati cerimonia"
end type
global w_h_cer w_h_cer

type variables
s_asp str_asp

end variables

event open;call super::open;f_centra ( w_h_cer )

dw_elenco.SetTransObject ( sqlca )
dw_elenco.Retrieve ( )

end event

on w_h_cer.create
call w_select_rec::create
end on

on w_h_cer.destroy
call w_select_rec::destroy
end on

event activate;call super::activate;gs_context = "Selezione cerimonia entrata"

end event

type dw_elenco from w_select_rec`dw_elenco within w_h_cer
int Width=1431
string DataObject="d_h_cer"
end type

event dw_elenco::select_item;call super::select_item;if row > 0 then

	str_asp.v_data = GetItemDateTime ( row, "data_cer" )
	str_asp.v_citta = GetItemString ( row, "luogo_cer" )
	str_asp.v_turno = GetItemString ( row, "turno" )
	
	CloseWithReturn ( parent, str_asp )
	
	return
	
end if

CloseWithReturn ( parent, -1 )

end event

event dw_elenco::dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

CloseWithReturn ( parent, -1 )

return 1

end event

type cb_cancel from w_select_rec`cb_cancel within w_h_cer
int X=732
int Y=729
end type

type cb_ok from w_select_rec`cb_ok within w_h_cer
int X=357
int Y=729
end type

