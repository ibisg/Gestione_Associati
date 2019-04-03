$PBExportHeader$w_struttura_tv_tab-old.srw
forward
global type w_struttura_tv_tab-old from w_struttura_tv
end type
type tab_dettaglio from tab within w_struttura_tv_tab-old
end type
type tabpage_base from userobject within tab_dettaglio
end type
type lv_dettaglio from listview within tabpage_base
end type
type uodw_aggiornamento from uodw_anagrafica within tabpage_base
end type
type tabpage_base from userobject within tab_dettaglio
lv_dettaglio lv_dettaglio
uodw_aggiornamento uodw_aggiornamento
end type
type tabpage_rif from userobject within tab_dettaglio
end type
type cb_salva_sr from commandbutton within tabpage_rif
end type
type cb_rimuovi_sr from commandbutton within tabpage_rif
end type
type cb_aggiungi_sr from commandbutton within tabpage_rif
end type
type uo_dw_rif from uodw_generica within tabpage_rif
end type
type tabpage_rif from userobject within tab_dettaglio
cb_salva_sr cb_salva_sr
cb_rimuovi_sr cb_rimuovi_sr
cb_aggiungi_sr cb_aggiungi_sr
uo_dw_rif uo_dw_rif
end type
type tabpage_ediz from userobject within tab_dettaglio
end type
type gb_testata from groupbox within tabpage_ediz
end type
type dw_pubblicazioni from datawindow within tabpage_ediz
end type
type cbx_storico from checkbox within tabpage_ediz
end type
type tabpage_ediz from userobject within tab_dettaglio
gb_testata gb_testata
dw_pubblicazioni dw_pubblicazioni
cbx_storico cbx_storico
end type
type tabpage_offerte from userobject within tab_dettaglio
end type
type cbx_importi from checkbox within tabpage_offerte
end type
type cb_stampa from commandbutton within tabpage_offerte
end type
type dw_storicocontributi from datawindow within tabpage_offerte
end type
type gb_testata1 from groupbox within tabpage_offerte
end type
type tabpage_offerte from userobject within tab_dettaglio
cbx_importi cbx_importi
cb_stampa cb_stampa
dw_storicocontributi dw_storicocontributi
gb_testata1 gb_testata1
end type
type tabpage_liste from userobject within tab_dettaglio
end type
type cb_rimuovi from commandbutton within tabpage_liste
end type
type cb_aggiungi from commandbutton within tabpage_liste
end type
type dw_cod_lista from datawindow within tabpage_liste
end type
type dw_dettaglio_liste from datawindow within tabpage_liste
end type
type gb_2 from groupbox within tabpage_liste
end type
type tabpage_liste from userobject within tab_dettaglio
cb_rimuovi cb_rimuovi
cb_aggiungi cb_aggiungi
dw_cod_lista dw_cod_lista
dw_dettaglio_liste dw_dettaglio_liste
gb_2 gb_2
end type
type tabpage_studio from userobject within tab_dettaglio
end type
type cb_salva_se from commandbutton within tabpage_studio
end type
type cb_rimuovi_se from commandbutton within tabpage_studio
end type
type cb_aggiungi_se from commandbutton within tabpage_studio
end type
type uo_dw_se from uodw_generica within tabpage_studio
end type
type tabpage_studio from userobject within tab_dettaglio
cb_salva_se cb_salva_se
cb_rimuovi_se cb_rimuovi_se
cb_aggiungi_se cb_aggiungi_se
uo_dw_se uo_dw_se
end type
type tabpage_goh from userobject within tab_dettaglio
end type
type cb_salva_sg from commandbutton within tabpage_goh
end type
type cb_rimuovi_sg from commandbutton within tabpage_goh
end type
type cb_aggiungi_sg from commandbutton within tabpage_goh
end type
type uo_dw_sg from uodw_generica within tabpage_goh
end type
type tabpage_goh from userobject within tab_dettaglio
cb_salva_sg cb_salva_sg
cb_rimuovi_sg cb_rimuovi_sg
cb_aggiungi_sg cb_aggiungi_sg
uo_dw_sg uo_dw_sg
end type
type tab_dettaglio from tab within w_struttura_tv_tab-old
tabpage_base tabpage_base
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
end type
end forward

global type w_struttura_tv_tab-old from w_struttura_tv
integer width = 5486
integer height = 3068
event type integer ue_insertitem ( )
event type integer ue_moveitem ( )
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event ue_trasferimenti ( )
tab_dettaglio tab_dettaglio
end type
global w_struttura_tv_tab-old w_struttura_tv_tab-old

type variables
dataWindowChild idwc_rif
dataWindow idw_dettaglio
string is_codice
end variables

forward prototypes
public function integer lvf_dettaglio (long tvi_handle)
end prototypes

event type integer ue_insertitem();if  tv_struttura.uf_insertitem(tv_struttura.is_struttura_s.handle) > 0 then
 
 	return lvf_dettaglio(tv_struttura.is_struttura_s.handle)
	 
else
	
	return -1
	
end if
end event

event type integer ue_moveitem();if  tv_struttura.uf_moveitem(tv_struttura.is_struttura_s.handle) > 0 then
 
 	return lvf_dettaglio(tv_struttura.is_struttura_s.handle)
	 
else
	
	return -1
	
end if
end event

event type integer ue_runquery(integer ai_qualequery, integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento
long ll_handle
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
	case 1
		ls_object= 'dw_queryofferte'
	case 2
		ls_object= 'dw_queryofferte_div'
	case 3
		ls_object= 'dw_queryofferte_resp'
	case 4
		ls_object= 'dw_queryofferte_tab'
	case 5
		ls_object= 'dw_queryofferte_dettaglio'
end choose

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	tv_struttura.is_struttura_s= ll_tvi.data
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
			
			li_livello_raggruppamento= gi_maxlivello
			
		else
		
			openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
		
			li_livello_raggruppamento= message.doubleParm
			
			if li_livello_raggruppamento= 0 then return -1
			
		end if
	
//	li_pos_raggruppamento= pos(s_struttura_loc.vc_nodo
	
////	open(w_preview_scheda)
//	
//	//w_preview_scheda.dw_current.dataObject= ls_object
//	
//	tab_dettaglio.tabpage_report.dw_report.dataObject= ls_object
//	
//	tab_dettaglio.tabpage_report.dw_report.reset()
//	
//	setpointer(hourGlass!)
//
//	tab_dettaglio.tabpage_report.dw_report.setRedraw(false)

	open(w_preview_scheda)
	
	w_preview_scheda.uodw_current.dataObject= ls_object
	
	w_preview_scheda.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview_scheda.uodw_current.setRedraw(false)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, s_data_s)
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)

		open(w_preview_scheda)
		
		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview_scheda.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_scheda.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_scheda.uodw_current.groupCalc()

w_preview_scheda.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_scheda.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_queryofferte(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

		ls_query= f_creaqueryofferte(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			li_ret= w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura+": ")	
			else
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
			end if
		
		loop
		
	case 2
		
		ls_query= f_creaqueryofferte_div(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)

		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura,
			:ls_cod_div;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
		loop
		
	case 3
		
		ls_query= f_creaqueryofferte_resp(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
			
			PREPARE SQLSA FROM :ls_query ;
			
			OPEN DYNAMIC my_cursor ;
			if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
			
			do while sqlca.sqlcode <> 100
				FETCH my_cursor INTO 
				:ls_livello_struttura, 
				:ls_status,
				:ld_importo,
				:ld_zero,
				:ll_totale_persone,
				:ls_descrizione_struttura,
				:ls_cod_resp;
				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
				if sqlca.sqlcode= 100 then continue
				
				ll_row= w_preview_scheda.uodw_current.insertRow(0)
				w_preview_scheda.uodw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
				w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
				w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
				w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
				w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			loop
		
	case 4
		
		ls_query= f_creaqueryofferte_tab(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura,
			:ls_cod_div,
			:ls_cod_resp;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)	
			w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
		loop
		
	case 5
		
		ls_query= f_creaqueryofferte_dettaglio(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ls_codice,
			:ls_cognome,
			:ls_nome,
			:ls_max_livello,
			:ls_altri_livelli,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "codice", ls_codice)
			w_preview_scheda.uodw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview_scheda.uodw_current.setItem(ll_row, "nome", ls_nome)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
		
		loop
		
end choose

CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0

closecur: CLOSE my_cursor ;
			 trap_sql(sqlca, "QUERY03") 

return -1


end event

event ue_trasferimenti();integer li_ret
listViewItem llvi_dettaglio
treeViewItem ltvi_struttura

long ll_handle
string ls_codice
s_struttura s_struttura_loc

//li_ret= lv_dettaglio.getItem(1, llvi_dettaglio)
ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
li_ret= tv_struttura.getItem(ll_handle, ltvi_struttura)

if li_ret <= 0 then return
	
//s_struttura_loc= llvi_dettaglio.data

s_struttura_loc= ltvi_struttura.data

if s_struttura_loc.livello < gi_maxlivello then return

open(w_ricerca_associati_small)
ls_codice= message.stringParm

if ls_codice = "" then return

if messageBox(this.title, "Confermi il trasferimento?", question!, yesNo!, 2)= 2 then return

//li_ret= lv_dettaglio.getItem(1, llvi_dettaglio)
//
//if li_ret <= 0 then return
//	
//s_struttura_loc= llvi_dettaglio.data

// coordinate del tree view della struttura

update membri_gerarchica
set vc_parent= :s_struttura_loc.vc_nodo
where codice= :ls_codice;

if trap_sql(sqlca, "UPDATE.TRASF01") < 0 then
	rollback;
	trap_sql(sqlca, "ROLLBACK.TRASF01") 
else
	commit;
	trap_sql(sqlca, "COMMIT.TRASF01") 
end if

li_ret= lvf_dettaglio(s_struttura_loc.handle)

if messageBox(this.title, "Il trasferimento è stato eseguito, vuoi modificare ora i dati anagrafici?", question!, yesNo!, 2)= 2 then return

openWithParm(w_dati_anagrafici, ls_codice)

end event

public function integer lvf_dettaglio (long tvi_handle);integer li_idx
long ll_child_handle, ll_rows, ll_idx
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc

tab_dettaglio.tabpage_base.lv_dettaglio.deleteItems()

tv_struttura.getItem(tvi_handle, ll_tvi)

s_struttura_loc= ll_tvi.data

this.setRedraw(false)

tab_dettaglio.tabpage_base.lv_dettaglio.visible= true
tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= false


if s_struttura_loc.livello <  gi_maxlivello then
	
			tab_dettaglio.tabpage_base.lv_dettaglio.view= listViewList!

			ll_child_handle = tv_struttura.FindItem(childTreeItem!, tvi_handle)
			
			do while ll_child_handle <> -1
				
				tv_struttura.getItem(ll_child_handle, ll_tvi)
				
				ll_lvi.data= ll_tvi.data
						
				s_struttura_loc= ll_tvi.data
				
				ll_lvi.label= f_iniziali(s_struttura_loc.descrizione_livello)+": "+f_iniziali(s_struttura_loc.descrizione_struttura)
				ll_lvi.pictureIndex= s_struttura_loc.livello
				ll_lvi.statePictureIndex= 1
		

				ll_lvi.selected= false
				
				if tab_dettaglio.tabpage_base.lv_dettaglio.addItem(ll_lvi) < 0 then return -1
				
				ll_child_handle= tv_struttura.FindItem(nextTreeItem!, ll_child_handle)
			
			loop
		
			for li_idx= 2 to upperBound(tab_dettaglio.control[])
			
				tab_dettaglio.control[li_idx].visible= false
			
			next
		
elseif s_struttura_loc.livello =  gi_maxlivello then
	
			tab_dettaglio.tabpage_base.lv_dettaglio.event ue_list_View_mode()
			
			is_codice= s_struttura_loc.vc_nodo
			
			ll_rows= ids_membri.retrieve(is_codice)
			
			if ll_rows <= 0 then return -1
			
			s_struttura_loc.livello= gi_maxlivello+1
			s_struttura_loc.handle= tvi_handle
			
			for ll_idx= 1 to ll_rows

				s_struttura_loc.codice=	ids_membri.getItemString(ll_idx, "codice")
				s_struttura_loc.cognome=	ids_membri.getItemString(ll_idx, "cognome")
				s_struttura_loc.nome=	ids_membri.getItemString(ll_idx, "nome")
				s_struttura_loc.cod_div=	integer(ids_membri.getItemString(ll_idx, "cod_div"))
				s_struttura_loc.divisione=	ids_membri.getItemString(ll_idx, "divisione")
				s_struttura_loc.citta_nas=	ids_membri.getItemString(ll_idx, "citta_nas")
				s_struttura_loc.prov_nas=	ids_membri.getItemString(ll_idx, "prov_nas")
				s_struttura_loc.data_nas=	ids_membri.getItemDatetime(ll_idx, "data_nas")
				s_struttura_loc.ind_dom=	ids_membri.getItemString(ll_idx, "ind_dom")
				s_struttura_loc.cap_dom=	ids_membri.getItemString(ll_idx, "cap_dom")
				s_struttura_loc.comune=	ids_membri.getItemString(ll_idx, "comune")
				s_struttura_loc.provincia=	ids_membri.getItemString(ll_idx, "provincia")
				s_struttura_loc.num_tel=	ids_membri.getItemString(ll_idx, "num_tel")
				s_struttura_loc.num_tel_2=	ids_membri.getItemString(ll_idx, "num_tel_2")
				s_struttura_loc.e_mail=	ids_membri.getItemString(ll_idx, "e_mail")
				s_struttura_loc.professione=	ids_membri.getItemString(ll_idx, "professione")
				s_struttura_loc.pres_da=	ids_membri.getItemString(ll_idx, "pres_da")
				s_struttura_loc.data_cer=	ids_membri.getItemDatetime(ll_idx, "data_cer")
				s_struttura_loc.luogo_cer=	ids_membri.getItemString(ll_idx, "luogo_cer")
				s_struttura_loc.responsabilita1=	ids_membri.getItemString(ll_idx, "responsabilita1")
				s_struttura_loc.responsabilita2=	ids_membri.getItemString(ll_idx, "responsabilita2")
				s_struttura_loc.livello_studio=	ids_membri.getItemString(ll_idx, "livello_studio")
				s_struttura_loc.flag_goh=	ids_membri.getItemString(ll_idx, "flag_goh")
				s_struttura_loc.flag_tok=	ids_membri.getItemString(ll_idx, "flag_tok")
				s_struttura_loc.flag_oma=	ids_membri.getItemString(ll_idx, "flag_oma")
				s_struttura_loc.flag_er=	ids_membri.getItemString(ll_idx, "flag_er")
				s_struttura_loc.status=	ids_membri.getItemString(ll_idx, "status")

				ll_lvi.label= f_iniziali(trim(s_struttura_loc.cognome)+" "+trim(s_struttura_loc.nome))
				
				if s_struttura_loc.status= 'ATTIVO' then
					ll_lvi.pictureIndex= gi_maxlivello + s_struttura_loc.cod_div
				else
					ll_lvi.pictureIndex= 0
				end if
				
				ll_lvi.statePictureIndex=  2
				
				ll_lvi.data= s_struttura_loc
	
//				tab_dettaglio.tabpage_base.lv_dettaglio.view= listViewList!
				
				if tab_dettaglio.tabpage_base.lv_dettaglio.addItem(ll_lvi) < 0 then return -1
				
			next
			
			tab_dettaglio.tabpage_base.lv_dettaglio.event ue_lv_report()
			
				for li_idx= 2 to upperBound(tab_dettaglio.control[])
				
					tab_dettaglio.control[li_idx].visible= false
				
				next
				
//				tab_dettaglio.tabpage_base.lv_dettaglio.event ue_lv_report()
				
else
			
			tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
			tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
			
			is_codice= s_struttura_loc.codice
			
			tab_dettaglio.selectTab(tab_dettaglio.SelectedTab)
			
			for li_idx= 2 to upperBound(tab_dettaglio.control[])
				
					tab_dettaglio.control[li_idx].visible= true
				
			next

end if

this.setRedraw(true)

return 0
end function
on w_struttura_tv_tab-old.create
int iCurrent
call super::create
this.tab_dettaglio=create tab_dettaglio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dettaglio
end on

on w_struttura_tv_tab-old.destroy
call super::destroy
destroy(this.tab_dettaglio)
end on

event open;call super::open;long ll_handle

ll_handle= AncestorReturnValue

tab_dettaglio.tabpage_base.uodw_aggiornamento.setTransObject(sqlca)
tab_dettaglio.tabpage_rif.uo_dw_rif.setTransObject(sqlca)
tab_dettaglio.tabpage_ediz.dw_pubblicazioni.setTransObject(sqlca_ediz)
tab_dettaglio.tabpage_offerte.dw_storicocontributi.setTransObject(sqlca)
tab_dettaglio.tabpage_studio.uo_dw_se.setTransObject(sqlca)
tab_dettaglio.tabpage_goh.uo_dw_sg.setTransObject(sqlca)

tab_dettaglio.tabpage_rif.uo_dw_rif.getChild("cod_rif", idwc_rif)

lvf_dettaglio(ll_handle)

im_pop_lv_dettaglio= create m_pop_lv_dettaglio

return ll_handle
end event

event resize;call super::resize;tv_struttura.width= WorkspaceWidth() - PixelsToUnits ( 850,  XPixelsToUnits! )

tab_dettaglio.height= this.height - 180

tab_dettaglio.tabpage_base.height= tv_struttura.height //tv_struttura.height // + gb_cerca.height
tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30
tab_dettaglio.width= WorkspaceWidth() - tab_dettaglio.x - 60 

tab_dettaglio.tabpage_base.lv_dettaglio.height= tab_dettaglio.tabpage_base.height - 30

//tab_dettaglio.tabpage_base.lv_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30 

//tab_dettaglio.tabpage_base.uodw_aggiornamento.height=tab_dettaglio.tabpage_base.height - 30

//tab_dettaglio.tabpage_dettaglio.uodw_aggiornamento.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.uodw_aggiornamento.width= tab_dettaglio.tabpage_base.width - 30 

if isValid( idw_dettaglio) then 
	idw_dettaglio.height= this.height - 30/*- idw_dettaglio.y*/ /*- 30*/
	idw_dettaglio.width= this.width - 30
end if



//		tab_dettaglio.tabpage_rif.uo_dw_rif.width= this.width - 50

/*if isValid( idw_dettaglio) then*/// idw_dettaglio.height= this.height - idw_dettaglio.y - 30
end event

type cb_cerca from w_struttura_tv`cb_cerca within w_struttura_tv_tab-old
integer x = 1586
integer y = 28
integer width = 320
end type

type p_cerca from w_struttura_tv`p_cerca within w_struttura_tv_tab-old
integer x = 1431
integer y = 28
integer width = 169
integer height = 96
end type

type sle_cerca from w_struttura_tv`sle_cerca within w_struttura_tv_tab-old
integer y = 28
integer width = 1399
integer textsize = -8
integer weight = 700
long textcolor = 16711680
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_struttura_tv_tab-old
integer y = 136
integer indent = 150
boolean checkboxes = true
end type

event tv_struttura::selectionchanged;call super::selectionchanged;parent.lvf_dettaglio(newHandle)


end event

type tab_dettaglio from tab within w_struttura_tv_tab-old
integer x = 2354
integer y = 28
integer width = 3031
integer height = 2780
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_base tabpage_base
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
end type

on tab_dettaglio.create
this.tabpage_base=create tabpage_base
this.tabpage_rif=create tabpage_rif
this.tabpage_ediz=create tabpage_ediz
this.tabpage_offerte=create tabpage_offerte
this.tabpage_liste=create tabpage_liste
this.tabpage_studio=create tabpage_studio
this.tabpage_goh=create tabpage_goh
this.Control[]={this.tabpage_base,&
this.tabpage_rif,&
this.tabpage_ediz,&
this.tabpage_offerte,&
this.tabpage_liste,&
this.tabpage_studio,&
this.tabpage_goh}
end on

on tab_dettaglio.destroy
destroy(this.tabpage_base)
destroy(this.tabpage_rif)
destroy(this.tabpage_ediz)
destroy(this.tabpage_offerte)
destroy(this.tabpage_liste)
destroy(this.tabpage_studio)
destroy(this.tabpage_goh)
end on

event selectionchanging;choose case newindex
		
	case 1
		
		idw_dettaglio= tab_dettaglio.tabpage_base.uodw_aggiornamento
		
	case 2
		
		idw_dettaglio= tab_dettaglio.tabpage_rif.uo_dw_rif
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_rif.uo_dw_rif.retrieve(is_codice)
	
	case 3
		
//		tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(is_codice)

		idw_dettaglio= tab_dettaglio.tabpage_ediz.dw_pubblicazioni
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
		
	case 4
		
//		tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(is_codice)

		idw_dettaglio= tab_dettaglio.tabpage_offerte.dw_storicocontributi
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_offerte.dw_storicocontributi.retrieve(is_codice )

	case 5
		
			idw_dettaglio= tab_dettaglio.tabpage_liste.dw_dettaglio_liste
	
			idw_dettaglio.Object.DataWindow.ReadOnly="Yes"
		
		if tabpage_liste.dw_cod_lista.rowCount() = 0 then 
			tabpage_liste.dw_cod_lista.setTransObject(sqlca)
			idw_dettaglio.setTransObject(sqlca)
			tabpage_liste.dw_cod_lista.retrieve()
			idw_dettaglio.retrieve(is_codice)
		end if
	
	
	case 6
		
		idw_dettaglio= tab_dettaglio.tabpage_studio.uo_dw_se
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_studio.uo_dw_se.retrieve(is_codice)

	case 7
		
		idw_dettaglio= tab_dettaglio.tabpage_goh.uo_dw_sg
		
		
end choose

if NOT isNull(is_codice) then idw_dettaglio.retrieve(is_codice)

if isVAlid(idw_dettaglio) then idw_dettaglio.height=this.height - 180//0
if isVAlid(idw_dettaglio) then idw_dettaglio.width=this.width - 30//0

end event

type tabpage_base from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Base"
long tabtextcolor = 33554432
string picturename = "EditDataTabular!"
long picturemaskcolor = 536870912
lv_dettaglio lv_dettaglio
uodw_aggiornamento uodw_aggiornamento
end type

on tabpage_base.create
this.lv_dettaglio=create lv_dettaglio
this.uodw_aggiornamento=create uodw_aggiornamento
this.Control[]={this.lv_dettaglio,&
this.uodw_aggiornamento}
end on

on tabpage_base.destroy
destroy(this.lv_dettaglio)
destroy(this.uodw_aggiornamento)
end on

type lv_dettaglio from listview within tabpage_base
event type integer ue_lv_report ( )
event ue_list_view_mode ( )
integer width = 1385
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 16777215
boolean autoarrange = true
boolean extendedselect = true
boolean fixedlocations = true
boolean gridlines = true
listviewview view = listviewlist!
string largepicturename[] = {"wi0064-48.gif","Library!","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"wi0064-48.gif","Library!","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer smallpicturewidth = 32
integer smallpictureheight = 32
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event type integer ue_lv_report();if this.view <> listViewReport! then this.view = listViewReport! // return -1

integer li_index
listViewItem lvi_report
s_struttura s_struttura_s

setpointer(hourGlass!)

this.setRedraw(false)

li_index = this.FindItem(0, directionAll!, false, false, false, false)

do while li_index <> -1
		
		if this.GetItem ( li_index, lvi_report )= -1 then exit
		
		s_struttura_s= lvi_report.data
		
		this.setItem(li_index, 1, f_iniziali(s_struttura_s.cognome+ " " +s_struttura_s.nome) )
		this.setItem(li_index, 2, s_struttura_s.status)
		this.setItem(li_index, 3, s_struttura_s.flag_goh)
		this.setItem(li_index, 4, s_struttura_s.flag_tok)
		this.setItem(li_index, 5, s_struttura_s.flag_oma)
		this.setItem(li_index, 6, s_struttura_s.responsabilita1)
		this.setItem(li_index, 7, s_struttura_s.responsabilita2)
		
		li_index = this.FindItem(li_index, directionAll!, false, false, false, false)
		
loop

this.setRedraw(true)

return 0
end event

event ue_list_view_mode();this.setRedraw(false)

this.view= listViewReport!

if this.totalColumns() = 0 then

	this.addColumn("Nome", left!, 800)
	this.addColumn("Status", center!, 250)
	this.addColumn("Okatagi", center!, 250)
	this.addColumn("Tokubetsu", center!, 250)
	this.addColumn("Omamori", center!, 250)
	this.addColumn("1° responsabilità", left!, 400)
	this.addColumn("2° responsabilità", left!, 400)
	
end if

this.setRedraw(true)
end event

event doubleclicked;integer li_ret= 1, li_idx
long ll_nodo, ll_livello, ll_handle, ll_struttura
listViewItem llvi_dettaglio
string ls_nodo
treeViewItem ltvi_struttura
s_struttura s_struttura_loc

//addColumn("Nome", left!, 800)
//addColumn("Status", left!, 400)
//addColumn("Okatagi", left!, 400)
//addColumn("Tokubetsu", left!, 400)
//addColumn("Omamori", left!, 400)
//addColumn("Responsabilità", left!, 400)

li_ret= getItem(index, llvi_dettaglio)

if li_ret <= 0 then return -1
	
s_struttura_loc= llvi_dettaglio.data

// coordinate del tree view della struttura

ls_nodo= s_struttura_loc.vc_nodo

ll_livello= s_struttura_loc.livello

ll_handle= s_struttura_loc.handle

if ll_livello > gi_maxlivello then
	
			tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
			tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
			
			is_codice= s_struttura_loc.codice
			
			tab_dettaglio.selectTab(tab_dettaglio.SelectedTab)
			
			for li_idx= 2 to upperBound(tab_dettaglio.control[])
				
					tab_dettaglio.control[li_idx].visible= true
				
			next


else
	
	li_ret= tv_struttura.selectItem(ll_handle)

end if

return 0
end event
event rightclicked;im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )
end event

type uodw_aggiornamento from uodw_anagrafica within tabpage_base
integer width = 2994
integer height = 2576
integer taborder = 60
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;if rowcount > 0 then
	this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")
	this.object.gb_struttura.text= "Struttura: "+this.getItemString(1, "vc_parent")
end if
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case 'b_scheda'
		
		open(w_preview_scheda)
		w_preview_scheda.uodw_current.dataObject= "dw_scheda_anagrafica_gerarchica"
			w_preview_scheda.uodw_current.setTransObject(sqlca)
		
		w_preview_scheda.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_scheda.uodw_current.setRedraw(false)
		w_preview_scheda.uodw_current.retrieve(is_codice)
		w_preview_scheda.uodw_current.setRedraw(true)

	case "b_bollettino"
		
		s_bollettini s_bollettini_s
		
		s_bollettini_s.tipo_stampa= "N"
		s_bollettini_s.criterio= uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice")
		
		openWithParm(w_bollettini,  s_bollettini_s)

end choose
end event

type tabpage_rif from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Riferimenti"
long tabtextcolor = 33554432
string picturename = "Custom020!"
long picturemaskcolor = 536870912
cb_salva_sr cb_salva_sr
cb_rimuovi_sr cb_rimuovi_sr
cb_aggiungi_sr cb_aggiungi_sr
uo_dw_rif uo_dw_rif
end type

on tabpage_rif.create
this.cb_salva_sr=create cb_salva_sr
this.cb_rimuovi_sr=create cb_rimuovi_sr
this.cb_aggiungi_sr=create cb_aggiungi_sr
this.uo_dw_rif=create uo_dw_rif
this.Control[]={this.cb_salva_sr,&
this.cb_rimuovi_sr,&
this.cb_aggiungi_sr,&
this.uo_dw_rif}
end on

on tabpage_rif.destroy
destroy(this.cb_salva_sr)
destroy(this.cb_rimuovi_sr)
destroy(this.cb_aggiungi_sr)
destroy(this.uo_dw_rif)
end on

type cb_salva_sr from commandbutton within tabpage_rif
integer x = 827
integer y = 4
integer width = 402
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if uo_dw_rif.update() < 0 then
	rollback;
else
	commit;
end if

//this.enabled= false
end event

type cb_rimuovi_sr from commandbutton within tabpage_rif
integer x = 411
integer y = 4
integer width = 402
integer height = 112
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	uo_dw_rif.deleteRow(0)
	cb_salva_sr.enabled= true
end if
end event

type cb_aggiungi_sr from commandbutton within tabpage_rif
integer y = 4
integer width = 402
integer height = 112
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

ll_row= uo_dw_rif.insertRow(0)

uo_dw_rif.setItem(ll_row, "codice", is_codice)
end event

type uo_dw_rif from uodw_generica within tabpage_rif
event type integer ue_mail ( string as_mail )
integer y = 128
integer width = 2702
integer height = 1664
integer taborder = 80
string dataobject = "dw_riferimenti"
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event type integer ue_mail(string as_mail);mailSession mSes

mailReturnCode mRet

mailMessage mMsg

if isNull(as_mail) or as_mail= "" then
	messageBox(parent.text, "Indirizzo e-mail non presente.", information!)
	return 0
end if

setPointer(hourGlass!)

// Create a mail session

mSes = create mailSession

// Log on to the session

mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon fallito.')
		return -1

END IF

// Populate the mailMessage structure

//mMsg.Subject = "boh"
//
//mMsg.NoteText = 'Luncheon at 12:15'

//			mMsg.Recipient[1].name = 'Smith, John'
//			
//			mMsg.Recipient[2].name = 'Shaw, Sue'

//			mMsg.Recipient[1].name = 'GdS, GdS'

mMsg.Recipient[1].address= trim(as_mail)

// Send the mail

mRet = mSes.mailSend(mMsg) // +cc

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail Send", 'Mail non inviata')
		return -1

END IF

mSes.mailLogoff()

DESTROY mSes

return 0
		

end event

event buttonclicked;call super::buttonclicked;this.scrollToRow(row)

if dwo.name= "b_invia" then
	
	string ls_mail

	if uo_dw_rif.getRow() <= 0 then return 0
	
	ls_mail= uo_dw_rif.getItemString(uo_dw_rif.getRow(), "riferimento_descr")
	
	return uo_dw_rif.event ue_mail(ls_mail)
	
end if
end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row(this)
end event

type tabpage_ediz from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Edizioni"
long tabtextcolor = 33554432
string picturename = "Custom003!"
long picturemaskcolor = 536870912
gb_testata gb_testata
dw_pubblicazioni dw_pubblicazioni
cbx_storico cbx_storico
end type

on tabpage_ediz.create
this.gb_testata=create gb_testata
this.dw_pubblicazioni=create dw_pubblicazioni
this.cbx_storico=create cbx_storico
this.Control[]={this.gb_testata,&
this.dw_pubblicazioni,&
this.cbx_storico}
end on

on tabpage_ediz.destroy
destroy(this.gb_testata)
destroy(this.dw_pubblicazioni)
destroy(this.cbx_storico)
end on

type gb_testata from groupbox within tabpage_ediz
integer width = 2555
integer height = 120
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
borderstyle borderstyle = stylelowered!
end type

type dw_pubblicazioni from datawindow within tabpage_ediz
integer y = 128
integer width = 2555
integer height = 1668
integer taborder = 30
string title = "none"
string dataobject = "dw_pubblicazioni"
boolean vscrollbar = true
string icon = "Report5!"
boolean livescroll = true
end type

type cbx_storico from checkbox within tabpage_ediz
integer x = 37
integer y = 36
integer width = 887
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra lo storico abbonamenti"
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked= true then
	dw_pubblicazioni.setFilter("")
else
	dw_pubblicazioni.setFilter("copie_residue> 0")
end if

dw_pubblicazioni.filter()
end event

type tabpage_offerte from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Offerte"
long tabtextcolor = 33554432
string picturename = "Custom054!"
long picturemaskcolor = 536870912
cbx_importi cbx_importi
cb_stampa cb_stampa
dw_storicocontributi dw_storicocontributi
gb_testata1 gb_testata1
end type

on tabpage_offerte.create
this.cbx_importi=create cbx_importi
this.cb_stampa=create cb_stampa
this.dw_storicocontributi=create dw_storicocontributi
this.gb_testata1=create gb_testata1
this.Control[]={this.cbx_importi,&
this.cb_stampa,&
this.dw_storicocontributi,&
this.gb_testata1}
end on

on tabpage_offerte.destroy
destroy(this.cbx_importi)
destroy(this.cb_stampa)
destroy(this.dw_storicocontributi)
destroy(this.gb_testata1)
end on

type cbx_importi from checkbox within tabpage_offerte
integer x = 27
integer y = 36
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Visualizza importi"
end type

event clicked;integer i_ret

if this.checked= true then
	
	open(w_check_pw)
	
	i_ret= message.doubleParm
	
	if i_ret= 1 then
		
		//visualizza gli importi
//		tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 1
//		tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo_t.Visible= 1
		
	else
		
		this.checked= false
		
	end if
	
else
	
//	tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 0
//	tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo_t.Visible= 0
	
end if
end event

type cb_stampa from commandbutton within tabpage_offerte
integer x = 864
integer y = 8
integer width = 334
integer height = 112
integer taborder = 22
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Stampa"
end type

event clicked;//openWithParm(w_dw_print_options, tab_dati.tabpage_storicocontributi.dw_storicocontributi)
end event

type dw_storicocontributi from datawindow within tabpage_offerte
integer y = 128
integer width = 2725
integer height = 1700
integer taborder = 20
string dataobject = "dw_info"
boolean vscrollbar = true
boolean livescroll = true
end type

event sqlpreview;return 0
end event

type gb_testata1 from groupbox within tabpage_offerte
integer width = 832
integer height = 124
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
borderstyle borderstyle = stylelowered!
end type

type tabpage_liste from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Liste"
long tabtextcolor = 33554432
string picturename = "Custom002!"
long picturemaskcolor = 536870912
cb_rimuovi cb_rimuovi
cb_aggiungi cb_aggiungi
dw_cod_lista dw_cod_lista
dw_dettaglio_liste dw_dettaglio_liste
gb_2 gb_2
end type

on tabpage_liste.create
this.cb_rimuovi=create cb_rimuovi
this.cb_aggiungi=create cb_aggiungi
this.dw_cod_lista=create dw_cod_lista
this.dw_dettaglio_liste=create dw_dettaglio_liste
this.gb_2=create gb_2
this.Control[]={this.cb_rimuovi,&
this.cb_aggiungi,&
this.dw_cod_lista,&
this.dw_dettaglio_liste,&
this.gb_2}
end on

on tabpage_liste.destroy
destroy(this.cb_rimuovi)
destroy(this.cb_aggiungi)
destroy(this.dw_cod_lista)
destroy(this.dw_dettaglio_liste)
destroy(this.gb_2)
end on

type cb_rimuovi from commandbutton within tabpage_liste
integer x = 846
integer y = 240
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;//tab_dati.tabpage_liste.dw_dettaglio_liste.deleteRow(0)
//
//if tab_dati.tabpage_liste.dw_dettaglio_liste.update() < 0 then
//	messageBox(parent.text, "Aggiornamento fallito.", exclamation!)
//	rollback;
//	if trap_sql(sqlca, "LISTERIM01") < 0 then return -1
//else
//	commit;
//	if trap_sql(sqlca, "LISTERIM02") < 0 then return -1
//end if
end event

type cb_aggiungi from commandbutton within tabpage_liste
integer x = 434
integer y = 240
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;//long ll_row
//
//if dw_dettaglio_liste.Find ( "cod_lista='"+dw_cod_lista.getItemString(dw_cod_lista.getRow(), "cod_lista")+"'", 1, dw_dettaglio_liste.rowCount() ) > 0 then
//	
//	messageBox(parent.text, "Lista già inserita.", information!)
//	return
//	
//end if
//
//ll_row= dw_dettaglio_liste.insertRow(0)
//
//dw_dettaglio_liste.setItem(ll_row, "cod_lista", dw_cod_lista.getItemString(dw_cod_lista.getRow(), "cod_lista") )
//
//dw_dettaglio_liste.setItem(ll_row, "codice", is_codice)
//
////dw_dettaglio_liste.setItem(ll_row, "liste_descrizione", dw_cod_lista.getItemString(dw_cod_lista.getRow(), "descrizione") )
//
//if tab_dati.tabpage_liste.dw_dettaglio_liste.update() < 0 then
//	messageBox(parent.text, "Aggiornamento fallito.", exclamation!)
//	rollback;
//	if trap_sql(sqlca, "LISTEADD01") < 0 then return -1
//else
//	commit;
//	if trap_sql(sqlca, "LISTEADD02") < 0 then return -1
//end if

end event

type dw_cod_lista from datawindow within tabpage_liste
integer x = 78
integer y = 80
integer width = 1586
integer height = 120
integer taborder = 100
string title = "none"
string dataobject = "dw_cod_lista"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_dettaglio_liste from datawindow within tabpage_liste
integer x = 32
integer y = 392
integer width = 1678
integer height = 1544
integer taborder = 40
string title = "none"
string dataobject = "dw_liste_dettaglio"
boolean livescroll = true
end type

event rowfocuschanged;f_select_current_row(this)
end event

type gb_2 from groupbox within tabpage_liste
integer x = 1911
integer y = 960
integer width = 1742
integer height = 1968
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Inserimento in liste"
borderstyle borderstyle = stylelowered!
end type

type tabpage_studio from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Dip. Studio"
long tabtextcolor = 33554432
string picturename = "Custom083!"
long picturemaskcolor = 536870912
cb_salva_se cb_salva_se
cb_rimuovi_se cb_rimuovi_se
cb_aggiungi_se cb_aggiungi_se
uo_dw_se uo_dw_se
end type

on tabpage_studio.create
this.cb_salva_se=create cb_salva_se
this.cb_rimuovi_se=create cb_rimuovi_se
this.cb_aggiungi_se=create cb_aggiungi_se
this.uo_dw_se=create uo_dw_se
this.Control[]={this.cb_salva_se,&
this.cb_rimuovi_se,&
this.cb_aggiungi_se,&
this.uo_dw_se}
end on

on tabpage_studio.destroy
destroy(this.cb_salva_se)
destroy(this.cb_rimuovi_se)
destroy(this.cb_aggiungi_se)
destroy(this.uo_dw_se)
end on

type cb_salva_se from commandbutton within tabpage_studio
integer x = 823
integer y = 4
integer width = 402
integer height = 112
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;if uo_dw_se.update() < 0 then
	rollback;
else
	commit;
end if

this.enabled= false
end event

type cb_rimuovi_se from commandbutton within tabpage_studio
integer x = 411
integer y = 4
integer width = 402
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	uo_dw_se.deleteRow(0)
	cb_salva_se.enabled= true
end if
end event

type cb_aggiungi_se from commandbutton within tabpage_studio
integer x = 5
integer y = 4
integer width = 402
integer height = 112
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

ll_row= uo_dw_se.insertRow(0)

uo_dw_se.setItem(ll_row, "codice", is_codice)
end event

type uo_dw_se from uodw_generica within tabpage_studio
integer y = 128
integer width = 1696
integer height = 1484
integer taborder = 50
string dataobject = "ds_curr_studio"
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;cb_salva_se.enabled= true
end event

type tabpage_goh from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2994
integer height = 2652
long backcolor = 67108864
string text = "Storico Gohonzon"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_salva_sg cb_salva_sg
cb_rimuovi_sg cb_rimuovi_sg
cb_aggiungi_sg cb_aggiungi_sg
uo_dw_sg uo_dw_sg
end type

on tabpage_goh.create
this.cb_salva_sg=create cb_salva_sg
this.cb_rimuovi_sg=create cb_rimuovi_sg
this.cb_aggiungi_sg=create cb_aggiungi_sg
this.uo_dw_sg=create uo_dw_sg
this.Control[]={this.cb_salva_sg,&
this.cb_rimuovi_sg,&
this.cb_aggiungi_sg,&
this.uo_dw_sg}
end on

on tabpage_goh.destroy
destroy(this.cb_salva_sg)
destroy(this.cb_rimuovi_sg)
destroy(this.cb_aggiungi_sg)
destroy(this.uo_dw_sg)
end on

type cb_salva_sg from commandbutton within tabpage_goh
integer x = 818
integer width = 402
integer height = 112
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;if uo_dw_sg.update() < 0 then
	rollback;
else
	commit;
end if

this.enabled= false
end event

type cb_rimuovi_sg from commandbutton within tabpage_goh
integer x = 407
integer width = 402
integer height = 112
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	uo_dw_sg.deleteRow(0)
	cb_salva_sg.enabled= true
end if
end event

type cb_aggiungi_sg from commandbutton within tabpage_goh
integer width = 402
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

ll_row= uo_dw_sg.insertRow(0)

uo_dw_sg.setItem(ll_row, "codice", is_codice)
end event

type uo_dw_sg from uodw_generica within tabpage_goh
integer y = 128
integer width = 2528
integer taborder = 110
string dataobject = "d_storico_goh"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;cb_salva_sg.enabled= true
end event

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

ls_note=  this.getItemString(row, "note")

if dwo.name= 'b_note' then
	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
	end if
	
end if
end event

