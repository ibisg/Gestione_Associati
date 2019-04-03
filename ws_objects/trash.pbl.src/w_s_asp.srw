$PBExportHeader$w_s_asp.srw
forward
global type w_s_asp from w_select_rec
end type
end forward

global type w_s_asp from w_select_rec
int X=951
int Y=677
int Width=1925
boolean TitleBar=true
string Title="Selezione nominativi"
end type
global w_s_asp w_s_asp

type variables
s_nom str_nom

end variables

on w_s_asp.create
call w_select_rec::create
end on

on w_s_asp.destroy
call w_select_rec::destroy
end on

event open;call super::open;f_centra ( w_s_asp )

dw_elenco.SetTransObject ( sqlca )

str_nom = message.PowerObjectParm

dw_elenco.Retrieve ( str_nom.v_cognome, str_nom.v_nome )

dw_elenco.SetFocus ( )

end event

type dw_elenco from w_select_rec`dw_elenco within w_s_asp
int Width=1898
string DataObject="d_s_asp"
end type

event dw_elenco::select_item;call super::select_item;if row > 0 then

	w_asp.il_code = this.GetItemNumber ( row, 3 )
	w_asp.is_dip = this.GetItemString ( row, 4 )
	
	w_asp.dw_asp.SetRedraw ( false )
	w_asp.dw_asp.Reset ( )
	w_asp.dw_asp.Retrieve ( w_asp.il_code, w_asp.is_dip )
	w_asp.dw_asp.SetRedraw ( true )
	
	close ( parent )
	
	return
	
else
	
	return
	
end if

end event

event dw_elenco::dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

CloseWithReturn ( parent, -1 )

return 1

end event

type cb_cancel from w_select_rec`cb_cancel within w_s_asp
int X=942
int Y=717
end type

type cb_ok from w_select_rec`cb_ok within w_s_asp
int X=567
int Y=717
end type

