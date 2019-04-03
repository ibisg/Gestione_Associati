$PBExportHeader$uodw_header.sru
forward
global type uodw_header from datawindow
end type
end forward

global type uodw_header from datawindow
integer width = 4325
integer height = 396
string title = "Testata"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type
global uodw_header uodw_header

event buttonclicked;choose case dwo.name
		
	case "b_sposta"
	
		integer li_ret
		s_evento s_evento_s
	
		if row= 0 then return 0
		
	//	if gi_classediutenza >= gc_op then return 0
	
		s_evento_s.id=  this.getItemDecimal(row, "id")
		s_evento_s.cod_dip= s_session_s.cod_dip
		
		li_ret= openWithParm(w_mod_eventi, s_evento_s)
		
		li_ret= message.doubleParm
		if li_ret < 0  then return -1
	//
		
//		openWithParm(w_mod_eventi, this.getItemDecimal(row, "id") )
//		li_ret= message.doubleParm
//		if li_ret= -1 then return
		
		this.retrieve(this.getItemDecimal(row, "id"))
	
	case "b_todolist"
			
		decimal ld_id
		integer li_quanti, li_tipo
		long ll_row
		
		dataStore ids_scadenze_interne
		
		ids_scadenze_interne= create dataStore
		
		ll_row= this.getRow()
		
		if  ll_row<= 0 then return -1
		
		ld_id= this.getItemDecimal(ll_row, "id")
		
		select count(*)
		into :li_quanti
		from eventi_compiti
		where id= :ld_id;
		if trap_sql(sqlca, "COUNTID01") < 0 then return -1
		
				if li_quanti= 0 then // se inserisco un nuovo evento...
				
					long ll_idx
					string ls_descrizione, ls_tipo_scadenza
					
					ids_scadenze_interne= create dataStore
					ids_scadenze_interne.dataObject= 'ds_scadenze_interne'
					ids_scadenze_interne.setTransObject(sqlca)
					
					li_tipo= this.getItemNumber(ll_row, "tipo_evento")
					
						// Nel caso degli esami il tipo va da 1 a 5 ...
						
						if li_tipo <= 5 then li_tipo= 5 // esami...
						
							// estrae le scadenze interne da eventi_scadenze_interne e le inserisce in eventi_compiti
							
							if ids_scadenze_interne.retrieve(li_tipo) > 0 then
							
								for ll_idx= 1 to ids_scadenze_interne.rowCount()
									
									ls_descrizione= ids_scadenze_interne.getItemString(ll_idx, "descrizione")
									ls_tipo_scadenza=  ids_scadenze_interne.getItemString(ll_idx, "tipo_scadenza")
									
									  INSERT INTO eventi_compiti  
												( id,   
												  descrizione,   
												  stato,   
												  ordine,   
												  tipo_scadenza,   
												  operatore )  
									  VALUES ( :ld_id,   
												  :ls_descrizione,   
												  '1',   
												  :ll_idx,   
												  :ls_tipo_scadenza,
												  "");
									if sqlca.sqlcode < 0 then exit
		
								next
								
									if sqlca.sqlcode= 0 then
										commit;
										if trap_sql(sqlca, "INSTODO02") <  0 then ld_id= -1
									else
										rollback;
										trap_sql(sqlca, "INSTODO03")
										ld_id= -1
									end if
								
						end if // se ci sono scadenze interne tabellate...
					
				end if // se nuovo evento...
				
		
		if ld_id = -1  then return -1 
		
		openWithParm(w_todolist, ld_id)
		
		return message.doubleParm

end choose
end event

on uodw_header.create
end on

on uodw_header.destroy
end on

