$PBExportHeader$w_conferma_cerimonie_sheet.srw
forward
global type w_conferma_cerimonie_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_conferma_cerimonie_sheet from w_gestione_archivio_sheet
string title = "Conferma partecipazione alle cerimonie"
string menuname = "m_conferma_cerimonie"
windowstate windowstate = maximized!
string icon = "Query5!"
event type integer ue_aggiornaanagrafica ( )
end type
global w_conferma_cerimonie_sheet w_conferma_cerimonie_sheet

type variables
s_cerimonia is_cerimonia_s
end variables

on w_conferma_cerimonie_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_conferma_cerimonie" then this.MenuID = create m_conferma_cerimonie
end on

on w_conferma_cerimonie_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long ll_row
openWithParm(w_gestione_cerimonie, "I")

is_cerimonia_s= message.powerObjectParm

if isNull(is_cerimonia_s.id) then close(this)

return dw_current.retrieve(is_cerimonia_s.id)
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_conferma_cerimonie_sheet
event type long ue_inserimento ( string as_codice,  string as_gm )
event type long ue_aggiorna ( )
string dataobject = "dw_conferma_cerimonie"
end type

event dw_current::ue_inserimento;insert membri_gerarchica
  SELECT aspiranti.codice, 
  		null,
         aspiranti.cognome,   
         aspiranti.nome,   
         aspiranti.citta_nas,   
         aspiranti.prov_nas,   
         aspiranti.data_nas,   
         aspiranti.cod_nazione,   
         aspiranti.cod_div,   
         aspiranti.ind_dom,   
         aspiranti.cap_dom,   
         aspiranti.cod_com,   
         aspiranti.num_tel,   
         aspiranti.num_tel_2,   
         aspiranti.e_mail,   
         aspiranti.cod_prof,  
         aspiranti.pres_da,
	    cerimonie.data_cer,
	    cerimonie.luogo_cer,
          "000" resp_1,   
          "000" resp_2,
		"000" staff,
		"00" studio,
          aspiranti.membro,   
          "N" flag_tok,   
          "N" flag_oma,    
          "S" flag_er,   
		 "N" flag_dis,
          "ATT" cod_dis,
		suser_name ( ) u_insert, 
		GetDate ( ) d_insert,
		null,
		null,
		null,
		null,
		null,
		aspiranti.vc_parent
    		FROM aspiranti, cerimonie
   		WHERE 	(aspiranti.id= cerimonie.id) and
						( aspiranti.codice= :as_codice);
						
		if trap_sql(sqlca, "INSSTORICOGOH1") < 0 then return -1
						
		
		
		if as_gm= 'S' then
		// inserimento in storico gohonzon...
		
		  INSERT INTO storico_goh  
			 SELECT aspiranti.codice, 
						"OKATAGI",
								 cerimonie.data_cer,
									"ACQ",
										null
			FROM aspiranti, cerimonie
			WHERE 	(aspiranti.id= cerimonie.id) and
						( aspiranti.codice= :as_codice);
						
			if trap_sql(sqlca, "INSSTORICOGOH2") < 0 then return -1
		
		end if
		
		
		




return 0
end event

event dw_current::ue_aggiorna;decimal ld_id
integer li_ret
long ll_idx

setPointer(hourGlass!)

do while ll_idx <= this.rowCount() and li_ret= 0 
	
	ll_idx++
	
	if  this.getItemString(ll_idx, "cconferma")= 'N' then continue
	
	li_ret=  event ue_inserimento( this.getItemString(ll_idx, "codice"), this.getItemString(ll_idx, "membro") )
	
	if li_ret < 0 then continue
	
loop

if li_ret= 0 and ll_idx > 0  then
	
	ld_id= this.getItemDecimal(1, "id")
	delete from cerimonie where id=  :ld_id; // i record di "aspiranti" corrispondenti alla cerimonia vengono cancellati da un trigger
	if trap_sql(sqlca, "ASPDELETE") < 0 then return -1
	
	commit;
	if trap_sql(sqlca, "ASPCOMMIT") < 0 then return -1
	
	return ll_idx
	
else
	
	rollback;
	if trap_sql(sqlca, "ASPROLLBACK") < 0 then return -1	
	
	return -1
	
end if
	
	
	
	
	
end event

