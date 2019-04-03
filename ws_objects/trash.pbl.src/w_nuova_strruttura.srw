$PBExportHeader$w_nuova_strruttura.srw
forward
global type w_nuova_strruttura from window
end type
type cb_annulla from commandbutton within w_nuova_strruttura
end type
type em_items from editmask within w_nuova_strruttura
end type
type cb_struttura from commandbutton within w_nuova_strruttura
end type
end forward

global type w_nuova_strruttura from window
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
global w_nuova_strruttura w_nuova_strruttura

type variables
datastore ids_aree, ids_territori, ids_centri, ids_capitoli, ids_settori, ids_gruppi
end variables

on w_nuova_strruttura.create
this.cb_annulla=create cb_annulla
this.em_items=create em_items
this.cb_struttura=create cb_struttura
this.Control[]={this.cb_annulla,&
this.em_items,&
this.cb_struttura}
end on

on w_nuova_strruttura.destroy
destroy(this.cb_annulla)
destroy(this.em_items)
destroy(this.cb_struttura)
end on

type cb_annulla from commandbutton within w_nuova_strruttura
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

type em_items from editmask within w_nuova_strruttura
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

type cb_struttura from commandbutton within w_nuova_strruttura
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

event clicked;boolean lb_aree= true, lb_territori= true, lb_centri= true, lb_capitoli= true, lb_settori= true, lb_gruppi= true
long ll_aree, ll_territori, ll_centri, ll_capitoli, ll_settori, ll_gruppi
string ls_cod_area, ls_cod_terr, ls_cod_cen, ls_cod_cap, ls_cod_sett, ls_cod_gru
string ls_area, ls_territorio, ls_centro, ls_capitolo, ls_settore, ls_gruppo

// Cancella il contenuto della tabella struttura

delete from struttura;
if trap_sql(sqlca, "01") < 0 then goto errore

// Apre un cursore per ogni attuale livello di struttura

declare  aree_cur cursor for
select cod_area, descrizione
from aree
where cod_area <> 'A'
order by cod_area;

declare  territori_cur cursor for
select cod_area, cod_terr, descrizione
from territori
where cod_area= :ls_cod_area
order by cod_area, cod_terr;

declare centri_cur cursor for
select cod_area, cod_terr, cod_cen
from centri
where cod_area= :ls_cod_area and cod_terr= :ls_cod_terr
order by cod_area, cod_terr, cod_cen;

declare capitoli_cur cursor for
select cod_area, cod_terr, cod_cen, cod_cap
from capitoli
where cod_area= :ls_cod_area and cod_terr= :ls_cod_terr and cod_cen= :ls_cod_cen
order by cod_area, cod_terr, cod_cen, cod_cap;

declare settori_cur cursor for
select cod_area, cod_terr, cod_cen, cod_cap, cod_sett, descrizione
from settori
where cod_area= :ls_cod_area and cod_terr= :ls_cod_terr and cod_cen= :ls_cod_cen and cod_sett= :ls_cod_sett
order by cod_area, cod_terr, cod_cen, cod_cap, cod_sett;

declare gruppi_cur cursor for
select cod_area, cod_terr, cod_cen, cod_cap, cod_sett, cod_gru, descrizione
from gruppi
where cod_area= :ls_cod_area and cod_terr= :ls_cod_terr and cod_cen= :ls_cod_cen and cod_sett= :ls_cod_sett and cod_gru= :ls_gruppo
order by cod_area, cod_terr, cod_cen, cod_cap, cod_sett, cod_gru;

// Apre tutti i cursori

open aree_cur;
if trap_sql(sqlca, "02") < 0 then goto errore

open territori_cur;
if trap_sql(sqlca, "03") < 0 then goto errore

open centri_cur;
if trap_sql(sqlca, "04") < 0 then goto errore

open capitoli_cur;
if trap_sql(sqlca, "05") < 0 then goto errore

open settori_cur;
if trap_sql(sqlca, "06") < 0 then goto errore

open gruppi_cur;
if trap_sql(sqlca, "07") < 0 then goto errore

// Estrazioni

setPointer(hourGlass!)

do while lb_aree

	fetch  aree_cur
	into :ls_cod_area, :ls_area;
	if trap_sql(sqlca, "08") < 0 then goto errore
	
	if sqlca.sqlcode= 100 then
		ll_territori= 0
		lb_aree= false
		continue
	end if
	
	ll_aree++
	
	  INSERT INTO struttura  
         ( livello,   
		 id_nodo, 
           relazione,   
           id_parent,   
           codice,   
           descrizione )  
	  VALUES ( 
			 1,   
			 :ll_aree,
				  'G',   
				  0,   
				  :ls_cod_area,   
				  :ls_area )  ;
		if trap_sql(sqlca, "INSAREE") < 0 then goto errore
	
	do while lb_territori
		
		fetch  territori_cur
		into :ls_cod_terr, :ls_territorio;
		if trap_sql(sqlca, "09") < 0 then goto errore
		
		if sqlca.sqlcode= 100 then
			ll_centri= 0
			lb_territori= false
			continue
		end if
		
		ll_territori++
		
		INSERT INTO struttura  
				( livello,   
			 id_nodo, 
				  relazione,   
				  id_parent,   
				  codice,   
				  descrizione )  
	  	VALUES ( 
				 2,   
				 :ll_territori,
					  'G',   
					  :ll_aree,   
					  :ls_cod_terr,   
					  :ls_territorio )  ;
		if trap_sql(sqlca, "INSTERR") < 0 then goto errore
		
		do while lb_centri
		
			fetch  centri_cur
			into :ls_cod_cen, :ls_centro;
			if trap_sql(sqlca, "10") < 0 then goto errore
			
			if sqlca.sqlcode= 100 then
				ll_capitoli= 0
				lb_centri= false
				continue
			end if
			
			ll_centri++
			
			INSERT INTO struttura  
					( livello,   
				 id_nodo, 
					  relazione,   
					  id_parent,   
					  codice,   
					  descrizione )  
			VALUES ( 
					 3,   
					 :ll_centri,
						  'G',   
						  :ll_territori,   
						  :ls_cod_cen,   
						  :ls_centro )  ;
			if trap_sql(sqlca, "INSCEN") < 0 then goto errore
			
			do while lb_capitoli
			
				fetch  capitoli_cur
				into :ls_cod_cap, :ls_capitolo;
				if trap_sql(sqlca, "11") < 0 then goto errore
				
				if sqlca.sqlcode= 100 then
					ll_settori= 0
					lb_capitoli= false
					continue
				end if
				
				ll_capitoli++
				
				INSERT INTO struttura  
						( livello,   
					 id_nodo, 
						  relazione,   
						  id_parent,   
						  codice,   
						  descrizione )  
				VALUES ( 
						 4,   
						 :ll_capitoli,
							  'G',   
							  :ll_centri,   
							  :ls_cod_cen,   
							  :ls_centro )  ;
				if trap_sql(sqlca, "INSCAP") < 0 then goto errore
				
				do while lb_settori
				
					fetch settori_cur
					into :ls_cod_terr, :ls_territorio;
					if trap_sql(sqlca, "12") < 0 then goto errore
					
					if sqlca.sqlcode= 100 then
						ll_gruppi= 0
						lb_settori= false
						continue
					end if
					
						ll_settori++
						
						INSERT INTO struttura  
								( livello,   
							 id_nodo, 
								  relazione,   
								  id_parent,   
								  codice,   
								  descrizione )  
						VALUES ( 
								 5,   
								 :ll_settori,
									  'G',   
									  :ll_capitoli,   
									  :ls_cod_sett,   
									  :ls_settore )  ;
						if trap_sql(sqlca, "INSSETT") < 0 then goto errore
					
					do while lb_gruppi
					
						fetch  gruppi_cur
						into :ls_cod_gru, :ls_gruppo;
						if trap_sql(sqlca, "13") < 0 then goto errore
						
						if sqlca.sqlcode= 100 then
							lb_gruppi= false
							continue
						end if
						
						ll_gruppi++
						
						INSERT INTO struttura  
								( livello,   
							 id_nodo, 
								  relazione,   
								  id_parent,   
								  codice,   
								  descrizione )  
						VALUES ( 
								 6,   
								 :ll_gruppi,
									  'G',   
									  :ll_settori,   
									  :ls_cod_gru,   
									  :ls_gruppo )  ;
						if trap_sql(sqlca, "INSGRUPPI") < 0 then goto errore
						
						em_items.text= string(ll_gruppi)
						
					loop
					
				loop
				
			loop
			
		loop
		
	loop

loop

commit;

trap_sql(sqlca, "COMMIT")

return

errore:

rollback;

trap_sql(sqlca, "ROLLBACK")

return


end event

