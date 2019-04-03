$PBExportHeader$w_struttura_tv_tab_ori.srw
forward
global type w_struttura_tv_tab_ori from w_struttura_tv
end type
type tab_dettaglio from tab within w_struttura_tv_tab_ori
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
type tabpage_stat from userobject within tab_dettaglio
end type
type cb_apri from commandbutton within tabpage_stat
end type
type pb_carica from picturebutton within tabpage_stat
end type
type st_name from statictext within tabpage_stat
end type
type dw_reportname from datawindow within tabpage_stat
end type
type uodw_stat from uodw_generica within tabpage_stat
end type
type tabpage_stat from userobject within tab_dettaglio
cb_apri cb_apri
pb_carica pb_carica
st_name st_name
dw_reportname dw_reportname
uodw_stat uodw_stat
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
type tab_dettaglio from tab within w_struttura_tv_tab_ori
tabpage_base tabpage_base
tabpage_stat tabpage_stat
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
tabpage_resp tabpage_resp
tabpage_log tabpage_log
end type
type cbx_blocca from checkbox within w_struttura_tv_tab_ori
end type
end forward

global type w_struttura_tv_tab_ori from w_struttura_tv
integer width = 6519
integer height = 3228
string icon = "typewr_red.ico"
string pointer = "SizeWE!"
event type integer ue_insertitem ( )
event type integer ue_moveitem ( )
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event ue_trasferimenti ( )
event type integer ue_runquerystruttura ( integer ai_qualequery,  integer ai_source )
event type integer ue_querystruttura ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_runquery_offerte ( integer ai_qualequery,  integer ai_source )
tab_dettaglio tab_dettaglio
cbx_blocca cbx_blocca
end type
global w_struttura_tv_tab_ori w_struttura_tv_tab_ori

type variables
boolean ib_modificatastruttura

dataWindowChild idwc_rif
dataWindow idw_dettaglio
dataWindowChild idwc_reportname
string is_codice, is_dataobject
integer iddlb_index= 1, ii_tabindex= 1
integer ii_anno
//s_preview is_preview_s
nca_pdf inca_pdf
u_ds_com ids_com

m_preview im_preview

s_struttura is_strutturatgt_s, is_current_item_s

n_connectservice_ediz in_connectservice_ediz
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

event type integer ue_moveitem();if gi_classediutenza= gc_cons then
	messageBox(this.title, "Operazione non permessa", exclamation!)
	return -1
end if

if  tv_struttura.uf_moveitem(tv_struttura.is_struttura_s.handle) > 0 then
 
// 	tab_dettaglio.selectTab(1)
 
 	return 0//lvf_dettaglio(tv_struttura.is_struttura_s.handle)
	 
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

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_scheda, is_preview_s)
	
//	w_preview_scheda.uodw_current.dataObject= ls_object
	
//	w_preview_scheda.uodw_current.reset()
	
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

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview_scheda, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
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

//w_preview_scheda.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_scheda.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_queryofferte(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret, li_liv_resp
string ls_query, ls_status, ls_cod_div, ls_er, ls_descrizione_struttura, ls_livello_struttura, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
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
			li_ret= w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
		
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
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte per divisione dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_dis", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
		
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
				:li_liv_resp;
				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
				if sqlca.sqlcode= 100 then continue
				
				ll_row= w_preview_scheda.uodw_current.insertRow(0)
				w_preview_scheda.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
				w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte per livelli di responsabilità dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
				w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
				w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
				w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
				
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
			
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
			:li_liv_resp;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			w_preview_scheda.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte analitico dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)	
			w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
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
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte nominativo dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "codice", ls_codice)
			w_preview_scheda.uodw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview_scheda.uodw_current.setItem(ll_row, "nome", ls_nome)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
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
			:ls_er, 
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.uodw_current.insertRow(0)
			w_preview_scheda.uodw_current.setItem(ll_row, "intestazione", "Report offerte per status dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.uodw_current.setItem(ll_row, "cod_dis", ls_status)
			w_preview_scheda.uodw_current.setItem(ll_row, "flag_er", ls_er)
			w_preview_scheda.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			w_preview_scheda.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.uodw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_scheda.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			
//			if ai_source= 1 then
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
//			else
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "livello_master", "generale")	
//				li_ret=w_preview_scheda.uodw_current.setItem(ll_row, "descrizione_master", ": ")					
//			end if
	
		loop
		
end choose

w_preview_scheda.uodw_current.sort()

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

if gi_classediutenza= gc_cons then
	messageBox(this.title, "Operazione non permessa", exclamation!)
	return
end if

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
set vc_parent= :s_struttura_loc.vc_nodo
where codice= :ls_codice;

if trap_sql(sqlca, "UPDATE.TRASF01") < 0 then
	rollback;
	trap_sql(sqlca, "ROLLBACK.TRASF01") 
else
	commit;
	trap_sql(sqlca, "COMMIT.TRASF01") 
end if

if tv_struttura.uf_visualizzanuovoitem(s_struttura_loc.handle)= -1 then return
					
if messageBox(this.title, "Il trasferimento è stato eseguito, vuoi modificare ora i dati anagrafici?", question!, yesNo!, 2)= 2 then

		this.lvf_dettaglio(s_struttura_loc.handle)
					
	else // modifica...

//		idw_dettaglio.retrieve(ls_codice)
		tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
		tab_dettaglio.selectTab(1)
		
		for li_ret= 1 to upperBound(tab_dettaglio.control[])
				
			tab_dettaglio.control[li_ret].visible= true
				
		next
		
		tab_dettaglio.control[2].visible= false
		
		idw_dettaglio.retrieve(ls_codice)
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
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	tv_struttura.is_struttura_s= ll_tvi.data
	
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
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
			li_ret= event ue_querystruttura(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			
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

if messageBox(this.title, "Come conseguenza del cambiamento di stato, questa persona verrà rimossa dalle mailing list in cui è inserita.~n"+&
								"Confermi la rimozione dalle liste?", question!, yesNo!, 2)= 2 then return 0

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
			
//			if tab_dettaglio.selectedTab= 2 /* statistica */ then
//				
//				event ue_properties(s_struttura_loc)
//				
//			end if

			// Ora deve riempire la list view...
			
			// Verifica che esista un nodo child...
			ll_child_handle = tv_struttura.FindItem(childTreeItem!, tvi_handle)
			
			do while ll_child_handle <> -1
				
				// Se esiste ne legge gli attributi...
				
				tv_struttura.getItem(ll_child_handle, ll_tvi)
				
				ll_lvi.data= ll_tvi.data
						
				s_struttura_child= ll_tvi.data
						
				if s_struttura_child.livello <= gi_maxlivello then
				
					ll_lvi.label= f_iniziali(s_struttura_child.descrizione_livello)+": "+f_iniziali(s_struttura_child.descrizione_struttura)
					ll_lvi.pictureIndex= s_struttura_child.livello
					ll_lvi.statePictureIndex= 0
				
				else
					
					// Altrimenti sono persone...
					
					ll_lvi.label= f_iniziali(trim(s_struttura_child.cognome)+" "+trim(s_struttura_child.nome))
				
						if s_struttura_child.cod_dis= 'MEM' and s_struttura_child.flag_er= 'S' then
							ll_lvi.pictureIndex= gi_maxlivello + s_struttura_child.cod_div
						else
							ll_lvi.pictureIndex= 0
						end if
						
					ll_lvi.statePictureIndex=  0
					if s_struttura_child.flag_ldr= '1' then ll_lvi.statePictureIndex=  1
					
					ll_lvi.data= s_struttura_child
					
				end if
		
				ll_lvi.selected= false
				
				// Aggiunge un nuovo item di list view e ne valorizza gli attributi...
				
				li_index= tab_dettaglio.tabpage_base.lv_dettaglio.addItem(ll_lvi) 
				if li_index < 0 then return -1
				
				tab_dettaglio.selectTab(1)
				
				if s_struttura_child.livello > gi_maxlivello then
					
//					tab_dettaglio.selectTab(1)
					 idw_dettaglio.retrieve(s_struttura_loc.codice)

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
					
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 1, f_iniziali(s_struttura_child.cognome+ " " +s_struttura_child.nome) )
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 2, s_struttura_child.divisione)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 3, s_struttura_child.status)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 4, ls_goh)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 5, s_struttura_child.flag_oma)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 6, s_struttura_child.responsabilita1)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 7, s_struttura_child.responsabilita2)
				
				end if
				
				ll_child_handle= tv_struttura.FindItem(nextTreeItem!, ll_child_handle) // cerca gli eventuali altri child...
			
			loop

			if  s_struttura_loc.livello > gi_maxlivello then
				
								
				for li_idx= 1 to upperBound(tab_dettaglio.control[]) -1
				
					tab_dettaglio.control[li_idx].visible= true
				
				next
				
				tab_dettaglio.control[2].visible= false // stats
				
			else
				
				for li_idx= 3 to upperBound(tab_dettaglio.control[]) -1
				
					tab_dettaglio.control[li_idx].visible= false
				
				next
				
				tab_dettaglio.control[2].visible= true // stats
				tab_dettaglio.tabpage_stat.pb_carica.enabled= true
				tab_dettaglio.tabpage_stat.uodw_stat.reset()		
				
			end if
				
				
//			
//			if s_struttura_child.livello <= gi_maxlivello +1 or s_struttura_loc.livello <> gi_maxlivello  then
//		
//				for li_idx= 3 to upperBound(tab_dettaglio.control[])
//				
//					tab_dettaglio.control[li_idx].visible= false
//				
//				next
//				
//				tab_dettaglio.control[2].visible= true // stats
//				tab_dettaglio.tabpage_stat.pb_carica.enabled= true
//				tab_dettaglio.tabpage_stat.uodw_stat.reset()
//				
//			else
//				
//				for li_idx= 3 to upperBound(tab_dettaglio.control[])
//				
//					tab_dettaglio.control[li_idx].visible= true
//				
//				next
//				
//				tab_dettaglio.control[2].visible= false // stats
//				
//			end if
			
			cbx_blocca.visible= false
//			tab_dettaglio.control[2].visible= true // stats
//			tab_dettaglio.tabpage_stat.pb_carica.enabled= true
//			tab_dettaglio.tabpage_stat.uodw_stat.reset()
		
else // tv a  livello persone
	
			if tab_dettaglio.selectedTab > 1 then cbx_blocca.visible= true
			tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
			tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
			
			is_codice= s_struttura_loc.codice
			
			if cbx_blocca.checked= false then 
				tab_dettaglio.selectTab(1)
			else
				if this.wf_modified() < 0 then return -1
				if (NOT isNull(is_codice) ) OR is_codice <> ""  then 
					
//					ll_rows= idw_dettaglio.retrieve(is_codice)
					tab_dettaglio.selectTab(tab_dettaglio.selectedTab)
					
				end if
			end if
			
			for li_idx= 3 to upperBound(tab_dettaglio.control[])
				
					tab_dettaglio.control[li_idx].visible= true
				
			next
			
			tab_dettaglio.control[2].visible= false // stats
			
			///
			if f_is_np(2) = true then tab_dettaglio.tabpage_liste.visible= false
			///
			

end if

this.setRedraw(true)

return 0
end function

on w_struttura_tv_tab_ori.create
int iCurrent
call super::create
this.tab_dettaglio=create tab_dettaglio
this.cbx_blocca=create cbx_blocca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dettaglio
this.Control[iCurrent+2]=this.cbx_blocca
end on

on w_struttura_tv_tab_ori.destroy
call super::destroy
destroy(this.tab_dettaglio)
destroy(this.cbx_blocca)
end on

event open;call super::open;integer li_ret
long ll_handle

ll_handle= AncestorReturnValue

s_session_s.context= "Esplorazione struttura"

in_connectservice_ediz= create n_connectservice_ediz

if in_connectservice_ediz.of_connectdb() <> 0 then return

tab_dettaglio.tabpage_base.uodw_aggiornamento.setTransObject(sqlca)
tab_dettaglio.tabpage_rif.uodw_rif.setTransObject(sqlca)
tab_dettaglio.tabpage_ediz.uodw_pubblicazioni.setTransObject(sqlca_ediz)
tab_dettaglio.tabpage_offerte.uodw_storicocontributi.setTransObject(sqlca)
tab_dettaglio.tabpage_studio.uodw_se.setTransObject(sqlca)
tab_dettaglio.tabpage_goh.uodw_sg.setTransObject(sqlca)

tab_dettaglio.tabpage_rif.uodw_rif.getChild("cod_rif", idwc_rif)

lvf_dettaglio(ll_handle)

im_pop_lv_dettaglio= create m_pop_lv_dettaglio
im_preview= create m_preview

// external dw dei nomi report in tab statistiche
string ls_entries

//idwc_reportname.dataObject= "dw_listobjects"

tab_dettaglio.tabpage_stat.dw_reportname.GetChild('reportname', idwc_reportname)

//ls_entries= libraryDirectory(/*gs_docdir+"\PBL\"+*/gs_reportpath, DirDataWindow!)
ls_entries= libraryDirectory(gs_docdir+"\"+gs_reportpath, DirDataWindow!)

li_ret= idwc_reportname.importString(ls_entries)

idwc_reportname.sort()

tab_dettaglio.tabpage_stat.dw_reportname.insertRow(0)
return ll_handle

end event

event resize;call super::resize;integer li_tabwidth= 750

tv_struttura.width= WorkspaceWidth() - PixelsToUnits ( li_tabwidth,  XPixelsToUnits! ) - 60// - 60

tab_dettaglio.height= /*tv_struttura.height + tv_struttura.y */ this.height - tab_dettaglio.y - 162

//tab_dettaglio.tabpage_base.height= tv_struttura.height //tv_struttura.height // + gb_cerca.height
tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

tab_dettaglio.width=PixelsToUnits ( li_tabwidth,  XPixelsToUnits! )// WorkspaceWidth() - tab_dettaglio.x - 60 

tab_dettaglio.tabpage_base.lv_dettaglio.height= tab_dettaglio.tabpage_base.height - 10
tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30

cbx_blocca.x= tab_dettaglio.x - cbx_blocca.width - 60

//tab_dettaglio.tabpage_base.lv_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30 

//tab_dettaglio.tabpage_base.uodw_aggiornamento.height=tab_dettaglio.tabpage_base.height - 30

//tab_dettaglio.tabpage_dettaglio.uodw_aggiornamento.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.tabpage_base.uodw_aggiornamento.width= tab_dettaglio.tabpage_base.width - 30 

if isValid( idw_dettaglio) then 
	idw_dettaglio.height= tab_dettaglio.tabpage_base.height - 10 //this.height - 30//160// - 30/*- idw_dettaglio.y*/ /*- 30*/
	idw_dettaglio.width= this.width - 30
end if



//		tab_dettaglio.tabpage_rif.uo_dw_rif.width= this.width - 50

/*if isValid( idw_dettaglio) then*/// idw_dettaglio.height= this.height - idw_dettaglio.y - 30
end event

event mousemove;call super::mousemove;if flags= 1 then
	tv_struttura.width= xpos
	cbx_blocca.x= tab_dettaglio.x - cbx_blocca.width - 60
	tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30
	cbx_blocca.x= tab_dettaglio.x - cbx_blocca.width - 60
	tab_dettaglio.width= WorkspaceWidth() - tab_dettaglio.x - 30
end if
end event

event closequery;call super::closequery;if this.wf_riferimenti() = 1 then return 1

if this.wf_modified() < 0 then return 1
end event

event mousedown;call super::mousedown;//if flags= 1 then
//	tv_struttura.width= xpos
//	tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30
//	tab_dettaglio.width= WorkspaceWidth() - tab_dettaglio.x - 30
//end if
end event

event close;call super::close;s_session_s.codice= ""

if in_connectservice_ediz.of_disconnectdb() <> 0 then return
end event

type pb_estesa from w_struttura_tv`pb_estesa within w_struttura_tv_tab_ori
integer y = 4
integer taborder = 50
boolean originalsize = true
alignment htextalign = center!
vtextalign vtextalign = vcenter!
end type

type pb_trova from w_struttura_tv`pb_trova within w_struttura_tv_tab_ori
integer y = 12
end type

type sle_cerca from w_struttura_tv`sle_cerca within w_struttura_tv_tab_ori
integer y = 8
integer width = 1001
integer weight = 700
string pointer = "IBeam!"
long textcolor = 16711680
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_struttura_tv_tab_ori
integer y = 128
borderstyle borderstyle = styleraised!
boolean disabledragdrop = true
boolean checkboxes = true
grsorttype sorttype = userdefinedsort!
end type

event tv_struttura::selectionchanged;call super::selectionchanged;parent.lvf_dettaglio(newHandle)

//tab_dettaglio.tabpage_stat.uodw_stat.reset()
//tab_dettaglio.tabpage_stat.uodw_stat.Object.t_header.Text =""





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

type tab_dettaglio from tab within w_struttura_tv_tab_ori
integer x = 2903
integer y = 16
integer width = 3442
integer height = 3028
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
boolean powertips = true
integer selectedtab = 1
tabpage_base tabpage_base
tabpage_stat tabpage_stat
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
this.tabpage_stat=create tabpage_stat
this.tabpage_rif=create tabpage_rif
this.tabpage_ediz=create tabpage_ediz
this.tabpage_offerte=create tabpage_offerte
this.tabpage_liste=create tabpage_liste
this.tabpage_studio=create tabpage_studio
this.tabpage_goh=create tabpage_goh
this.tabpage_resp=create tabpage_resp
this.tabpage_log=create tabpage_log
this.Control[]={this.tabpage_base,&
this.tabpage_stat,&
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
destroy(this.tabpage_stat)
destroy(this.tabpage_rif)
destroy(this.tabpage_ediz)
destroy(this.tabpage_offerte)
destroy(this.tabpage_liste)
destroy(this.tabpage_studio)
destroy(this.tabpage_goh)
destroy(this.tabpage_resp)
destroy(this.tabpage_log)
end on

event selectionchanging;if oldindex= 3 then
	
		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
		if wf_riferimenti()= 1 then return 1

end if

if parent.wf_modified() < 0 then return -1

cbx_blocca.visible= false
if newindex > 1 then cbx_blocca.visible= true

choose case newindex
		
	case 1
		
		idw_dettaglio= tab_dettaglio.tabpage_base.uodw_aggiornamento
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica"
		
	case 2

		idw_dettaglio= tab_dettaglio.tabpage_stat.uodw_stat
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Statistiche"

	case 3
		
		idw_dettaglio= tab_dettaglio.tabpage_rif.uodw_rif
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Riferimenti"
		
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
	
//			idw_dettaglio.Object.DataWindow.ReadOnly="Yes"
		
//		if tabpage_liste.dw_cod_lista.rowCount() = 0 then 
//			tabpage_liste.dw_cod_lista.setTransObject(sqlca)
//			idw_dettaglio.setTransObject(sqlca)
//			tabpage_liste.dw_cod_lista.retrieve()
//			idw_dettaglio.retrieve(is_codice)
//		end if
	
	
	case 7
		
		idw_dettaglio= tab_dettaglio.tabpage_studio.uodw_se
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Esami"
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_studio.uo_dw_se.retrieve(is_codice)

	case 8
		
		idw_dettaglio= tab_dettaglio.tabpage_goh.uodw_sg
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Gohonzon"
		
	case 9
		
		idw_dettaglio= tab_dettaglio.tabpage_resp.uodw_storico_resp
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Responsabilità"
		
	case 10
		
		idw_dettaglio= tab_dettaglio.tabpage_log.uodw_vislog
		
		idw_dettaglio.setTransObject(sqlca)
		
		
end choose

//if tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex= 2 then
//	
////	parent.event ue_properties(parent.is_struttura_s)
//	
//else


if tv_struttura.is_struttura_s.livello > gi_maxlivello and newindex <>2 then
	
	if NOT isNull(is_codice) OR is_codice <> ""  then
		idw_dettaglio.retrieve(is_codice)
		s_session_s.codice= is_codice
	end if
	
end if


if tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex <>2 then
	
	if NOT isNull(is_codice) OR is_codice <> ""  then
		idw_dettaglio.retrieve(is_codice)
		s_session_s.codice= is_codice
	end if
	
end if

//end if

if isValid(idw_dettaglio) then
	
	if newindex= 2 then
		idw_dettaglio.width=this.width - 60
		idw_dettaglio.height= tv_struttura.height - idw_dettaglio.y
	else
			idw_dettaglio.height=tv_struttura.height
	end if
	
end if

if gi_classediutenza= gc_cons and isValid(idw_dettaglio) and newindex <> 2 then idw_dettaglio.Object.DataWindow.ReadOnly="Yes"




end event

type tabpage_base from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
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
event type integer ue_taglia ( )
integer width = 1385
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 16777215
boolean autoarrange = true
boolean extendedselect = true
boolean fixedlocations = true
boolean labelwrap = false
boolean trackselect = true
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
string statepicturename[] = {"HOUSE.bmp"}
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

tab_dettaglio.setRedraw(false)
	
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
	im_pop_lv_dettaglio.m_offerte.enabled= false
	im_pop_lv_dettaglio.m_consegne.enabled= false
	if gi_classediutenza <= gc_op then im_pop_lv_dettaglio.m_trasferimenti.enabled= true
else
	im_pop_lv_dettaglio.m_report.enabled= true
	im_pop_lv_dettaglio.m_offerte.enabled= true
	im_pop_lv_dettaglio.m_consegne.enabled= true
	im_pop_lv_dettaglio.m_trasferimenti.enabled= false
end if
	

im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )



end event

event columnclick;this.SetRedraw(false)

this.Sort(Ascending! , column)

this.SetRedraw(true)
end event

type uodw_aggiornamento from uodw_generica within tabpage_base
integer width = 3991
integer height = 2848
integer taborder = 100
string dataobject = "dw_anagrafica"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;integer li_ret
long ll_currenthandle
s_struttura s_struttura_s
			
if ancestorreturnvalue < 0 then return -1

choose case dwo.name
		
	case "b_nucleo"
		
		openWithParm(w_visualizza_nuclei, this.getItemString(row, "codice_fam"))
		
//	case "b_m_anag"
		
//		// Cancella l'item di tv relativo alla persona cancellata
//		
//		ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
//				
//		li_ret= tv_struttura.deleteItem(ll_currenthandle)
		
	case "b_aggiorna"
		
//						ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
		
//						tv_struttura.uf_visualizzanuovoitem(tv_struttura.FindItem(parentTreeItem!, ll_currenthandle))
						
//						tv_struttura.uf_cerca_nodo(is_current_item_s.vc_nodo)
		
		if ancestorreturnvalue= 0 and ib_modificatastruttura= true then
			
				tv_struttura.setRedraw(false)
				tab_dettaglio.setRedraw(false)
				
				ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
				tv_struttura.deleteItem(ll_currenthandle)
		
//				if tv_struttura.uf_cerca_nodo(s_struttura_s.vc_nodo)= -1 then return

				tv_struttura.uf_visualizzanuovoitem(is_strutturatgt_s.handle)
				
				tv_struttura.setRedraw(true)
				tab_dettaglio.setRedraw(true)	
				
				ib_modificatastruttura= false
			
		end if
		
		case "b_m_anag"
			
			if gi_classediutenza > gc_dirseg then
				
				messageBox(parent.text, "Operazione non permessa", exclamation!)
				return
				
			end if
			
			open(w_check_pw)
	
			li_ret= message.doubleParm
	
			if li_ret= 1 then
				
				li_ret= uof_modificheincorso()
				
				if li_ret= 3 then return
		
				li_ret= this.uof_cancella()
				
				// Cancella l'item di tv relativo alla persona cancellata
		
			ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
			li_ret= tv_struttura.deleteItem(ll_currenthandle)
				
			end if
		
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
				messageBox(parent.text, "Firma non presente", stopSign!)
				return -1
			end if
			
			inca_pdf.isa_valori[9]= ls_filename // message.stringParm
			
		end if
		
		setPointer(hourGlass!)
		
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
		
		select rtrim(nome)+" "+cognome,
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
						:inca_pdf.isa_valori[4],
						:inca_pdf.isa_valori[5],
						:inca_pdf.isa_valori[6],
						:inca_pdf.isa_valori[7],
						:inca_pdf.isa_valori[8]
				from membri_gerarchica, tab_comuni
				where membri_gerarchica.cod_com= tab_comuni.cod_com and codice= :is_codice;
				
				if trap_sql(sqlca, "LPRESENTAZIONE01") < 0 then return -1
				
		inca_pdf.isa_valori[10]= string(today()) //string(today(), "dd.mm.yyyy")
		
		inca_pdf.isa_valori[2]= lsa_resp[long(mid(inca_pdf.isa_valori[2], 1, 1) ) + 1 ] // responsabilità
		
		inca_pdf.isa_valori[3]= lsa_div[long(inca_pdf.isa_valori[3] ) ] // divisione
		
		inca_pdf.isa_valori[6]= lsa_studio[long(inca_pdf.isa_valori[6] ) + 1 ] // studio
		
		inca_pdf.isa_valori[7]= f_descrizione_struttura(inca_pdf.isa_valori[7])
		
		//		if wf_action(LPRESENTAZIONE, 0) < 0 then return -1
		
		//		return tab_dati.selectTab(tab_dati.tabpage_visualizza)
		
		//		OpenWithParm ( w_lettere_auto, dw_dati.getItemString(dw_dati.getRow(), "codice" ) )
		
		ls_path_ldp= inca_pdf.uof_test(gs_cutepdf, gs_docdir)
		
		if ls_path_ldp= "" then return -1 // errore su file pdf
		
			//////////////////
			s_session_s.context= "Anagrafica: sportello"
			f_log(s_session_s, "Evasa richiesta di lettera di presentazione", true)
			///////////////
		
		//ole_viewer.object.SRC= is_path_ldp
		
		//li_ret= run("'"+gs_pdfreader+"' "+is_path_ldp)
		
//		ls_path_ldp= gs_pdfreader+" "+ls_path_ldp
//		
//		li_ret= run(ls_path_ldp)
//		
//		if li_ret= -1 then messageBox(parent.text, "Non è stato possibile lanciare l'applicazione PDF Reader", exclamation!)

return 0
		
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
		s_assegnastruttura_s.as_struttura_s.livello= gi_maxlivello
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.al_ultimolivelloparent= gi_maxlivello -1
		
		s_struttura_s=  this.uof_struttura(s_assegnastruttura_s)
		
		if s_struttura_s.livello= -1 then return -1
		
		this.object.b_aggiorna.visible= '1'
		
		this.setItem(row, "vc_parent", s_struttura_s.vc_nodo)
		this.setItem(row, "u_ult_mod", s_utente_s.s_nome_esteso)
		this.setItem(row, "d_ult_mod", today())
		
		ib_modificatastruttura= true
		
//		this.object.gb_struttura.text= "Struttura: "+this.getItemString(row, "vc_parent")
		
		is_strutturatgt_s= s_struttura_s
		
//		tv_struttura.setRedraw(false)
//		tab_dettaglio.setRedraw(false)
//		
//		ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
//		
//		tv_struttura.deleteItem(ll_currenthandle)
//
////		if tv_struttura.uf_cerca_nodo(s_struttura_s.vc_nodo)= -1 then return
//		tv_struttura.uf_visualizzanuovoitem(s_struttura_s.handle)
//		
//		tv_struttura.setRedraw(true)
//		tab_dettaglio.setRedraw(true)

	case "b_cap"
		
		integer i_err
		string ls_cap, ls_loc
		
		s_strade s_strade_s
		
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

event itemchanged;call super::itemchanged;integer i_err, li_exists
long ll_rows
boolean first_time = true
string ls_data, search_string, old_comune, ls_nuovaOrganizzazione, ls_message

ids_com= create u_ds_com
ids_com.setTransObject(sqlca)

if row <= 0 then return -1
	
//	s_session_s.context= "Anagrafica"
	
	data = trim ( data )
	
	old_comune= data

	CHOOSE CASE dwo.name
			
		case "citta_nas"
			
			ls_message= "Cittaà nascita: "+this.getItemString(row, "citta_nas")+" - Modificato in: "+data
			
		case "ind_dom"
			
			ls_message= "Domicilio: "+this.getItemString(row, "ind_dom")+" - Modificato in: "+data
			
			if this.getItemString(row, "flag_ldr")= 'S' then
			messageBox(parent.text, "Attenzione, il domicilio di "+this.getItemString(row, "nome")+" "+this.getItemString(row, "cognome")+" è registrato come luogo di riunione.~n"+&
												"Ricordati di verificare se il nuovo domicilio è ancora luogo di riunione.", exclamation!)
			//this.setItem(row, "flag_ldr", 'N')
			
			this.setText('0')
			
			end if
			
		case "flag_ldr"
			
			ls_message= "Luogo di riunione: "+this.getItemString(row, "flag_ldr")+" - Modificato in: "+data
			
		CASE "cognome"

			ls_message= "Cognome: "+this.getItemString(row, "cognome")+" - Modificato in: "+data
			
		CASE "nome"

			ls_message= "Nome: "+this.getItemString(row, "nome")+" - Modificato in: "+data
			
		CASE "cod_div"

			ls_message= "Divisione: "+this.getItemString(row, "cod_div")+" - Modificato in: "+data
			
		CASE "comune"
			
			s_strade s_strade_s
			
			s_strade_s.comune= trim(data)
			
			ls_message= "Comune: "+this.getItemString(row, "comune")+" - Modificato in: "+data
			
			s_strade_s= f_cap(s_strade_s.comune)
			
			choose case s_strade_s.return_code
					
				case 0
					
					messageBox(this.title, "Operazione annullata.", information!)
					
				case -1
					
					return 1
					
				case 1
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					i_err= this.setText ( s_strade_s.comune )
					
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
								
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					return 2
					
				case 2
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					i_err= this.setText ( s_strade_s.comune )
					
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					return 2
					
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
			
//			if f_min ( data ) = 1 then
//				if MessageBox ( parent.title, "E' consentito inserire minorenni solo con il consenso dei genitori."+&
//														"~nAbbiamo il modulo di consenso firmato da ambedue i genitori?" , question!, yesNo!, 2)= 2 then
//					return 1
//				else
//					return 0
//				end if
//			end if
			
//			SetColumn ( "cod_div" )

		case "vc_parent"
			
			ls_message= "Struttura: "+this.getItemString(row, "vc_parent")+" - Modificato in: "+data
			
		case "data_cer"
			
			if date ( mid ( data, 1, 10 ) ) > today ( ) then
				MessageBox ( "Attenzione", "Data posteriore a quella odierna.", exclamation! )
				return 1
			end if
			
			ls_message= "Data cerimonia: "+string(this.getItemDatetime(row, "data_cer"), "dd.mm.yyyy")+" - Modificato in: "+string(date(mid(data, 1, 10)), "dd.mm.yyyy")
			
			SetColumn ( "luogo_cer" )
			
		case "luogo_cer"
			
			ls_message= "Luogo cerimonia: "+this.getItemString(row, "luogo_cer")+" - Modificato in: "+data
			
		case "pres_da"
			
			ls_message= "Presentato da: "+this.getItemString(row, "pres_da")+" - Modificato in: "+data
			
			
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		case "cod_dis"
			
			choose case data
					
				case  "MEM"
					
					if this.getItemString(row, "flag_er") = 'S' /*OR this.getItemString(row, "flag_npa") = 'S'*/  then
						if wf_deletefromliste(is_codice) = -1 then return 0
						SetItem ( row, "flag_dis", "N" )  // Presente
					else
						SetItem ( row, "flag_dis", "S" ) // Assente
					end if
					
				case else
					
					if wf_deletefromliste(is_codice) = -1 then return 0
					SetItem ( row, "flag_dis", "S" )  // Assente
					SetItem ( row, "flag_npa", "S" )  // si resetta il flag npa (default = non partecipa alle attività ) , ha solo senso se lo status è MEM
					
			end choose
			
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
				if wf_deletefromliste(is_codice) = -1 then return 0
				SetItem ( row, "flag_dis", "S" )
			else 
				SetItem ( row, "flag_dis", "N" )
			end if

			ls_message= "Membro dell'ente religioso: "+this.getItemString(row, "flag_er")+" - Modificato in: "+data
			
		case "flag_npa"
			
			if (data = "S") then
				if wf_deletefromliste(is_codice) = -1 then return 0
				//SetItem ( row, "flag_dis", "S" )
			else
				//SetItem ( row, "flag_dis", "N" )
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

return 0

end event

event retrieveend;call super::retrieveend;if rowcount > 0 then
	if isNull(this.getItemString(1, "u_insert") ) then
		this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")+&
											" [Modificato da: "+this.getItemString(1, "u_ult_mod")+&
											" il: "+string(this.getItemDateTime(1, "d_ult_mod"), "dd.mm.yyyy")+"]"
	else
			
		this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")+&
										" [Inserito da: "+this.getItemString(1, "u_insert")+&
											" il: "+string(this.getItemDateTime(1, "d_insert"), "dd.mm.yyyy")+"]"+&
											" [Modificato da: "+this.getItemString(1, "u_ult_mod")+&
											" il: "+string(this.getItemDateTime(1, "d_ult_mod"), "dd.mm.yyyy")+"]"
											
end if
											
//	this.object.gb_struttura.text= "Struttura: "+this.getItemString(1, "vc_parent")
end if
end event

event updatestart;call super::updatestart;//// Aggiorna la tabella storico_resp con i nuovi codici responsabilità...

string ls_cod

if getRow()= 0 then return 0

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

if isNull(this.getItemString(1, "u_insert") ) then
		this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")+&
											" [Modificato da: "+this.getItemString(1, "u_ult_mod")+&
											" il: "+string(this.getItemDateTime(1, "d_ult_mod"), "dd.mm.yyyy")+"]"
	else
			
		this.object.gb_dati.text= "Codice: "+this.getItemString(1, "codice")+&
										" [Inserito da: "+this.getItemString(1, "u_insert")+&
											" il: "+string(this.getItemDateTime(1, "d_insert"), "dd.mm.yyyy")+"]"+&
											" [Modificato da: "+this.getItemString(1, "u_ult_mod")+&
											" il: "+string(this.getItemDateTime(1, "d_ult_mod"), "dd.mm.yyyy")+"]"
											
end if
end event

type tabpage_stat from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 67108864
string text = "Statistiche"
long tabtextcolor = 33554432
string picturename = "Table!"
long picturemaskcolor = 536870912
cb_apri cb_apri
pb_carica pb_carica
st_name st_name
dw_reportname dw_reportname
uodw_stat uodw_stat
end type

on tabpage_stat.create
this.cb_apri=create cb_apri
this.pb_carica=create pb_carica
this.st_name=create st_name
this.dw_reportname=create dw_reportname
this.uodw_stat=create uodw_stat
this.Control[]={this.cb_apri,&
this.pb_carica,&
this.st_name,&
this.dw_reportname,&
this.uodw_stat}
end on

on tabpage_stat.destroy
destroy(this.cb_apri)
destroy(this.pb_carica)
destroy(this.st_name)
destroy(this.dw_reportname)
destroy(this.uodw_stat)
end on

type cb_apri from commandbutton within tabpage_stat
integer x = 2089
integer y = 12
integer width = 521
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Apri in nuova finestra"
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

if uodw_stat.Object.DataWindow.Processing= '4' then // Crosstab dw...
	s_preview_s.doretrieve= false
	openWithParm(w_preview, s_preview_s)
	w_preview.uodw_current.setRedraw(false)
	w_preview.uodw_current.retrieve(s_struttura_loc.vc_nodo+"%", ii_anno, s_struttura_loc.livello/*+2*/)
	w_preview.uodw_current.setRedraw(true)
else
	s_preview_s.doretrieve= false
	openWithParm(w_preview, s_preview_s)
	w_preview.uodw_current.setRedraw(false)
	uodw_stat.shareData(w_preview.uodw_current)
	w_preview.uodw_current.setRedraw(true)
end if

end event

type pb_carica from picturebutton within tabpage_stat
integer x = 1838
integer y = 16
integer width = 110
integer height = 96
integer taborder = 50
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
if uodw_stat.event ue_stats(1)= 0 then
	messageBox( parent.text, "Nessun record estratto.", information!)
else
	cb_apri.enabled= true
end if

return 0
end event

type st_name from statictext within tabpage_stat
integer x = 174
integer y = 36
integer width = 434
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

type dw_reportname from datawindow within tabpage_stat
integer x = 608
integer y = 12
integer width = 1234
integer height = 120
integer taborder = 60
string title = "none"
string dataobject = "edw_reportname"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_syntax, ls_errors

ls_syntax= libraryExport(gs_docdir+"\"+gs_reportpath, data, exportDataWindow!)

if ls_syntax= "" then
	messageBox(parent.text, "Errore in generazione datawindow", exclamation!)
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
idw_dettaglio.setRedraw(true)
end event

type uodw_stat from uodw_generica within tabpage_stat
event type integer ue_stats ( integer index )
integer y = 140
integer width = 2994
integer height = 1736
integer taborder = 90
boolean maxbox = false
boolean resizable = true
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event type integer ue_stats(integer index);long ll_handle, ll_rows
s_struttura s_struttura_loc
treeViewItem ll_tvi

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)

if tv_struttura.GetItem(ll_handle, ll_tvi)= -1 then return -1

s_struttura_loc= ll_tvi.data

//if isValid(this.Object.t_header) then this.Object.t_header.Text = s_struttura_loc.descrizione_livello+" "+ s_struttura_loc.descrizione_struttura

ii_anno= year(today())

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

ll_rows= this.retrieve(s_struttura_loc.vc_nodo+"%", ii_anno, s_struttura_loc.livello/*+2*/)

return ll_rows
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stat

im_preview.m_aggiungi.enabled= false
im_preview.m_inserisci.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false
im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

type tabpage_rif from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 81324524
string text = "Riferimenti"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "Custom020!"
long picturemaskcolor = 536870912
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
integer width = 3086
integer taborder = 50
string dataobject = "dw_riferimenti"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
integer ii_userlevel = 3
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

im_preview.m_aggiungi.enabled= false
im_preview.m_inserisci.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

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
		
		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//		if wf_riferimenti()= 1 then return 1
		
	case "b_invia"
		
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
	
		if len(ls_number)= 10 then ls_number = '39'+ls_number
			
//		if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
				
		mMsg.recipient[1].name= "smsgateway"
				
		mMsg.recipient[1].address=  ls_number+"@"+gs_smsgateway
				
		mMsg.recipient[1].recipientType= mailTO!
		
		li_ret=  f_sendsms(mMsg) 		
		
	end if
		
end choose
end event

event itemchanged;string ls_rif, ls_message

// Non esegue la script ancestor

ls_rif= this.getItemString(row, "cod_rif")

choose case dwo.name
		
case "riferimento_descr"
	
	if ls_rif= "MA" then
		if pos(data, "@")= 0 then
			messageBox(parent.text, "Indirizzo di posta elettronica non valido.", exclamation!)
			return 1
		end if
	end if
	
	ls_message= this.getItemString(row, "riferimento_descr")+" - Modificato in: "+data
	
	f_log(s_session_s, ls_message, false)
	
case "preferito"
	
	long ll_found
	
	this.object.b_aggiorna.visible= true
	
	if data= '1' then
		
		ll_found = this.Find("cod_rif= '"+ls_rif+"' and preferito= '1'", 1, this.RowCount())
		
		if ll_found > 0 then
			
			this.setItem(ll_found, "preferito", '0')
			return 0
			
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

event doubleclicked;call super::doubleclicked;s_riferimenti s_riferimenti_s
s_riferimenti_s.codice= is_codice

if row <= 0 then return 0

s_riferimenti_s.idx= this.getItemDecimal(row, "idx")
s_riferimenti_s.rif_membri= true
openWithParm(w_ins_riferimenti, s_riferimenti_s)
this.retrieve(is_codice)
		
end event

type tabpage_ediz from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 81324524
string text = "Edizioni"
long tabtextcolor = 33554432
string picturename = "Custom003!"
long picturemaskcolor = 536870912
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
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_pubblicazioni

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

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
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 81324524
string text = "Offerte"
long tabtextcolor = 33554432
string picturename = "Custom054!"
long picturemaskcolor = 536870912
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
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_storicocontributi

//im_preview.m_storicoabbonamenti.enabled= false
//im_preview.m_importi.enabled= true
im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;call super::buttonclicked;integer i_ret

if uodw_storicocontributi.Object.importo.Visible= '0' then
	
	open(w_check_pw)
	
	i_ret= message.doubleParm
	
	if i_ret= 1 then
		
		//visualizza gli importi
		uodw_storicocontributi.Object.importo.Visible= 1
		uodw_storicocontributi.Object.importo_t.Visible= 1
		
	end if
	
else
	
	uodw_storicocontributi.Object.importo.Visible= 0
	uodw_storicocontributi.Object.importo_t.Visible= 0
	
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
integer y = 112
integer width = 3406
integer height = 2900
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
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
integer ii_userlevel = 3
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_liste

im_preview.m_aggiungi.enabled= true
im_preview.m_rimuovi.enabled= true
im_preview.m_salva.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

event buttonclicked;// Non deve eseguire la script ancestor

string ls_message

//if f_np(gc_superv)= 1 then return 0

choose case dwo.name
		
	case "b_aggiorna"
		
		ls_message= "Liste: inserito in: "+this.getItemString(row, "cod_lista")
		
		if uof_esegui(gc_aggiornamento) < 0 then return -1
			
		f_log(s_session_s, ls_message, true)	
		this.object.b_aggiorna.visible= false
		
	case "b_p" 
		
		if uof_esegui(gc_inserimento) < 0 then return -1
		
		this.setItem(this.getRow(), "codice", is_codice)
		
		this.resetUpdate()
		
		this.setItemStatus(this.getRow(), 0, Primary!, new!)
	
case "b_m"
	
	ls_message= "Liste: rimosso da: "+this.getItemString(row, "cod_lista")
	
	if uof_esegui(gc_cancellazione) < 0 then return -1
	
	f_log(s_session_s, ls_message, true)	
	
end choose
end event

event itemchanged;call super::itemchanged;long ll_found
string ls_message,	ls_tipo, ls_tipo_rif, ls_cod_lista
s_riferimenti s_riferimenti_s
		
if dwo.name= "cod_lista" then
	
	s_session_s.context= "Anagrafica - Liste"
	
	ls_message= "Liste: inserito in: "+data
	
	ls_cod_lista= data // this.getItemString(row, "cod_lista")
	
	ll_found= find("cod_lista= '"+ls_cod_lista+"'", 1, this.rowCount() )
	
	if ll_found > 0 then
		messageBox(parent.text, "Già presente in questa lista.", information!)
		return 1
	end if
	
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
	
end if
end event

type tabpage_studio from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 81324524
string text = "Esami"
long tabtextcolor = 33554432
string picturename = "Custom083!"
long picturemaskcolor = 536870912
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
integer ii_userlevel = 3
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_se

//im_preview.m_storicoabbonamenti.enabled= false
//im_preview.m_importi.enabled= false
im_preview.m_aggiungi.enabled= true
im_preview.m_inserisci.enabled= true
im_preview.m_rimuovi.enabled= true
im_preview.m_salva.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )

end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row(this)
end event

event itemerror;call super::itemerror;return 1
end event

event buttonclicked;call super::buttonclicked;//if f_np(gc_superv)= 1 then return 0

if dwo.name= "b_p" then
	
	this.setItem(this.getRow(), "codice", is_codice)
	this.resetUpdate()
	
	this.setItemStatus(this.getRow(), 0, Primary!, new!)

end if
end event

type tabpage_goh from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 81324524
string text = "Gohonzon"
long tabtextcolor = 33554432
string picturename = "Custom004!"
long picturemaskcolor = 536870912
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
integer width = 2373
integer taborder = 110
string dataobject = "d_storico_goh"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 3
end type

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

//if f_np(gc_superv)= 1 then return 0

if dwo.name= "b_note" then

	ls_note=  this.getItemString(row, "note")

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

//im_preview.m_storicoabbonamenti.enabled= false
//im_preview.m_importi.enabled= false
im_preview.m_aggiungi.enabled= true
im_preview.m_inserisci.enabled= true
im_preview.m_rimuovi.enabled= true
im_preview.m_salva.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )





end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row(this)
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_resp from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 67108864
string text = "Responsabilità"
long tabtextcolor = 33554432
string picturename = "Run!"
long picturemaskcolor = 536870912
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
integer width = 2734
integer taborder = 70
string dataobject = "dw_storico_resp"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
boolean ib_allowrowselection = true
integer ii_userlevel = 3
end type

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

//if f_np(gc_superv)= 1 then return 0

choose case dwo.name
		
	case "b_aggiorna"
		
//		if ancestorReturnValue= 0 then
		
	case "b_note"

		ls_note=  this.getItemString(row, "note")
	
		openWithParm(w_note, ls_note)
		
		ls_note_old= ls_note
		
		ls_note= message.stringParm
		
		if ls_note <> ls_note_old or isNull(ls_note_old) then
			this.setItem(row, "note", ls_note)
		end if
	
	case "b_p"
	
		this.setItem(this.getRow(), "codice", is_codice)
		this.setItem(this.getRow(), "utente", s_utente_s.s_nome_esteso)
	
		this.resetUpdate()
		
		this.setItemStatus(this.getRow(), 0, Primary!, new!)

end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_storico_resp

im_preview.m_aggiungi.enabled= true
im_preview.m_inserisci.enabled= true
im_preview.m_rimuovi.enabled= true
im_preview.m_salva.enabled= true

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )

end event

type tabpage_log from userobject within tab_dettaglio
integer x = 18
integer y = 112
integer width = 3406
integer height = 2900
long backcolor = 67108864
string text = "Aggiornamenti"
long tabtextcolor = 33554432
string picturename = "ComputeToday5!"
long picturemaskcolor = 536870912
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
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_vislog

im_preview.m_aggiungi.enabled= false
im_preview.m_inserisci.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )
end event

type cbx_blocca from checkbox within w_struttura_tv_tab_ori
integer x = 1490
integer y = 24
integer width = 411
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Blocca scheda"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked= true then
	ii_tabindex= tab_dettaglio.selectedTab
else
	ii_tabindex= 1
end if
	
end event

