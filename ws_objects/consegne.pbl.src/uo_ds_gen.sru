$PBExportHeader$uo_ds_gen.sru
forward
global type uo_ds_gen from datastore
end type
end forward

global type uo_ds_gen from datastore
end type
global uo_ds_gen uo_ds_gen

event dberror;//f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

on uo_ds_gen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ds_gen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event retrieverow;if this.DataObject = "ds_exist_fam" then
	
	if this.GetItemNumber ( row, "codice_membro" ) = this.GetItemNumber ( row, "cod_fam" ) and &
		this.GetItemString ( row, "cod_dip") = this.GetItemString ( row, "dip_fam") then
		
		this.SetItem ( row, "c_fam", "S" )
		
	else
		
		this.SetItem ( row, "c_fam", "N" )
		
	end if
	
end if

end event

