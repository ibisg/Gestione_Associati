$PBExportHeader$uo_ds_stor.sru
forward
global type uo_ds_stor from datastore
end type
end forward

global type uo_ds_stor from datastore
string dataobject = "d_agg_stor"
end type
global uo_ds_stor uo_ds_stor

event dberror;choose case sqldbcode
		
	case 547 // sqlserver - FK violation
		
		messagebox("Errore DB", "La cancellazione non è possibile: sono ancora presenti dei dati dipendenti.", information!)
		
	case 2627 // sqlserver - Dupicate key
		
		messagebox("Errore DB", "Chiave duplicata: stai tentando di inserire un record già presente nello storico Gohonzon.", information!)
		
	case else
		
		messagebox("Errore DB", sqlerrtext, information!)		
		
end choose	

return 1
end event

on uo_ds_stor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ds_stor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

