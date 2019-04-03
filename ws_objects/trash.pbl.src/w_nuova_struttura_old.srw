$PBExportHeader$w_nuova_struttura_old.srw
forward
global type w_nuova_struttura_old from window
end type
type cb_annulla from commandbutton within w_nuova_struttura_old
end type
type em_items from editmask within w_nuova_struttura_old
end type
type cb_struttura from commandbutton within w_nuova_struttura_old
end type
end forward

global type w_nuova_struttura_old from window
integer width = 1527
integer height = 940
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_annulla cb_annulla
em_items em_items
cb_struttura cb_struttura
end type
global w_nuova_struttura_old w_nuova_struttura_old

type variables
datastore ids_aree, ids_territori, ids_centri, ids_capitoli, ids_settori, ids_gruppi

end variables

on w_nuova_struttura_old.create
this.cb_annulla=create cb_annulla
this.em_items=create em_items
this.cb_struttura=create cb_struttura
this.Control[]={this.cb_annulla,&
this.em_items,&
this.cb_struttura}
end on

on w_nuova_struttura_old.destroy
destroy(this.cb_annulla)
destroy(this.em_items)
destroy(this.cb_struttura)
end on

type cb_annulla from commandbutton within w_nuova_struttura_old
integer x = 375
integer y = 600
integer width = 558
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annulla"
end type

type em_items from editmask within w_nuova_struttura_old
integer x = 375
integer y = 408
integer width = 558
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type cb_struttura from commandbutton within w_nuova_struttura_old
integer x = 375
integer y = 152
integer width = 558
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inserisci struttura"
end type

event clicked;long ll_idx_aree, ll_idx_territori, ll_idx_centri, ll_idx_capitoli, ll_idx_settori, ll_idx_gruppi
long ll_aree, ll_territori, ll_centri, ll_capitoli, ll_settori, ll_gruppi, ll_handle, ll_parent
long ll_handle_aree, ll_handle_terr, ll_handle_cen, ll_handle_cap, ll_handle_sett, ll_handle_gru
long ll_tot_aree, ll_tot_terr, ll_tot_cen, ll_tot_cap, ll_tot_sett, ll_tot_gru
long ll_territori_inseriti, ll_centri_inseriti, ll_capitoli_inseriti, ll_settori_inseriti, ll_gruppi_inseriti
string ls_cod_area, ls_cod_terr, ls_cod_cen, ls_cod_cap, ls_cod_sett, ls_cod_gru
string ls_area, ls_territorio, ls_centro, ls_capitolo, ls_settore, ls_gruppo, ls_org

long ll_idx
string ls_nodo, ls_parent

// Cancella il contenuto della tabella struttura

delete from struttura;
if trap_sql(sqlca, "01") < 0 then goto errore

//commit;

ids_aree= create datastore
ids_territori= create datastore
ids_centri= create datastore
ids_capitoli= create datastore
ids_settori= create datastore
ids_gruppi= create datastore

ids_aree.dataObject= 'ds_aree'
ids_territori.dataObject= 'ds_territori'
ids_centri.dataObject= 'ds_centri'
ids_capitoli.dataObject= 'ds_capitoli'
ids_settori.dataObject= 'ds_settori'
ids_gruppi.dataObject= 'ds_gruppi'

ids_aree.setTransObject(sqlca)
ids_territori.setTransObject(sqlca)
ids_centri.setTransObject(sqlca)
ids_capitoli.setTransObject(sqlca)
ids_settori.setTransObject(sqlca)
ids_gruppi.setTransObject(sqlca)

// Estrazioni

setPointer(hourGlass!)

	select count(*)
	into :ll_tot_terr
	from territori_copy
	using sqlca;
	
	select count(*)
	into :ll_tot_cen
	from centri_copy
	using sqlca;
	
	select count(*)
	into :ll_tot_cap
	from capitoli_copy
	using sqlca;
	
	select count(*)
	into :ll_tot_sett
	from settori_copy
	using sqlca;
	
	select count(*)
	into :ll_tot_gru
	from gruppi_copy
	using sqlca;
	
// inserisce il primo livello

	  INSERT INTO struttura  
         ( 	livello,   
		 	codice,
		 	vc_nodo,
		 	vc_parent,
           	relazione,  
           	descrizione)
	  VALUES ( 
			 		1,  
			 		'IT', 
					'IT',
			 		'00', // nessun parent
					'G',   
				 	'ITALIA');
					if trap_sql(sqlca, "INSNAZ") < 0 then goto errore
//
ll_idx_aree= ids_aree.retrieve()

ll_tot_aree= ll_idx_aree

for ll_aree = 1 to ll_idx_aree
	
	ls_cod_area= ids_aree.getItemString(ll_aree, "cod_area")
	ls_area= ids_aree.getItemString(ll_aree, "descrizione")

	ll_handle_aree= ll_aree
	
	ls_parent= "IT"
	
	ls_org= ls_parent+"."+ls_cod_area
	
	  INSERT INTO struttura  
         ( 	livello,   
		 	codice,
		 	vc_nodo,
		 	vc_parent,
           	relazione,  
           	descrizione)
	  VALUES 
	  	(	 	2,
			 	:ls_cod_area,
				:ls_org,
				 :ls_parent,	 
				 "G",
				 :ls_area);
		if trap_sql(sqlca, "INSAREE") < 0 then goto errore
		
	ll_idx_territori= ids_territori.retrieve(ls_cod_area)
	
	for ll_territori= 1 to ll_idx_territori
		
		ls_cod_terr= ids_territori.getItemString(ll_territori, "cod_terr")
		ls_territorio= ids_territori.getItemString(ll_territori, "descrizione")
		
		ll_parent= ll_handle_aree
		ll_territori_inseriti++
		ll_handle_terr= /*ll_territori +*/ ll_territori_inseriti + ll_tot_aree
		
		//test
		ls_parent= "IT."+ls_cod_area
		ls_org= ls_parent+"."+ls_cod_terr
		
	  INSERT INTO struttura  
         ( 	livello,   
		 	codice,
		 	vc_nodo,
		 	vc_parent,
           	relazione,  
           	descrizione)
	  VALUES ( 
			 	3,  
			 	:ls_cod_terr,   
				:ls_org,
				 :ls_parent,				
				 'G',    
				 :ls_territorio);
		if trap_sql(sqlca, "INSTERR") < 0 then goto errore
		
		ll_idx_centri= ids_centri.retrieve(ls_cod_area, ls_cod_terr, ls_cod_cen)
		
		for ll_centri= 1 to ll_idx_centri
			
			ls_cod_cen= ids_centri.getItemString(ll_centri, "cod_cen")
			ls_centro= ids_centri.getItemString(ll_centri, "descrizione")
			
			ll_parent= ll_handle_terr
			ll_centri_inseriti++
			ll_handle_cen= /*ll_centri +*/ ll_centri_inseriti + ll_tot_terr + ll_tot_aree -1
			
			//test
			ls_parent= "IT."+ls_cod_area+"."+ls_cod_terr
			ls_org= ls_parent+"."+ls_cod_cen
			
	  INSERT INTO struttura  
         ( 	livello,   
		 	codice,
		 	vc_nodo,
		 	vc_parent,
           	relazione,  
           	descrizione)
	  VALUES ( 
			 	4,  
			 	:ls_cod_cen,   
				:ls_org,
				 :ls_parent,
				 'G',    
				 :ls_centro)  ;
			if trap_sql(sqlca, "INSCEN") < 0 then goto errore
			
			ll_idx_capitoli= ids_capitoli.retrieve(ls_cod_area, ls_cod_terr, ls_cod_cen)
			
			for ll_capitoli= 1 to ll_idx_capitoli
				
				ls_cod_cap= ids_capitoli.getItemString(ll_capitoli, "cod_cap")
				ls_capitolo= ids_capitoli.getItemString(ll_capitoli, "descrizione")				
			
				ll_parent= ll_handle_cen
				ll_capitoli_inseriti++
				ll_handle_cap=/* ll_capitoli +*/ ll_capitoli_inseriti + ll_tot_cen + ll_tot_terr+ ll_tot_aree -2
				
				//test
				ls_parent= "IT."+ls_cod_area+"."+ls_cod_terr+"."+ls_cod_cen
				ls_org= ls_parent+"."+ls_cod_cap
				
			
	  INSERT INTO struttura  
         ( 	livello,   
		 	codice,
		 	vc_nodo,
		 	vc_parent,
           	relazione,  
           	descrizione)
	  VALUES ( 
			 	5,  
			 	:ls_cod_cap,   
				:ls_org,
				 :ls_parent,
				 'G',    
				 :ls_capitolo)  ;
				if trap_sql(sqlca, "INSCAP") < 0 then goto errore
				
				ll_idx_settori= ids_settori.retrieve(ls_cod_area, ls_cod_terr, ls_cod_cen, ls_cod_cap)
				
				for ll_settori= 1 to ll_idx_settori
					
					ls_cod_sett= ids_settori.getItemString(ll_settori, "cod_sett")
					ls_settore= ids_settori.getItemString(ll_settori, "descrizione")						
					
					ll_parent= ll_handle_cap
					ll_settori_inseriti++
					ll_handle_sett= /*ll_settori +*/ ll_settori_inseriti + ll_tot_cap + ll_tot_cen + ll_tot_terr + ll_tot_aree -3
					
					//test
					ls_parent= "IT."+ls_cod_area+"."+ls_cod_terr+"."+ls_cod_cen+"."+ls_cod_cap
					ls_org= ls_parent+"."+ls_cod_sett
						
									
					  INSERT INTO struttura  
							( 	livello,   
							codice,
							vc_nodo,
							vc_parent,
								relazione,  
								descrizione)
					  VALUES ( 
								6,  
								:ls_cod_sett,   
								:ls_org,
								 :ls_parent,
								 'G',    
								 :ls_settore)  ;
						if trap_sql(sqlca, "INSSETT") < 0 then goto errore
						
						ll_idx_gruppi= ids_gruppi.retrieve(ls_cod_area, ls_cod_terr, ls_cod_cen, ls_cod_cap, ls_cod_sett)
					
					for ll_gruppi= 1 to ll_idx_gruppi
						
						ls_cod_gru= ids_gruppi.getItemString(ll_gruppi, "cod_gru")
						ls_gruppo= ids_gruppi.getItemString(ll_gruppi, "descrizione")									
						
						ll_parent= ll_handle_sett
						ll_gruppi_inseriti++
						ll_handle_gru= /*ll_gruppi + */ll_gruppi_inseriti + ll_tot_sett + ll_tot_cap + ll_tot_cen + ll_tot_terr + ll_tot_aree -4
						
//						messageBox("test", "livello: "+string(6)+" id_nodo: "+string(ll_handle_gru))

						//test
						ls_parent= "IT."+ls_cod_area+"."+ls_cod_terr+"."+ls_cod_cen+"."+ls_cod_cap+"."+ls_cod_sett
						ls_org= ls_parent+"."+ls_cod_gru

							
					  INSERT INTO struttura  
							( 	livello,   
							codice,
							vc_nodo,
							vc_parent,
								relazione,  
								descrizione)
					  VALUES ( 
								7,  
								:ls_cod_gru,   
								:ls_org,
								 :ls_parent,
								 'G',    
								 :ls_gruppo)  ;
						if trap_sql(sqlca, "INSGRUPPI") < 0 then goto errore
						
						// ora fa l'update in membri_copy...
						
						// costruisce la string id del nodo...
						
						//ls_nodo=   ls_cod_gru // string(ll_handle_gru)
						ls_parent= "IT."+ls_cod_area+"."+ls_cod_terr+"."+ls_cod_cen+"."+ls_cod_cap+"."+ls_cod_sett+"."+ls_cod_gru
						
						/////////////////////////////////////////////////
						
						update membri_copy
						set /*livello= 7,  relazione= 'G', vc_nodo= :ls_nodo ,*/ vc_parent= :ls_parent
						where cod_area= :ls_cod_area and
									cod_terr= :ls_cod_terr and
										cod_cen= :ls_cod_cen and
											cod_cap= :ls_cod_cap and
												cod_sett= :ls_cod_sett and
												   cod_gru= :ls_cod_gru;
													
						if trap_sql(sqlca, "INSGRUPPI_1") < 0 then goto errore
						
						em_items.text= string(ll_gruppi_inseriti)
						
					next
					
				next
				
			next
			
		next
		
	next

next

commit;

trap_sql(sqlca, "COMMIT")

return

errore:

rollback;

trap_sql(sqlca, "ROLLBACK")

return


end event

