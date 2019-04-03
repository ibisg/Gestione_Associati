$PBExportHeader$w_struttura_tv_tab_test.srw
forward
global type w_struttura_tv_tab_test from w_struttura_tv
end type
type tab_dettaglio from tab within w_struttura_tv_tab_test
end type
type tabpage_base from userobject within tab_dettaglio
end type
type lv_dettaglio from listview within tabpage_base
end type
type uodw_aggiornamento from uodw_generica within tabpage_base
end type
type tabpage_base from userobject within tab_dettaglio
lv_dettaglio lv_dettaglio
uodw_aggiornamento uodw_aggiornamento
end type
type tabpage_andamenti from userobject within tab_dettaglio
end type
type cb_filtra from commandbutton within tabpage_andamenti
end type
type cb_apri from commandbutton within tabpage_andamenti
end type
type pb_carica from picturebutton within tabpage_andamenti
end type
type uodw_stat from uodw_generica within tabpage_andamenti
end type
type st_name from statictext within tabpage_andamenti
end type
type dw_reportname from datawindow within tabpage_andamenti
end type
type tabpage_andamenti from userobject within tab_dettaglio
cb_filtra cb_filtra
cb_apri cb_apri
pb_carica pb_carica
uodw_stat uodw_stat
st_name st_name
dw_reportname dw_reportname
end type
type tabpage_rif from userobject within tab_dettaglio
end type
type uodw_rif from uodw_generica within tabpage_rif
end type
type tabpage_rif from userobject within tab_dettaglio
uodw_rif uodw_rif
end type
type tabpage_ediz from userobject within tab_dettaglio
end type
type uodw_pubblicazioni from uodw_generica within tabpage_ediz
end type
type tabpage_ediz from userobject within tab_dettaglio
uodw_pubblicazioni uodw_pubblicazioni
end type
type tabpage_offerte from userobject within tab_dettaglio
end type
type uodw_storicocontributi from uodw_generica within tabpage_offerte
end type
type tabpage_offerte from userobject within tab_dettaglio
uodw_storicocontributi uodw_storicocontributi
end type
type tabpage_liste from userobject within tab_dettaglio
end type
type uodw_liste from uodw_generica within tabpage_liste
end type
type tabpage_liste from userobject within tab_dettaglio
uodw_liste uodw_liste
end type
type tabpage_studio from userobject within tab_dettaglio
end type
type uodw_se from uodw_generica within tabpage_studio
end type
type tabpage_studio from userobject within tab_dettaglio
uodw_se uodw_se
end type
type tabpage_goh from userobject within tab_dettaglio
end type
type uodw_sg from uodw_generica within tabpage_goh
end type
type tabpage_goh from userobject within tab_dettaglio
uodw_sg uodw_sg
end type
type tabpage_resp from userobject within tab_dettaglio
end type
type uodw_storico_resp from uodw_generica within tabpage_resp
end type
type tabpage_resp from userobject within tab_dettaglio
uodw_storico_resp uodw_storico_resp
end type
type tabpage_log from userobject within tab_dettaglio
end type
type uodw_vislog from uodw_generica within tabpage_log
end type
type tabpage_log from userobject within tab_dettaglio
uodw_vislog uodw_vislog
end type
type tab_dettaglio from tab within w_struttura_tv_tab_test
tabpage_base tabpage_base
tabpage_andamenti tabpage_andamenti
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
tabpage_resp tabpage_resp
tabpage_log tabpage_log
end type
type dw_1 from datawindow within w_struttura_tv_tab_test
end type
end forward

global type w_struttura_tv_tab_test from w_struttura_tv
integer width = 6519
integer height = 3228
string icon = "typewr_red.ico"
string pointer = "Arrow!"
event type integer ue_insertitem ( )
event type integer ue_moveitem ( )
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event ue_trasferimenti ( )
event type integer ue_runquerystruttura ( integer ai_qualequery,  integer ai_source )
event type integer ue_querystruttura ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_runquery_offerte ( integer ai_qualequery,  integer ai_source )
event type integer ue_modifyitem ( )
event type integer ue_postopen ( )
event type integer ue_runquery_abbonamenti ( integer ai_source )
event type long ue_runreport ( integer ai_qualequery,  integer ai_source )
event type integer ue_bollettini ( s_preview as_preview_s )
event type integer ue_mcompleta ( )
event type integer ue_queryorg ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  integer al_livello_sup )
event type integer ue_runqueryorg ( integer ai_qualequery,  integer ai_source )
event type integer ue_run_completa ( integer ai_source )
tab_dettaglio tab_dettaglio
dw_1 dw_1
end type
global w_struttura_tv_tab_test w_struttura_tv_tab_test

type variables
boolean ib_modificatastruttura
dataWindowChild idwc_rif
uodw_generica idw_dettaglio
dataWindowChild idwc_reportname
dataWindowChild idwc_cod_dis
string is_codice, is_dataobject
integer iddlb_index= 1, ii_tabindex= 1
integer ii_anno
m_pop_lv_dettaglio im_pop_lv_dettaglio
//s_preview is_preview_s
nca_pdf inca_pdf
u_ds_com ids_com

m_preview im_preview
m_pop_tv_tab im_pop_tv

s_struttura is_strutturatgt_s, is_current_item_s

end variables

forward prototypes
public function integer wf_modified ()
public function integer wf_riferimenti ()
public function integer wf_deletefromliste (string as_codice)
public function integer lvf_dettaglio (long tvi_handle)
end prototypes

event type integer ue_insertitem();long ll_parent

if gi_classediutenza= gc_cons then
	messageBox(this.title, "Operazione non permessa", exclamation!)
	return -1
end if

ll_parent= tv_struttura.is_struttura_s.handle

if  tv_struttura.uf_insertitem(ll_parent) =1 then
 	
	 tab_dettaglio.selectTab(1)
	 
 	return lvf_dettaglio(ll_parent)
	 
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
	case 6
		ls_object= 'dw_queryofferte_dis'
end choose

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
	
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

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_offerte, is_preview_s)
	
//	w_preview_offerte.uodw_current.dataObject= ls_object
	
//	w_preview_offerte.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview_offerte.uodw_current.setRedraw(false)

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

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_offerte, is_preview_s)
		
//		w_preview_offerte.uodw_current.dataObject= ls_object
		
		w_preview_offerte.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_offerte.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_offerte.uodw_current.groupCalc()

//w_preview_scheda.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_offerte.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_queryofferte(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret, li_liv_resp
string ls_nodo, ls_query, ls_status, ls_cod_div, ls_er, ls_descrizione_struttura, ls_livello_struttura, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli, ls_npa
long ll_totale_persone, ll_row, ll_npa
decimal ld_importo, ld_zero

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

		ls_query= f_creaqueryofferte(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		// messageBox("test", ls_query)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO
			:ls_livello_struttura, 
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ll_npa,
			:ls_descrizione_struttura;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview_offerte.uodw_current.insertRow(0)
			li_ret= w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "")	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", "")					
			end if
		
		loop
		
	case 2
		
		ls_query= f_creaqueryofferte_div(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)

		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_nodo,
			:ls_livello_struttura, 
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ll_npa,
			:ls_descrizione_struttura,
			:ls_cod_div;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_offerte.uodw_current.insertRow(0)
			w_preview_offerte.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
			w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte per divisione dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview_offerte.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_offerte.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
		
		loop
		
	case 3
		
		ls_query= f_creaqueryofferte_resp(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
			
			PREPARE SQLSA FROM :ls_query ;
			
			OPEN DYNAMIC my_cursor ;
			if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
			
			do while sqlca.sqlcode <> 100
				FETCH my_cursor INTO 
				:ls_nodo,
				:ls_livello_struttura, 
				:ld_importo,
				:ld_zero,
				:ll_totale_persone,				
				:ll_npa,
				:ls_descrizione_struttura,
				:li_liv_resp;
				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
				if sqlca.sqlcode= 100 then continue
				
				ll_row= w_preview_offerte.uodw_current.insertRow(0)
				w_preview_offerte.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
				w_preview_offerte.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
				w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte per livelli di responsabilità dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview_offerte.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
				w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
				w_preview_offerte.uodw_current.setItem(ll_row, "importo_0", ld_zero)
				w_preview_offerte.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview_offerte.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
				
//			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
			
			loop
		
	case 4
		
		ls_query= f_creaqueryofferte_tab(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO
			:ls_nodo,
			:ls_livello_struttura, 
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ll_npa,
			:ls_descrizione_struttura,
			:ls_cod_div,
			:li_liv_resp;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_offerte.uodw_current.insertRow(0)
			w_preview_offerte.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
			w_preview_offerte.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
			w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte analitico dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo_0", ld_zero)	
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_offerte.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_offerte.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
//			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
		
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
			:ll_npa,
			:ld_importo,
			:ls_codice,
			:ls_cognome,
			:ls_nome,
			:ls_max_livello,
			:ls_altri_livelli,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_offerte.uodw_current.insertRow(0)
			w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte nominativo dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_offerte.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_offerte.uodw_current.setItem(ll_row, "codice", ls_codice)
			w_preview_offerte.uodw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview_offerte.uodw_current.setItem(ll_row, "nome", ls_nome)
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
		
		loop
		
	case 6
		
		ls_query= f_creaqueryofferte_dis(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)

		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ls_npa, 
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_offerte.uodw_current.insertRow(0)
			w_preview_offerte.uodw_current.setItem(ll_row, "intestazione", "Report offerte per status dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_offerte.uodw_current.setItem(ll_row, "cod_dis", ls_status)
			w_preview_offerte.uodw_current.setItem(ll_row, "flag_npa", ls_npa)
			w_preview_offerte.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			w_preview_offerte.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_offerte.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_offerte.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			
//			if ai_source= 1 then
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_offerte.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
	
		loop
		
end choose

w_preview_offerte.uodw_current.sort()

CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0

closecur: CLOSE my_cursor ;
			 trap_sql(sqlca, "QUERY03") 

return -1


end event

event ue_trasferimenti();integer li_ret
listViewItem llvi_dettaglio
treeViewItem ltvi_struttura, ltvi_newitem

long ll_handle, ll_todelete
string ls_codice
s_struttura s_struttura_loc

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
li_ret= tv_struttura.getItem(ll_handle, ltvi_struttura)

if li_ret <= 0 then return

s_struttura_loc= ltvi_struttura.data

if s_struttura_loc.livello < gi_maxlivello then return

s_ricerca s_ricerca_s

open(w_ricerca_associati_small)

s_ricerca_s= message.powerObjectParm

if s_ricerca_s.i_retcode= -1 then return

ls_codice= s_ricerca_s.codice

if ls_codice = "" then return

if messageBox(this.title, "Confermi il trasferimento?", question!, yesNo!, 2)= 2 then return

update membri_gerarchica
set vc_parent= :s_struttura_loc.vc_nodo, flag_ldr= 'N'
where codice= :ls_codice;

if trap_sql(sqlca, "UPDATE.TRASF01") < 0 then
	rollback;
	trap_sql(sqlca, "ROLLBACK.TRASF01") 
else
	commit;
	trap_sql(sqlca, "COMMIT.TRASF01") 
end if

if messageBox(this.title, "Vuoi annullare responsabilità ed appartenenza agli staff della persona trasferita?.", question!, yesNo!, 2)= 1 then
		update membri_gerarchica
		set cod_att_ist_1= '000', cod_att_ist_2= '000', codice_staff= '000'
		where codice= :ls_codice;
		
		if trap_sql(sqlca, "UPDATE.TRASF01.01") < 0 then
			rollback;
			trap_sql(sqlca, "ROLLBACK.TRASF01.01") 
		else
			commit;
			trap_sql(sqlca, "COMMIT.TRASF01.01") 
		end if
end if

if tv_struttura.uf_visualizzanuovoitem(s_struttura_loc.handle)= -1 then return

s_session_s.codice= ls_codice
s_session_s.context= "Anagrafica: trasferimenti"
f_log(s_session_s, "Trasferimento in entrata da: "+s_ricerca_s.struttura, true)
					
if messageBox(this.title, "Il trasferimento è stato eseguito, vuoi modificare ora i dati anagrafici?", question!, yesNo!, 2)= 2 then

		this.lvf_dettaglio(s_struttura_loc.handle)
					
	else // modifica...

//		idw_dettaglio.retrieve(ls_codice)
		tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
		tab_dettaglio.selectTab(1)
		
		for li_ret= 1 to upperBound(tab_dettaglio.control[])
				
			tab_dettaglio.control[li_ret].visible= true
				
		next
		
			tab_dettaglio.tabpage_andamenti.visible= false
		
			tab_dettaglio.tabpage_offerte.visible= 	f_has_p('S')
			
			tab_dettaglio.tabpage_ediz.visible= 		f_has_p('W')
			tab_dettaglio.tabpage_studio.visible= 	f_has_p('W')
			tab_dettaglio.tabpage_goh.visible= 		f_has_p('W')
			tab_dettaglio.tabpage_resp.visible= 		f_has_p('W')
		
		idw_dettaglio.retrieve(ls_codice)
		
			if idw_dettaglio.getItemString(idw_dettaglio.getRow(), "flag_npa")=  '1' then
				tab_dettaglio.tabpage_liste.visible= false
			else
				tab_dettaglio.tabpage_liste.visible= 	f_has_p('S')
			end if
			
		tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
		
end if
end event

event type integer ue_runquerystruttura(integer ai_qualequery, integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento
long ll_handle
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
	case 1
		ls_object= 'edw_reportcerimonie'
//	case 2
//		ls_object= 'dw_queryofferte_div'
//	case 3
//		ls_object= 'dw_queryofferte_resp'
//	case 4
//		ls_object= 'dw_queryofferte_tab'
//	case 5
//		ls_object= 'dw_queryofferte_dettaglio'
end choose

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello /*-1*/ then
			
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

	is_preview_s.dataObject= ls_object
	is_preview_s.doretrieve= false
	
	openWithParm(w_preview_cerimonie, is_preview_s)
	
//	w_preview_scheda.uodw_current.dataObject= ls_object
	
//	w_preview_scheda.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview_cerimonie.uodw_current.setRedraw(false)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			li_ret= event ue_querystruttura(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, s_data_s)
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_cerimonie, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview_cerimonie.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_cerimonie.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			//tv_struttura.is_struttura_s= ll_lvi.data
			
			s_struttura_loc=  ll_lvi.data
		
			li_ret= event ue_querystruttura(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_cerimonie.uodw_current.groupCalc()

//w_preview_cerimonie.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_cerimonie.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_querystruttura(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero

integer li_anno
datetime ldt_data_cer
string ls_luogo_cer
long ll_u_goh, ll_u_fed, ll_d_goh, ll_d_fed, ll_gu_goh, ll_gu_fed, ll_gd_goh, ll_gd_fed

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

		ls_query= f_creaquerystruttura(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:li_anno,
			:ldt_data_cer,
			:ls_luogo_cer,
			:ll_u_goh,
			:ll_u_fed,
			:ll_d_goh,
			:ll_d_fed,
			:ll_gu_goh,
			:ll_gu_fed,
			:ll_gd_goh,
			:ll_gd_fed,
			:ls_descrizione_struttura;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview_cerimonie.uodw_current.insertRow(0)
//			li_ret= w_preview_cerimonie.uodw_current.setItem(ll_row, "intestazione", "Consegne dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "anno", li_anno)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "data_cer", ldt_data_cer)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "luogo_cer", ls_luogo_cer)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "u_goh", ll_u_goh)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "u_fed", ll_u_fed)	
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "d_goh", ll_d_goh)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "d_fed", ll_d_fed)	
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "gu_goh", ll_gu_goh)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "gu_fed", ll_gu_fed)	
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "gd_goh", ll_gd_goh)
			li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "gd_fed", ll_gd_fed)	
			
			if ai_source= 1 then
				li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)
				li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
				//li_ret=w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_master", "")					
			end if
		
		loop
		
//	case 2
//		
//		ls_query= f_creaqueryofferte_div(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
//
//		PREPARE SQLSA FROM :ls_query ;
//		
//		OPEN DYNAMIC my_cursor ;
//		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
//		
//		do while sqlca.sqlcode <> 100
//			FETCH my_cursor INTO 
//			:ls_livello_struttura, 
//			:ls_status,
//			:ld_importo,
//			:ld_zero,
//			:ll_totale_persone,
//			:ls_descrizione_struttura,
//			:ls_cod_div;
//			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
//			if sqlca.sqlcode= 100 then continue
//			
//			ll_row= w_preview_cerimonie.uodw_current.insertRow(0)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "status", ls_status)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "importo", ld_importo)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "importo_0", ld_zero)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
//		
//		loop
//		
//	case 3
//		
//		ls_query= f_creaqueryofferte_resp(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
//			
//			PREPARE SQLSA FROM :ls_query ;
//			
//			OPEN DYNAMIC my_cursor ;
//			if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
//			
//			do while sqlca.sqlcode <> 100
//				FETCH my_cursor INTO 
//				:ls_livello_struttura, 
//				:ls_status,
//				:ld_importo,
//				:ld_zero,
//				:ll_totale_persone,
//				:ls_descrizione_struttura,
//				:ls_cod_resp;
//				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
//				if sqlca.sqlcode= 100 then continue
//				
//				ll_row= w_preview_cerimonie.uodw_current.insertRow(0)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "status", ls_status)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "importo", ld_importo)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "importo_0", ld_zero)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
//				w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
//			
//			loop
//		
//	case 4
//		
//		ls_query= f_creaqueryofferte_tab(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
//		
//		PREPARE SQLSA FROM :ls_query ;
//		
//		OPEN DYNAMIC my_cursor ;
//		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
//		
//		do while sqlca.sqlcode <> 100
//			FETCH my_cursor INTO 
//			:ls_livello_struttura, 
//			:ls_status,
//			:ld_importo,
//			:ld_zero,
//			:ll_totale_persone,
//			:ls_descrizione_struttura,
//			:ls_cod_div,
//			:ls_cod_resp;
//			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
//			if sqlca.sqlcode= 100 then continue
//			
//			ll_row= w_preview_cerimonie.uodw_current.insertRow(0)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "status", ls_status)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "importo", ld_importo)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "importo_0", ld_zero)	
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
//		
//		loop

		
//	case 5
//		
//		ls_query= f_creaqueryofferte_dettaglio(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
//		
//		PREPARE SQLSA FROM :ls_query ;
//		
//		OPEN DYNAMIC my_cursor ;
//		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
//		
//		do while sqlca.sqlcode <> 100
//			FETCH my_cursor INTO 
//			:ls_livello_struttura, 
//			:ls_status,
//			:ld_importo,
//			:ls_codice,
//			:ls_cognome,
//			:ls_nome,
//			:ls_max_livello,
//			:ls_altri_livelli,
//			:ls_descrizione_struttura;
//			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
//			if sqlca.sqlcode= 100 then continue
//			
//			ll_row= w_preview_cerimonie.uodw_current.insertRow(0)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "status", ls_status)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "importo", ld_importo)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "codice", ls_codice)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "cognome", ls_cognome)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "nome", ls_nome)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
//			w_preview_cerimonie.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
//		
//		loop
		
end choose

CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0

closecur: CLOSE my_cursor ;
			 trap_sql(sqlca, "QUERY03") 

return -1


end event

event type integer ue_runquery_offerte(integer ai_qualequery, integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento, li_anno
long ll_handle
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
	case 1
		ls_object= 'dctb_div'
	case 2
		ls_object= 'dctb_quadrostatistico'
	case 3
		ls_object= 'dctb_membri_per_anni'
	case 4
		ls_object= 'dctb_membri_per_anno'
	case 5
		ls_object= 'dctb_struttura'
	case 6
		ls_object= 'dw_completa'
	case 7
		ls_object= 'dw_count_resp'
	case 8
		ls_object= 'dw_organigramma_test'
	case 9
		ls_object= 'dgraph_membri_per_anno'
	case 10
		ls_object= 'dgraph_membri_per_anno_div'
end choose

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
	
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

	is_preview_s.dataObject= ls_object
	is_preview_s.doretrieve= false
	
	openWithParm(w_preview_offerte, is_preview_s)
	
//	w_preview_scheda.uodw_current.dataObject= ls_object
	
//	w_preview_scheda.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview_offerte.uodw_current.setRedraw(false)
	
	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			li_anno= year(today())
			
			li_ret= 	w_preview_offerte.uodw_current.retrieve(ls_nodo+"%", li_anno, li_livello_raggruppamento/*+2*/)
			
			///////////////////
//			integer ii_anno
//long ll_handle, ll_rows
//s_struttura s_struttura_loc
//treeViewItem ll_tvi
//
//ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
//
//if tv_struttura.GetItem(ll_handle, ll_tvi)= -1 then return -1
//
//s_struttura_loc= ll_tvi.data
//
////if isValid(this.Object.t_header) then this.Object.t_header.Text = s_struttura_loc.descrizione_livello+" "+ s_struttura_loc.descrizione_struttura
//
//ii_anno= year(today())
//
////tab_dettaglio.tabpage_stat.dw_stat.Object.t_header.Text = f_descrizione_struttura_fill(is_struttura_s.vc_nodo)
//
////tab_dettaglio.tabpage_stat.uodw_stat.setTransObject(sqlca)
//
//this.setTransObject(sqlca)
//
///*
// * N.B. Gli argomenti passati nella seguente retrieve sono e devono sempre essere tre:
// * il nodo, l'anno di riferimento, il livello di struttura su cui eseguire l'estrazione.
// * Non sempre sono necessari tutti, per cui una certa dw può utilizzare solo il nodo o il nodo e il livello etc.
// * Per compatibilità in ogni caso ogni dw creata per essere utilizzata in questa sezione del programma deve avere questi tre parametri
// * ( retrieval arguments )  nello stesso ordine anche se non verranno tutti utilizzati.
// * PB dà, nel caso, un messaggio di warning al salvataggio della dw, di cui non va tenuto conto.
// */
//
//ll_rows= this.retrieve(s_struttura_loc.vc_nodo+"%", ii_anno, s_struttura_loc.livello/*+2*/)
			////////////////////////
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_offerte, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview_offerte.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_offerte.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_offerte.uodw_current.groupCalc()

w_preview_offerte.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_offerte.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_modifyitem();if gi_classediutenza= gc_cons then
	messageBox(this.title, "Operazione non permessa", exclamation!)
	return -1
end if

if  tv_struttura.uf_modifyitem(tv_struttura.is_struttura_s.handle) > 0 then
 
 	return 0
	 
else
	
	return -1
	
end if
end event

event type integer ue_postopen();integer li_idx

sqlca_ediz= create transaction

db_connection.uof_getinipar(gc_DBEDIZ)

db_connection.is_connectionparm_s.logid= "ga.user"
db_connection.is_connectionparm_s.logpass=  "gauser"

if db_connection.uof_connectdb(sqlca_ediz) < 0 then return -1

li_idx= tab_dettaglio.tabpage_ediz.uodw_pubblicazioni.setTransObject(sqlca_ediz)

return 0
end event

event type integer ue_runquery_abbonamenti(integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento
long ll_handle
string ls_object= 'dw_test_report_riviste', ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

//open(w_criteri_estrazione)
//
//s_data_s= message.powerObjectParm
//
//if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
			
			li_livello_raggruppamento= gi_maxlivello
			
		else
		
			openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
		
			li_livello_raggruppamento= message.doubleParm
			
			if li_livello_raggruppamento= 0 then return -1
			
		end if

	is_preview_s.dataObject= ls_object
	is_preview_s.ib_dwcreate= false
	is_preview_s.doretrieve= false
	
	openWithParm(w_preview_abbonamenti, is_preview_s)
	
	setpointer(hourGlass!)
	
	w_preview_abbonamenti.uodw_current.setRedraw(false)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
//			li_ret= event ue_queryofferte(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, s_data_s)
			w_preview_abbonamenti.uodw_current.retrieve(ls_nodo, 0, li_livello_raggruppamento)
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_scheda, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview_scheda.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_scheda.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
//			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			w_preview_scheda.uodw_current.retrieve(tv_struttura.is_struttura_s.vc_nodo, tv_struttura.is_struttura_s.livello, 0)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_abbonamenti.uodw_current.groupCalc()

//w_preview_scheda.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_abbonamenti.uodw_current.setRedraw(true)

return li_ret
end event

event type long ue_runreport(integer ai_qualequery, integer ai_source);integer li_livello_raggruppamento, li_pos_raggruppamento, li_howmany, li_ret
long ll_handle, ll_ret
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

//choose case ai_qualequery
//		
//	case 1
//		ls_object= 'dw_count_struttura'
//	case 2
//		ls_object= 'dw_count_resp'
//	case 3
//		ls_object= 'dctb_quadrostatistico'
//	case 4
//		ls_object= 'dctb_quadrostatistico_totale'
//end choose
//
//is_preview_s.dataObject= ls_object
//is_preview_s.ib_dwcreate= false
//is_preview_s.transobject= sqlca
//
//this.setRedraw(false)
//
//if ai_source= 1 then // la query viene richiesta dal treeView...
//	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	ll_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
//	
//	if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
//	
//		li_livello_raggruppamento= gi_maxlivello
//	
//	else
//	
//		openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
//	
//		li_livello_raggruppamento= message.doubleParm
//		
//		if li_livello_raggruppamento= 0 then return -1
//		
//	end if
//	
//	is_preview_s.doretrieve= true
//	is_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
//	is_preview_s.anno= 0
//	is_preview_s.livello= tv_struttura.is_struttura_s.livello
//	
//	openWithParm(w_preview_report, is_preview_s)
//	
//	setpointer(hourGlass!)
//	
//	w_preview_report.uodw_current.setRedraw(false)
//
//	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"
//
//	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
//	
//	PREPARE SQLSA FROM :ls_query ;
//	
//	OPEN DYNAMIC query_cur ;
//	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1
//
//		do while sqlca.sqlcode <> 100
//			
//			fetch query_cur into
//			:ls_nodo;
//			if sqlca.sqlcode= 100 then continue
//			
//			ll_ret= w_preview_report.uodw_current.retrieve(is_preview_s.criterio, is_preview_s.anno, is_preview_s.livello)
//		
//			w_preview_report.uodw_current.groupCalc()
//			
//			if li_ret= -1 then exit
//	
//		loop
//		
//		close query_cur;
//		
//		w_preview_report.uodw_current.setRedraw(true)
//	
//else // la query viene richiesta dalla list view...
//	
//	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
//
//	is_preview_s.doretrieve= false
//	is_preview_s.dataObject= ls_object
//	
//	openWithParm(w_preview_report, is_preview_s)
//	
//		do while ll_handle <> -1
//			
//			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
//			
//			tv_struttura.is_struttura_s= ll_lvi.data
//			
//			ll_ret= w_preview_report.uodw_current.retrieve(tv_struttura.is_struttura_s.vc_nodo, is_preview_s.anno, is_preview_s.livello)
//			
//			if ll_ret= -1 then exit		
//						
//again:			if w_preview_report.uodw_current.ib_retrieved= false then
//				
//						f_wait_n_seconds(1)
//						
//						li_howmany++
//						
//						if li_howmany= 10 then w_preview_report.uodw_current.ib_retrieved= true
//						
//						goto again
//						
//					end if
//			
//			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
//			
//		loop
//		
//		w_preview_report.uodw_current.groupCalc()
//
//end if
//
////w_preview_report.uodw_current.groupCalc()
//
////w_preview_cerimonie.uodw_current.Object.DataWindow.Print.Preview= 'Yes'
//
//this.setRedraw(true)
//
return ll_ret
end event

event type integer ue_bollettini(s_preview as_preview_s);integer li_ret

w_preview_bollettini iw_bollettini

as_preview_s.dataObject= "r_boll_sing"

w_frame_gestioneassociati.setRedraw(false)
	li_ret= openWithParm(iw_bollettini, as_preview_s)
w_frame_gestioneassociati.setRedraw(true)

return li_ret
end event

event type integer ue_mcompleta();//return openWithParm(w_completa, tv_struttura.is_struttura_s.vc_nodo)

integer li_ret

w_preview iw_completa

is_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
is_preview_s.dataObject= "dw_completa"
is_preview_s.doretrieve= true

w_frame_gestioneassociati.setRedraw(false)
	li_ret= openWithParm(iw_completa, is_preview_s)
w_frame_gestioneassociati.setRedraw(true)

return li_ret
end event

event type integer ue_queryorg(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, integer al_livello_sup);integer li_ret, li_livello
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row, ll_idx
decimal ld_importo, ld_zero

integer li_anno
datetime ldt_data_cer
string ls_luogo_cer, ls_parent, ls_struttura, ls_struttura_old

//DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

			ll_row= w_preview_org.uodw_current.retrieve(as_nodo, 0, al_livello, al_livello_sup)
			
			open(w_wait_snoopy_writing)
			
			for ll_idx= 1 to ll_row
				
				ls_parent= w_preview_org.uodw_current.getItemString(ll_idx, "vc_parent")
				li_livello= w_preview_org.uodw_current.getItemNumber(ll_idx, "att_ist_livello")
				
				ls_struttura= f_parse_struttura_left (ls_parent,  li_livello )
				if ls_struttura <> ls_struttura_old then ls_descrizione_struttura= f_descrizione_nodo( ls_parent ,  li_livello )
				
				w_preview_org.uodw_current.setItem(ll_idx, "catt_ist_struttura", ls_struttura)
				w_preview_org.uodw_current.setItem(ll_idx, "catt_ist_nome_struttura", ls_descrizione_struttura)
				
				ls_struttura_old= ls_struttura
				
			next
			
			close(w_wait_snoopy_writing)
			
		case 2
			
			ll_row= w_preview_org.uodw_current.retrieve(as_nodo, 0, al_livello, al_livello_sup)
			
			open(w_wait_snoopy_writing)
			
			for ll_idx= 1 to ll_row
				
				ls_parent= w_preview_org.uodw_current.getItemString(ll_idx, "vc_nodo")
				li_livello= w_preview_org.uodw_current.getItemNumber(ll_idx, "struttura_livello")
				
				ls_struttura= f_parse_struttura_left (ls_parent,  li_livello )
				if ls_struttura <> ls_struttura_old then ls_descrizione_struttura= f_descrizione_nodo( ls_parent ,  li_livello )
				
				w_preview_org.uodw_current.setItem(ll_idx, "catt_ist_struttura", ls_struttura)
				w_preview_org.uodw_current.setItem(ll_idx, "catt_ist_nome_struttura", ls_descrizione_struttura)
				
				ls_struttura_old= ls_struttura
				
			next
			
			close(w_wait_snoopy_writing)
		
end choose

return 0


end event

event type integer ue_runqueryorg(integer ai_qualequery, integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento,li_livello_superiore
long ll_handle
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
	case 1
		ls_object= 'dw_resp_nodo' // organigramma
	case 2
		ls_object= 'dw_quadro_generale'
//	case 3
//		ls_object= 'dw_queryofferte_resp'
//	case 4
//		ls_object= 'dw_queryofferte_tab'
//	case 5
//		ls_object= 'dw_queryofferte_dettaglio'
end choose

//open(w_criteri_estrazione)
//
//s_data_s= message.powerObjectParm
//
//if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then // mod il 25/05/09 GdS
			
			li_livello_raggruppamento= gi_maxlivello
			li_livello_superiore= gi_maxlivello
			
		else
		
			openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
		
			li_livello_raggruppamento= message.doubleParm
			
			if li_livello_raggruppamento= 0 then return -1
			
			if li_livello_raggruppamento= gi_maxlivello then
				
				li_livello_superiore= gi_maxlivello
				
			else
			
				openWithParm(w_selezione_livello_minimo, li_livello_raggruppamento)
			
				li_livello_superiore= message.doubleParm
				
				if li_livello_superiore= 0 then return -1		
				
			end if
			
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

	is_preview_s.dataObject= ls_object
	is_preview_s.ib_dwcreate= false
	is_preview_s.doretrieve= false
	
	openWithParm(w_preview_org, is_preview_s)
	
//	w_preview_scheda.uodw_current.dataObject= ls_object
	
//	w_preview_scheda.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview_org.uodw_current.setRedraw(false)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			li_ret= event ue_queryorg(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, li_livello_superiore)
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	openWithParm(w_selezione_livello_minimo, tv_struttura.is_struttura_s.livello + 1)

	li_livello_superiore= message.doubleParm
	
	if li_livello_superiore= 0 then return -1				
	
	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_org, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview_org.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview_org.uodw_current.setRedraw(false)
	
		do while ll_handle <> -1
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			//tv_struttura.is_struttura_s= ll_lvi.data
			
			s_struttura_loc=  ll_lvi.data
		
			li_ret= event ue_queryorg(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, li_livello_superiore)
			
			if li_ret= -1 then exit
			
			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_org.uodw_current.sort()

w_preview_org.uodw_current.groupCalc()

//w_preview_cerimonie.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_org.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_run_completa(integer ai_source);integer li_livello_raggruppamento, li_pos_raggruppamento, li_howmany
long ll_handle, ll_ret
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

ls_object= 'dw_completa'

//is_preview_s.dataObject= ls_object
//is_preview_s.ib_dwcreate= false
//is_preview_s.transobject= sqlca
//
//this.setRedraw(false)
//
//if ai_source= 1 then // la query viene richiesta dal treeView...
//	
//	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//	
//	ll_ret= tv_struttura.getItem(ll_handle, ll_tvi)
//	
//	tv_struttura.is_struttura_s= ll_tvi.data
//	
//	is_preview_s.doretrieve= true
//	is_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
//	is_preview_s.anno= 0
//	is_preview_s.livello= tv_struttura.is_struttura_s.livello
//	
//	openWithParm(w_preview_completa, is_preview_s)
//	
//else // la query viene richiesta dalla list view...
//	
//	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
//
//	is_preview_s.doretrieve= false
//	is_preview_s.dataObject= ls_object
//	
//	openWithParm(w_preview_completa, is_preview_s)
//	
//		do while ll_handle <> -1
//			
//			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
//			
//			tv_struttura.is_struttura_s= ll_lvi.data
//			
//			ll_ret= w_preview_completa.uodw_current.retrieve(tv_struttura.is_struttura_s.vc_nodo, is_preview_s.anno, is_preview_s.livello)
//			
//			if ll_ret= -1 then exit		
//						
//again:			if w_preview_completa.uodw_current.ib_retrieved= false then
//				
//						f_wait_n_seconds(1)
//						
//						li_howmany++
//						
//						if li_howmany= 10 then w_preview_completa.uodw_current.ib_retrieved= true
//						
//						goto again
//						
//					end if
//			
//			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
//			
//		loop
//		
//		w_preview_completa.uodw_current.groupCalc()
//
//end if
//
////w_preview_completa.uodw_current.groupCalc()
//
////w_preview_completa.uodw_current.Object.DataWindow.Print.Preview= 'Yes'
//
//this.setRedraw(true)
//
return ll_ret
end event

public function integer wf_modified ();if NOT isValid(idw_dettaglio) then return 0

	idw_dettaglio.acceptText()
	
	if idw_dettaglio.modifiedCount() > 0 or idw_dettaglio.deletedCount() > 0 then
		if messageBox(this.title, "Sono stati aggiornati dei dati. Vuoi salvare le modifiche?", question!, yesNo!, 1)= 1 then
			if idw_dettaglio.update()> 0 then
				commit;
				if trap_sql(sqlca, "COMMITANAG") < 0 then goto errore
			else
				goto errore
			end if
		end if
	end if
					
return 0					
					
errore:
		messageBox(this.title, "Errore in aggiornamento dati.", exclamation!)
		rollback;
		trap_sql(sqlca, "ROLLBACKANAG")
		return -1
end function

public function integer wf_riferimenti ();integer li_rif, li_pref

if tab_dettaglio.tabpage_rif.uodw_rif.getRow() <= 0 then return -1

li_rif= tab_dettaglio.tabpage_rif.uodw_rif.getItemNumber(tab_dettaglio.tabpage_rif.uodw_rif.getRow(), "crif")
li_pref= tab_dettaglio.tabpage_rif.uodw_rif.getItemNumber(tab_dettaglio.tabpage_rif.uodw_rif.getRow(), "cpref")

if li_pref > li_rif then
	messageBox("Riferimenti", "E' possibile indicare un solo riferimento preferito per ciascun tipo.", information!)
	return 1 // blocca il cambio di selezione tab e ritorna alla maschera...
end if

if li_pref < li_rif then
			messageBox("Riferimenti", "Occorre indicare un riferimento preferito per ciascun tipo.", information!)
	return 1 // blocca il cambio di selezione tab e ritorna alla maschera...
end if

return 0
end function

public function integer wf_deletefromliste (string as_codice);integer li_ok

select count(*) into :li_ok from liste_dettaglio  where codice= :as_codice;
if trap_sql(sqlca, "DELFROMLISTE01") < 0 then return -1

if li_ok= 0 or isNull(li_ok) then return 0

//if messageBox(this.title, "Come conseguenza del cambiamento di stato, questa persona verrà rimossa dalle mailing list in cui è inserita.~n"+&
//								"Confermi la rimozione dalle liste?", question!, yesNo!, 2)= 2 then return -1

delete
from liste_dettaglio
where codice= :as_codice;
if trap_sql(sqlca, "DELFROMLISTE02") < 0 then
	rollback;
	trap_sql(sqlca, "DELFROMLISTE03")
	return -1
end if
// la commit viene eseguita nel tab base

return 0

end function

public function integer lvf_dettaglio (long tvi_handle);integer li_idx, li_index
long ll_child_handle, ll_rows, ll_idx
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc, s_struttura_child
string ls_goh

li_index= tab_dettaglio.tabpage_base.lv_dettaglio.deleteItems()

if tv_struttura.getItem(tvi_handle, ll_tvi)= -1 then return -1

s_struttura_loc= ll_tvi.data

//// test 
is_current_item_s= ll_tvi.data

/////////////////////////

this.setRedraw(false)

// Questa funzione viene lanciata ogni volta che cambia la selezione su un item del tree view

// La dw di aggiornamento è visibile solo a livello delle persone
tab_dettaglio.tabpage_base.lv_dettaglio.visible= true
tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= false

// s_struttura_loc.livello indica il livello corrente nel tree view non nella list view
if s_struttura_loc.livello <=  gi_maxlivello then // Cioè, fino al livello di gruppo...

			is_codice= s_struttura_loc.vc_nodo
	
			// Imposta il layout della list view...
			
			if s_struttura_loc.livello < gi_maxlivello then // Prima del gruppo...
				tab_dettaglio.tabpage_base.lv_dettaglio.view= ListViewLargeIcon!
			else
				// imposta il layout per il gruppo con il dettaglio di ogni persona... 
				tab_dettaglio.tabpage_base.lv_dettaglio.event ue_list_view_mode()
			end if
			
			tab_dettaglio.selectTab(1)	

			// Ora deve riempire la list view...
			
			// Verifica che esista un nodo child...
			ll_child_handle = tv_struttura.FindItem(childTreeItem!, tvi_handle)
			
			do while ll_child_handle <> -1
				
				// Se esiste ne legge gli attributi...
				
				tv_struttura.getItem(ll_child_handle, ll_tvi)
				
				ll_lvi.data= ll_tvi.data
						
				s_struttura_child= ll_tvi.data
						
				if s_struttura_child.livello <= gi_maxlivello then
				
					ll_lvi.label= /*f_iniziali(s_struttura_child.descrizione_livello)+": "+*/ f_iniziali(s_struttura_child.descrizione_struttura)
					ll_lvi.pictureIndex= s_struttura_child.livello
					ll_lvi.statePictureIndex= 0
					tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= false
				
				else
					
					// Altrimenti sono persone...
					
					ll_lvi.label= f_iniziali(trim(s_struttura_child.cognome)+" "+trim(s_struttura_child.nome))
				
						if s_struttura_child.flag_npa= "1" then
							ll_lvi.pictureIndex= 0
						else
							ll_lvi.pictureIndex= gi_maxlivello + s_struttura_child.cod_div
						end if
						
					ll_lvi.statePictureIndex=  0
					if s_struttura_child.flag_ldr= '1' then ll_lvi.statePictureIndex=  1
					
					ll_lvi.data= s_struttura_child
					
					tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= true
					
				end if
		
				ll_lvi.selected= false
				
				// Aggiunge un nuovo item di list view e ne valorizza gli attributi...
				
				li_index= tab_dettaglio.tabpage_base.lv_dettaglio.addItem(ll_lvi) 
				if li_index < 0 then return -1
				
				// GdS tab_dettaglio.selectTab(1)
				
				if s_struttura_child.livello > gi_maxlivello then
					
//					tab_dettaglio.selectTab(1)
					//idw_dettaglio.retrieve(s_struttura_loc.codice)
					
					ls_goh= ""

					if s_struttura_child.flag_goh= 'S' then
						
						ls_goh= 'Okatagi'
						
					elseif  s_struttura_child.flag_tok= 'S' then
						
						ls_goh= 'Tokubetsu'
						
					elseif s_struttura_child.flag_goh= 'F' then
						
						ls_goh= 'Famiglia'
						
					elseif  s_struttura_child.flag_tok= 'F' then
						
						ls_goh= 'Famiglia'
						
					end if
					
					if s_struttura_child.flag_oma= 'S' then
						
						s_struttura_child.flag_oma= 'Si'
						
					else
						
						s_struttura_child.flag_oma= 'No'
						
					end if
					
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 1, f_iniziali(trim(s_struttura_child.cognome)+ " " +trim(s_struttura_child.nome) ) )
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 2, s_struttura_child.divisione)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 3, s_struttura_child.status)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 4, ls_goh)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 5, s_struttura_child.flag_oma)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 6, s_struttura_child.responsabilita1)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 7, s_struttura_child.responsabilita2)
					
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 8, s_struttura_child.codice)
					
				end if
				
				ll_child_handle= tv_struttura.FindItem(nextTreeItem!, ll_child_handle) // cerca gli eventuali altri child...
			
			loop

			if  s_struttura_loc.livello > gi_maxlivello then
					
				for li_idx= 1 to upperBound(tab_dettaglio.control[]) -1
				
					tab_dettaglio.control[li_idx].visible= true

				next
					
			else
				
				for li_idx= 2 to upperBound(tab_dettaglio.control[]) -1
						
						tab_dettaglio.control[li_idx].visible= false
				
				next
				
			end if
			
			//???????
			is_codice= s_struttura_loc.vc_nodo
			//??????????
			
			tab_dettaglio.control[2].visible= true // stats
			tab_dettaglio.tabpage_andamenti.pb_carica.enabled= true
			tab_dettaglio.tabpage_andamenti.uodw_stat.reset()
		
else // tv a  livello persone
	
			tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
			tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
			
			// test GdS: tab_dettaglio.tabpage_base.uodw_aggiornamento.dataObject= 'dw_scheda_anagrafica_gerarchica'
			
			is_codice= s_struttura_loc.codice
			
				if this.wf_modified() < 0 then return -1
				if (NOT isNull(is_codice) ) OR is_codice <> ""  then
					
					/*
					Se ero posizionato sul tab "andamenti" dato che il tab non compare a livello delle persone devo forzare
					la selezione del tab 1 cioè la scheda anagrafica.
					*/
					if tab_dettaglio.selectedTab= 2 then tab_dettaglio.selectedTab= 1
					
					tab_dettaglio.selectTab(tab_dettaglio.selectedTab)
					
				end if
			
			for li_idx= 2 to upperBound(tab_dettaglio.control[])
				
					tab_dettaglio.control[li_idx].visible= true
				
			next
			
			// GdS
			
			tab_dettaglio.tabpage_andamenti.visible= false
		
			tab_dettaglio.tabpage_offerte.visible= 	f_has_p('S')
			
			if s_struttura_loc.flag_npa= '1' then
				tab_dettaglio.tabpage_liste.visible= false
			else
				tab_dettaglio.tabpage_liste.visible= 	f_has_p('S')
			end if
			
			tab_dettaglio.tabpage_ediz.visible= 		f_has_p('W')
			tab_dettaglio.tabpage_studio.visible= 	f_has_p('W')
			tab_dettaglio.tabpage_goh.visible= 		f_has_p('W')
			tab_dettaglio.tabpage_resp.visible= 		f_has_p('W')
			
end if

this.setRedraw(true)

return 0
end function

on w_struttura_tv_tab_test.create
int iCurrent
call super::create
this.tab_dettaglio=create tab_dettaglio
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dettaglio
this.Control[iCurrent+2]=this.dw_1
end on

on w_struttura_tv_tab_test.destroy
call super::destroy
destroy(this.tab_dettaglio)
destroy(this.dw_1)
end on

event open;call super::open;integer li_ret
long ll_handle

ll_handle= AncestorReturnValue

s_session_s.context= "Esplorazione struttura"

tab_dettaglio.tabpage_base.uodw_aggiornamento.setTransObject(sqlca)
tab_dettaglio.tabpage_rif.uodw_rif.setTransObject(sqlca)
//tab_dettaglio.tabpage_ediz.uodw_pubblicazioni.setTransObject(sqlca_ediz)
tab_dettaglio.tabpage_offerte.uodw_storicocontributi.setTransObject(sqlca)
tab_dettaglio.tabpage_studio.uodw_se.setTransObject(sqlca)
tab_dettaglio.tabpage_goh.uodw_sg.setTransObject(sqlca)

tab_dettaglio.tabpage_rif.uodw_rif.getChild("cod_rif", idwc_rif)
tab_dettaglio.tabpage_base.uodw_aggiornamento.getChild("cod_dis", idwc_cod_dis)

lvf_dettaglio(ll_handle)

im_pop_lv_dettaglio= create m_pop_lv_dettaglio
im_preview= create m_preview
im_pop_tv= create m_pop_tv_tab

// external dw dei nomi report in tab statistiche
string ls_entries

//idwc_reportname.dataObject= "dw_listobjects"

tab_dettaglio.tabpage_andamenti.dw_reportname.GetChild('reportname', idwc_reportname)

//ls_entries= libraryDirectory(/*gs_docdir+"\PBL\"+*/gs_reportpath, DirDataWindow!)
ls_entries= libraryDirectory(gs_docdir+"\"+gs_reportpath, DirDataWindow!)

li_ret= idwc_reportname.importString(ls_entries)

if li_ret <= 0 then
	
	messageBox(this.title, "OPEN: Errore N. "+string(li_ret)+" in inportString")
	return 0
	
end if

idwc_reportname.sort()

li_ret= tab_dettaglio.tabpage_andamenti.dw_reportname.insertRow(0)

event post ue_postopen()

return ll_handle

end event

event resize;call super::resize;integer li_tabwidth= 500, li_tvwidth=600, li_resize

li_resize= UnitsToPixels( WorkspaceWidth() , XUnitsToPixels!)

//messageBox("test", string(li_resize))

if li_resize > 1024 then 
	li_tabwidth= (li_resize*3)/5
	
//	tv_struttura.pictureHeight= 16//32
//	tv_struttura.pictureWidth= 16//32
	
else
	li_tabwidth= (li_resize*2)/3	
	
//	tv_struttura.pictureHeight= 16
//	tv_struttura.pictureWidth= 16
	
end if
		

tv_struttura.width= WorkspaceWidth() - PixelsToUnits ( li_tabwidth,  XPixelsToUnits! ) - 60// - 60

tab_dettaglio.height= /*tv_struttura.height + tv_struttura.y */ this.height - tab_dettaglio.y - 150

//tab_dettaglio.tabpage_base.height= tv_struttura.height //tv_struttura.height // + gb_cerca.height
tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

tab_dettaglio.width=PixelsToUnits ( li_tabwidth,  XPixelsToUnits! )// WorkspaceWidth() - tab_dettaglio.x - 60 

tab_dettaglio.tabpage_base.lv_dettaglio.height= tab_dettaglio.tabpage_base.height - 10
tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30

//tab_dettaglio.tabpage_base.lv_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30 

//tab_dettaglio.tabpage_base.uodw_aggiornamento.height=tab_dettaglio.tabpage_base.height - 30

//tab_dettaglio.tabpage_dettaglio.uodw_aggiornamento.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.uodw_aggiornamento.width= tab_dettaglio.tabpage_base.width - 30 

//if isValid( idw_dettaglio) then 
//	idw_dettaglio.height=tab_dettaglio.tabpage_base.height -10
//	idw_dettaglio.width= tab_dettaglio.tabpage_base.width - 30
//end if



//		tab_dettaglio.tabpage_rif.uo_dw_rif.width= this.width - 50

/*if isValid( idw_dettaglio) then*/// idw_dettaglio.height= this.height - idw_dettaglio.y - 30
end event

event closequery;call super::closequery;if this.wf_riferimenti() = 1 then return 1

if this.wf_modified() < 0 then return 1
end event

event close;call super::close;s_session_s.codice= ""

db_connection.uof_disconnectdb(sqlca_ediz)
	
end event

event ue_tvdim;call super::ue_tvdim;tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30
tab_dettaglio.width= WorkspaceWidth() - tab_dettaglio.x - 30
idw_dettaglio.width= tab_dettaglio.width - 60
end event

event timer;call super::timer;string ls_cerca
long ll_rows

	ls_cerca= f_trim_all(dw_1.getItemString(dw_1.getRow(), "target") )
	
	ll_rows= ids_struttura.retrieve("%"+ls_cerca+"%", gs_ambito+"%")
end event

type pb_estesa from w_struttura_tv`pb_estesa within w_struttura_tv_tab_test
integer x = 1202
integer y = 0
integer height = 124
integer taborder = 50
boolean originalsize = false
alignment htextalign = center!
vtextalign vtextalign = vcenter!
end type

type pb_trova from w_struttura_tv`pb_trova within w_struttura_tv_tab_test
integer y = 12
string powertiptext = "Ricerca"
end type

type sle_cerca from w_struttura_tv`sle_cerca within w_struttura_tv_tab_test
integer x = 1509
integer y = 4
integer width = 1001
integer weight = 700
string pointer = "IBeam!"
long textcolor = 16711680
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_struttura_tv_tab_test
event ue_return pbm_dwnprocessenter
event type integer ue_lvfdettaglio ( long al_handle )
integer x = 37
integer y = 124
string pointer = "HyperLink!"
integer indent = 150
boolean haslines = false
boolean linesatroot = false
boolean trackselect = true
grsorttype sorttype = userdefinedsort!
string picturename[] = {"wi0064-48.gif","foot_blue.gif","foot_orange.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_blue.gif","foot_orange.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","sally.gif"}
string statepicturename[] = {"house.bmp"}
integer statepicturewidth = 16
integer statepictureheight = 16
long statepicturemaskcolor = 553648127
end type

event tv_struttura::ue_return;long ll_tvi

//ll_tvi = this.FindItem(CurrentTreeItem!, 0)
//
//event clicked(ll_tvi)

return 0
end event

event type integer tv_struttura::ue_lvfdettaglio(long al_handle);return parent.lvf_dettaglio(al_handle)
end event

event tv_struttura::selectionchanged;call super::selectionchanged;if tv_struttura.ib_searchend= true then
	tv_struttura.ib_searchend= false
	parent.lvf_dettaglio(newHandle)
	tv_struttura.ib_searchend= true
end if






end event

event tv_struttura::sort;call super::sort;TreeViewItem tvi, tvi2

This.GetItem(handle1, tvi)

This.GetItem(handle2, tvi2)

IF tvi.Label > tvi2.Label THEN
		RETURN 1

ELSEIF tvi.Label < tvi2.Label THEN
		RETURN -1

ELSE
		RETURN 0

END IF
end event

event tv_struttura::rightclicked;call super::rightclicked;integer li_ret
long ll_handle
treeviewItem ll_tvi
	
li_ret= this.getItem(handle, ll_tvi)

if li_ret= -1 then return -1
	
is_struttura_s= ll_tvi.data

parent.im_pop_tv.m_aggiornanodo.enabled= true
parent.im_pop_tv.m_struttura.m_modifica.enabled= true

if ll_tvi.level  > is_tvinit_s.ai_numerolivellivisualizzati then
	parent.im_pop_tv.m_aggiornanodo.enabled= false
	parent.im_pop_tv.m_struttura.m_modifica.enabled= false
end if

if ll_tvi.level  >= is_tvinit_s.ai_numerolivellivisualizzati then 
	
	// a livello delle persone non fa comparire alcuni elementi del menu
	parent.im_pop_tv.m_struttura.m_inseriscinuovastruttura.enabled= false
	parent.im_pop_tv.m_struttura.m_modificastruttura.enabled= false
	parent.im_pop_tv.m_report.enabled= false
//	parent.im_pop_tv.m_offerte.enabled= false
//	parent.im_pop_tv.m_consegne.enabled= false
//	parent.im_pop_tv.m_abbonamenti.enabled= false
	
else
	
	if f_has_p("O")= true then
		parent.im_pop_tv.m_struttura.m_inseriscinuovastruttura.enabled= true
		parent.im_pop_tv.m_struttura.m_modificastruttura.enabled= true
		parent.im_pop_tv.m_report.enabled= true
	//	parent.im_pop_tv.m_offerte.enabled= true
	//	parent.im_pop_tv.m_consegne.enabled= true
	//	parent.im_pop_tv.m_abbonamenti.enabled= true
	else
		parent.im_pop_tv.m_struttura.enabled= false
end if
	
end if

parent.im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )



end event

type tab_dettaglio from tab within w_struttura_tv_tab_test
integer x = 1915
integer y = 16
integer width = 3552
integer height = 3036
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
boolean focusonbuttondown = true
boolean powertips = true
integer selectedtab = 1
tabpage_base tabpage_base
tabpage_andamenti tabpage_andamenti
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
tabpage_resp tabpage_resp
tabpage_log tabpage_log
end type

on tab_dettaglio.create
this.tabpage_base=create tabpage_base
this.tabpage_andamenti=create tabpage_andamenti
this.tabpage_rif=create tabpage_rif
this.tabpage_ediz=create tabpage_ediz
this.tabpage_offerte=create tabpage_offerte
this.tabpage_liste=create tabpage_liste
this.tabpage_studio=create tabpage_studio
this.tabpage_goh=create tabpage_goh
this.tabpage_resp=create tabpage_resp
this.tabpage_log=create tabpage_log
this.Control[]={this.tabpage_base,&
this.tabpage_andamenti,&
this.tabpage_rif,&
this.tabpage_ediz,&
this.tabpage_offerte,&
this.tabpage_liste,&
this.tabpage_studio,&
this.tabpage_goh,&
this.tabpage_resp,&
this.tabpage_log}
end on

on tab_dettaglio.destroy
destroy(this.tabpage_base)
destroy(this.tabpage_andamenti)
destroy(this.tabpage_rif)
destroy(this.tabpage_ediz)
destroy(this.tabpage_offerte)
destroy(this.tabpage_liste)
destroy(this.tabpage_studio)
destroy(this.tabpage_goh)
destroy(this.tabpage_resp)
destroy(this.tabpage_log)
end on

event selectionchanging;

//if oldindex=3 then
//	
//		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//		if wf_riferimenti()= 1 then return 1
//
//end if

if parent.wf_modified() < 0 then return -1

//messageBox("test", "newindex= "+string(newindex) )

this.setRedraw(false)

choose case newindex
		
	case 1
		
		idw_dettaglio= tab_dettaglio.tabpage_base.uodw_aggiornamento
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
	case 2

		idw_dettaglio= tab_dettaglio.tabpage_andamenti.uodw_stat
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Statistiche"
		
	case 3
		
		string ls_dis
		
		idw_dettaglio= tab_dettaglio.tabpage_rif.uodw_rif
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Riferimenti"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
		ls_dis= tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString(tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "flag_dis")
		
		if ls_dis= "1" then idw_dettaglio.object.b_invia.visible= false
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_rif.uo_dw_rif.retrieve(is_codice)
	
	case 4
		
//		tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(is_codice)

		idw_dettaglio= tab_dettaglio.tabpage_ediz.uodw_pubblicazioni
		
		idw_dettaglio.setTransObject(sqlca_ediz)
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
		
	case 5
		
//		tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(is_codice)

		idw_dettaglio= tab_dettaglio.tabpage_offerte.uodw_storicocontributi
		
		idw_dettaglio.setTransObject(sqlca)
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_offerte.dw_storicocontributi.retrieve(is_codice )

	case 6
		
			idw_dettaglio= tab_dettaglio.tabpage_liste.uodw_liste
			
			idw_dettaglio.setTransObject(sqlca)
			
			s_session_s.context= "Anagrafica - Liste"
	
			idw_dettaglio.ib_readonly= NOT f_has_p('O')
	
	case 7
		
		idw_dettaglio= tab_dettaglio.tabpage_studio.uodw_se
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Esami"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')

	case 8
		
		idw_dettaglio= tab_dettaglio.tabpage_goh.uodw_sg
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Gohonzon"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
	case 9
		
		idw_dettaglio= tab_dettaglio.tabpage_resp.uodw_storico_resp
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Responsabilità"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
	case 10
		
		idw_dettaglio= tab_dettaglio.tabpage_log.uodw_vislog
		
		idw_dettaglio.setTransObject(sqlca)
		
end choose

//if tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex= 2 then
//	
////	parent.event ue_properties(parent.is_struttura_s)
//	
//else


if /*tv_struttura.is_struttura_s.livello > gi_maxlivello and*/ newindex <>2  then
	
	if NOT isNull(is_codice) OR is_codice <> ""  then
		idw_dettaglio.retrieve(is_codice)
		s_session_s.codice= is_codice
	end if
	
end if

//if tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex <>2 then
//	
//	if NOT isNull(is_codice) OR is_codice <> ""  then
//		idw_dettaglio.retrieve(is_codice)
//		s_session_s.codice= is_codice
//	end if
//	
//end if

//end if

if isValid(idw_dettaglio) then

	if newindex= 2 then
		idw_dettaglio.width=this.width - 60
		idw_dettaglio.height= this.height -160 -idw_dettaglio.y
	else
			idw_dettaglio.height= tab_dettaglio.height -160 -idw_dettaglio.y
	end if

//	if f_has_p("O")= true and tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex <> 2 then
//		idw_dettaglio.Object.DataWindow.ReadOnly="No"
//	else
//		idw_dettaglio.Object.DataWindow.ReadOnly="Yes"
//	end if

this.setRedraw(true)

end if



end event

type tabpage_base from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 67108864
string text = "Anagrafica"
long tabtextcolor = 33554432
string picturename = "EditDataTabular!"
long picturemaskcolor = 1073741824
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
event type integer ue_taglia ( )
event type integer ue_struttura ( )
event type integer ue_qsgruppo ( )
integer x = 9
integer width = 1385
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 16777215
boolean autoarrange = true
boolean extendedselect = true
boolean checkboxes = true
boolean trackselect = true
boolean gridlines = true
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewlist!
string largepicturename[] = {"wi0064-48.gif","foot_blue.gif","foot_orange.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_blue.gif","foot_orange.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","sally.gif"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 553648127
string smallpicturename[] = {"wi0064-48.gif","foot_blue.gif","foot_orange.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_blue.gif","foot_orange.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","sally.gif"}
integer smallpicturewidth = 32
integer smallpictureheight = 32
long smallpicturemaskcolor = 553648127
string statepicturename[] = {""}
integer statepicturewidth = 16
integer statepictureheight = 16
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

	this.addColumn("Nome", left!, 750)
	this.addColumn("Divisione", left!, 250)	
	this.addColumn("Status", center!, 250)
	this.addColumn("Gohonzon", center!, 250)
	this.addColumn("Omamori", center!, 250)
	this.addColumn("1° responsabilità", left!, 400)
	this.addColumn("2° responsabilità", left!, 400)
	
	this.addColumn("Codice", left!, 250)
	
end if

this.setRedraw(true)
end event

event type integer ue_struttura();		long 	ll_handle, ll_idx, ll_checked=0
		s_assegnastruttura s_assegnastruttura_s
		s_struttura s_struttura_s
		string ls_da, ls_a, ls_codice, ls_vc_nodo
		treeViewItem ltvi_struttura
		listViewItem lv_item
		
		if gi_classediutenza= gc_cons then
			messageBox(parent.text, "Operazione non permessa", exclamation!)
			return 0
		end if
		
		///
		for ll_idx= 1 to this.totalItems()
			
			this.getItem(ll_idx, lv_item)
			
			if lv_item.statePictureIndex= 2 then ll_checked++ // checked
			
		next
		
		if ll_checked= 0 then
			
			messageBox(parent.text, "Nessuna persona è stata selezionata", exclamation!)	
			
			return 0
			
		end if
			
		///
		
		ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
		
		tv_struttura.GetItem ( ll_handle, ltvi_struttura)
		
		s_struttura_s= ltvi_struttura.data
		
		ls_da= s_struttura_s.vc_nodo
		s_assegnastruttura_s.as_struttura_s.vc_nodo=s_struttura_s.vc_parent
		s_assegnastruttura_s.as_struttura_s.livello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.ai_maxlivello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ai_ultimolivelloparent= is_assegnastruttura_s.ai_ultimolivelloparent
		s_assegnastruttura_s.as_ambito= is_assegnastruttura_s.as_ambito

		openWithParm(w_assegna_struttura, s_assegnastruttura_s )
		
		s_struttura_s= message.powerObjectParm
		
		if s_struttura_s.livello= -1 then return -1
		
		ls_a= s_struttura_s.vc_nodo
		
		if ls_da= ls_a then 
			
				messageBox(parent.text, "Il gruppo di partenza e il gruppo di arrivo sono uguali", exclamation!)
				return -1
				
		end if
		
		if messageBox(parent.text, "Confermi lo spostamento?", question!, yesNo!, 2)= 2 then return 0	
		
//		ib_modificatastruttura= true
		
		is_strutturatgt_s= s_struttura_s
		
		ls_vc_nodo= s_struttura_s.vc_nodo
		
		s_session_s.context= "Anagrafica: cambio di gruppo"
		
		for ll_idx= 1 to this.totalItems()
			
			this.getItem(ll_idx, lv_item)
			
			if lv_item.statePictureIndex= 1 then continue // Unchecked
			
			s_struttura_s= lv_item.data
			
			ls_codice= s_struttura_s.codice
			
			update membri_gerarchica
			set vc_parent= :ls_vc_nodo
			where codice= :ls_codice;
			
			if trap_sql(sqlca, "SPOSTAGRUPPO01") < 0 then goto errore
			
			s_session_s.codice= ls_codice
			f_log(s_session_s, "Da: "+ls_da+" >> A: "+ ls_a, false)
			
		next
		
		commit;
		
		if trap_sql(sqlca, "SPOSTAGRUPPO02") < 0 then goto errore
		
		open(w_message)
		
		tv_struttura.setRedraw(false)
		tab_dettaglio.setRedraw(false)
		
		ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
		
		tv_struttura.uf_visualizzanuovoitem(ll_handle)
		tv_struttura.uf_visualizzanuovoitem(is_strutturatgt_s.handle)
		tv_struttura.selectItem(is_strutturatgt_s.handle)

		tv_struttura.setRedraw(true)
		tab_dettaglio.setRedraw(true)

		return 1
		
errore:

		rollback;
		
		trap_sql(sqlca, "SPOSTAGRUPPO03")
		
		open(w_message_negative)
		
		return -1

end event

event type integer ue_qsgruppo();		long 	ll_handle
		s_struttura s_struttura_s
		treeViewItem ltvi_struttura
		
		ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
		
		tv_struttura.GetItem ( ll_handle, ltvi_struttura)
		
		s_struttura_s= ltvi_struttura.data

		return openWithParm(w_qsgruppo, s_struttura_s )
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

tab_dettaglio.setRedraw(false)
	
//tv_struttura.ib_searchend= true
li_ret= tv_struttura.selectItem(ll_handle)

tab_dettaglio.setRedraw(true)

return 0
end event

event rightclicked;long ll_handle
treeViewItem ltvi_new_item
s_struttura s_struttura_loc

ll_handle= tv_struttura.findItem(currentTreeItem!, 0)
if tv_struttura.getItem(ll_handle, ltvi_new_item) < 0 then return -1

//if ltvi_new_item.level > il_fino_a_quale_livello then return 0

s_struttura_loc= ltvi_new_item.data

if s_struttura_loc.livello= gi_maxlivello then
	im_pop_lv_dettaglio.m_report.enabled= false
//	im_pop_lv_dettaglio.m_offerte.enabled= false
//	im_pop_lv_dettaglio.m_consegne.enabled= false
	if f_has_p("O") then
		im_pop_lv_dettaglio.m_trasferimenti.enabled= true
		im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= true
	else
		im_pop_lv_dettaglio.m_trasferimenti.enabled= false
		im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= false		
	end if
		im_pop_lv_dettaglio.m_qsgruppo.enabled= true
else
	im_pop_lv_dettaglio.m_report.enabled= true
//	im_pop_lv_dettaglio.m_offerte.enabled= true
//	im_pop_lv_dettaglio.m_consegne.enabled= true
	im_pop_lv_dettaglio.m_trasferimenti.enabled= false
	im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= false
	im_pop_lv_dettaglio.m_qsgruppo.enabled= false
end if
	

im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )



end event

event columnclick;this.SetRedraw(false)

//if this.SortType = Ascending! then
//	
//	this.Sort(Descending! , column)
//	
//	 this.SortType = Descending!
//	
//else

	this.Sort(Ascending! , column)
	
//end if

this.SetRedraw(true)
end event

type uodw_aggiornamento from uodw_generica within tabpage_base
integer width = 3406
integer height = 2724
integer taborder = 100
string dataobject = "dw_anagrafica"
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
integer ii_userlevel = 0
long il_newrow = 5
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event buttonclicked;call super::buttonclicked;integer li_ret
long ll_currenthandle, ll_parenthandle, ll_childitem, ll_ret, ll_oldhandle, ll_newhandle
s_struttura s_struttura_s
s_strade s_strade_s
s_famiglia s_famiglia_s
string ls_message
treeViewItem ltvi_current
			
if ancestorreturnvalue < 0 then return -1

choose case dwo.name
				
	case "b_modnucleo"
		
		string ls_codice
		
		if this.uof_modificheincorso() = 3 then return 0
		
		openWithParm( w_check_pw, s_utente_s)
		if message.doubleparm= -1 then return 0
		
		s_famiglia_s.codice= this.getItemString(row, "codice")
		s_famiglia_s.codice_fam= this.getItemString(row, "codice_fam")
		
		openWithParm(w_fai_nuclei, s_famiglia_s)
		
		w_struttura_tv_tab.setRedraw(false)
		this.retrieve(s_famiglia_s.codice)
		w_struttura_tv_tab.setRedraw(true)
		
	case "b_nucleo"
		
		openWithParm(w_visualizza_nuclei, this.getItemString(row, "codice_fam"))
		
//	case "b_m_anag"
		
//		// Cancella l'item di tv relativo alla persona cancellata
//		
//		ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
//				
//		li_ret= tv_struttura.deleteItem(ll_currenthandle)
		
	case "b_aggiorna"
		
			if ancestorreturnvalue= 1 and ib_modificatastruttura= true then
			
//			ls_message= "Struttura: "+this.getItemString(row, "vc_parent")+" - Modificato in: "+is_strutturatgt_s.vc_nodo
//			s_session_s.context= "Anagrafica"
//			f_log(s_session_s, ls_message, false)
		
			tv_struttura.setRedraw(false)
			tab_dettaglio.setRedraw(false)
			
			ll_oldhandle = tv_struttura.FindItem(currentTreeItem!, 0)
			
			//ll_parenthandle = tv_struttura.FindItem(parentTreeItem!, is_strutturatgt_s.handle)
			
			tv_struttura.getItem(ll_currenthandle, ltvi_current)
			
			//s_struttura_s= ltvi_current.data
			
			if messageBox(parent.text, "Il trasferimento è stato eseguito, vuoi spostarti nella nuova posizione?", question!, yesNo!, 2)= 1 then
				
				//li_ret= tv_struttura.collapseItem(ll_parenthandle)

				li_ret= tv_struttura.uf_cerca_nodo(is_strutturatgt_s.vc_nodo/*+"."+trim(s_struttura_s.cognome)+" "+trim(s_struttura_s.nome)*/ )
				
				ll_parenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
				li_ret= tv_struttura.uf_visualizzanuovoitem(ll_parenthandle)
			
			end if
			
			li_ret= tv_struttura.deleteItem(ll_oldhandle)
					
			tv_struttura.setRedraw(true)
			tab_dettaglio.setRedraw(true)	
			
			ib_modificatastruttura= false
		

			
			end if
		
		case "b_m_anag"
			
			if gi_classediutenza > gc_dirseg then
				
				messageBox(parent.text, "Operazione non permessa", exclamation!)
				return
				
			end if
			
		openWithParm( w_check_pw, s_utente_s)
		if message.doubleparm= -1 then return 0
				
				li_ret= uof_modificheincorso()
				
				if li_ret= 3 then return
		
				li_ret= this.uof_cancella()
				
				// Cancella l'item di tv relativo alla persona cancellata
		
			ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
			li_ret= tv_struttura.deleteItem(ll_currenthandle)
		
	case 'b_scheda'
		
//		openSheet(w_preview_scheda, w_frame_gestioneassociati)
//		lw_preview_scheda.uodw_current.dataObject= "dw_scheda_anagrafica_gerarchica"
//			lw_preview_scheda.uodw_current.setTransObject(sqlca)
//		
//		lw_preview_scheda.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		is_preview_s.criterio= uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice")
		is_preview_s.dataObject= "dw_scheda_anagrafica_gerarchica"
		
		openWithParm(w_preview_scheda, is_preview_s)
		
//		lw_preview_scheda.uodw_current.setRedraw(false)
//		lw_preview_scheda.uodw_current.retrieve(is_preview_s)
//		lw_preview_scheda.uodw_current.setRedraw(true)

	case "b_bollettino"
		
		is_preview_s.tipo_stampa= "N"
		is_preview_s.criterio= uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice")
		
		w_struttura_tv_tab.event ue_bollettini(is_preview_s)
		
			//////////////////
			s_session_s.context= "Anagrafica: sportello"
			f_log(s_session_s, "Stampato un bollettino offerta", true)
			///////////////
		
	case "b_lettera"
		
//		openWithParm(w_preview_ole,  uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice"))

		string lsa_resp[]= {"None", "Block", "District", "Chapter", "Headquarter", "Territory", "Area", "Region", "National", "Generale director"}, &
		lsa_studio[]= {"None", "1° Level", "2° Level", "3° Level", "4° Level", "5° Level"}, &
		lsa_div[]={"MD", "WD", "YMD", "YWD"}, ls_path_ldp, &
		ls_filename
		
		if messageBox(parent.text, "Vuoi aggiungere la tua firma al documento?", question!, yesNo!, 2)= 1 then
//			openWithParm(w_dirlist, gs_docdir+"\firme")
			ls_filename= gs_docdir+"\firme\"+s_utente_s. s_nome+"\"+s_utente_s. s_nome+".jpg"
			if NOT fileExists(ls_filename) then
				messageBox(parent.text, "Firma non presente.", stopSign!)
				return -1
			end if
			
			inca_pdf.isa_valori[9]= ls_filename // message.stringParm
			
		end if
		
		setPointer(hourGlass!)
		
		dateTime ldt_nascita, ldt_cerimonia
		
		inca_pdf.isa_datipersonali[1]= 'nome'
		inca_pdf.isa_datipersonali[2]= 'resp'
		inca_pdf.isa_datipersonali[3]= 'divisione'
		inca_pdf.isa_datipersonali[4]= 'data_cerimonia'
		inca_pdf.isa_datipersonali[5]= 'data_nascita'
		inca_pdf.isa_datipersonali[6]= 'livello_studio'
		inca_pdf.isa_datipersonali[7]= 'organizzazione'
		inca_pdf.isa_datipersonali[8]= 'indirizzo'
		inca_pdf.isa_datipersonali[9]= 'firma'
		inca_pdf.isa_datipersonali[10]= 'data'
		
		select rtrim(nome)+" "+ltrim(cognome),
				cod_att_ist_1,
				cod_div,
				convert(varchar,  data_cer),
				convert(varchar, data_nas),
				cod_studio,
				vc_parent,
				ind_dom+",   "+cap_dom+" ,   "+comune
				into	:inca_pdf.isa_valori[1],
						:inca_pdf.isa_valori[2],
						:inca_pdf.isa_valori[3],
						:ldt_nascita, /*:inca_pdf.isa_valori[4],*/
						:ldt_cerimonia, /*:inca_pdf.isa_valori[5],*/
						:inca_pdf.isa_valori[6],
						:inca_pdf.isa_valori[7],
						:inca_pdf.isa_valori[8]
				from membri_gerarchica, tab_comuni
				where membri_gerarchica.cod_com= tab_comuni.cod_com and codice= :is_codice;
				
				if trap_sql(sqlca, "LPRESENTAZIONE01") < 0 then return -1
				
		inca_pdf.isa_valori[1]= f_iniziali(inca_pdf.isa_valori[1])
		
		inca_pdf.isa_valori[2]= lsa_resp[long(mid(inca_pdf.isa_valori[2], 1, 1) ) + 1 ] // responsabilità
		
		inca_pdf.isa_valori[2]= f_iniziali(inca_pdf.isa_valori[2])
		
		inca_pdf.isa_valori[3]= f_iniziali(lsa_div[long(inca_pdf.isa_valori[3] ) ] ) // divisione
		
		inca_pdf.isa_valori[4]= string(ldt_nascita, "dd.mm.yyyy") // data nascita
		
		inca_pdf.isa_valori[5]= string(ldt_cerimonia, "dd.mm.yyyy") // data cerimonia		
		
		inca_pdf.isa_valori[6]= lsa_studio[long(inca_pdf.isa_valori[6] ) + 1 ] // studio
		
		inca_pdf.isa_valori[7]= f_iniziali(f_descrizione_struttura(inca_pdf.isa_valori[7]) )
		
		inca_pdf.isa_valori[8]= f_iniziali(inca_pdf.isa_valori[8])
		
		inca_pdf.isa_valori[10]= string(today()) //string(today(), "dd.mm.yyyy")
		
		ls_path_ldp= inca_pdf.uof_test(gs_cutepdf, gs_docdir)
		
		if ls_path_ldp= "" then return -1 // errore su file pdf
		
		s_session_s.context= "Anagrafica: sportello"
		f_log(s_session_s, "Evasa richiesta di lettera di presentazione", true)
		
//		if messageBox(parent.text, "Vuoi visualizzare la lettera?", question!, yesNo!, 2)= 1 then

				String ls_null 
				SetNull (ls_null) 
				ShellExecuteA(Handle(Parent), ls_null, ls_path_ldp, ls_null, ls_null, 1) 
				
//		end if

	case "b_forzailcap"
		
		messageBox("Attenzione", "Il C.A.P. inserito manualmente potrebbe essere scorretto.", information!)
		
		this.Object.cap_dom.Protect=0
		this.setColumn("cap_dom")
		
	case "b_struttura"
		
		long ll_handle
		s_assegnastruttura s_assegnastruttura_s
		treeViewItem ltvi_struttura
		
		if gi_classediutenza= gc_cons then
			messageBox(this.title, "Operazione non permessa", exclamation!)
			return 0
		end if
		
		s_assegnastruttura_s.as_struttura_s.vc_nodo= this.getItemString(row, "vc_parent")
		s_assegnastruttura_s.as_struttura_s.livello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.ai_maxlivello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ai_ultimolivelloparent= is_assegnastruttura_s.ai_ultimolivelloparent
		s_assegnastruttura_s.as_ambito= is_assegnastruttura_s.as_ambito
		
		is_strutturatgt_s=  this.uof_struttura(s_assegnastruttura_s)
		
		if is_strutturatgt_s.livello= -1 then return -1
		
		this.object.b_aggiorna.visible= '1'
		
		this.setItem(row, "vc_parent", is_strutturatgt_s.vc_nodo)
		
		ib_modificatastruttura= true
		
		this.setItem(row, "u_ult_mod", s_utente_s.s_nome_esteso)
		this.setItem(row, "d_ult_mod", today())
		
		ls_message= "Struttura: "+s_assegnastruttura_s.as_struttura_s.vc_nodo+" - Modificato in: "+is_strutturatgt_s.vc_nodo
		s_session_s.context= "Anagrafica"
		f_log(s_session_s, ls_message, false)
		
	case "b_cap"
		
		integer i_err
		string ls_cap, ls_loc
		
		s_strade_s.cap= this.getItemString(row, "cap_dom")
		s_strade_s.comune= this.getItemString(row, "comune")
		s_strade_s.cod_com= this.getItemString(row, "cod_com")
		s_strade_s.provincia= this.getItemString(row, "provincia")
		
		s_strade_s= f_vercap(s_strade_s)
		
		choose case s_strade_s.return_code
				
			case 0
				
				messageBox(this.title, "Operazione annullata.", information!)
				
			case -1
				
				return -1
				
			case 1
				
				i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
							
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
			case 2
				
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
		end choose
		
		
end choose

return 0

end event

event itemchanged;call super::itemchanged;integer li_err, li_exists, li_ret
long ll_rows
boolean first_time = true
string ls_codice, search_string, old_comune, ls_nuovaOrganizzazione, ls_message
s_struttura s_struttura_s

long ll_currentHandle, ll_parentHandle
treeViewItem ltv_item, ltvi_current

if row <= 0 then return 1

tv_struttura.setRedraw(false)

ll_currentHandle= tv_struttura.findItem(currentTreeItem!, 0)

tv_struttura.getItem(ll_currentHandle, ltv_item)

ids_com= create u_ds_com
ids_com.setTransObject(sqlca)


	
//	s_session_s.context= "Anagrafica"
	
	data = trim ( data )

	CHOOSE CASE dwo.name
			
//		case "vc_parent"
//			
//			tv_struttura.DeleteItem ( ll_currentHandle )
			
		case "citta_nas"
			
			ls_message= "Città nascita: "+this.getItemString(row, "citta_nas")+" - Modificato in: "+data
			
		case "ind_dom"
			
			ls_message= "Domicilio: "+this.getItemString(row, "ind_dom")+" - Modificato in: "+data
			
			if this.getItemString(row, "flag_ldr")= 'S' then
			messageBox(parent.text, "Attenzione, il domicilio di "+trim(this.getItemString(row, "nome") )+" "+trim(this.getItemString(row, "cognome") )+" è registrato come luogo di riunione.~n"+&
												"Ricordati di verificare se il nuovo domicilio è luogo di riunione o no e, eventualmente, modifica il dato.", exclamation!)
			//this.setItem(row, "flag_ldr", 'N')
			
			this.setText('0')
			
			end if
			
		case "flag_ldr"
			
//			treeViewItem ltv_item
//			
//			tv_struttura.getItem(ll_currenthandle, ltv_item)
//			
//			ltv_item.statePictureIndex= 0
//			if this.getItemString(this.getRow(), "flag_ldr")= 'S' then ltv_item.statePictureIndex= 1
//			tv_struttura.setItem(ll_currenthandle, ltv_item)
			
			ls_message= "Luogo di riunione: "+this.getItemString(row, "flag_ldr")+" - Modificato in: "+data
			
		CASE "cognome"

			ls_message= "Cognome: "+this.getItemString(row, "cognome")+" - Modificato in: "+data
			
		CASE "nome"

			ls_message= "Nome: "+this.getItemString(row, "nome")+" - Modificato in: "+data
			
		CASE "cod_div"

			ls_message= "Divisione: "+this.getItemString(row, "cod_div")+" - Modificato in: "+data
			
		CASE "ccomune"			

			s_strade s_strade_s
			
			s_strade_s.comune= trim(data)
			old_comune= s_strade_s.comune
			
			if s_strade_s.comune= "" or isNull(s_strade_s.comune) then return 0
			
			ls_message= "Comune: "+this.getItemString(row, "comune")+" - Modificato in: "+data
			
			f_cap(s_strade_s)
			
			choose case s_strade_s.return_code
					
				case 0
					
					messageBox(this.title, "Operazione annullata.", information!)
					
				case -1
					
					li_ret= 1
					goto fine
					
				case 1
					
					this.setText("")
					
					li_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					li_err= this.SetItem ( row, "comune", s_strade_s.comune )
					//li_err= this.setText ( s_strade_s.comune )
					
					li_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					li_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
								
					li_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					//data= ""
					
					li_ret= 1
					goto fine
					
				case 2
					
					this.setText("")
					
					li_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					li_err= this.SetItem ( row, "comune", s_strade_s.comune )
					
					li_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					li_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					li_ret= 0
					goto fine
					
			end choose
		
						
		CASE "cod_att_ist_1"

			ls_message= "Modificata responsabilità 1"
			
			if data = "000" then
				SetItem ( row, "cod_att_ist_2", "000" )
				this.Object.cod_att_ist_2.Protect='1'
			else
				this.Object.cod_att_ist_2.Protect='0'
			end if
			
		CASE "cod_att_ist_2"
			
			ls_message= "Modificata responsabilità 2"
			
		CASE "data_nas"
			
			ls_message= "Data nascita: "+string(this.getItemDatetime(row, "data_nas"), "dd.mm.yyyy")+" - Modificato in: "+string(date(mid(data, 1, 10)), "dd.mm.yyyy")
			
			if f_min ( data ) = 1 then
				MessageBox ( parent.text, "L'età non può essere inferiore ai 16 anni.", information!)
				li_ret= 1
				goto fine
			end if
			
		case "vc_parent"
			
			ls_message= "Struttura: "+this.getItemString(row, "vc_parent")+" - Modificato in: "+data
			
		case "data_cer"
			
			if date ( mid ( data, 1, 10 ) ) > today ( ) then
				MessageBox ( "Attenzione", "Data posteriore a quella odierna.", exclamation! )
				li_ret= 1
				goto fine
			end if
			
			ls_message= "Data cerimonia: "+string(this.getItemDatetime(row, "data_cer"), "dd.mm.yyyy")+" - Modificato in: "+string(date(mid(data, 1, 10)), "dd.mm.yyyy")
			
			SetColumn ( "luogo_cer" )
			
		case "luogo_cer"
			
			ls_message= "Luogo cerimonia: "+this.getItemString(row, "luogo_cer")+" - Modificato in: "+data
			
		case "pres_da"
			
			ls_message= "Presentato da: "+this.getItemString(row, "pres_da")+" - Modificato in: "+data
			
			
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		case "cod_dis"
					
					if data= 'MEM' then
						
						if this.getItemString(row, "flag_er") = 'S' /*OR this.getItemString(row, "flag_npa") = '1'*/  then
							SetItem ( row, "flag_dis", "N" )  // Presente
							SetItem ( row, "flag_npa", "0" ) 
						else
							SetItem ( row, "flag_dis", "S" ) // Assente
							SetItem ( row, "flag_npa", "1" ) 
						end if
						
					else
						
						if data= 'DIM' then // esegue una copia del record corrente sulla tabella membri_dim e cancella il record stesso dalla tabella membri_gerarchica.
						
							setItem(row, "dt_dectfedim", today() )
						
							if wf_deletefromliste(is_codice) = -1 then
								li_ret=  1
								goto errore
							end if
						
							if messageBox( parent.text, "Attenzione: i dati verranno spostati nella tabella dimissionari. Confermi?", exclamation!, yesNo!, 2)= 2 then
								li_ret= 0
								goto fine
								
							else
								
								if messageBox( parent.text, "Vuoi stampare la scheda dati?", question!, yesNo!, 1)= 1 then
								
									setpointer(hourGlass!)
			
									is_preview_s.criterio= this.getItemString(this.getRow(), "codice")
									is_preview_s.dataObject= "dw_scheda_anagrafica_gerarchica"
			
									openWithParm(w_preview_scheda, is_preview_s)
									
								end if
								
							end if
							
							if this.GetItemStatus( this.GetRow(), 0, Primary!)= DataModified! then this.uof_aggiorna()
							
							ls_codice= this.getItemString(row, "codice")
							
							insert into membri_dim
							select * from membri_gerarchica where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.1") < 0 then
								li_ret= 1
								goto errore
							end if
							
							insert into esami_curr_dim
							select * from esami_curr where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.2") < 0 then 
								li_ret= 1
								goto errore
							end if
							
							insert into gohonzon_storico_dim
							select * from gohonzon_storico where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.3") < 0 then
								li_ret= 1
								goto errore
							end if
							
							insert into riferimenti_dim
							select
							codice,
							cod_rif,
							riferimento_descr,
							predefinito,
							note,
							flag_riservato
							from riferimenti where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.4") < 0 then
								li_ret= 1
								goto errore
							end if
							
							insert into storico_resp_dim
							select * from storico_resp where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.5") < 0 then
								li_ret= 1
								goto errore
							end if
							
							insert into offerte_dim
							select * from offerte where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.6") < 0 then
								li_ret= 1
								goto errore
							end if
							
							insert into zaimu_dim
							select * from zaimu where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM01.7") < 0 then
								li_ret= 1
								goto errore
							end if
							
							delete from membri_gerarchica where codice= :ls_codice;
							
							if trap_sql(sqlca, "DELDIM02") < 0 then
								li_ret= 1
								goto errore
							end if
							
							commit;
							
							if sqlca.sqlcode < 0 then
								
								rollback;
								trap_sql(sqlca, "DELDIM03")
								
								return -1
								
							end if		
							
							this.resetUpdate()
							
							this.reset()
							
							ll_currentHandle= tv_struttura.findItem(currentTreeItem!, ll_currentHandle)
							
							tv_struttura.deleteItem(ll_currentHandle)
							
							goto fine
						
						end if // if data = 'DIM'...

						if data= 'TAI' /*or data= 'DIM' */ then
							
							if this.getItemString(row, "flag_goh") = 'S' OR &
								this.getItemString(row, "flag_tok") = 'S' OR &
									this.getItemString(row, "flag_oma") = 'S' then	
										messageBox(parent.text, "Attenzione, la persona è assegnataria di Gohonzon.", information!)
										this.reselectRow(row)
										li_ret= 2
										goto fine
							end if
													
							if messageBox(parent.text, "Assegnando questo status verranno annullate: "+"~nresponsabilità, appartenenza agli staff e luogo di riunione."+&
									"~nVuoi continuare?", question!, yesNo!, 2)= 2 then
									//this.reselectRow(row)
									li_ret= 2
									goto fine
							end if
								
								this.setItem(row, "cod_att_ist_1", '000')
								this.setItem(row, "cod_att_ist_2", '000')
								this.setItem(row, "codice_staff", '000')
							
							end if
						
							SetItem ( row, "flag_dis", "S" )  // Assente
							SetItem ( row, "flag_npa", "1" ) // Non partecipante alle attività
							setItem(row, "flag_ldr", 'N') // No luogo di riunione
						
							if wf_deletefromliste(is_codice) = -1 then
								li_ret= 1 // non accetta il valore inserito...
								goto errore
							end if
					
					end if
			
			ls_message= "Status: "+this.getItemString(row, "cod_dis")+" - Modificato in: "+data
			
			// Valorizzo a seconda del nuovo status una delle tre date possibili in modo da poter 
			// identificare il passaggio ad una delle tre fasce(1: ATT e NPA, 2: NOP e TAI, 3: DEC TFE e DIM)
			if data= 'MEM' /*or data= 'NPA' */ then
				setItem(row, "dt_attnrc", today() )
			elseif data= "TAI" then
				setItem(row, "dt_tai", today() )
			else
				setItem(row, "dt_dectfedim", today() )
			end if
			
		case "flag_er"
			
			if (data = "N") then

				SetItem ( row, "flag_dis", "S" )
				SetItem ( row, "flag_npa", "1" )	
				
				if wf_deletefromliste(is_codice) = -1 then
					li_ret= 1
					goto errore
				end if
				
			else 
				
				if this.getItemString(row, "cod_dis") = 'MEM' then
					SetItem ( row, "flag_dis", "N" )
					SetItem ( row, "flag_npa", "0" )	
				end if
				
			end if

			ls_message= "Membro dell'ente religioso: "+this.getItemString(row, "flag_er")+" - Modificato in: "+data
			
		case "flag_npa"
			
			if (data = "1") then
				if wf_deletefromliste(is_codice) = -1 then
					li_ret= 1 // non accetta il nuovo valore
					goto errore
				end if
				
				tab_dettaglio.tabpage_liste.visible= false
			else
				tab_dettaglio.tabpage_liste.visible= f_has_p("S")
			end if

			ls_message= "Non partecipante alle attività / Non reperibile: "+this.getItemString(row, "flag_npa")+" - Modificato in: "+data
			
			
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		case "codice_staff"
			
//				if data= "000" then
//					m_anag.m_principale.m_staff.enabled = false
//				else
//					m_anag.m_principale.m_staff.enabled = true		
//				end if

				ls_message= "Staff: "+this.getItemString(row, "codice_staff")+" - Modificato in: "+data
			
		CASE else

	END CHOOSE
	
//		if this.object.b_aggiorna.visible= '0' then
//			if gi_classediutenza < gc_cons then this.object.b_aggiorna.visible= '1'
//		end if

		this.setItem(row, "u_ult_mod", s_utente_s.s_nome_esteso)
		this.setItem(row, "d_ult_mod", today())

f_log(s_session_s, ls_message, false)

// Modifica la visualizzazione dell'item sul treeView

choose case dwo.name
		
	case "flag_ldr"
		
		ltv_item.statePictureIndex= 0
		if data= "S" then ltv_item.statePictureIndex= 1
		
	case "cod_dis"
		
		string ls_data, ls_er
		
		ls_data= data
		ls_er=  this.getItemString(row, "flag_er")
		
		 ltv_item.pictureIndex= 0
		if ls_data= "MEM" and ls_er = "S" then ltv_item.pictureIndex= gi_maxlivello + integer(this.getItemString(row, "cod_div") )

	case "flag_er"
		
		 ltv_item.pictureIndex= 0
		if data= "S" and this.getItemString(row, "cod_dis") = "MEM" then ltv_item.pictureIndex= gi_maxlivello + integer(this.getItemString(row, "cod_div") )

case "flag_npa"
	
	 ltv_item.pictureIndex= 0
	if data= "0" then ltv_item.pictureIndex= gi_maxlivello + integer(this.getItemString(row, "cod_div") )	
		
	case "cod_att_ist_1"
		
		 ltv_item.bold= false
		if data= "101" then ltv_item.bold= true
		
	case "cod_att_ist_2"
		
		 ltv_item.bold= false
		if data= "101" then ltv_item.bold= true
		
	case "cognome"
		
		ltv_item.label= f_iniziali(trim(data) + " " + trim(this.getItemString(row, "nome") ) )
		
	case "nome"
		
		ltv_item.label= f_iniziali(trim(this.getItemString(row, "cognome") ) + " " + trim(data) )
		
end choose

ltv_item.selectedPictureIndex=  ltv_item.pictureIndex

li_err= tv_struttura.setItem(ll_currentHandle, ltv_item)

fine: tv_struttura.setRedraw(true)

return li_ret

errore:

rollback;
trap_sql(sqlca, "ITEMCHANGED01")

 tv_struttura.setRedraw(true)
 
 return li_ret



end event

event retrieveend;call super::retrieveend;if rowcount <= 0 then return

this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")

this.object.b_aggiorna.visible= false

if f_has_p('S') = false then
	string ls_filter
	ls_filter= "cod_dis <> 'DIM' and cod_dis <> 'TAI' "
	idwc_cod_dis.SetFilter ( ls_filter )
	idwc_cod_dis.Filter ( )
end if


end event

event updatestart;call super::updatestart;//// Aggiorna la tabella storico_resp con i nuovi codici responsabilità...

string ls_cod

if getRow()= 0 then return 0

this.setItem(getRow(), "u_ult_mod", s_utente_s.s_nome)
this.setItem(getRow(), "d_ult_mod", string(today(), "dd.mm.yyyy hh:mm") )

if this.getItemStatus(getRow(), "cod_att_ist_1", primary!)= dataModified! then
	
	ls_cod= this.getItemString(getRow(), "cod_att_ist_1")
	
	  INSERT INTO storico_resp  
         ( codice,   
           livello,   
           cod_att_ist,   
           utente,   
           data,   
           note )  
	  VALUES ( :is_codice,   
				  1,   
				  :ls_cod,   
				  current_user,   
				  getDate()  ,
				  null )  ;
				  
	if trap_sql(sqlca, "UPDATERESP01") < 0 then return 1
	
end if
	
if this.getItemStatus(getRow(), "cod_att_ist_2", primary!)= dataModified! then
	
	ls_cod= this.getItemString(getRow(), "cod_att_ist_2")
	
	  INSERT INTO storico_resp  
         ( codice,   
           livello,   
           cod_att_ist,   
           utente,   
           data,   
           note )  
	  VALUES ( :is_codice,   
				  2,   
				  :ls_cod,   
				  current_user,   
				  getDate()  , 
				  null )  ;
				  
	if trap_sql(sqlca, "UPDATERESP02") < 0 then return 1
	
end if

return 0
end event

event updateend;call super::updateend;if rowsdeleted > 0 then return 0

//long ll_handle, ll_parent
//
//tv_struttura.setRedraw(false)
//
//ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
//
//ll_parent = tv_struttura.FindItem(parentTreeItem!, ll_handle)
//
//tv_struttura.uf_visualizzanuovoitem(ll_parent)
//
//tv_struttura.setRedraw(true)
end event

event editchanged;call super::editchanged;//if this.object.b_aggiorna.visible= false then this.object.b_aggiorna.visible= true
end event

event itemfocuschanged;call super::itemfocuschanged;return 0
end event

type tabpage_andamenti from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 67108864
string text = "Report e andamenti"
long tabtextcolor = 33554432
string picturename = "Custom067!"
long picturemaskcolor = 536870912
cb_filtra cb_filtra
cb_apri cb_apri
pb_carica pb_carica
uodw_stat uodw_stat
st_name st_name
dw_reportname dw_reportname
end type

on tabpage_andamenti.create
this.cb_filtra=create cb_filtra
this.cb_apri=create cb_apri
this.pb_carica=create pb_carica
this.uodw_stat=create uodw_stat
this.st_name=create st_name
this.dw_reportname=create dw_reportname
this.Control[]={this.cb_filtra,&
this.cb_apri,&
this.pb_carica,&
this.uodw_stat,&
this.st_name,&
this.dw_reportname}
end on

on tabpage_andamenti.destroy
destroy(this.cb_filtra)
destroy(this.cb_apri)
destroy(this.pb_carica)
destroy(this.uodw_stat)
destroy(this.st_name)
destroy(this.dw_reportname)
end on

type cb_filtra from commandbutton within tabpage_andamenti
boolean visible = false
integer x = 2409
integer y = 12
integer width = 247
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Filtra"
end type

event clicked;openWithParm(w_filter, uodw_stat)

string ls_filter

ls_filter= message.stringParm

uodw_stat.setFilter(ls_filter)

uodw_stat.filter()
end event

type cb_apri from commandbutton within tabpage_andamenti
integer x = 1778
integer y = 12
integer width = 617
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Apri in una nuova finestra"
end type

event clicked;s_preview s_preview_s
s_struttura s_struttura_loc
treeViewItem ll_tvi
long ll_handle

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)

if tv_struttura.GetItem(ll_handle, ll_tvi)= -1 then return -1

s_struttura_loc= ll_tvi.data

s_preview_s.dataObject=  is_dataobject // uodw_stat.dataObject
s_preview_s.ib_dwcreate= true
s_preview_s.ib_anteprima= false

s_preview_s.criterio= s_struttura_loc.vc_nodo
//s_preview_s.anno= ii_anno
//s_preview_s.livello= s_struttura_loc.livello

//if uodw_stat.Object.DataWindow.Processing= '4' then // Crosstab dw...
	s_preview_s.doretrieve= false
	openWithParm(w_preview, s_preview_s)
	w_preview.uodw_current.setRedraw(false)
	w_preview.uodw_current.retrieve(s_struttura_loc.vc_nodo/*+"%"*/, ii_anno, s_struttura_loc.livello/*+2*/)
	w_preview.uodw_current.groupCalc()
	w_preview.uodw_current.setRedraw(true)
//else
//	s_preview_s.doretrieve= false
//	openWithParm(w_preview, s_preview_s)
//	w_preview.uodw_current.setRedraw(false)
//	uodw_stat.shareData(w_preview.uodw_current)
//	w_preview.uodw_current.setRedraw(true)
//end if

//uodw_stat.groupCalc()

end event

type pb_carica from picturebutton within tabpage_andamenti
integer x = 1637
integer y = 16
integer width = 119
integer height = 104
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "doublenextarrow.gif"
alignment htextalign = left!
end type

event clicked;this.enabled= false
dw_reportname.enabled= false

if uodw_stat.event ue_stats(0)= 0 then
	messageBox( parent.text, "Nessun record estratto.", information!)
else
	cb_apri.enabled= true
	cb_filtra.enabled= true
end if

dw_reportname.enabled= true

return 0
end event

type uodw_stat from uodw_generica within tabpage_andamenti
event type integer ue_stats ( integer ai_anno )
integer y = 140
integer width = 2661
integer height = 1736
integer taborder = 100
boolean maxbox = false
boolean resizable = true
borderstyle borderstyle = stylebox!
boolean ib_allowstop = true
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
integer ii_userlevel = 0
long il_newrow = 4
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event type integer ue_stats(integer ai_anno);long ll_handle, ll_rows
s_struttura s_struttura_loc
treeViewItem ll_tvi

//open(w_wait_snoopy_writing)

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)

if tv_struttura.GetItem(ll_handle, ll_tvi)= -1 then return -1

s_struttura_loc= ll_tvi.data

//if isValid(this.Object.t_header) then this.Object.t_header.Text = s_struttura_loc.descrizione_livello+" "+ s_struttura_loc.descrizione_struttura

if ai_anno= 0 then
	ii_anno= year(today())
else
	ii_anno= ai_anno
end if

//tab_dettaglio.tabpage_stat.dw_stat.Object.t_header.Text = f_descrizione_struttura_fill(is_struttura_s.vc_nodo)

//tab_dettaglio.tabpage_stat.uodw_stat.setTransObject(sqlca)

this.setTransObject(sqlca)

/*
 * N.B. Gli argomenti passati nella seguente retrieve sono e devono sempre essere tre:
 * il nodo, l'anno di riferimento, il livello di struttura su cui eseguire l'estrazione.
 * Non sempre sono necessari tutti, per cui una certa dw può utilizzare solo il nodo o il nodo e il livello etc.
 * Per compatibilità in ogni caso ogni dw creata per essere utilizzata in questa sezione del programma deve avere questi tre parametri
 * ( retrieval arguments )  nello stesso ordine anche se non verranno tutti utilizzati.
 * PB dà, nel caso, un messaggio di warning al salvataggio della dw, di cui non va tenuto conto.
 */

this.setRedraw(false)

	ll_rows= this.retrieve(s_struttura_loc.vc_nodo/*+"%"*/, ii_anno, s_struttura_loc.livello/*+2*/)
	
	this.setFilter("")
	
	this.filter()

this.setRedraw(true)

//close(w_wait_snoopy_writing)

return ll_rows
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stat

im_preview.m_aggiungi.enabled= false
im_preview.m_inserisci.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false
im_preview.m_ordina.enabled= false
im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case "b_filtra"
		
		openWithParm(w_filter, this)

	case  "b_anno"
	
		integer li_anno
		
		open(w_anno)
		
		li_anno= message.doubleParm
		
		if this.event ue_stats(li_anno)= 0 then
			messageBox( parent.text, "Nessun record estratto.", information!)
		else
			cb_apri.enabled= true
			cb_filtra.enabled= true
		end if
		
		dw_reportname.enabled= true
		
	
	case "b_summary"
		
		integer li_height
		
		li_height= this.object.dataWindow.summary.height
		
		if li_height= 0 then
			this.object.dataWindow.summary.height.autoSize= 'Yes'
		else
			this.object.dataWindow.summary.height= 0		
		end if
	
	case "b_dis"
		
		if this.filteredCount() > 0 then
		
			this.setFilter("")
			
			this.Object.t_lista.text= "( tutti )"
			
		else
			
			this.setFilter("flag_dis='N'")
			
			this.Object.t_lista.text= "( esclusi non attivi )"	
			
		end if
		
		this.filter()
		
		this.groupCalc()
		
end choose
end event

type st_name from statictext within tabpage_andamenti
integer x = 5
integer y = 36
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona il report: "
boolean focusrectangle = false
end type

type dw_reportname from datawindow within tabpage_andamenti
integer x = 411
integer y = 12
integer width = 1234
integer height = 128
integer taborder = 30
string title = "none"
string dataobject = "edw_reportname"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_syntax, ls_errors

tab_dettaglio.tabpage_andamenti.dw_reportname.GetChild('reportname', idwc_reportname)

ls_syntax= libraryExport(gs_docdir+"\"+gs_reportpath, data, exportDataWindow!)

if ls_syntax= "" then
	messageBox(parent.text, "Errore in generazione datawindow:"+ls_syntax, exclamation!)
	return
end if

uodw_stat.create(ls_syntax, ls_errors) // idw_dettaglio.create(ls_syntax, ls_errors)
if len(ls_errors) > 0 then
	messageBox(parent.text, ls_errors, exclamation!)
	return -1
end if

//uodw_stat.dataObject= data //idw_dettaglio.dataObject= data
is_dataobject= data

idw_dettaglio.setRedraw(false)
pb_carica.enabled= true
cb_apri.enabled= false
cb_filtra.enabled= false
idw_dettaglio.setRedraw(true)
end event

type tabpage_rif from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 81324524
string text = "Riferimenti"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "Custom020!"
long picturemaskcolor = 1073741824
uodw_rif uodw_rif
end type

on tabpage_rif.create
this.uodw_rif=create uodw_rif
this.Control[]={this.uodw_rif}
end on

on tabpage_rif.destroy
destroy(this.uodw_rif)
end on

type uodw_rif from uodw_generica within tabpage_rif
event type integer ue_modrif ( )
integer width = 3470
integer taborder = 50
string dataobject = "dw_riferimenti"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
integer ii_userlevel = 0
long il_newrow = 3
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event type integer ue_modrif();s_riferimenti s_riferimenti_s
s_riferimenti_s.codice= is_codice

if this.getRow() <= 0 then return 0

s_riferimenti_s.idx= this.getItemDecimal(this.getRow(), "idx")
s_riferimenti_s.rif_membri= true
openWithParm(w_ins_riferimenti, s_riferimenti_s)
this.retrieve(is_codice)
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_rif

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event itemerror;call super::itemerror;return 1
end event

event buttonclicked;call super::buttonclicked;//if gi_classediutenza= gc_cons then
//	messageBox(this.title, "Operazione non permessa", exclamation!)
//	return -1
//end if

choose case  dwo.name
			
	case "b_p"
		
//		this.setItem(uodw_rif.il_newrow, "codice", is_codice)
		s_riferimenti s_riferimenti_s
		s_riferimenti_s.codice= is_codice
		s_riferimenti_s.idx= 0
	     s_riferimenti_s.rif_membri= true
		openWithParm(w_ins_riferimenti, s_riferimenti_s)
		
		this.setRedraw(false)
			this.retrieve(is_codice)
		this.setRedraw(true)
		
//		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//		if wf_riferimenti()= 1 then return 1
		
	case "b_invia"
		
		openWithParm(w_check_pw, s_utente_s)
		
		if message.doubleParm= -1 then return -1
		
		string ls_mail
		
		ls_mail= this.getItemString(row, "riferimento_descr")
		
		if this.getItemString(row, "cod_rif")= "MA" then
			if pos(ls_mail, "@")= 0 or len(trim(ls_mail) )= 0 then
				messageBox(parent.text, "Indirizzo di posta elettronica non valido.", exclamation!)
				return -1
			end if
			
			mailSession mSes
	
			mailReturnCode mRet
			
			mailMessage mMsg
			
			setPointer(hourGlass!)
			
			// Create a mail session
			
			mSes = create mailSession
			
			// Log on to the session
			
			mRet = mSes.mailLogon(mailNewSession!)
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail", 'Logon fallito.')
					return -1
			
			END IF
			
			mMsg.Recipient[1].address= trim(ls_mail)
			
			// Send the mail
			
			mRet = mSes.mailSend(mMsg) // +cc
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail Send", 'Mail non inviata')
					return -1
			
			END IF
			
			mSes.mailLogoff()
			
			DESTROY mSes
			
			return 0
			
		else // SMS
			
			integer li_ret
			long ll_idx
			string ls_number, ls_message
			
			open(w_composizione_sms)
			
			ls_message= message.stringParm
			
			if ls_message= "" then return -1
			
			mailFileDescription a_mailFileDescription[]
			
			mMsg.subject= "SMS"
			
			mMsg.noteText= ls_message
					
			ls_number= uodw_rif.getItemString(row, "riferimento_descr")
			ls_number= f_cleanphonenumber(ls_number)
				
			if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then return -1
			
			// Numero di cellulare= tre cifre di prefisso più 7 cifre di numero telefonico
		
			if len(ls_number) <= 10 then ls_number = '39'+ls_number
				
	//		if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
					
			mMsg.recipient[1].name= "smsgateway"
					
			mMsg.recipient[1].address=  ls_number+"@"+s_sms_s.as_smsgateway
					
			mMsg.recipient[1].recipientType= mailTO!
			
	//		li_ret=  f_sendsms(mMsg, s_sms_s) 		
	
	//SMS

			s_sms_s.as_mailuser= s_sms_s.as_smsuser
			s_sms_s.as_mailpw= s_sms_s.as_smspw
			
			s_sms_s.as_mailfrom= s_sms_s.as_smsfrom
			
			//s_sms.as_mailfrom
			
			li_ret= f_sendmail_blat(mMsg, s_sms_s)
			
			
		end if
		
end choose
end event

event itemchanged;integer li_ret
string ls_rif, ls_message

// Non esegue la script ancestor

ls_rif= this.getItemString(row, "cod_rif")

choose case dwo.name
		
//case "riferimento_descr"
//	
//	if ls_rif= "MA" then
//		if pos(data, "@")= 0 then
//			messageBox(parent.text, "Indirizzo di posta elettronica non valido.", exclamation!)
//			return 1
//		end if
//	end if
//	
//	ls_message= this.getItemString(row, "riferimento_descr")+" - Modificato in: "+data
//	
//	f_log(s_session_s, ls_message, false)
	
case "preferito"
	
	long ll_found
	
	// da lasciare... non esegue la script ancestor
	this.object.b_aggiorna.visible= true
	
	if data= '1' then
		
		ll_found = this.Find("cod_rif= '"+ls_rif+"' and preferito= '1'", 1, this.RowCount())
		
		if ll_found > 0 then
			
			this.setItem(ll_found, "preferito", '0')
			return 0
			
		end if
		
	else // se data= 0
		
		decimal ld_idx
		
		ld_idx= this.getItemDecimal(row, "idx")
		
		select count(*)
		into : li_ret
		from riferimenti
		where	codice= :is_codice and
					cod_rif= :ls_rif and 
					predefinito= '1' and
					idx <> :ld_idx;
					
					if li_ret= 0 then // se nessun riferimento è qualificato come preferito...
						messageBox(parent.text, "Almeno un riferimento di questo tipo deve essere indicato come preferito", information!)
						return 1
					end if							

	end if
	
end choose
end event

event updatestart;call super::updatestart;//// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//
//boolean lb_found
//
//long ll_breakrow, ll_start= 1, ll_ok
//
//lb_found = FALSE
//
//ll_breakrow = 0
//
//DO WHILE NOT (lb_found)
//	
//		ll_breakrow = this.FindGroupChange(ll_breakrow, 1)
//
//// If no breaks are found, exit.
//		IF ll_breakrow <= 0 THEN EXIT
//
//// altrimenti cerca all'interno del gruppo il preferito...
//
//		ll_ok= this.find("preferito= '1'", ll_start, ll_breakrow - 1)
//		
//		if ll_ok= 0 then
//			messageBox(parent.text, "Occorre indicare un riferimento preferito per ciascun tipo.", information!)
//			return 1 // blocca l'update e ritorna alla maschera...
//		end if
//
//// Increment starting row to find next break
//		ll_start= ll_breakrow
//		ll_breakrow = ll_breakrow + 1
//
//LOOP
//
//return 0



end event

event buttonclicking;call super::buttonclicking;//if dwo.name= "b_aggiorna" then
//	
//	// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//
//		boolean lb_found
//		
//		long ll_breakrow= 2, ll_start= 1, ll_ok, ll_end
//		
//		lb_found = FALSE
//		
//		this.sort()
//		this.groupCalc()
//		
//		DO WHILE NOT (lb_found)
//			
//				ll_breakrow = this.FindGroupChange(ll_breakrow, 1)
//		
//		// altrimenti cerca all'interno del gruppo il preferito...
//		
//				if ll_breakrow= 0 then
//					ll_end= this.rowCount()
//				else
//					ll_end= ll_breakrow - 1
//				end if
//		
//				ll_ok= this.find("preferito= '1'", ll_start, ll_end)
//				
//				if ll_ok= 0 then
//					messageBox(parent.text, "Occorre indicare un riferimento preferito per ciascun tipo.", information!)
//					return 1 // blocca l'update e ritorna alla maschera...
//				end if
//				
//		// If no breaks are found, exit.
//				IF ll_breakrow <= 0 THEN EXIT
//		
//		// Increment starting row to find next break
//				ll_start= ll_breakrow
//				ll_breakrow = ll_breakrow + 1
//		
//		LOOP
//		
//		return 0
//		
//end if
end event

event doubleclicked;call super::doubleclicked;integer li_ret
s_riferimenti s_riferimenti_s
string ls_rif

s_riferimenti_s.codice= is_codice

if row <= 0 then return 0

if f_has_p("O")= false then return -1

ls_rif= this.getItemString(row, "cod_rif")

s_riferimenti_s.idx= this.getItemDecimal(row, "idx")
s_riferimenti_s.rif_membri= true
openWithParm(w_ins_riferimenti, s_riferimenti_s)

this.setRedraw(false)

this.retrieve(is_codice)

select count(*)
into : li_ret
from riferimenti
where	codice= :is_codice and
			cod_rif= :ls_rif and 
			predefinito= '1';
if trap_sql(sqlca, "MODRIF01") < 0 then return -1			
			
			if li_ret= 0 then // se nessun riferimento è qualificato come preferito...
				update riferimenti
				set predefinito= '1'
				where 	codice= :is_codice and
							cod_rif= :ls_rif and 
							idx= (select MAX(idx) from riferimenti
							where 	codice= :is_codice and
										cod_rif= :ls_rif);
				if trap_sql(sqlca, "MODRIF02") < 0 then return -1
				
				this.uof_aggiorna()
				
				if trap_sql(sqlca, "MODRIF03") < 0 then return -1
				
				this.retrieve(is_codice)						
			end if							
			
this.setRedraw(true)			

end event

event sqlpreview;call super::sqlpreview;if f_has_p('S')=  false  then // deve estrarre solo i record non riservati

	string ls_syntax
	
	ls_syntax= " and flag_riservato= 'N' "
	
	sqlsyntax += ls_syntax
	
	if setSqlPreview( sqlSyntax ) < 0 then
		messageBox(parent.text, "Errore in sqlPreview riferimenti")
		return 1
	end if
	
end if
		
end event

type tabpage_ediz from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 81324524
string text = "Edizioni"
long tabtextcolor = 33554432
string picturename = "Custom003!"
long picturemaskcolor = 1073741824
uodw_pubblicazioni uodw_pubblicazioni
end type

on tabpage_ediz.create
this.uodw_pubblicazioni=create uodw_pubblicazioni
this.Control[]={this.uodw_pubblicazioni}
end on

on tabpage_ediz.destroy
destroy(this.uodw_pubblicazioni)
end on

type uodw_pubblicazioni from uodw_generica within tabpage_ediz
integer width = 2437
integer height = 2584
integer taborder = 60
string dataobject = "dw_pubblicazioni"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
integer ii_userlevel = 0
long il_newrow = 4
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_pubblicazioni

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_storico" then
	
	if this.filteredCount() > 0  then
	this.setFilter("")
	else
		this.setFilter("copie_residue> 0")
	end if
	
	return this.filter()
	
end if
end event

type tabpage_offerte from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 81324524
string text = "Offerte"
long tabtextcolor = 33554432
string picturename = "Custom054!"
long picturemaskcolor = 1073741824
uodw_storicocontributi uodw_storicocontributi
end type

on tabpage_offerte.create
this.uodw_storicocontributi=create uodw_storicocontributi
this.Control[]={this.uodw_storicocontributi}
end on

on tabpage_offerte.destroy
destroy(this.uodw_storicocontributi)
end on

type uodw_storicocontributi from uodw_generica within tabpage_offerte
integer width = 2560
integer taborder = 90
string dataobject = "dw_info"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
integer ii_userlevel = 0
long il_newrow = 4
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_storicocontributi

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false
	
im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;call super::buttonclicked;integer i_ret

if uodw_storicocontributi.Object.importo.Visible= '0' then
	
	openWithParm(w_check_pw, s_utente_s)
	
	if message.doubleParm= 1 then
	
		//visualizza gli importi
		uodw_storicocontributi.Object.importo.Visible= 1
		uodw_storicocontributi.Object.importo_t.Visible= 1
		uodw_storicocontributi.Object.cimporto.Visible= 1
		
	else
		
		uodw_storicocontributi.Object.importo.Visible= 0
		uodw_storicocontributi.Object.importo_t.Visible= 0
		uodw_storicocontributi.Object.cimporto.Visible= 0
		
	end if
	
end if
end event

event retrieveend;call super::retrieveend;uodw_storicocontributi.Object.importo.Visible= 0
uodw_storicocontributi.Object.importo_t.Visible= 0
end event

type tabpage_liste from userobject within tab_dettaglio
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 67108864
string text = "Liste"
long tabtextcolor = 33554432
string picturename = "Custom002!"
long picturemaskcolor = 536870912
uodw_liste uodw_liste
end type

on tabpage_liste.create
this.uodw_liste=create uodw_liste
this.Control[]={this.uodw_liste}
end on

on tabpage_liste.destroy
destroy(this.uodw_liste)
end on

type uodw_liste from uodw_generica within tabpage_liste
integer width = 2226
integer height = 1272
integer taborder = 40
string dataobject = "dw_liste_dettaglio"
boolean maxbox = false
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 0
long il_newrow = 3
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_liste

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;// Non deve eseguire la script ancestor

string ls_message

//if f_np(gc_superv)= 1 then return 0
//string ls_lista

//ls_lista= this.getItemString(this.getRow(), "cod_lista")

choose case dwo.name
		
	case "b_aggiorna"
		
		ls_message= "Liste: inserito in mailing list"
		
		if uof_esegui(ic_aggiornamento) < 0 then return -1
			
		f_log(s_session_s, ls_message, true)	
		this.object.b_aggiorna.visible= false
		
	case "b_p" 
		
		//ls_message= "Liste: inserito in mailing list"
		
		openWithParm(w_assegna_lista, is_codice)
		
		if message.doubleParm < 0 then return
		
		this.retrieve(is_codice)
		
	//	if uof_esegui(ic_inserimento) < 0 then return -1
		
	//	this.setItem(this.getRow(), "codice", is_codice)
		
//		this.resetUpdate()
//		
//		this.setItemStatus(this.getRow(), 0, Primary!, new!)
	
case "b_m"
	
	ls_message= "Liste: rimosso da mailing list"
	
	if uof_esegui(ic_cancellazione) < 0 then return -1
	
	f_log(s_session_s, ls_message, true)	
	
end choose
end event

event itemchanged;call super::itemchanged;//decimal ld_idx
long ll_found
string ls_message,	ls_tipo, ls_tipo_rif, ls_cod_lista
s_riferimenti s_riferimenti_s
		
if dwo.name= "idx" then
	
	s_session_s.context= "Anagrafica - Liste"
	
	ls_message= "Liste: inserito in: "+data
	
	//ld_idx= data // this.getItemString(row, "cod_lista")
	
	ll_found= find("idx= "+data, 1, this.rowCount() )
	
	if ll_found > 0 then
		messageBox(parent.text, "Già presente in questa lista.", information!)
		return 1
	end if
	/*
	// se non esiste il riferimento relativo al tipo di lista ne permette l'inserimento....
	
			select cod_tipo
			into :ls_tipo
			from liste
			where cod_lista= :data;
			
			if trap_sql(sqlca, "LISTE00") < 0 then return -1
			
			if ls_tipo <> "MAIL" and ls_tipo <> "SMS" then return 0
	
			select distinct r.cod_rif
			into :ls_tipo_rif
			from 
			riferimenti r, liste l, liste_tipi t
			where
			r.cod_rif= t.cod_rif and
			r.codice=  :is_codice  and 
			t.cod_tipo= l.cod_tipo and
			l.cod_lista= :ls_cod_lista;

			if trap_sql(sqlca, "LISTE01") < 0 then return -1
			
			if ls_tipo_rif= "" or isNull(ls_tipo_rif) then
						
				messageBox(parent.text, "Non esiste un riferimento del tipo richiesto: inserirlo ora.")
				
				s_riferimenti_s.codice= is_codice
				s_riferimenti_s.rif_membri= true
				s_riferimenti_s.cod_rif= ls_tipo_rif
				s_riferimenti_s.idx= 0
				
				if openWithParm(w_ins_riferimenti, s_riferimenti_s)= -1 then return
				
				f_log(s_session_s, ls_message, false)
		
			end if
			
			*/
	
end if
end event

type tabpage_studio from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 81324524
string text = "Esami"
long tabtextcolor = 33554432
string picturename = "Custom083!"
long picturemaskcolor = 1073741824
uodw_se uodw_se
end type

on tabpage_studio.create
this.uodw_se=create uodw_se
this.Control[]={this.uodw_se}
end on

on tabpage_studio.destroy
destroy(this.uodw_se)
end on

type uodw_se from uodw_generica within tabpage_studio
integer width = 2025
integer height = 1484
integer taborder = 50
string dataobject = "ds_curr_studio"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 0
long il_newrow = 3
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_se

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )

end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row(this)
end event

event itemerror;call super::itemerror;return 1
end event

event buttonclicked;call super::buttonclicked;//if f_np(gc_superv)= 1 then return 0

choose case dwo.name
		
	case "b_p" 
	
	this.setItem(this.getRow(), "codice", is_codice)
	this.resetUpdate()
	
	this.setItemStatus(this.getRow(), 0, Primary!, new!)
	
case "b_anag"
	
	string ls_studio, ls_codice, ls_esito, ls_cod_studio_anag
	
	ls_codice= this.getItemString(this.getRow(), "codice")
	ls_studio= this.getItemString(this.getRow(), "cod_studio")
	
	select cod_studio
	into :ls_cod_studio_anag
	from membri_gerarchica
	where codice= :ls_codice;
	
	if trap_sql(sqlca, "UPDSTUDIO01") < 0 then return -1
	
	if ls_cod_studio_anag= ls_studio then
		
		messageBox(parent.text, "Il livello di studio, in anagrafica, è già aggiornato.", information!)
		return 0
		
	else
		
		if messageBox(parent.text, "Attualmente il livello di studio, in anagrafica, è: "+mid(ls_cod_studio_anag, 2, 1)+"° . ~n"+&
												"Vuoi aggiornarlo a: "+mid(ls_studio, 2, 1)+"° ?", question!, yesNo!, 2)= 2 then return 0
		
	end if

	update membri_gerarchica set cod_studio= :ls_studio where codice= :ls_codice;
	
	return this.uof_aggiorna()

end choose
end event

type tabpage_goh from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 81324524
string text = "Gohonzon"
long tabtextcolor = 33554432
string picturename = "Custom004!"
long picturemaskcolor = 1073741824
uodw_sg uodw_sg
end type

on tabpage_goh.create
this.uodw_sg=create uodw_sg
this.Control[]={this.uodw_sg}
end on

on tabpage_goh.destroy
destroy(this.uodw_sg)
end on

type uodw_sg from uodw_generica within tabpage_goh
integer width = 2775
integer taborder = 110
string dataobject = "d_storico_goh"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 0
long il_newrow = 3
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

if dwo.name= "b_note" then

	ls_note=  this.getItemString(this.getRow(), "note")

	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
	end if
	
elseif dwo.name= "b_p" then
	
	this.setItem(this.getRow(), "codice", is_codice)
	this.resetUpdate()
	
	this.setItemStatus(this.getRow(), 0, Primary!, new!)

	
end if
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_sg

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )





end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row(this)
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_resp from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 67108864
string text = "Responsabilità"
long tabtextcolor = 33554432
string picturename = "Run!"
long picturemaskcolor = 1073741824
uodw_storico_resp uodw_storico_resp
end type

on tabpage_resp.create
this.uodw_storico_resp=create uodw_storico_resp
this.Control[]={this.uodw_storico_resp}
end on

on tabpage_resp.destroy
destroy(this.uodw_storico_resp)
end on

type uodw_storico_resp from uodw_generica within tabpage_resp
integer y = 8
integer width = 2642
integer taborder = 70
string dataobject = "dw_storico_resp"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 0
long il_newrow = 3
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

//if f_np(gc_superv)= 1 then return 0

choose case dwo.name
		
	case "b_aggiorna"
		
//		if ancestorReturnValue= 0 then
		
	case "b_note"

		ls_note=  this.getItemString(this.getRow(), "note")
	
		openWithParm(w_note, ls_note)
		
		ls_note_old= ls_note
		
		ls_note= message.stringParm
		
		if ls_note <> ls_note_old or isNull(ls_note_old) then
			this.setItem(this.getRow(), "note", ls_note)
		end if
	
	case "b_p"
	
		this.setItem(this.getRow(), "codice", is_codice)
		this.setItem(this.getRow(), "utente", s_utente_s.s_nome_esteso)
	
		this.resetUpdate()
		
		this.setItemStatus(this.getRow(), 0, Primary!, new!)

end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_storico_resp

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )

end event

type tabpage_log from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 3515
integer height = 2812
long backcolor = 67108864
string text = "Riepilogo"
long tabtextcolor = 33554432
string picturename = "ComputeToday5!"
long picturemaskcolor = 1073741824
uodw_vislog uodw_vislog
end type

on tabpage_log.create
this.uodw_vislog=create uodw_vislog
this.Control[]={this.uodw_vislog}
end on

on tabpage_log.destroy
destroy(this.uodw_vislog)
end on

type uodw_vislog from uodw_generica within tabpage_log
integer width = 3406
integer height = 2880
integer taborder = 70
string dataobject = "dw_vislog"
integer ii_userlevel = 0
long il_newrow = 4
integer ic_annullaestrazione = 0
integer ic_ricerca = 2
integer ic_aggiornamento = 3
integer ic_cancellazione = 4
integer ic_impostapagina = 5
integer ic_inserimento = 6
integer ic_layout = 7
integer ic_modificheincorso = 8
integer ic_next = 9
integer ic_print = 10
integer ic_prior = 11
integer ic_reset = 12
integer ic_struttura = 13
integer ic_zoom = 14
integer ic_aggiungi = 15
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_vislog

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

type dw_1 from datawindow within w_struttura_tv_tab_test
integer x = 37
integer y = 8
integer width = 1001
integer height = 108
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "edw_target_ricerca"
boolean livescroll = true
end type

event editchanged;string ls_cerca
long ll_rows

timer(0, w_struttura_tv_tab_test)

if integer(data)= 0 then
	
//	event ue_totale(row, dec(data) )

//	ls_cerca= f_trim_all(sle_cerca.text)
//	
//	ll_rows= ids_struttura.retrieve("%"+ls_cerca+"%", as_ambito+"%")
	
else
	
	timer(0.50, w_struttura_tv_tab_test)
	
end if
end event

