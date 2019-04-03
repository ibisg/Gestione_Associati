$PBExportHeader$w_deceduti.srw
forward
global type w_deceduti from window
end type
type st_count from statictext within w_deceduti
end type
type cb_commit from commandbutton within w_deceduti
end type
type cb_annulla from commandbutton within w_deceduti
end type
type cb_estrai from commandbutton within w_deceduti
end type
type dw_current from datawindow within w_deceduti
end type
end forward

global type w_deceduti from window
integer width = 2816
integer height = 1888
boolean titlebar = true
string title = "Deceduti"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
st_count st_count
cb_commit cb_commit
cb_annulla cb_annulla
cb_estrai cb_estrai
dw_current dw_current
end type
global w_deceduti w_deceduti

on w_deceduti.create
this.st_count=create st_count
this.cb_commit=create cb_commit
this.cb_annulla=create cb_annulla
this.cb_estrai=create cb_estrai
this.dw_current=create dw_current
this.Control[]={this.st_count,&
this.cb_commit,&
this.cb_annulla,&
this.cb_estrai,&
this.dw_current}
end on

on w_deceduti.destroy
destroy(this.st_count)
destroy(this.cb_commit)
destroy(this.cb_annulla)
destroy(this.cb_estrai)
destroy(this.dw_current)
end on

event open;dw_current.setTransObject(sqlca)

dw_current.retrieve()
end event

type st_count from statictext within w_deceduti
integer x = 1755
integer y = 1584
integer width = 343
integer height = 156
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 65535
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_commit from commandbutton within w_deceduti
integer x = 1056
integer y = 1588
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Commit"
end type

event clicked;				commit;

				if trap_sql(sqlca, "DELDEC010") < 0 then return -1
end event

type cb_annulla from commandbutton within w_deceduti
integer x = 2277
integer y = 1616
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

type cb_estrai from commandbutton within w_deceduti
integer x = 567
integer y = 1588
integer width = 370
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Estrai e sposta"
end type

event clicked;long ll_idx
string ls_codice

for ll_idx= 1 to dw_current.rowcount()
	
	ls_codice= dw_current.getItemString(ll_idx, "codice")	
				
				delete from esami where codice= :ls_codice;
				if trap_sql(sqlca, "DELFROM ESAMI01") < 0 then return -1									
				
				delete from esami_curr
				where esami_curr.esito= 'A' and
				codice= :ls_codice;
				
				if trap_sql(sqlca, "DELFROM ESAMI02") < 0 then return -1
				
			  INSERT INTO membri_dec  
					( codice,   
					  codice_fam,   
					  cognome,   
					  nome,   
					  citta_nas,   
					  prov_nas,   
					  data_nas,   
					  cod_nazione,   
					  cod_cittadinanza,   
					  cod_div,   
					  ind_dom,   
					  cap_dom,   
					  cod_com,   
					  cod_prof,   
					  pres_da,   
					  data_cer,   
					  luogo_cer,   
					  cod_att_ist_1,   
					  cod_att_ist_2,   
					  codice_staff,   
					  cod_studio,   
					  flag_goh,   
					  flag_tok,   
					  flag_oma,   
					  flag_er,   
					  flag_dis,   
					  cod_dis,   
					  u_insert,   
					  d_insert,   
					  u_ult_mod,   
					  d_ult_mod,   
					  dt_attnrc,   
					  dt_tai,   
					  dt_dectfedim,   
					  vc_parent,   
					  vc_gruppoentrata )  
			  SELECT membri_gerarchica.codice,   
						membri_gerarchica.codice_fam,   
						membri_gerarchica.cognome,   
						membri_gerarchica.nome,   
						membri_gerarchica.citta_nas,   
						membri_gerarchica.prov_nas,
						membri_gerarchica.data_nas,    
						membri_gerarchica.cod_nazione,   
						membri_gerarchica.cod_cittadinanza,   
						membri_gerarchica.cod_div,   
						membri_gerarchica.ind_dom,   
						membri_gerarchica.cap_dom,   
						membri_gerarchica.cod_com,   
						membri_gerarchica.cod_prof,   
						membri_gerarchica.pres_da,   
						membri_gerarchica.data_cer,   
						membri_gerarchica.luogo_cer,   
						membri_gerarchica.cod_att_ist_1,   
						membri_gerarchica.cod_att_ist_2,   
						membri_gerarchica.codice_staff,   
						membri_gerarchica.cod_studio,   
						membri_gerarchica.flag_goh,   
						membri_gerarchica.flag_tok,   
						membri_gerarchica.flag_oma,   
						membri_gerarchica.flag_er,   
						membri_gerarchica.flag_dis,   
						membri_gerarchica.cod_dis,   
						membri_gerarchica.u_insert,   
						membri_gerarchica.d_insert,   
						membri_gerarchica.u_ult_mod,   
						membri_gerarchica.d_ult_mod,   
						membri_gerarchica.dt_attnrc,   
						membri_gerarchica.dt_tai,   
						membri_gerarchica.dt_dectfedim,   
						membri_gerarchica.vc_parent,   
						membri_gerarchica.vc_gruppoentrata  
				 FROM membri_gerarchica
				 where codice= :ls_codice;
				
				if trap_sql(sqlca, "DELDEC01") < 0 then return -1
											 
				  INSERT INTO esami_curr_dec  
							(
							  codice,   
							  cod_studio,   
							  data_esame,   
							  esito,   
							  voto,   
							  soglia,   
							  note,   
							  id_esami_sessioni )  
					  SELECT  
								esami_curr.codice,   
								esami_curr.cod_studio,   
								esami_curr.data_esame,   
								esami_curr.esito,   
								esami_curr.voto,   
								esami_curr.soglia,   
								esami_curr.note,   
								esami_curr.id_esami_sessioni  
						 FROM esami_curr
						 where codice= :ls_codice; 
						 
				
				if trap_sql(sqlca, "DELDEC02") < 0 then return -1
				
				  INSERT INTO gohonzon_storico_dec  
						(   
						  codice,   
						  tipo_goh,   
						  data,   
						  luogo,   
						  cod_causale,   
						  note )  
				  SELECT  
							gohonzon_storico.codice,   
							gohonzon_storico.tipo_goh,   
							gohonzon_storico.data,   
							gohonzon_storico.luogo,   
							gohonzon_storico.cod_causale,   
							gohonzon_storico.note  
					 FROM gohonzon_storico
					 where codice= :ls_codice; 
					 
				
				if trap_sql(sqlca, "DELDEC03") < 0 then return -1
				
				  INSERT INTO riferimenti_dec  
						( 
						  codice,   
						  cod_rif,   
						  riferimento_descr,   
						  predefinito,   
						  note,   
						  flag_riservato )  
				  SELECT    
							riferimenti.codice,   
							riferimenti.cod_rif,   
							riferimenti.riferimento_descr,   
							riferimenti.predefinito,   
							riferimenti.note,   
							riferimenti.flag_riservato  
					 FROM riferimenti
					 where codice= :ls_codice;
					 
				
				if trap_sql(sqlca, "DELDEC04") < 0 then return -1

				  INSERT INTO storico_resp_dec  
						( codice,   
						  livello,   
						  cod_att_ist,   
						  utente,   
						  data,   
						  note )  
				  SELECT storico_resp.codice,   
							storico_resp.livello,   
							storico_resp.cod_att_ist,   
							storico_resp.utente,   
							storico_resp.data,   
							storico_resp.note  
					 FROM storico_resp
					 where codice= :ls_codice; 
					 
				
				if trap_sql(sqlca, "DELDEC05") < 0 then return -1
				
				  INSERT INTO offerte_dec  
							( num,   
							  codice,   
							  data,   
							  data_ec,   
							  importo,   
							  modalita_vers,   
							  dip_op,   
							  registrato_da,   
							  cancellata,   
							  sessione_id,   
							  data_ins )  
					  SELECT offerte.num,   
								offerte.codice,   
								offerte.data,   
								offerte.data_ec,   
								offerte.importo,   
								offerte.modalita_vers,   
								offerte.dip_op,   
								offerte.registrato_da,   
								offerte.cancellata,   
								offerte.sessione_id,   
								offerte.data_ins  
						 FROM offerte
						 where codice= :ls_codice; 
						 
				
				if trap_sql(sqlca, "DELDEC06") < 0 then return -1
				
				  INSERT INTO zaimu_dec  
					( num,   
					  codice,   
					  importo_lire,   
					  data,   
					  data_ec,   
					  importo )  
			  SELECT zaimu.num,   
						zaimu.codice,   
						zaimu.importo_lire,   
						zaimu.data,   
						zaimu.data_ec,   
						zaimu.importo  
				 FROM zaimu
				 where codice= :ls_codice; 
													
				if trap_sql(sqlca, "DELDEC07") < 0 then return -1
				
				delete from membri_gerarchica where codice= :ls_codice;
				
				if trap_sql(sqlca, "DELDEC08") < 0 then return -1
				
			//	delete from event_log where codice= :ls_codice;
				
			//	if trap_sql(sqlca, "DELDEC09") < 0 then return -1
				
			st_count.text= string(ll_idx)
				
			next		
end event

type dw_current from datawindow within w_deceduti
integer x = 5
integer width = 2752
integer height = 1520
integer taborder = 10
string title = "none"
string dataobject = "dw_fs"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

