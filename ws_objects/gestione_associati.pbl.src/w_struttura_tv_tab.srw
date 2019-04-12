$PBExportHeader$w_struttura_tv_tab.srw
forward
global type w_struttura_tv_tab from w_struttura_tv
end type
type tab_dettaglio from tab within w_struttura_tv_tab
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
type gb_runreport from groupbox within tabpage_andamenti
end type
type rb_4 from radiobutton within tabpage_andamenti
end type
type sle_report_struttura_corrente from singlelineedit within tabpage_andamenti
end type
type rb_3 from radiobutton within tabpage_andamenti
end type
type rb_offertestatus from radiobutton within tabpage_andamenti
end type
type sle_struttura from singlelineedit within tabpage_andamenti
end type
type sle_report from singlelineedit within tabpage_andamenti
end type
type dw_reportname from datawindow within tabpage_andamenti
end type
type rb_2 from radiobutton within tabpage_andamenti
end type
type rb_1 from radiobutton within tabpage_andamenti
end type
type rb_stampabollettini from radiobutton within tabpage_andamenti
end type
type rb_offerteresp from radiobutton within tabpage_andamenti
end type
type cb_runreport from commandbutton within tabpage_andamenti
end type
type rb_offerte from radiobutton within tabpage_andamenti
end type
type rb_offertediv from radiobutton within tabpage_andamenti
end type
type cb_apri from commandbutton within tabpage_andamenti
end type
type gb_report from groupbox within tabpage_andamenti
end type
type sle_runreport from singlelineedit within tabpage_andamenti
end type
type rb_organigramma from radiobutton within tabpage_andamenti
end type
type rb_offertetab from radiobutton within tabpage_andamenti
end type
type tabpage_andamenti from userobject within tab_dettaglio
gb_runreport gb_runreport
rb_4 rb_4
sle_report_struttura_corrente sle_report_struttura_corrente
rb_3 rb_3
rb_offertestatus rb_offertestatus
sle_struttura sle_struttura
sle_report sle_report
dw_reportname dw_reportname
rb_2 rb_2
rb_1 rb_1
rb_stampabollettini rb_stampabollettini
rb_offerteresp rb_offerteresp
cb_runreport cb_runreport
rb_offerte rb_offerte
rb_offertediv rb_offertediv
cb_apri cb_apri
gb_report gb_report
sle_runreport sle_runreport
rb_organigramma rb_organigramma
rb_offertetab rb_offertetab
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
type rb_oma_sd from radiobutton within tabpage_goh
end type
type rb_tok_sd from radiobutton within tabpage_goh
end type
type rb_oka_sd from radiobutton within tabpage_goh
end type
type st_5 from statictext within tabpage_goh
end type
type st_4 from statictext within tabpage_goh
end type
type em_data from editmask within tabpage_goh
end type
type em_luogo from editmask within tabpage_goh
end type
type cb_esegui from commandbutton within tabpage_goh
end type
type st_3 from statictext within tabpage_goh
end type
type st_2 from statictext within tabpage_goh
end type
type st_1 from statictext within tabpage_goh
end type
type rb_oma_s from radiobutton within tabpage_goh
end type
type rb_oka_s from radiobutton within tabpage_goh
end type
type rb_oma_r from radiobutton within tabpage_goh
end type
type rb_tok_r from radiobutton within tabpage_goh
end type
type rb_oka_r from radiobutton within tabpage_goh
end type
type rb_oma_a from radiobutton within tabpage_goh
end type
type rb_tok_a from radiobutton within tabpage_goh
end type
type st_oma from statictext within tabpage_goh
end type
type p_oma from picture within tabpage_goh
end type
type st_tok from statictext within tabpage_goh
end type
type p_tok from picture within tabpage_goh
end type
type st_oka from statictext within tabpage_goh
end type
type p_oka from picture within tabpage_goh
end type
type uodw_sg from uodw_generica within tabpage_goh
end type
type rb_tok_s from radiobutton within tabpage_goh
end type
type rb_oka_a from radiobutton within tabpage_goh
end type
type rb_oka_tok from radiobutton within tabpage_goh
end type
type gb_status from groupbox within tabpage_goh
end type
type tabpage_goh from userobject within tab_dettaglio
rb_oma_sd rb_oma_sd
rb_tok_sd rb_tok_sd
rb_oka_sd rb_oka_sd
st_5 st_5
st_4 st_4
em_data em_data
em_luogo em_luogo
cb_esegui cb_esegui
st_3 st_3
st_2 st_2
st_1 st_1
rb_oma_s rb_oma_s
rb_oka_s rb_oka_s
rb_oma_r rb_oma_r
rb_tok_r rb_tok_r
rb_oka_r rb_oka_r
rb_oma_a rb_oma_a
rb_tok_a rb_tok_a
st_oma st_oma
p_oma p_oma
st_tok st_tok
p_tok p_tok
st_oka st_oka
p_oka p_oka
uodw_sg uodw_sg
rb_tok_s rb_tok_s
rb_oka_a rb_oka_a
rb_oka_tok rb_oka_tok
gb_status gb_status
end type
type tabpage_resp from userobject within tab_dettaglio
end type
type uodw_storico_resp from uodw_generica within tabpage_resp
end type
type tabpage_resp from userobject within tab_dettaglio
uodw_storico_resp uodw_storico_resp
end type
type tabpage_studenti from userobject within tab_dettaglio
end type
type uodw_studenti from uodw_generica within tabpage_studenti
end type
type tabpage_studenti from userobject within tab_dettaglio
uodw_studenti uodw_studenti
end type
type tabpage_log from userobject within tab_dettaglio
end type
type uodw_vislog from uodw_generica within tabpage_log
end type
type tabpage_log from userobject within tab_dettaglio
uodw_vislog uodw_vislog
end type
type tab_dettaglio from tab within w_struttura_tv_tab
tabpage_base tabpage_base
tabpage_andamenti tabpage_andamenti
tabpage_rif tabpage_rif
tabpage_ediz tabpage_ediz
tabpage_offerte tabpage_offerte
tabpage_liste tabpage_liste
tabpage_studio tabpage_studio
tabpage_goh tabpage_goh
tabpage_resp tabpage_resp
tabpage_studenti tabpage_studenti
tabpage_log tabpage_log
end type
type cb_ricercaanomalie from commandbutton within w_struttura_tv_tab
end type
type shl_altritipi from statichyperlink within w_struttura_tv_tab
end type
end forward

global type w_struttura_tv_tab from w_struttura_tv
integer width = 6519
integer height = 3156
string icon = "typewr_red.ico"
string pointer = "Arrow!"
event type integer ue_insertitem ( )
event type integer ue_moveitem ( )
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_trasferimenti ( )
event type integer ue_runquerystruttura ( integer ai_qualequery,  integer ai_source )
event type integer ue_querystruttura ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_runquery_offerte ( integer ai_qualequery,  integer ai_source )
event type integer ue_modifyitem ( )
event type integer ue_postopen ( )
event type integer ue_runquery_abbonamenti ( integer ai_source )
event type long ue_runreport ( integer ai_qualequery,  integer ai_source )
event type integer ue_bollettini ( s_preview as_preview_s )
event type integer ue_mcompleta ( )
event type integer ue_queryorg ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  long al_livello_sup )
event type integer ue_runqueryorg ( integer ai_qualequery,  integer ai_source )
event type integer ue_run_completa ( integer ai_source )
tab_dettaglio tab_dettaglio
cb_ricercaanomalie cb_ricercaanomalie
shl_altritipi shl_altritipi
end type
global w_struttura_tv_tab w_struttura_tv_tab

type variables
boolean ib_modificatastruttura, ib_componentenucleo= false
dataWindowChild idwc_rif
uodw_generica idw_dettaglio
dataWindowChild idwc_reportname
dataWindowChild idwc_cod_dis

string is_codice_fam, is_dataobject
integer iddlb_index= 1, ii_tabindex= 1
integer ii_selreport, ii_ruolo_rga, ii_utente_abilitato

long il_modifiedhandle

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
public function integer lvf_dettaglio (long tvi_handle)
public function integer wf_assegnatario ()
public function integer wf_componente ()
public function integer wf_handle_rb ()
public function integer wf_checkstatus ()
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

open(w_criteri_estrazione) // data

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

	is_preview_s.dataObject= ls_object
	//is_preview_s.ib_sort= true
	
	openWithParm(w_preview, is_preview_s)
	
	setpointer(hourGlass!)
	
	w_preview.uodw_current.setRedraw(false)
	
	open(w_wait_snoopy)

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
		
		close(w_wait_snoopy)
	
else // la query viene richiesta dalla list view...

	is_preview_s.dataObject= ls_object
	// is_preview_s.ib_sort= true
	
	openWithParm(w_preview, is_preview_s)
		
		w_preview.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview.uodw_current.setRedraw(false)
		
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			s_struttura_loc= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
		next

end if

w_preview.uodw_current.groupCalc()

w_preview.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_queryofferte(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret, li_liv_resp
string ls_nodo, ls_query, ls_status, ls_cod_div, ls_er, ls_descrizione_struttura, ls_livello_struttura, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli, ls_npa
long ll_totale_persone, ll_row, ll_npa, ll_totale_versanti, ll_totale_versantiU,ll_totale_versantiD, ll_totale_versantiGU, ll_totale_versantiGD, ll_totale_personeU, ll_totale_personeD, ll_totale_personeGU, ll_totale_personeGD
decimal ld_importo

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

		ls_query= f_creaqueryofferte(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		 //messageBox("test", ls_query)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO
			:ls_livello_struttura, 
			:ld_importo,
			:ll_totale_versanti,
			:ll_totale_persone,
			:ll_npa,
			:ls_descrizione_struttura;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview.uodw_current.insertRow(0)
			li_ret= w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)
			li_ret= w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			li_ret=w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview.uodw_current.setItem(ll_row, "versanti", ll_totale_versanti)
			li_ret=w_preview.uodw_current.setItem(ll_row, "persone", ll_totale_persone)
			li_ret=w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			if ai_source= 1 then
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", "")	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", "")					
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
			:ll_totale_versantiU,
			:ll_totale_personeU,			
			:ll_totale_versantiD,
			:ll_totale_personeD,			
			:ll_totale_versantiGU,
			:ll_totale_personeGU,			
			:ll_totale_versantiGD,		
			:ll_totale_personeGD,		
			:ll_npa,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview.uodw_current.insertRow(0)
			w_preview.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
			w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte per divisione dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview.uodw_current.setItem(ll_row, "versantiU", ll_totale_versantiU)
			w_preview.uodw_current.setItem(ll_row, "personeU", ll_totale_personeU)			
			w_preview.uodw_current.setItem(ll_row, "versantiD", ll_totale_versantiD)
			w_preview.uodw_current.setItem(ll_row, "personeD", ll_totale_personeD)			
			w_preview.uodw_current.setItem(ll_row, "versantiGU", ll_totale_versantiGU)
			w_preview.uodw_current.setItem(ll_row, "personeGU", ll_totale_personeGU)			
			w_preview.uodw_current.setItem(ll_row, "versantiGD", ll_totale_versantiGD)		
			w_preview.uodw_current.setItem(ll_row, "personeGD", ll_totale_personeGD)	
			w_preview.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
//			if ai_source= 1 then
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
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
				:ll_totale_versanti,
				:ll_totale_persone,				
				:ll_npa,
				:ls_descrizione_struttura,
				:li_liv_resp;
				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
				if sqlca.sqlcode= 100 then continue
				
				ll_row= w_preview.uodw_current.insertRow(0)
				w_preview.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
				w_preview.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
				w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte per livelli di responsabilità dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
				w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
				w_preview.uodw_current.setItem(ll_row, "versanti", ll_totale_versanti)
				w_preview.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
				
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			
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
			:ll_totale_versanti,
			:ll_totale_persone,
			:ll_npa,
			:ls_descrizione_struttura,
			:ls_cod_div,
			:li_liv_resp;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview.uodw_current.insertRow(0)
			w_preview.uodw_current.setItem(ll_row, "vc_nodo", ls_nodo)
			w_preview.uodw_current.setItem(ll_row, "liv_resp", li_liv_resp)
			w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte analitico dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview.uodw_current.setItem(ll_row, "versanti", ll_totale_versanti)	
			w_preview.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview.uodw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
		
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
			
			ll_row= w_preview.uodw_current.insertRow(0)
			w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte nominativo dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview.uodw_current.setItem(ll_row, "status", ls_status)
			w_preview.uodw_current.setItem(ll_row, "totale_npa", ll_npa)
			w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview.uodw_current.setItem(ll_row, "codice", ls_codice)
			w_preview.uodw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview.uodw_current.setItem(ll_row, "nome", ls_nome)
			w_preview.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
			
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	

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
			:ll_totale_versanti,
			:ll_totale_persone,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview.uodw_current.insertRow(0)
			w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)
			w_preview.uodw_current.setItem(ll_row, "intestazione", "Report offerte per status dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview.uodw_current.setItem(ll_row, "cod_dis", ls_status)
			w_preview.uodw_current.setItem(ll_row, "flag_npa", ls_npa)
			w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
			w_preview.uodw_current.setItem(ll_row, "versanti", ll_totale_versanti)
			w_preview.uodw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	

		loop
		
end choose

w_preview.uodw_current.sort()

CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0

closecur: CLOSE my_cursor ;
			 trap_sql(sqlca, "QUERY03") 

return -1


end event

event type integer ue_trasferimenti();integer li_ret
listViewItem llvi_dettaglio
treeViewItem ltvi_struttura, ltvi_newitem

long ll_handle, ll_todelete
string ls_codice, ls_message, ls_resp1, ls_resp2, ls_staff
s_struttura s_struttura_loc
s_session ls_session_s

ls_session_s= s_session_s

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
li_ret= tv_struttura.getItem(ll_handle, ltvi_struttura)

if li_ret <= 0 then return 0

s_struttura_loc= ltvi_struttura.data

if s_struttura_loc.livello < gi_maxlivello then return 0

s_ricerca s_ricerca_s

open(w_ricerca_associati_small)

s_ricerca_s= message.powerObjectParm

if s_ricerca_s.i_retcode= -1 then return 0

ls_codice= s_ricerca_s.codice

if ls_codice = "" then return 0

/* in sospeso, lasciando il commento, se una persona viene trasferita resta nella lista esami di origine; in questo modo gli può essere attribuito
  * il voto considerato che il suo compito è lì, l'unico problema può essere il diploma nel senso che può essere stato inviato nella vecchia struttura.
  * if f_verificalistaesame(ls_codice, s_struttura_loc.vc_nodo)< 0 then return
  */

if messageBox(this.title, "Confermi il trasferimento?", question!, yesNo!, 2)= 2 then return 0

update membri_gerarchica
set vc_parent= :s_struttura_loc.vc_nodo, flag_ldr= 'N'
where codice= :ls_codice;

if trap_sql(sqlca, "UPDATE.TRASF01") < 0 then goto errore

if f_confermaresponsabilita(ls_codice, s_ricerca_s.struttura, s_struttura_loc.vc_nodo) < 0 then goto errore

/* tolta per richiesta di Maki/Clara 08/07/2013
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
*/

setRedraw(false)

if tv_struttura.uf_visualizzanuovoitem(s_struttura_loc.handle)= -1 then return 0

ls_session_s.codice= ls_codice
ls_session_s.struttura_src= s_ricerca_s.struttura
ls_session_s.struttura_tgt= s_struttura_loc.vc_nodo
ls_message= "Struttura: "+s_ricerca_s.struttura+" - Modificato in: "+s_struttura_loc.vc_nodo
ls_session_s.context= "Trasferimento"

f_log(ls_session_s, ls_message, true)

//messageBox("test", ls_message)
					
//if messageBox(this.title, "Il trasferimento è stato eseguito, vuoi modificare ora i dati anagrafici?", question!, yesNo!, 2)= 2 then

		//this.lvf_dettaglio(s_struttura_loc.handle)
		
		ll_handle= tv_struttura.uf_cerca_nodo(s_struttura_loc.vc_nodo)
		
setRedraw(true)		

if ll_handle > 0 then messageBox(this.title, "Il trasferimento è stato eseguito, ora puoi  modificare ora i dati anagrafici.", information!)
					
	commit;
	trap_sql(sqlca, "COMMIT.TRASF") 
	
	return 0

errore:

	rollback;
	trap_sql(sqlca, "ROLLBACK.TRASF") 
	
	return -1


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
		
		open(w_criteri_estrazione)
		
		s_data_s= message.powerObjectParm
		
		if isNull(s_data_s.ls_da) then return -1		
		
	case 2
		ls_object= 'edw_reportcerimonieanno'
		
		open(w_anno)
		
		s_data_s.ls_da= string(message.DoubleParm) // anno
		
		if isNull(s_data_s.ls_da) then return -1		
		
	case 3
		ls_object= 'edw_reportcerimonieconfronto'
		
		open(w_anno)
		
		s_data_s.ls_da= string(message.DoubleParm) // anno
		
		if isNull(s_data_s.ls_da) then return -1				
		
end choose

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
	is_preview_s.ib_append= true
	is_preview_s.ib_sort= true
	
	openWithParm(w_preview, is_preview_s)
	
//	w_preview_scheda.uodw_current.dataObject= ls_object
	
//	w_preview_scheda.uodw_current.reset()
	
	setpointer(hourGlass!)
	
	w_preview.uodw_current.setRedraw(false)
	
	open(w_wait_snoopy)

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
		
		close(w_wait_snoopy)
	
else // la query viene richiesta dalla list view...
	
	is_preview_s.ib_append= true

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview.uodw_current.setRedraw(false)
	
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			s_struttura_loc=  ll_lvi.data
		
			li_ret= event ue_querystruttura(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
		next

end if

w_preview.uodw_current.groupCalc()

//w_preview_cerimonie.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview.uodw_current.setRedraw(true)

return li_ret
end event

event type integer ue_querystruttura(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, s_data as_data_s);integer li_ret
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row, ll_totale_memprec, ll_tai_anno, ll_tfe_anno, ll_dec_anno
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
			
			ll_row= w_preview.uodw_current.insertRow(0)
			li_ret=w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)
			li_ret=w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "anno", li_anno)
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_cer", ldt_data_cer)
			li_ret=w_preview.uodw_current.setItem(ll_row, "luogo_cer", ls_luogo_cer)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_goh", ll_u_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_fed", ll_u_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_goh", ll_d_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_fed", ll_d_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_goh", ll_gu_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_fed", ll_gu_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_goh", ll_gd_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_fed", ll_gd_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_da", as_data_s. ls_da)				
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_a", as_data_s.ls_a)	
			
			if ai_source= 1 then
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)					
			end if
		
		loop
		
		w_preview.uodw_current.sort()
		
	case 2
		
		ls_query= f_creaqueryconsegne(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:li_anno,
			:ll_u_goh,
			:ll_u_fed,
			:ll_d_goh,
			:ll_d_fed,
			:ll_gu_goh,
			:ll_gu_fed,
			:ll_gd_goh,
			:ll_gd_fed,
			:ls_descrizione_struttura,
			:ll_totale_memprec,
			:ll_tai_anno,
			:ll_tfe_anno,
			:ll_dec_anno;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview.uodw_current.insertRow(0)
//			li_ret= w_preview.uodw_current.setItem(ll_row, "intestazione", "Consegne dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "anno", li_anno)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_goh", ll_u_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_fed", ll_u_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_goh", ll_d_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_fed", ll_d_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_goh", ll_gu_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_fed", ll_gu_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_goh", ll_gd_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_fed", ll_gd_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_da", as_data_s. ls_da)				
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_a", as_data_s.ls_a)				
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_memprec", ll_totale_memprec)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_tai_anno", ll_tai_anno)		
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_tfe_anno", ll_tfe_anno)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_dec_anno", ll_dec_anno)	
			
			if ai_source= 1 then
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			end if
		
		loop
		
		w_preview.uodw_current.sort()
		
	case 3
		
		ls_query= f_creaqueryconsegneaconfronto(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:li_anno,
			:ll_u_goh,
			:ll_u_fed,
			:ll_d_goh,
			:ll_d_fed,
			:ll_gu_goh,
			:ll_gu_fed,
			:ll_gd_goh,
			:ll_gd_fed,
			:ls_descrizione_struttura,
			:ll_totale_memprec,
			:ll_tai_anno,
			:ll_tfe_anno,
			:ll_dec_anno;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview.uodw_current.insertRow(0)
//			li_ret= w_preview.uodw_current.setItem(ll_row, "intestazione", "Consegne dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview.uodw_current.setItem(ll_row, "anno", li_anno)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_goh", ll_u_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "u_fed", ll_u_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_goh", ll_d_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "d_fed", ll_d_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_goh", ll_gu_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gu_fed", ll_gu_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_goh", ll_gd_goh)
			li_ret=w_preview.uodw_current.setItem(ll_row, "gd_fed", ll_gd_fed)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "vc_nodo", as_nodo)
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_da", as_data_s. ls_da)				
			li_ret=w_preview.uodw_current.setItem(ll_row, "data_a", as_data_s.ls_a)				
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_memprec", ll_totale_memprec)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_tai_anno", ll_tai_anno)		
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_tfe_anno", ll_tfe_anno)	
			li_ret=w_preview.uodw_current.setItem(ll_row, "totale_dec_anno", ll_dec_anno)	
			
			if ai_source= 1 then
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			else
				li_ret=w_preview.uodw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)
				li_ret=w_preview.uodw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura)	
			end if
		
		loop
		
		w_preview.uodw_current.sort()


		
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
//			ll_row= w_preview.uodw_current.insertRow(0)
//			w_preview.uodw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
//			w_preview.uodw_current.setItem(ll_row, "status", ls_status)
//			w_preview.uodw_current.setItem(ll_row, "importo", ld_importo)
//			w_preview.uodw_current.setItem(ll_row, "codice", ls_codice)
//			w_preview.uodw_current.setItem(ll_row, "cognome", ls_cognome)
//			w_preview.uodw_current.setItem(ll_row, "nome", ls_nome)
//			w_preview.uodw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
//			w_preview.uodw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
//			w_preview.uodw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
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

// evento non utilizzato...

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

//open(w_criteri_estrazione)
//
//s_data_s= message.powerObjectParm
//
//if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
			
			li_livello_raggruppamento= gi_maxlivello
			
		else
		
			openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
		
			li_livello_raggruppamento= message.doubleParm
			
			if li_livello_raggruppamento= 0 then return -1
			
		end if

	is_preview_s.dataObject= ls_object
	is_preview_s.doretrieve= false
	is_preview_s.ib_anteprima= true
	is_preview_s.ib_append= true
	is_preview_s.ib_dwcreate= false
	is_preview_s.ib_sort= false	
	
	openWithParm(w_preview, is_preview_s)
	
	if is_preview_s.doretrieve= true then goto vaiqua
	
		setpointer(hourGlass!)
		
		w_preview.uodw_current.setRedraw(false)
		
		open(w_wait_snoopy)
		
		ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+&
							" and vc_nodo like '"+tv_struttura.is_struttura_s.vc_nodo+"%'"
							//" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo))+") = '"+tv_struttura.is_struttura_s.vc_nodo+"'"
	
		DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC query_cur ;
		if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1
		
		li_anno= year(today())
	
			do while sqlca.sqlcode <> 100
				
				fetch query_cur into
				:ls_nodo;
				if sqlca.sqlcode= 100 then continue
				
				li_ret= 	w_preview.uodw_current.retrieve(ls_nodo, li_livello_raggruppamento)
				
				if li_ret= -1 then exit
		
			loop
			
			close query_cur;
			
			close(w_wait_snoopy)
		
		vaiqua:
	
else // la query viene richiesta dalla list view...

	is_preview_s.dataObject= ls_object
	is_preview_s.doretrieve= false
	is_preview_s.ib_anteprima= false //true
	is_preview_s.ib_sort= true
	is_preview_s.ib_append= true
	
	openWithParm(w_preview, is_preview_s)
		
		w_preview.uodw_current.reset()
		
		setpointer(hourGlass!)
		
		w_preview.uodw_current.setRedraw(false)
	
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			s_struttura_loc=  ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
		next

end if

w_preview.uodw_current.groupCalc()

w_preview.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview.uodw_current.setRedraw(true)

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

/* Accede al DB Edizioni */

sqlca_ediz= create transaction

db_connection.uof_getinipar(gc_DBEDIZ)

db_connection.is_connectionparm_s.logid= "ga.user"
//db_connection.is_connectionparm_s.logpass=  "t3C=an-wRaFe"
db_connection.is_connectionparm_s.logpass=  "gauser"


if db_connection.uof_connectdb(sqlca_ediz) < 0 then return -1

li_idx= tab_dettaglio.tabpage_ediz.uodw_pubblicazioni.setTransObject(sqlca_ediz)

open(w_segnala_anomalie)

return 0
end event

event type integer ue_runquery_abbonamenti(integer ai_source);integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento
//long ll_handle
//string ls_object= 'dw_test_report_riviste', ls_nodo, ls_query
//s_struttura s_struttura_loc
//s_data s_data_s
//listViewItem ll_lvi
//treeviewItem ll_tvi
//
////open(w_criteri_estrazione)
////
////s_data_s= message.powerObjectParm
////
////if isNull(s_data_s.ls_da) then return -1
//
//if ai_source= 1 then // la query viene richiesta dal treeView...
//	
////	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
////	
////	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
////	
////	tv_struttura.is_struttura_s= ll_tvi.data
//	
//		if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
//			
//			li_livello_raggruppamento= gi_maxlivello
//			
//		else
//		
//			openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
//		
//			li_livello_raggruppamento= message.doubleParm
//			
//			if li_livello_raggruppamento= 0 then return -1
//			
//		end if
//
//	is_preview_s.dataObject= ls_object
//	is_preview_s.ib_dwcreate= false
//	is_preview_s.doretrieve= false
//	
//	openWithParm(w_preview_abbonamenti, is_preview_s)
//	
//	setpointer(hourGlass!)
//	
//	w_preview_abbonamenti.uodw_current.setRedraw(false)
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
////			li_ret= event ue_queryofferte(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, s_data_s)
//			w_preview_abbonamenti.uodw_current.retrieve(ls_nodo, 0, li_livello_raggruppamento)
//			
//			if li_ret= -1 then exit
//	
//		loop
//		
//		close query_cur;
//	
//else // la query viene richiesta dalla list view...
//	
//	ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
//
//	is_preview_s.dataObject= ls_object
//	
//	openWithParm(w_preview_scheda, is_preview_s)
//		
////		w_preview_scheda.uodw_current.dataObject= ls_object
//		
//		w_preview_scheda.uodw_current.reset()
//		
//		setpointer(hourGlass!)
//		
//		w_preview_scheda.uodw_current.setRedraw(false)
//	
//		do while ll_handle <> -1
//			
//			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
//			
//			tv_struttura.is_struttura_s= ll_lvi.data
//		
////			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
//			w_preview_scheda.uodw_current.retrieve(tv_struttura.is_struttura_s.vc_nodo, tv_struttura.is_struttura_s.livello, 0)
//			
//			if li_ret= -1 then exit
//			
//			ll_handle = tab_dettaglio.tabpage_base.lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
//			
//		loop
//
//end if
//
//w_preview_abbonamenti.uodw_current.groupCalc()
//
////w_preview_scheda.uodw_current.Object.DataWindow.Print.Preview= 'Yes'
//
//w_preview_abbonamenti.uodw_current.setRedraw(true)
//
return li_ret
end event

event type long ue_runreport(integer ai_qualequery, integer ai_source);integer li_livello_raggruppamento, li_pos_raggruppamento, li_howmany, li_ret
long ll_handle, ll_ret
string ls_object, ls_nodo, ls_query
//s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
		
	case 1
		ls_object= 'dw_conteggio_per_livelli'
	case 2
		ls_object= 'dw_storico_consegne_anno'
	case 3
		ls_object= 'dw_storico_consegne_data_25032013'
	case 4
		ls_object= 'dw_consegneperiodo_perdiv'

end choose

is_preview_s.dataObject= ls_object
is_preview_s.ib_dwcreate= false
is_preview_s.transobject= sqlca

this.setRedraw(false)

if ai_source= 1 then // la query viene richiesta dal treeView...
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	ll_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	tv_struttura.is_struttura_s= ll_tvi.data
	
	
	open(w_criteri_estrazione)
	
	s_data_s= message.PowerObjectParm
	
	if tv_struttura.is_struttura_s.livello = gi_maxlivello -1 then
	
		li_livello_raggruppamento= gi_maxlivello
	
	else
	
		openWithParm(w_selezione_livello, tv_struttura.is_struttura_s.livello)
	
		li_livello_raggruppamento= message.doubleParm
		
		if li_livello_raggruppamento= 0 then return -1
		
	end if
	
	is_preview_s.doretrieve= false
	is_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
	is_preview_s.livello= li_livello_raggruppamento
	
	openWithParm(w_preview, is_preview_s)
	
	if is_preview_s.doretrieve= false then
	
		setpointer(hourGlass!)
		
		w_preview.uodw_current.setRedraw(false)
		
		open(w_wait_snoopy)
	
				ll_ret= w_preview.uodw_current.retrieve(is_preview_s.criterio, s_data_s.ls_da, s_data_s.ls_a, is_preview_s.livello )
			
	//			w_preview.uodw_current.groupCalc()
				
				if li_ret= -1 then return -1
				
		close(w_wait_snoopy)		
		
		w_preview.uodw_current.setRedraw(true)
	
	end if
	
else // la query viene richiesta dalla list view...

	is_preview_s.doretrieve= false
	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview, is_preview_s)
	
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			//s_struttura_loc= ll_lvi.data
			
			ll_ret= w_preview.uodw_current.retrieve(is_preview_s.criterio, s_data_s.ls_da, s_data_s.ls_a, is_preview_s.livello )
			
			if ll_ret= -1 then exit		
						
		next
		
		w_preview.uodw_current.groupCalc()

end if

this.setRedraw(true)

return ll_ret
end event

event type integer ue_bollettini(s_preview as_preview_s);integer li_ret

w_preview iw_bollettini

if as_preview_s.tipo_stampa= "N" then // nominativo... 
	as_preview_s.dataObject= "r_boll_sing_codice"
else // stampa di bollettini per struttura...
	as_preview_s.dataObject= "r_boll_sing_nodo"
end if

as_preview_s.doretrieve= true
as_preview_s.ib_anteprima= true

li_ret= openWithParm(iw_bollettini, as_preview_s)

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

event type integer ue_queryorg(integer ai_qualequery, integer ai_source, long al_livello, string as_nodo, long al_livello_sup);long ll_row
//string ls_struttura_livello

//ls_struttura_livello= f_parse_struttura(as_nodo, al_livello)

//DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

			//ll_row= w_preview.uodw_current.retrieve(as_nodo, 0, al_livello, al_livello_sup)
			ll_row= w_preview.uodw_current.retrieve(as_nodo, al_livello, al_livello_sup)

		case 2
			
			ll_row= w_preview.uodw_current.retrieve(as_nodo, 0, al_livello, al_livello_sup)
			

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
		ls_object= 'dw_organigramma' // organigramma
	case 2
		ls_object= 'dw_qg_struttura'
//	case 3
//		ls_object= 'dw_conteggio'
//	case 4
//		ls_object= 'dw_queryofferte_tab'
//	case 5
//		ls_object= 'dw_queryofferte_dettaglio'
end choose

//is_preview_s.dataObject= ls_object
//is_preview_s.ib_dwcreate= false
//is_preview_s.doretrieve= false
//is_preview_s.transObject= sqlca
//is_preview_s.ib_append= true

if ai_source= 1 then // la query viene richiesta dal treeView...
	
		if tv_struttura.is_struttura_s.livello = gi_maxlivello /*-1*/ then // mod il 25/05/09 GdS
			
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

	is_preview_s.dataObject= ls_object
	is_preview_s.ib_dwcreate= false
	is_preview_s.doretrieve= false
	is_preview_s.transObject= sqlca
	is_preview_s.ib_append= true
	
	openWithParm(w_preview, is_preview_s)
	
	w_preview.uodw_current.setredraw(false)
	
	open(w_wait_snoopy)
	
//	if li_livello_raggruppamento= tv_struttura.is_struttura_s.livello then
//		
//		ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and vc_nodo= '"+tv_struttura.is_struttura_s.vc_nodo+"'"
//		
//	else
//		
//		ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(tv_struttura.is_struttura_s.vc_nodo)+1)+") = '"+tv_struttura.is_struttura_s.vc_nodo+".'"
//		
//	end if

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

ls_nodo= tv_struttura.is_struttura_s.vc_nodo
			
			li_ret= event ue_queryorg(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, li_livello_superiore)
			
//			if li_ret= -1 then exit
//	
//		loop
//		
//	close query_cur;
	
	close(w_wait_snoopy)
	
else // la query viene richiesta dalla list view...
	
	is_preview_s.ib_append= true // gds 05/03/2015
	
	openWithParm(w_selezione_livello_minimo, tv_struttura.is_struttura_s.livello + 1)

	li_livello_superiore= message.doubleParm
	
	if li_livello_superiore= 0 then return -1				

	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview, is_preview_s)
		
//		w_preview_scheda.uodw_current.dataObject= ls_object
		
		w_preview.uodw_current.reset()
	
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			s_struttura_loc=  ll_lvi.data
		
			li_ret= event ue_queryorg(ai_qualequery, ai_source, s_struttura_loc.livello, s_struttura_loc.vc_nodo, li_livello_superiore)
			
			if li_ret= -1 then exit

		next

end if

w_preview.uodw_current.sort()

//w_preview.uodw_current.groupCalc()

w_preview.uodw_current.setredraw(true)


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

is_preview_s.dataObject= ls_object
is_preview_s.ib_dwcreate= false
is_preview_s.transobject= sqlca

this.setRedraw(false)

if ai_source= 1 then // la query viene richiesta dal treeView...
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	ll_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	tv_struttura.is_struttura_s= ll_tvi.data
	
	is_preview_s.doretrieve= true
	is_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
//	is_preview_s.anno= 0
	is_preview_s.livello= tv_struttura.is_struttura_s.livello
	
	openWithParm(w_preview, is_preview_s)
	
else // la query viene richiesta dalla list view...

	is_preview_s.doretrieve= false
	is_preview_s.dataObject= ls_object
	
	openWithParm(w_preview, is_preview_s)
	
		for ll_handle= 1 to tab_dettaglio.tabpage_base.lv_dettaglio.totalItems()	
			
			tab_dettaglio.tabpage_base.lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			if ll_lvi.statePictureIndex = 1 then continue // unchecked...
			
			tv_struttura.is_struttura_s= ll_lvi.data
			
			ll_ret= w_preview.uodw_current.retrieve(tv_struttura.is_struttura_s.vc_nodo) //, is_preview_s.anno, is_preview_s.livello)
			
			if ll_ret= -1 then exit		
			
		next
		
		w_preview.uodw_current.groupCalc()

end if

//w_preview.uodw_current.groupCalc()

//w_preview.uodw_current.Object.DataWindow.Print.Preview= 'Yes'

this.setRedraw(true)

return ll_ret
end event

public function integer wf_modified ();if NOT isValid(idw_dettaglio) then return 0

	idw_dettaglio.acceptText()
	
	if idw_dettaglio.modifiedCount() > 0 or idw_dettaglio.deletedCount() > 0 then
		if messageBox("Aggiornamento", "Sono stati aggiornati dei dati. Vuoi salvare le modifiche?", question!, yesNo!, 1)= 1 then
			if idw_dettaglio.update()> 0 then
				commit;
				if trap_sql(sqlca, "COMMITANAG") < 0 then goto errore
			else
				// goto errore
				messageBox("Aggiornamento", "Aggiornamento non possibile, verificare i dati.", exclamation!)
				return -1
			end if
			
		else // non voglio salvare...
			
			rollback;
			
			idw_dettaglio.reset()
			idw_dettaglio.reselectrow(idw_dettaglio.getRow())
			
			return 0
			
		end if
		
	end if
					
return 0					
					
errore:
		messageBox("Aggiornamento", "Errore in aggiornamento dati.", exclamation!)
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

public function integer lvf_dettaglio (long tvi_handle);integer li_idx, li_index
long ll_child_handle, ll_rows, ll_idx
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura /*s_struttura_loc,*/ s_struttura_child
string ls_goh

li_index= tab_dettaglio.tabpage_base.lv_dettaglio.deleteItems()

tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= false

if tv_struttura.getItem(tvi_handle, ll_tvi)= -1 then return -1

//s_struttura_loc= ll_tvi.data

//// test 
is_current_item_s= ll_tvi.data

/////////////////////////

//this.setRedraw(false)

// Questa funzione viene lanciata ogni volta che cambia la selezione su un item del tree view

// La dw di aggiornamento è visibile solo a livello delle persone
tab_dettaglio.tabpage_base.lv_dettaglio.visible= true
tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= false

// s_struttura_loc.livello indica il livello corrente nel tree view non nella list view

tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= true

tab_dettaglio.tabpage_base.lv_dettaglio.setRedraw(false)
tab_dettaglio.tabpage_base.uodw_aggiornamento.setRedraw(false)

if is_current_item_s.livello <=  gi_maxlivello then // Cioè, fino al livello di gruppo...

//			tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= false

			// is_codice= s_struttura_loc.vc_nodo
	
			// Imposta il layout della list view...
			
			if is_current_item_s.livello < gi_maxlivello then // Prima del gruppo...
				tab_dettaglio.tabpage_base.lv_dettaglio.view= ListViewList!
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
				
				else
					
					// Altrimenti sono persone...
					
					ll_lvi.label= f_iniziali(trim(s_struttura_child.cognome)+"  "+trim(s_struttura_child.nome))
					
//					messageBox("test", s_struttura_child.flag_npa)
				
						if s_struttura_child.cod_dis <> 'MEM' OR s_struttura_child.flag_npa = "1" then	
							ll_lvi.pictureIndex= 0
						else
							ll_lvi.pictureIndex= gi_maxlivello + s_struttura_child.cod_div
						end if
						
					ll_lvi.statePictureIndex=  0
					if s_struttura_child.flag_ldr= '1' then ll_lvi.statePictureIndex=  1
					
					ll_lvi.data= s_struttura_child
					
					//tab_dettaglio.tabpage_base.lv_dettaglio.checkboxes= true
					
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

					if s_struttura_child.okatagi= 'A' then
						
						ls_goh= 'Okatagi'
						
					elseif  s_struttura_child.tokuso= 'A' then
						
						ls_goh= 'Tokuso'
						
					elseif s_struttura_child.okatagi= 'F' then
						
						ls_goh= 'Famiglia'
						
					elseif  s_struttura_child.tokuso= 'F' then
						
						ls_goh= 'Famiglia'
						
					end if
					
					if s_struttura_child.omamori= 'S' then
						
						s_struttura_child.omamori= 'Si'
						
					else
						
						s_struttura_child.omamori= 'No'
						
					end if
					
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 1, f_iniziali(trim(s_struttura_child.cognome)+ " " +trim(s_struttura_child.nome) ) )
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 2, s_struttura_child.divisione)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 3, s_struttura_child.status)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 4, ls_goh)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 5, s_struttura_child.omamori)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 6, s_struttura_child.responsabilita1)
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 7, s_struttura_child.responsabilita2)
					
					tab_dettaglio.tabpage_base.lv_dettaglio.setItem(li_index, 8, s_struttura_child.codice)
					
				end if
				
				ll_child_handle= tv_struttura.FindItem(nextTreeItem!, ll_child_handle) // cerca gli eventuali altri child...
			
			loop
			
			/*
			messageBox("test", "livello= "+string(is_current_item_s.livello)+" - max livello= "+string(gi_maxlivello) )

			if  is_current_item_s.livello > gi_maxlivello then
					
				for li_idx= 1 to upperBound(tab_dettaglio.control[])// -1
				
					tab_dettaglio.control[li_idx].visible= true

				next
					
			else
			*/	
				for li_idx= 2 to upperBound(tab_dettaglio.control[]) // -1
						
						tab_dettaglio.control[li_idx].visible= false
				
				next
				
			/*end if*/
			
			tab_dettaglio.control[2].visible= true // stats
		
else // tv a  livello persone
	
			tab_dettaglio.tabpage_base.lv_dettaglio.visible= false
			tab_dettaglio.tabpage_base.uodw_aggiornamento.visible= true
			
			// test GdS: tab_dettaglio.tabpage_base.uodw_aggiornamento.dataObject= 'dw_scheda_anagrafica_gerarchica'
			
			//is_codice= s_struttura_loc.codice
			
				//if this.wf_modified() < 0 then goto fine // return -1
				if (NOT isNull(is_current_item_s.codice) ) OR is_current_item_s.codice <> ""  then
					
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
			
			tab_dettaglio.tabpage_andamenti.visible= false
			
			 if f_offerte_privilege()= TRUE OR f_has_p('S')= TRUE then
	
				tab_dettaglio.tabpage_offerte.visible= true
				
			else
				
				tab_dettaglio.tabpage_offerte.visible= false
				
			end if
			
			 if f_storico_gohonzon_privilege()= TRUE OR f_has_p('S')= TRUE then
	
				tab_dettaglio.tabpage_goh.visible= true
				
			else
				
				tab_dettaglio.tabpage_goh.visible= false
				
			end if
			
			if is_current_item_s.flag_npa= '1' then
				tab_dettaglio.tabpage_liste.visible= false
			else
				tab_dettaglio.tabpage_liste.visible= 	( f_has_p('S')= TRUE OR f_invio_liste_privilege()=TRUE)
			end if
			
			tab_dettaglio.tabpage_ediz.visible= 		f_has_p('O')
			tab_dettaglio.tabpage_studio.visible= 	f_has_p('O')
			tab_dettaglio.tabpage_resp.visible= 		f_has_p('O')
			tab_dettaglio.tabpage_studenti.visible=f_has_p('O')			
			tab_dettaglio.tabpage_log.visible= 		f_has_p('O')			
			
end if

tab_dettaglio.tabpage_base.lv_dettaglio.setRedraw(true)
tab_dettaglio.tabpage_base.uodw_aggiornamento.setRedraw(true)

//fine:
//
//this.setRedraw(true)

return 0
end function

public function integer wf_assegnatario ();string ls_codice_fam

ls_codice_fam= tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString( &
							tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "codice_fam")

if ls_codice_fam <> "" and  is_current_item_s.codice= ls_codice_fam then

		messageBox(this.title, "La persona è assegnataria di un Gohonzon in un nucleo famigliare.~n"+&
											"Per eseguire l'operazione occorre prima sciogliere il nucleo.", information!)
											
		return -1									
												

end if

return 0
end function

public function integer wf_componente ();select codice_fam
into :is_codice_fam
from membri_gerarchica
where codice= :is_current_item_s.codice;
if trap_sql(sqlca, "WFCOMPONENTE01") < 0 then return -1

if is_codice_fam <> "" and NOT isNull(is_codice_fam) then
	
	// se c'è un nucleo e la persona ne è un componente e non assegnatario del G.
	if  is_current_item_s.codice <> is_codice_fam then 

			if messageBox(this.title, "La persona è un componente di  nucleo famigliare.~n"+&
												"Per proseguire occorre prima rimuoverla dal nucleo."+&
													"~nLa vuoi rimuovere ora?", question!, yesNo!, 2 )= 1 then
													
				ib_componentenucleo= true
				
				return 0
				
				else
												
				return -1
				
			end if
		
	else // se c'è un nucleo e la persona è assegnataria del G.
		
		messageBox(this.title, "La persona fa parte di un  nucleo famigliare ed è l'assegnataria del Gohonzon.~n"+&
											"Per proseguire occorre prima sciogliere il nucleo ( dalla scheda anagrafica ).", information!)
												
											
		return -1
			
	end if		
		
end if

return 0
end function

public function integer wf_handle_rb ();string okatagi, tokuso, omamori, ls_tmp

		tab_dettaglio.tabpage_goh.em_luogo.text= ""
		tab_dettaglio.tabpage_goh.em_data.text= string(today(), "dd.mm.yyyy")
			
		select		
			dbo.uf_situazione_okatagi(membri_gerarchica.codice, membri_gerarchica.cod_dis, membri_gerarchica.codice_fam), 
			dbo.uf_situazione_tokuso(membri_gerarchica.codice, membri_gerarchica.cod_dis, membri_gerarchica.codice_fam),
			dbo.uf_situazione_omamori(membri_gerarchica.codice, membri_gerarchica.cod_dis)	
		into :okatagi, :tokuso, :omamori
		from membri_gerarchica
		where codice= :is_current_item_s.codice;
		if trap_sql(sqlca, "HANDLERB01") < 0 then return -1
		
		/* init Omamori */
		
		tab_dettaglio.tabpage_goh.rb_oma_a.enabled = false
		tab_dettaglio.tabpage_goh.rb_oma_s.enabled = false
		tab_dettaglio.tabpage_goh.rb_oma_r.enabled = false
		
		tab_dettaglio.tabpage_goh.rb_oma_a.checked = false
		tab_dettaglio.tabpage_goh.rb_oma_s.checked = false
		tab_dettaglio.tabpage_goh.rb_oma_r.checked = false
		
		
		/* init Okatagi */
		
		tab_dettaglio.tabpage_goh.rb_oka_a.enabled = false
		tab_dettaglio.tabpage_goh.rb_oka_s.enabled = false
		tab_dettaglio.tabpage_goh.rb_oka_r.enabled = false
		tab_dettaglio.tabpage_goh.rb_oka_tok.enabled= false
		
		tab_dettaglio.tabpage_goh.rb_oka_a.checked = false
		tab_dettaglio.tabpage_goh.rb_oka_s.checked = false
		tab_dettaglio.tabpage_goh.rb_oka_r.checked = false
		tab_dettaglio.tabpage_goh.rb_oka_tok.checked= false
		
		
		/* init Tokuso */
		
		tab_dettaglio.tabpage_goh.rb_tok_a.enabled = false
		tab_dettaglio.tabpage_goh.rb_tok_r.enabled = false
		tab_dettaglio.tabpage_goh.rb_tok_s.enabled = false
		
		tab_dettaglio.tabpage_goh.rb_tok_a.checked = false
		tab_dettaglio.tabpage_goh.rb_tok_r.checked = false
		tab_dettaglio.tabpage_goh.rb_tok_s.checked = false
		
		if omamori= 'A' then
			
			select top 1 cod_causale
			into :ls_tmp
			from gohonzon_storico where codice=  :is_current_item_s.codice
			and tipo_goh='OMA'
			order by data DESC, substring(cod_causale, 1, 1) ASC;
			
			if trap_sql(sqlca, "HANDLERB02") < 0 then return -1
			
			if ls_tmp= 'ADS' then omamori='N'
			
		end if
		
		if okatagi= 'A' then
			
			select top 1 cod_causale
			into :ls_tmp
			from gohonzon_storico where codice=  :is_current_item_s.codice
			and tipo_goh='OKA'
			order by data DESC, substring(cod_causale, 1, 1) ASC;
			
			if trap_sql(sqlca, "HANDLERB03") < 0 then return -1
			
			if ls_tmp= 'ADS' then okatagi='N'
			
		end if		
		
		if tokuso= 'A' then
			
			select top 1 cod_causale
			into :ls_tmp
			from gohonzon_storico where codice=  :is_current_item_s.codice
			and tipo_goh='TOK'
			order by data DESC, substring(cod_causale, 1, 1) ASC;
			
			if trap_sql(sqlca, "HANDLERB04") < 0 then return -1
			
			if ls_tmp= 'ADS' then tokuso='N'
			
		end if				
			
		
		choose case omamori
				
			case 'A'
		
				tab_dettaglio.tabpage_goh.p_oma.visible = true
				tab_dettaglio.tabpage_goh.st_oma.visible = false
				tab_dettaglio.tabpage_goh.rb_oma_a.enabled = false
				tab_dettaglio.tabpage_goh.rb_oma_s.enabled = true
				tab_dettaglio.tabpage_goh.rb_oma_r.enabled = true
				tab_dettaglio.tabpage_goh.rb_oma_sd.enabled = true
				
			case else /* cioè N */
				
				tab_dettaglio.tabpage_goh.p_oma.visible = false
				tab_dettaglio.tabpage_goh.st_oma.visible = false
				tab_dettaglio.tabpage_goh.rb_oma_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_oma_r.enabled = false
				tab_dettaglio.tabpage_goh.rb_oma_sd.enabled = false
				tab_dettaglio.tabpage_goh.rb_oma_sd.enabled = false
				
		end choose
		
		choose case okatagi
				
			case 'A'
				
				tab_dettaglio.tabpage_goh.p_oka.visible = true
				tab_dettaglio.tabpage_goh.st_oka.visible = false
				tab_dettaglio.tabpage_goh.rb_oka_a.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_s.enabled = true
				tab_dettaglio.tabpage_goh.rb_oka_tok.enabled = true
				tab_dettaglio.tabpage_goh.rb_oka_r.enabled = true
				tab_dettaglio.tabpage_goh.rb_oka_sd.enabled = true
		
			case 'F'
				
				tab_dettaglio.tabpage_goh.p_oka.visible = true
				tab_dettaglio.tabpage_goh.st_oka.visible = true		
				tab_dettaglio.tabpage_goh.rb_oka_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_oka_s.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_tok.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_r.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_sd.enabled = false
				
			case else /* cioè NO */
				
				tab_dettaglio.tabpage_goh.p_oka.visible = false
				tab_dettaglio.tabpage_goh.st_oka.visible = false
				tab_dettaglio.tabpage_goh.rb_oka_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_oka_s.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_tok.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_r.enabled = false
				tab_dettaglio.tabpage_goh.rb_oka_sd.enabled = false
				
				if tokuso= 'A'  then // se ho un TOK ...
					tab_dettaglio.tabpage_goh.rb_oka_a.enabled = false
					tab_dettaglio.tabpage_goh.rb_oka_s.enabled = false
					tab_dettaglio.tabpage_goh.rb_oka_tok.enabled = false
					tab_dettaglio.tabpage_goh.rb_oka_r.enabled = false
				end if
				
		end choose
		
		choose case tokuso
				
			case 'A'
				
				tab_dettaglio.tabpage_goh.p_tok.visible = true
				tab_dettaglio.tabpage_goh.st_tok.visible = false
				tab_dettaglio.tabpage_goh.rb_tok_a.enabled = false
				tab_dettaglio.tabpage_goh.rb_tok_s.enabled = true
				tab_dettaglio.tabpage_goh.rb_tok_r.enabled = true
				tab_dettaglio.tabpage_goh.rb_tok_sd.enabled = true
				
			case 'F'
				
				tab_dettaglio.tabpage_goh.p_tok.visible = true
				tab_dettaglio.tabpage_goh.st_tok.visible = true
				tab_dettaglio.tabpage_goh.rb_oka_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_tok_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_tok_s.enabled = false
				tab_dettaglio.tabpage_goh.rb_tok_r.enabled = false
				tab_dettaglio.tabpage_goh.rb_tok_sd.enabled = false
		
			case else
				
				tab_dettaglio.tabpage_goh.p_tok.visible = false
				tab_dettaglio.tabpage_goh.st_tok.visible = false
				tab_dettaglio.tabpage_goh.rb_tok_a.enabled = true
				tab_dettaglio.tabpage_goh.rb_tok_s.enabled = false
				tab_dettaglio.tabpage_goh.rb_tok_r.enabled = false
				tab_dettaglio.tabpage_goh.rb_tok_sd.enabled = false
				
				if okatagi= 'A'  then // se ho un OKA ...
					tab_dettaglio.tabpage_goh.rb_tok_a.enabled = false
					tab_dettaglio.tabpage_goh.rb_tok_s.enabled = false
					tab_dettaglio.tabpage_goh.rb_tok_r.enabled = false
				end if				
				
//				if okatagi = 'F' then
//					tab_dettaglio.tabpage_goh.rb_tok_a.enabled = false
//					tab_dettaglio.tabpage_goh.rb_tok_r.enabled = false
//					tab_dettaglio.tabpage_goh.rb_tok_s.enabled = false
//				end if
				
		end choose
		
return 0

end function

public function integer wf_checkstatus ();string ls_dis

select cod_dis
into :ls_dis
from membri_gerarchica
where codice= :is_current_item_s.codice;
if trap_sql(sqlca, "ACQ01") < 0 then return -1

if ls_dis= 'TAI' then
	
	messageBox(this.title, "Lo status della persona è: TAI.~nDeve essere modificato prima di eseguire la procedura di acquisizione.", information!)
	return -1
	
end if

return 0
end function

on w_struttura_tv_tab.create
int iCurrent
call super::create
this.tab_dettaglio=create tab_dettaglio
this.cb_ricercaanomalie=create cb_ricercaanomalie
this.shl_altritipi=create shl_altritipi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dettaglio
this.Control[iCurrent+2]=this.cb_ricercaanomalie
this.Control[iCurrent+3]=this.shl_altritipi
end on

on w_struttura_tv_tab.destroy
call super::destroy
destroy(this.tab_dettaglio)
destroy(this.cb_ricercaanomalie)
destroy(this.shl_altritipi)
end on

event open;call super::open;integer li_ret
long ll_handle
string ls_reportpath

ll_handle= AncestorReturnValue

s_session_s.context= "Anagrafica"

tab_dettaglio.tabpage_base.uodw_aggiornamento.setTransObject(sqlca)
tab_dettaglio.tabpage_rif.uodw_rif.setTransObject(sqlca)
//tab_dettaglio.tabpage_ediz.uodw_pubblicazioni.setTransObject(sqlca_ediz)
tab_dettaglio.tabpage_offerte.uodw_storicocontributi.setTransObject(sqlca)
tab_dettaglio.tabpage_studio.uodw_se.setTransObject(sqlca)
tab_dettaglio.tabpage_goh.uodw_sg.setTransObject(sqlca)

tab_dettaglio.tabpage_rif.uodw_rif.getChild("cod_rif", idwc_rif)
tab_dettaglio.tabpage_base.uodw_aggiornamento.getChild("cod_dis", idwc_cod_dis)

// Se l'utente non è abilitato non visualizza lo status DIM nel menu a tendina corrispondente... GdS 14/02/2016
if  f_has_p('D')= false then
	idwc_cod_dis.SetFilter("cod_dis <>'DIM'")
	idwc_cod_dis.Filter()
end if

//lvf_dettaglio(ll_handle)

im_pop_lv_dettaglio= create m_pop_lv_dettaglio
im_preview= create m_preview
im_pop_tv= create m_pop_tv_tab

// external dw dei nomi report in tab statistiche
string ls_entries

//idwc_reportname.dataObject= "dw_listobjects"

//tab_dettaglio.tabpage_andamenti.dw_reportname.GetChild('reportname', idwc_reportname)

ls_reportpath= gs_docdir+"\"+gs_reportpath
ls_entries= libraryDirectory(ls_reportpath, DirDataWindow!)

//li_ret= idwc_reportname.importString(ls_entries)

li_ret= tab_dettaglio.tabpage_andamenti.dw_reportname.importString(ls_entries)

if li_ret <= 0 then
	
	messageBox(this.title, "OPEN: Errore N. "+string(li_ret)+" in inportString")
	return 0
	
end if

tab_dettaglio.tabpage_andamenti.dw_reportname.sort()

//tab_dettaglio.tabpage_andamenti.dw_reportname.setRow(1)

//li_ret= tab_dettaglio.tabpage_andamenti.dw_reportname.insertRow(0)

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
		

tv_struttura.width= WorkspaceWidth() - PixelsToUnits ( li_tabwidth,  XPixelsToUnits! ) - 60

tab_dettaglio.height= /*tv_struttura.height + tv_struttura.y */ this.height - tab_dettaglio.y -170

//tab_dettaglio.tabpage_base.height= tv_struttura.height //tv_struttura.height // + gb_cerca.height
tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

tab_dettaglio.width=PixelsToUnits ( li_tabwidth,  XPixelsToUnits! )// WorkspaceWidth() - tab_dettaglio.x - 60 

idw_dettaglio.height= tab_dettaglio.height -160 -idw_dettaglio.y

tab_dettaglio.tabpage_base.lv_dettaglio.height= tab_dettaglio.tabpage_base.height - 10
tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30

dw_cerca.width= tv_struttura.width/2 - phl_trova.width
phl_trova.x= dw_cerca.width+30

shl_altritipi.x= phl_trova.x + phl_trova.width + 30
cb_ricercaanomalie.x= phl_trova.x + phl_trova.width + 30


end event

event closequery;call super::closequery;//if this.wf_riferimenti() = 1 then return 1

if this.wf_modified() < 0 then return 1
end event

event close;call super::close;s_session_s.codice= ""

db_connection.uof_disconnectdb(sqlca_ediz)

if isValid(w_reportrunner_tv) then close(w_reportrunner_tv)

	
end event

event ue_tvdim;call super::ue_tvdim;tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30
tab_dettaglio.width= WorkspaceWidth() - tab_dettaglio.x - 30
idw_dettaglio.width= tab_dettaglio.width - 60
end event

type phl_trova from w_struttura_tv`phl_trova within w_struttura_tv_tab
boolean map3dcolors = false
string powertiptext = "Esegue la ricerca per nome o struttura"
end type

type st_ricerca1 from w_struttura_tv`st_ricerca1 within w_struttura_tv_tab
integer width = 658
end type

type dw_cerca from w_struttura_tv`dw_cerca within w_struttura_tv_tab
integer taborder = 10
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_struttura_tv_tab
event ue_return pbm_dwnprocessenter
event type integer ue_lvfdettaglio ( long al_handle )
integer y = 200
integer taborder = 20
string pointer = "HyperLink!"
integer indent = 150
boolean haslines = false
boolean linesatroot = false
boolean checkboxes = false
boolean trackselect = true
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

event tv_struttura::selectionchanged;call super::selectionchanged;parent.wf_modified()

if tv_struttura.ib_searchend= true then
	tv_struttura.ib_searchend= false
	//parent.setRedraw(false)
		parent.lvf_dettaglio(newHandle)
	//parent.setRedraw(true)
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

this.selectitem(handle)

if li_ret= -1 then return -1
	
is_struttura_s= ll_tvi.data

//messageBox("test", "tvilevel: "+string( ll_tvi.level)+" - ainumerolivellivisualizzati: "+string( is_tvinit_s.ai_numerolivellivisualizzati ))

// a livello delle persone...
if ll_tvi.level > is_tvinit_s.ai_numerolivellivisualizzati then
	parent.im_pop_tv.m_aggiornanodo.enabled= false
	parent.im_pop_tv.m_struttura.enabled= false
	parent.im_pop_tv.m_report.enabled= false
end if

if ll_tvi.level  = is_tvinit_s.ai_numerolivellivisualizzati  then 
	
	// a livello del gruppo...
	parent.im_pop_tv.m_aggiornanodo.enabled= true
	parent.im_pop_tv.m_struttura.enabled= false	
	parent.im_pop_tv.m_report.enabled= false
	
end if
	
if ll_tvi.level <  is_tvinit_s.ai_numerolivellivisualizzati then 
	
	if f_has_p("O")= true then
		parent.im_pop_tv.m_aggiornanodo.enabled= true
		parent.im_pop_tv.m_struttura.enabled= true			
		parent.im_pop_tv.m_struttura.m_modificastruttura.enabled= true
		parent.im_pop_tv.m_struttura.m_inseriscinuovastruttura.enabled= true
		parent.im_pop_tv.m_report.enabled= true
	else
		parent.im_pop_tv.m_struttura.enabled= false
	end if
	
end if

// modifica descrizione della struttura...
	if f_has_p("S")= true and ll_tvi.level  <=  is_tvinit_s.ai_numerolivellivisualizzati then
			parent.im_pop_tv.m_struttura.enabled= true			
			parent.im_pop_tv.m_struttura.m_modifica.enabled= true
			if  ll_tvi.level  =  is_tvinit_s.ai_numerolivellivisualizzati then
				parent.im_pop_tv.m_struttura.m_modificastruttura.enabled= false
				parent.im_pop_tv.m_struttura.m_inseriscinuovastruttura.enabled= false
			else
				parent.im_pop_tv.m_struttura.m_modificastruttura.enabled= true
				parent.im_pop_tv.m_struttura.m_inseriscinuovastruttura.enabled= true
		end if
		else
			parent.im_pop_tv.m_struttura.m_modifica.enabled= false
	end if

parent.im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )



end event

event tv_struttura::getfocus;call super::getfocus;w_struttura_tv_tab.triggerEvent(resize!)
end event

type tab_dettaglio from tab within w_struttura_tv_tab
integer x = 1893
integer y = 12
integer width = 4096
integer height = 3036
integer taborder = 30
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
tabpage_studenti tabpage_studenti
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
this.tabpage_studenti=create tabpage_studenti
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
this.tabpage_studenti,&
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
destroy(this.tabpage_studenti)
destroy(this.tabpage_log)
end on

event selectionchanging;if parent.wf_modified() < 0 then return 1 // non cambia tab...

//this.setRedraw(false)

choose case newindex
		
	case 1
		
		idw_dettaglio= tab_dettaglio.tabpage_base.uodw_aggiornamento
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
	case 2
		
//		long ll_handle
//		treeViewItem ll_tvi

//		idw_dettaglio= tab_dettaglio.tabpage_andamenti.uodw_reportname // uodw_stat
//		
//		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Statistiche"
		
		tab_dettaglio.tabpage_andamenti.sle_struttura.text= f_descrizione_nodo( is_current_item_s.vc_nodo,  is_current_item_s.livello)
		
//		tab_dettaglio.tabpage_andamenti.dw_reportname.setSort("col3")
//		
		tab_dettaglio.tabpage_andamenti.dw_reportname.sort()
	//	tab_dettaglio.tabpage_andamenti.dw_reportname.SelectRow ( 0, false)
		
		tab_dettaglio.tabpage_andamenti.dw_reportname.ScrollToRow(1)
		
		//tab_dettaglio.tabpage_andamenti.dw_reportname.setFocus()
		
		//idw_dettaglio= tab_dettaglio.tabpage_andamenti.uodw_reportname
		
	case 3 // Riferimenti
		
		string ls_dis
		
		idw_dettaglio= tab_dettaglio.tabpage_rif.uodw_rif
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Riferimenti"
		
		idw_dettaglio.ib_readonly= NOT f_has_p('O')
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_rif.uo_dw_rif.retrieve(is_codice)
	
	case 4 // Edizioni
		
//		tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(is_codice)

		idw_dettaglio= tab_dettaglio.tabpage_ediz.uodw_pubblicazioni
		
		idw_dettaglio.setTransObject(sqlca_ediz)
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_ediz.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
		
	case 5 // Offerte

		idw_dettaglio= tab_dettaglio.tabpage_offerte.uodw_storicocontributi
		
		idw_dettaglio.setTransObject(sqlca)
		
		
//		if NOT isNull(is_codice) then tab_dettaglio.tabpage_offerte.dw_storicocontributi.retrieve(is_codice )

	case 6 // Liste
		
			idw_dettaglio= tab_dettaglio.tabpage_liste.uodw_liste
			
			idw_dettaglio.setTransObject(sqlca)
			
			s_session_s.context= "Anagrafica - Liste"
	
			idw_dettaglio.ib_readonly= NOT f_has_p('O')
	
	case 7 // Esami
		
		idw_dettaglio= tab_dettaglio.tabpage_studio.uodw_se
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Esami"

	case 8 // Storico Gohonzon
		
		idw_dettaglio= tab_dettaglio.tabpage_goh.uodw_sg
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Gohonzon"
		
	case 9
		
		idw_dettaglio= tab_dettaglio.tabpage_resp.uodw_storico_resp
		
		idw_dettaglio.setTransObject(sqlca)
		
		s_session_s.context= "Anagrafica - Responsabilità"
		
	case 10
		
		idw_dettaglio= tab_dettaglio.tabpage_studenti.uodw_studenti
		
		idw_dettaglio.setTransObject(sqlca)				
		
	case 11 // storico variazioni...
		
		idw_dettaglio= tab_dettaglio.tabpage_log.uodw_vislog
		
		idw_dettaglio.setTransObject(sqlca)
		
end choose


if /*tv_struttura.is_struttura_s.livello > gi_maxlivello and*/ newindex <>2  then
	
	if NOT isNull(is_current_item_s.codice) OR is_current_item_s.codice <> ""  then
		idw_dettaglio.retrieve(is_current_item_s.codice)
		s_session_s.codice= is_current_item_s.codice
	else
		
		messageBox(parent.title, "Errore in retrieve dettaglio (codice nullo)")
		
	end if
	
end if


if isValid(idw_dettaglio) then

	if newindex= 2 then
		//tab_dettaglio.tabpage_andamenti.dw_reportname.width=this.width - 60
		tab_dettaglio.tabpage_andamenti.dw_reportname.height= this.height -160 -tab_dettaglio.tabpage_andamenti.dw_reportname.y
		tab_dettaglio.tabpage_andamenti.gb_report.height= tab_dettaglio.tabpage_andamenti.dw_reportname.height +tab_dettaglio.tabpage_andamenti.dw_reportname.y - (tab_dettaglio.tabpage_andamenti.gb_report.y) + 20
		//tab_dettaglio.tabpage_andamenti.dw_reportname.setFocus()
		
		tab_dettaglio.tabpage_andamenti.rb_organigramma.triggerEvent(clicked!)
		tab_dettaglio.tabpage_andamenti.rb_organigramma.checked= true
		
	else
			idw_dettaglio.height= tab_dettaglio.height -160 -idw_dettaglio.y
	end if

//	if f_has_p("O")= true and tv_struttura.is_struttura_s.livello <= gi_maxlivello and newindex <> 2 then
//		idw_dettaglio.Object.DataWindow.ReadOnly="No"
//	else
//		idw_dettaglio.Object.DataWindow.ReadOnly="Yes"
//	end if

//this.setRedraw(true)

end if

//this.setRedraw(true)



end event

type tabpage_base from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 4059
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
event type integer ue_selezionatutto ( )
event type integer ue_deselezionatutto ( )
integer x = 9
integer width = 1385
integer height = 552
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "@Arial Unicode MS"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 16777215
boolean autoarrange = true
boolean extendedselect = true
boolean trackselect = true
boolean gridlines = true
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewlist!
string largepicturename[] = {"wi0064-48.gif","foot_orange.gif","foot_blue.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_orange.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","sally.gif",""}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 553648127
string smallpicturename[] = {"wi0064-48.gif","foot_orange.gif","foot_blue.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_orange.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","sally.gif",""}
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
		this.setItem(li_index, 3, s_struttura_s.okatagi)
		this.setItem(li_index, 4, s_struttura_s.tokuso)
		this.setItem(li_index, 5, s_struttura_s.omamori)
		this.setItem(li_index, 6, s_struttura_s.responsabilita1)
		this.setItem(li_index, 7, s_struttura_s.responsabilita2)
		
		li_index = this.FindItem(li_index, directionAll!, false, false, false, false)
		
loop

this.setRedraw(true)

return 0
end event

event ue_list_view_mode();this.view= listViewReport!

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
end event

event type integer ue_struttura();		integer li_ret
		long 	ll_handle, ll_tgt_handle, ll_idx, ll_checked=0
		s_assegnastruttura s_assegnastruttura_s
		s_struttura s_struttura_s
		s_session ls_session_s
		string ls_da, ls_a, ls_codice, ls_vc_nodo, ls_cognomenome, ls_message
		listViewItem lv_item
		treeViewItem ltvi_src
		
		ls_session_s= s_session_s
		
		if f_has_p("O") = false then
			messageBox(parent.text, "Operazione non permessa", exclamation!)
			return 0
		end if
		
		for ll_idx= 1 to this.totalItems()
			
			this.getItem(ll_idx, lv_item)
			
			if lv_item.statePictureIndex= 2 then ll_checked++ // checked
			
		next
		
		if ll_checked= 0 then
			
			messageBox(parent.text, "Nessuna persona è stata selezionata", exclamation!)	
			
			return 0
			
		end if
		
		ls_da= is_current_item_s.vc_nodo
		s_assegnastruttura_s.as_struttura_s.vc_nodo=is_current_item_s.vc_parent
		s_assegnastruttura_s.as_struttura_s.livello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.ai_maxlivello= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ai_ultimolivelloparent= is_assegnastruttura_s.ai_ultimolivelloparent
		s_assegnastruttura_s.as_ambito= is_assegnastruttura_s.as_ambito

		openWithParm(w_assegna_struttura, s_assegnastruttura_s )
		
		is_strutturatgt_s = message.powerObjectParm
		
		if is_strutturatgt_s.livello= -1 then return -1
		
		ls_a= is_strutturatgt_s.vc_nodo
		
		if ls_da= ls_a then 
			
				messageBox(parent.text, "Il gruppo di partenza e il gruppo di arrivo sono uguali", exclamation!)
				return -1
				
		end if
		
		if messageBox(parent.text, "Confermi lo spostamento?", question!, yesNo!, 2)= 2 then return 0	
		
		for ll_idx= 1 to this.totalItems()
			
			this.getItem(ll_idx, lv_item)
			
			if lv_item.statePictureIndex= 1 then continue // Unchecked
			
			s_struttura_s= lv_item.data
			
			ls_codice= s_struttura_s.codice
			
			update membri_gerarchica
			set vc_parent= :ls_a
			where codice= :ls_codice;
			
			if trap_sql(sqlca, "SPOSTAGRUPPO01") < 0 then goto errore
			
			ls_cognomenome= s_struttura_s.cognome+" "+s_struttura_s.nome
		
			ls_session_s.context= "Trasferimento"
			ls_session_s.codice= ls_codice
			
			/*
			 * in questo caso la causale è TRASFG e la variazione indotta è una dimiminuzione sulla struttura di partenza
			 * ed un aumento sulla struttura di arrivo.
			 */
			
			ls_session_s.causale= "TRASFG"
			ls_session_s.tipo_variazione_src= "D-TRA"
			ls_session_s.tipo_variazione_tgt= "A-TRA"						
			
			ls_message= ls_cognomenome+": "+"Struttura: "+s_assegnastruttura_s.as_struttura_s.vc_nodo+" - Modificato in: "+is_strutturatgt_s.vc_nodo
			ls_session_s.struttura_src= s_assegnastruttura_s.as_struttura_s.vc_nodo
			ls_session_s.struttura_tgt= is_strutturatgt_s.vc_nodo			
			
			if  s_struttura_s.okatagi= 'A' OR s_struttura_s.tokuso= 'A' then

				ls_session_s.gm= 'G'
				
			else
				
				ls_session_s.gm= 'M'		
				
			end if		
			
			f_log(ls_session_s,ls_message, false)
			
		next
		
		commit;
		
		if trap_sql(sqlca, "SPOSTAGRUPPO02") < 0 then goto errore
		
		open(w_message)
		
//		setRedraw(false)
		
			ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
			
			ll_tgt_handle= tv_struttura.uf_cerca_nodo(is_strutturatgt_s.vc_nodo)
			
			tv_struttura.uf_visualizzanuovoitem(ll_handle)
			
			li_ret= tv_struttura.GetItem(ll_handle, ltvi_src)
			
			ltvi_src.selected= false			
			
			li_ret=tv_struttura.setItem(ll_handle, ltvi_src)
			
			tv_struttura.uf_visualizzanuovoitem(ll_tgt_handle)
			
			lvf_dettaglio(ll_tgt_handle)

//		setRedraw(true)

		return 1
		
errore:

		rollback;
		
		trap_sql(sqlca, "SPOSTAGRUPPO03")
		
		open(w_message_negative)
		
		return -1

end event

event type integer ue_qsgruppo();	return openWithParm(w_qsgruppo, is_current_item_s )
end event

event type integer ue_selezionatutto();integer li_ret
long ll_idx
listViewItem lv_item

for ll_idx= 1 to this.totalItems()
	
	li_ret= this.getItem(ll_idx, lv_item)
	
	if li_ret < 0 then exit
	
	lv_item.statePictureIndex= 2 // checked...
	
	this.SetItem ( ll_idx, lv_item )
	
next

return li_ret
end event

event type integer ue_deselezionatutto();integer li_ret
long ll_idx
listViewItem lv_item

for ll_idx= 1 to this.totalItems()
	
	li_ret= this.getItem(ll_idx, lv_item)
	
	if li_ret < 0 then exit
	
	lv_item.statePictureIndex= 1 // unchecked...
	
	this.SetItem ( ll_idx, lv_item )
	
next

return li_ret
end event

event doubleclicked;integer li_ret= 1
listViewItem llvi_dettaglio
treeViewItem ltvi_struttura
s_struttura s_struttura_loc


li_ret= getItem(index, llvi_dettaglio)

if li_ret <= 0 then return -1
	
s_struttura_loc= llvi_dettaglio.data

li_ret= tv_struttura.selectItem(s_struttura_loc.handle)

tab_dettaglio.setRedraw(true)

return 0
end event

event rightclicked;if is_current_item_s.livello= gi_maxlivello then
	im_pop_lv_dettaglio.m_report.enabled= false
//	im_pop_lv_dettaglio.m_offerte.enabled= false
//	im_pop_lv_dettaglio.m_consegne.enabled= false
	if f_has_p("O") then
		im_pop_lv_dettaglio.m_trasferimenti.enabled= true
		im_pop_lv_dettaglio.m_selezionatutti.enabled= true
		im_pop_lv_dettaglio.m_deselezionatutti.enabled= true		
		im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= true
	else
		im_pop_lv_dettaglio.m_trasferimenti.enabled= false
		im_pop_lv_dettaglio.m_selezionatutti.enabled= false	
		im_pop_lv_dettaglio.m_deselezionatutti.enabled= false	
		im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= false			
	end if
		im_pop_lv_dettaglio.m_qsgruppo.enabled= true
else
	im_pop_lv_dettaglio.m_report.enabled= true
//	im_pop_lv_dettaglio.m_offerte.enabled= true
//	im_pop_lv_dettaglio.m_consegne.enabled= true
	im_pop_lv_dettaglio.m_trasferimenti.enabled= false
	im_pop_lv_dettaglio.m_selezionatutti.enabled= false	
	im_pop_lv_dettaglio.m_deselezionatutti.enabled= false		
	im_pop_lv_dettaglio.m_spostainunaltrogruppo.enabled= false
	im_pop_lv_dettaglio.m_qsgruppo.enabled= false
end if
	

im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )



end event

event columnclick;this.SetRedraw(false)

	this.Sort(Ascending! , column)

this.SetRedraw(true)
end event

type uodw_aggiornamento from uodw_generica within tabpage_base
integer width = 3406
integer height = 2724
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_anagrafica"
boolean maxbox = false
boolean hscrollbar = false
boolean border = true
boolean ib_stampatoda = true
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

event buttonclicked;call super::buttonclicked;datetime ldt_data_cer, ldt_nascita, ldt_cerimonia
integer li_ret, li_err
long ll_currenthandle, ll_parenthandle, ll_childitem, ll_ret, ll_oldhandle, ll_newhandle
s_struttura s_struttura_s
s_strade s_strade_s
s_famiglia s_famiglia_s
s_session ls_session_s
string ls_message, ls_error, ls_cognomenome, ls_codice, ls_null
treeViewItem ltvi_current
			
if ancestorreturnvalue < 0 then return -1

ls_session_s= s_session_s

choose case dwo.name
		
	case "b_accessoremoto"
		
		if this.uof_modificheincorso() = 3 then return 0
		
		openWithParm( w_gestioneaccessoremoto, is_current_item_s.codice)
				
	case "b_modnucleo"
		
		if this.uof_modificheincorso() = 3 then return 0
		
		open( w_check_pw)
		if message.doubleparm= -1 then return 0
		
		s_famiglia_s.codice= this.getItemString(row, "codice")
		s_famiglia_s.codice_fam= this.getItemString(row, "codice_fam")
		
		openWithParm(w_fai_nuclei, s_famiglia_s)
		
		w_struttura_tv_tab.setRedraw(false)
		this.retrieve(s_famiglia_s.codice)
		w_struttura_tv_tab.setRedraw(true)
		
		ls_session_s.causale= "ANAGRAFICA"
		ls_message= "Generato/Modificato nucleo famigliare"
		
	case "b_nucleo"
		
		openWithParm(w_visualizza_nuclei, this.getItemString(row, "codice_fam"))
		
	case "b_aggiorna"

			// Nel caso di trasferimento in un nuovo gruppo...
			if ancestorreturnvalue= 1 and ib_modificatastruttura= true then
			
				tv_struttura.setRedraw(false)
				tab_dettaglio.setRedraw(false)
				
				ll_oldhandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
				li_ret= tv_struttura.deleteItem(ll_oldhandle)		
				
				ls_message= "Struttura: "+this.getItemString(row, "vc_parent")+" - Modificata in: "+is_strutturatgt_s.vc_nodo
				
					if messageBox(parent.text, "Il trasferimento è stato eseguito, vuoi spostarti nella nuova posizione?", question!, yesNo!, 2)= 1 then
						
						ll_newhandle= tv_struttura.uf_cerca_nodo(is_strutturatgt_s.vc_nodo/*+"."+trim(s_struttura_s.cognome)+" "+trim(s_struttura_s.nome)*/ )
						
						li_ret= tv_struttura.uf_visualizzanuovoitem(ll_newhandle /*ll_parenthandle*/)
					
					end if
						
				tv_struttura.setRedraw(true)
				tab_dettaglio.setRedraw(true)	
				
				ib_modificatastruttura= false
			
			end if
		
		case "b_m_anag"
			
			if this.getItemString(row, "codice_fam") <> "" AND NOT isNull( this.getItemString(row, "codice_fam") ) then
				
				messageBox(parent.text, "E' un componente di un nucleo familiare, occorre prima sciogliere il nucleo.", exclamation!)
				
				return 0
				
			end if
			
		ls_session_s.codice= 	this.getItemString(row, "codice")
			
		open( w_check_pw)
		if message.doubleparm= -1 then return 0
				
				li_ret= uof_modificheincorso()
				
				if li_ret= 3 then return
				
				ls_message= "Cancellato: "+this.getItemString(row, "codice")+" - "+this.getItemString(row, "cognome")+ " "+this.getItemString(row, "nome")

				li_ret= this.uof_cancella()
			
			// Cancella l'item di tv relativo alla persona cancellata
		
			ll_currenthandle = tv_struttura.FindItem(currentTreeItem!, 0)
				
			li_ret= tv_struttura.deleteItem(ll_currenthandle)
		
	case 'b_scheda'
		
		//setpointer(hourGlass!)
		
		is_preview_s.criterio= uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice")
		is_preview_s.dataObject= "dw_scheda_anagrafica_gerarchica"
		is_preview_s.doretrieve= true
		is_preview_s.ib_allowstop= false
		is_preview_s.ib_anteprima= false
		
		openWithParm(w_preview, is_preview_s)		
		

	case "b_bollettino"
		
		is_preview_s.tipo_stampa= "N"
		is_preview_s.criterio= uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice")
		
		w_struttura_tv_tab.event ue_bollettini(is_preview_s)
		
			ls_session_s.context= "Anagrafica: sportello"
			ls_session_s.causale= "ANAGRAFICA"
			
			ls_cognomenome= this.getItemString(row, "cognome")+" "+this.getItemString(row, "nome")

			ls_message= ls_session_s.causale+" - "+ls_cognomenome+": Stampato un bollettino offerta"
			f_log(ls_session_s, ls_message, true)
		
	case "b_lettera"
		
//		openWithParm(w_preview_ole,  uodw_aggiornamento.getItemString(uodw_aggiornamento.getRow(), "codice"))

		string lsa_resp[]= {"None", "Block", "District", "Chapter", "Headquarter", "Territory", "Region", "National", "Generale director"}, &
		lsa_studio[]= {"None", "1° Level", "2° Level", "3° Level", "4° Level", "5° Level"}, &
		lsa_div[]={"MD", "WD", "YMD", "YWD"}, ls_path_ldp, &
		ls_filename
		
		if messageBox(parent.text, "Vuoi aggiungere la tua firma al documento?", question!, yesNo!, 2)= 1 then
//			openWithParm(w_dirlist, gs_docdir+"\firme")
			ls_filename= gs_docdir+"\firme\"+s_session_s.s_utente_s. s_nome+"\"+s_session_s.s_utente_s. s_nome+".jpg"
			if NOT fileExists(ls_filename) then
				messageBox(parent.text, "Firma non presente.", stopSign!)
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
						:ldt_nascita,
						:ldt_cerimonia,
						:inca_pdf.isa_valori[6],
						:inca_pdf.isa_valori[7],
						:inca_pdf.isa_valori[8]
				from membri_gerarchica, tab_comuni
				where membri_gerarchica.cod_com= tab_comuni.cod_com and codice= :is_current_item_s.codice;
				
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
		
		ls_session_s.causale= "STRUTTURA"				
		
		ls_session_s.context= "Anagrafica: sportello"
		
		 ls_session_s.codice= is_current_item_s.codice
		
		ls_cognomenome= this.getItemString(row, "cognome")+" "+this.getItemString(row, "nome")

		ls_message= ls_session_s.causale+" - "+ls_cognomenome+": "+"Evasa richiesta di lettera di presentazione"

		f_log(ls_session_s, ls_message, true)
		
//		if messageBox(parent.text, "Vuoi visualizzare la lettera?", question!, yesNo!, 2)= 1 then

				SetNull (ls_null) 
				ShellExecuteA(Handle(Parent), ls_null, ls_path_ldp, ls_null, ls_null, 1) 
				
//		end if

	case "b_forzailcap"
		
		messageBox("Attenzione", "Il C.A.P. inserito manualmente potrebbe essere scorretto.", information!)
		
		this.Object.cap_dom.Protect=0
		this.setColumn("cap_dom")
		
	case "b_cap_poste"
		
		s_cap s_cap_s
		Open ( w_cap_poste )
		
		s_cap_s=message.powerobjectparm		
		
		if s_cap_s.codistat= "" then
			
			messageBox("Ricerca CAP", "Operazione annullata.", information!)
			
			return -1
			
		end if
				
		li_err= this.SetItem ( row, "cod_com", s_cap_s.id)
		
		if isNull(s_cap_s.frazione) or s_cap_s.frazione= "" then
		
			li_err= this.SetItem ( row, "comune", s_cap_s.comune )
			
		else
			
			li_err= this.SetItem ( row, "comune", s_cap_s.comune+" - Località "+s_cap_s.frazione )
			
		end if
		
		li_err= this.SetItem ( row, "provincia", s_cap_s.provincia_sigla)
		
		if s_cap_s.strada <> "" and NOT isNull( s_cap_s.strada) then 
			
			li_err= this.SetItem ( row, "ind_dom", s_cap_s.strada+" ")
			
		end if
					
		li_err= this.SetItem ( row, "cap_dom", s_cap_s.cap)
		
		 this.object.b_aggiorna.visible= '1'
		
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
		
		/*
		 * Verifica la presenza della persona su liste esami, al momento commentato, se una persona viene traferita in
		 * un'altra dipendenza resta nella lista d'origine, avendo fatto il compito lì, gli si può attribuire il voto
		 *
		 	if f_verificalistaesame(is_current_item_s.codice, is_strutturatgt_s.vc_nodo)< 0 then return -1
		 */
		
		this.object.b_aggiorna.visible= '1'
		
		this.setItem(row, "vc_parent", is_strutturatgt_s.vc_nodo)
		
		// ls_error= this.modify( "cstruttura.Background.color="+string(rgb(255,255,128)))
		
		ib_modificatastruttura= true
		
		
		if f_confermaresponsabilita(is_current_item_s.codice, s_assegnastruttura_s.as_struttura_s.vc_nodo,  is_strutturatgt_s.vc_nodo) < 0 then return -1
		
		/*
		 * in questo caso la causale è TRASFG e la variazione indotta è una dimiminuzione sulla struttura di partenza
		 * ed un aumento sulla struttura di arrivo.
		 */
		
		ls_session_s.causale= "TRASFG"
		ls_session_s.tipo_variazione_src= "DA-TRA"
		ls_session_s.tipo_variazione_tgt= "A-TRA"						
		
		ls_message= "Struttura: "+s_assegnastruttura_s.as_struttura_s.vc_nodo+" - Modificata in: "+is_strutturatgt_s.vc_nodo
		ls_session_s.context= "Trasferimento"
		ls_session_s.struttura_src= s_assegnastruttura_s.as_struttura_s.vc_nodo
		ls_session_s.struttura_tgt= is_strutturatgt_s.vc_nodo
		
		if  this.getItemString(row, "okatagi") = 'A' OR  this.getItemString(row, "tokuso") = 'A' then
			
				ls_session_s.gm= 'G' 
			
		else
						
				ls_session_s.gm= 'M'
				
		end if
		
		this.setItem(row, "u_ult_mod", s_session_s.s_utente_s.s_nome_esteso)
		this.setItem(row, "d_ult_mod", today())
		
		f_log(ls_session_s, ls_message, false)
		
end choose

return 0

end event

event itemchanged;call super::itemchanged;integer li_err, li_ret, li_count
long ll_rows
boolean first_time = true
string search_string, ls_old, ls_new, ls_tipo, ls_nomecolonna, ls_nuovaOrganizzazione, ls_message, ls_cognomenome, ls_resp, ls_div, ls_codice_fam,ls_status_attuale, ls_ultimocarattere, ls_checkdigit, ls_archivio, ls_sigla, as[], ls_descrizione_old, ls_descrizione_new
s_struttura s_struttura_s
s_session ls_session_s

long ll_currentHandle, ll_parentHandle
treeViewItem ltv_item, ltvi_current

if row <= 0 then return 1

ls_session_s= s_session_s

tv_struttura.setRedraw(false)

ll_currentHandle= tv_struttura.findItem(currentTreeItem!, 0)

tv_struttura.getItem(ll_currentHandle, ltv_item)

ids_com= create u_ds_com
ids_com.setTransObject(sqlca)

this.setItem(row, "u_ult_mod", s_session_s.s_utente_s.s_nome_esteso)
this.setItem(row, "d_ult_mod", today())		
	
data = trim ( data )

ls_cognomenome= trim(this.getItemString(row, "cognome")+" "+this.getItemString(row, "nome"))

ls_session_s.context= "Anagrafica"

ls_session_s.codice= is_current_item_s.codice

ls_session_s.struttura_src= this.getItemString(row, "vc_parent")	

ls_codice_fam=  this.getItemString(row, "codice_fam")

if  this.getItemString(row, "okatagi")= 'A' OR this.getItemString(row, "tokuso")= 'A' then

	ls_session_s.gm= 'G'
	
else
	
	ls_session_s.gm= 'M'		
	
end if

ls_old= getItemString(row, this.getColumnName())
ls_new= data

CHOOSE CASE dwo.name
	
		case "codice_fiscale"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			ls_ultimocarattere= mid(data, len(data), 1)
			
			ls_checkdigit= f_cfcheckdigit(data)
			
			if ls_checkdigit <> ls_ultimocarattere then
						
				messageBox(parent.text, "Il codice fiscale inserito è scorretto.", exclamation!)
						
				goto errore
						
			end if
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
	
		case "citta_nas"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
			
			
		case "prov_nas"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
			
		case "cod_nazione"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			ls_old= this.Describe( "Evaluate('LookUpDisplay(cod_nazione) ', "+ string(row) + ")")	
			
			search_string=  getItemString(row, this.getColumnName())
			select descrizione into :ls_old from nazioni where cod_nazione= :search_string;
			
			search_string=  data
			select descrizione into :ls_new from nazioni where cod_nazione= :search_string;

			
		case "cod_cittadinanza"
			
			ls_session_s.causale= "ANAGRAFICA"	
			
			search_string=  getItemString(row, this.getColumnName())
			select descrizione into :ls_old from nazioni where cod_nazione= :search_string;
			
			search_string=  data
			select descrizione into :ls_new from nazioni where cod_nazione= :search_string;
			
		case "cod_prof"
			
			ls_session_s.causale= "ANAGRAFICA"			

			search_string= data
			select descrizione into :ls_new from professioni where cod_prof= :search_string;
			
			ls_old= this.Describe( "Evaluate('LookUpDisplay(cod_prof) ', "+ string(row) + ")")			
			
		case "ind_dom"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			if this.getItemString(row, "flag_ldr")= 'S' then
			messageBox(parent.text, "Attenzione, il domicilio di "+ls_cognomenome+" è registrato come luogo di riunione.~n"+&
												"Ricordati di verificare se il nuovo domicilio è luogo di riunione o no e, eventualmente, modifica il dato.", exclamation!)
			
			end if
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
			
		case "flag_ldr"
			
			ls_session_s.causale= "STRUTTURA"
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data				
			
		case "cognome"
			
			ls_session_s.causale= "ANAGRAFICA"
			
			if len(trim(data))= 0 then goto errore
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				goto errore
				
			end if
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
	
		case "nome"
			
			ls_session_s.causale= "ANAGRAFICA"			
			
			if len(trim(data))= 0 then goto errore						
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				goto errore
				
			end if
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data		
			
		case "flag_npa"
			
			if data= '1' then // se non partecipa alle attività viene rimosso dalle liste...
															
				if messageBox( parent.text, "Attenzione: verrà disattivato l'accesso alle applicazioni.~nConfermi?", exclamation!, yesNo!, 2)= 2 then
					this.resetUpdate()
					this.reselectRow(row)
					goto errore
				end if	
			
				if f_deletefromliste(is_current_item_s.codice) = -1 then
					goto erroresql
				end if		
				if f_disabilitafunzioni(is_current_item_s.codice, 'MEM', data) = -1 then
					goto erroresql
				end if					
			end if
			
			ls_session_s.causale= "STRUTTURA"	
			
			if getItemString(row, this.getColumnName())= '0' then
				ls_old= 'Si'
			else
				ls_old= 'No'
			end if
			
			if data= '0' then
				ls_new= 'Si'
			else
				ls_new= 'No'
			end if			
			
		case "cod_div"
			
			ls_session_s.causale= "STRUTTURA"			
	
			/*
			 * Verifica che il nuovo gruppo (ex divisione) sia consistente con le responsabilità...
			 */
			 
			 ls_resp= this.getItemString(row, "cod_att_ist_1")
			 
			 select cod_div
			 into :ls_div
			 from att_ist
			 where cod_att_ist= :ls_resp;
			 
			 if trap_sql(sqlca, "ITEMCHANGED010") < 0 then goto erroresql
			 
			 if ls_div <> data  and ls_div <> "0" then
				messageBox(parent.text, "Il nuovo gruppo è incongruente con la prima responsabilità attuale")
				//goto errore
			end if
			
			 ls_resp= this.getItemString(row, "cod_att_ist_2")			
			
			 select cod_div
			 into :ls_div
			 from att_ist
			 where cod_att_ist= :ls_resp and cod_div <> 0;
			 
			 if trap_sql(sqlca, "ITEMCHANGED011") < 0 then goto erroresql			 
			 
			 if ls_div <> data  and ls_div <> "0" then
				messageBox(parent.text, "Il nuovo gruppo è incongruente con la seconda responsabilità attuale")
				//goto errore
			end if		
			
				choose case integer(this.getItemString(row, "cod_div"))
						
					case 1
						
						ls_old= 'U'
						
					case 2
						
						ls_old= 'D'
						
					case 3
						
						ls_old= 'GU'
						
					case 4
						
						ls_old= 'GD'
						
				end choose
						
			
				choose case integer(data)
						
					case 1
						
						ls_new= 'U'
						
					case 2
						
						ls_new= 'D'
						
					case 3
						
						ls_new= 'GU'
						
					case 4
						
						ls_new= 'GD'
						
				end choose

		case "comune"	
			
			ls_session_s.causale= "ANAGRAFICA"			
		
			s_strade s_strade_s
			
			s_strade_s.comune= trim(data)
			ls_old= s_strade_s.comune
			
			if s_strade_s.comune= "" or isNull(s_strade_s.comune) then return 0
			
			f_cap(s_strade_s)
			
//					choose case s_strade_s.return_code
//							
//						case 0
//							
//							messageBox(this.title, "Operazione annullata.", information!)
//							
//						case -1
//							
//							li_ret= 1
//							goto fine
//							
//						case 1
//							
//							this.setText("")
//							
//							li_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
//							
//							li_err= this.SetItem ( row, "comune", s_strade_s.comune )
//				
//							li_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
//							
//							li_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
//										
//							li_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//							
//							li_ret= 1
//							
//							goto fine
//							
//						case 2
//							
//							this.setText("")
//							
//							li_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
//							
//							li_err= this.SetItem ( row, "comune", s_strade_s.comune )
//							
//							li_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
//							
//							li_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//							
//							li_ret= 0
//							
//							goto fine
//							
//					end choose

			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
				
		case "cod_att_ist_1"
			
			ls_session_s.causale= "STRUTTURA"
			
			/*
			 * Verifica che la responsabilità 1 sia consistente con la divisione...
			 */
			 
			 select cod_div
			 into :ls_div
			 from att_ist
			 where cod_att_ist= :data;
			 
			 if trap_sql(sqlca, "ITEMCHANGED012") < 0 then goto erroresql				 
			 
			 if ls_div <> this.getItemString(row, "cod_div") and ls_div <> "0" then
				messageBox(parent.text, "La nuova prima responsabilità è incongruente con il gruppo attuale")
				//goto errore
			end if					
			
			if data = "000" then
				SetItem ( row, "cod_att_ist_2", "000" )
				this.Object.cod_att_ist_2.Protect='1'
			else
				this.Object.cod_att_ist_2.Protect='0'
			end if
			
			ls_old= this.Describe( "Evaluate('LookUpDisplay(cod_att_ist_1) ', "+ string(row) + ")")		
			
			search_string= data
			select descrizione into :ls_new from att_ist where cod_att_ist = :search_string;			
	
		case "cod_att_ist_2"
			
			ls_session_s.causale= "STRUTTURA"			
			
			/*
			 * Verifica che la responsabilità 2 sia consistente con la divisione...
			 */
			 
			 select cod_div
			 into :ls_div
			 from att_ist
			 where cod_att_ist= :data;
			 
			 if trap_sql(sqlca, "ITEMCHANGED013") < 0 then goto erroresql				 
			 
			 if ls_div <> this.getItemString(row, "cod_div") and ls_div <> "0" then
				messageBox(parent.text, "La nuova seconda responsabilità è incongruente con il gruppo attuale")
				//goto errore
			end if	
			
			ls_old= this.Describe( "Evaluate('LookUpDisplay(cod_att_ist_2) ', "+ string(row) + ")")		
			
			search_string= data
			select descrizione into :ls_new from att_ist where cod_att_ist = :search_string;					
	
		case "codice_staff"
			
			ls_session_s.causale= "STRUTTURA"	
			
			ls_old= this.Describe( "Evaluate('LookUpDisplay(codice_staff) ', "+ string(row) + ")")				

			search_string= data
			select descrizione into :ls_new from staff_e_resp where codice_staff = :search_string;	
			
		case "data_nas"
			
			ls_session_s.causale= "ANAGRAFICA"			
						
			if f_min ( data ) = 1 then
				li_ret= 1
				goto fine
			end if	
			
			ls_old= string(getItemDatetime(row, this.getColumnName()), "dd.mm.yyyy")
			ls_new= string(datetime(data), "dd.mm.yyyy")		
	
		case "data_cer"
			
			ls_session_s.causale= "STRUTTURA"			
			
			if date ( mid ( data, 1, 10 ) ) > today ( ) then
				MessageBox ( "Attenzione", "Data posteriore a quella odierna.", exclamation! )
				li_ret= 1
				goto fine
			end if
			
			ls_old= string(getItemDatetime(row, this.getColumnName()), "dd.mm.yyyy")
			ls_new= string(datetime(data), "dd.mm.yyyy")	
			
			SetColumn ( "luogo_cer" )			
	
		case "luogo_cer"
			
			ls_session_s.causale= "STRUTTURA"	
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
			
		case "pres_da"
			
			ls_session_s.causale= "STRUTTURA"			
			
			if len(trim(data))= 0 then goto errore
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				goto errore
				
			end if		
			
			ls_old= getItemString(row, this.getColumnName())
			ls_new= data			
	
		case "cod_dis" // Status può essere: MEM, DIM, DEC, TFE, ISG, NOP
			
						ls_session_s.causale= "STATUS"
						ls_session_s.status_src= getItemString(row, this.getColumnName())
						ls_session_s.status_tgt= data	
						
						if data= "DIM" OR data= "DEC" OR data= "NOP"  /* OR data= "TFE"*/ OR data= "ISG" /*provvisoriamente commentato */ then // esegue una copia del record corrente sulla tabella membri_fs e cancella il record stesso dalla tabella membri_gerarchica.
										
							
						if data= "NOP" then
								if this.getItemString(row, "okatagi") = 'A' OR &
									this.getItemString(row, "tokuso") = 'A' OR &
										this.getItemString(row, "omamori") = 'A'  then	
											messageBox("Operazione annullata", "Attenzione, la persona è assegnataria di Gohonzon (vedi lo storico).~n"+&
																				"Per assegnare questo status occorre, prima, effettuare la restituzione.", information!)
											this.resetUpdate()
											this.reselectRow(row)
											goto errore
								end if
						end if
							
							ls_codice_fam=  this.getItemString(row, "codice_fam")
							
							if ls_codice_fam <> "" and NOT isNull(ls_codice_fam) then
								messageBox( parent.text, "Attenzione: la persona è inserita in un nucleo famigliare,~nprima della variazione è necessario che il nucleo sia già stato sciolto.", StopSign!)
								this.resetUpdate()
								this.reselectRow(row)
								goto errore
								
							end if		
									
									choose case data
											
										case "DIM"
											
											ls_archivio= "dimissionari"
											
										case "DEC"
											
											ls_archivio= "deceduti"
											
										case "TFE"
											
											ls_archivio= "trasferiti definitivamente all'estero"
											
										case "ISG"
											
											ls_archivio= "membri AINS/ISG"
											
										case "NOP"
											
											ls_archivio= "non praticanti"											
											
									end choose
									
									if messageBox( parent.text, "Attenzione: i dati verranno spostati nell'archivio "+ls_archivio+" e rimossi dall'anagrafica.~nConfermi?", exclamation!, yesNo!, 2)= 2 then
										this.resetUpdate()
										this.reselectRow(row)
										goto errore
									end if	
									
									this.setItem(row, "cod_att_ist_1", '000')
									this.setItem(row, "cod_att_ist_2", '000')
									this.setItem(row, "codice_staff", '000')
									
									this.setItem(row, "flag_cn", '0')
									this.setItem(row, "flag_cdf", '0')
									this.setItem(row, "flag_consulta", '0')
									this.setItem(row, "flag_auditore_consulta", '0')
									this.setItem(row, "flag_ministro_culto", '0')
									
						
								// rimozione dalle liste di consegna messaggi...
								if f_deletefromliste(ls_session_s.codice) = -1 then goto erroresql		
								
								// disabilita l'accesso a GA, RGA, OpC, SADE?
								if f_disabilitafunzioni(ls_session_s.codice, data, '0') = -1 then goto erroresql	
									
								// avanti con la cancellazione...
									
								this.update(true, false)
							
								open(w_wait_snoopy)
								
									li_ret= f_insert_fuori_struttura(ls_session_s.codice, data)
								
									if li_ret < 0 then goto erroresql
									
									commit;
									
									if trap_sql(sqlca, "COMMITFS01") < 0 then goto erroresql
														
									this.resetUpdate()
									
									this.reset()
								
									w_struttura_tv_tab.setRedraw(false)
								
										ll_currentHandle= tv_struttura.findItem(currentTreeItem!, ll_currentHandle)
										
										ll_parentHandle=  tv_struttura.findItem(parentTreeItem!, ll_currentHandle)
										
										tv_struttura.deleteItem(ll_currentHandle)
										
										//uodw_aggiornamento.setRedraw(false)
										
											tv_struttura.uf_visualizzanuovoitem(ll_parentHandle)
										
										//uodw_aggiornamento.setRedraw(true)
										
										//lv_dettaglio.setRedraw(false)
									
											tv_struttura.event ue_lvfdettaglio(ll_parentHandle)
										
										//lv_dettaglio.setRedraw(true)	
			
								close(w_wait_snoopy)
								
								tv_struttura.setRedraw(true)
								
								w_struttura_tv_tab.setRedraw(true)		
								
								messageBox( parent.text, "Lo spostamento nell'archivio "+ls_archivio+" è stato effettuato.~nPer stampare la scheda anagrafica andare in Amministrazione -> Gestione "+ls_archivio, information!)
								
						end if		
						
						if (data = "TFE") then // provvisorio finchè non si attiva il trasferimento in membri_fs...
										
								if this.getItemString(row, "cod_att_ist_1") <> '000' OR &
									this.getItemString(row, "cod_att_ist_2") <> '000' OR &
										this.getItemString(row, "codice_staff") <> '000'  then	
										
											if messageBox("Responsabilità e Staff", "Attenzione, verranno annullate responsabilità e appartenenza agli staff.~n"+&
																				"Vuoi continuare?", exclamation!, okcancel!, 2)= 2 then
												this.resetUpdate()
												this.reselectRow(row)
												goto errore
												
											end if
								end if								
								
								
								this.setItem(row, "cod_att_ist_1", '000')
								this.setItem(row, "cod_att_ist_2", '000')
								this.setItem(row, "codice_staff", '000')
								
								this.setItem(row, "flag_cn", '0')
								this.setItem(row, "flag_cdf", '0')
								this.setItem(row, "flag_consulta", '0')
								this.setItem(row, "flag_auditore_consulta", '0')
								this.setItem(row, "flag_ministro_culto", '0')
								
						end if	
					
					if f_deletefromliste(is_current_item_s.codice) = -1 then
						goto erroresql
					end if
	
END CHOOSE

fine: tv_struttura.setRedraw(true)
		
		ls_nomecolonna= this.describe(dwo.name+"_t"+".text")+" "
		
		ls_tipo=  this.describe(dwo.name+".Coltype")
		
		//
//		string rownumber, displayvalue
//		rownumber = String(this.GetRow())
//		ls_old = this.Describe( "Evaluate('LookUpDisplay(cod_div) ', "+ rownumber + ")")

//		messageBox("test", displayvalue+" - "+getText())
		
	//	this.GetValue ( "cod_div", integer(getText() )
//		messageBox("test", ls_old)
//		messageBox("test",this.GetValue ( "cod_div", integer(data ) ))

		//
		
//		if Pos ( ls_tipo, "char", 1) > 0 then
			
			//messageBox("test", this.getText())
			
			if isNull(ls_old) OR ls_old="" then ls_old= 'Non definito'
			if isNull(ls_new) OR ls_new= "" then ls_new= 'Non definito'
		
			ls_message= ls_session_s.causale+" - "+ls_nomecolonna+ ls_old+" - Modificato in: "+ ls_new
			
//		elseif Pos ( ls_tipo, "datetime", 1) > 0 then
//			
//			ls_message= ls_session_s.causale+ ": "+ls_nomecolonna+string(this.getItemDatetime(row,  this.getColumnName()), "dd.mm.yyyy")+" - Modificata in: "+string(datetime(data), "dd.mm.yyyy")
//			
//		else
//			
//			ls_message= ls_session_s.causale+ ": "+ls_nomecolonna+string(this.getItemDatetime(row,  this.getColumnName()))+" - Modificato in: "+string(datetime(data))
//			
//		end if
		
		if ls_message <> "" then 

			li_err= f_log(ls_session_s, ls_message, TRUE)
		
			if li_err= -1 then messageBox("Anagrafica variazioni", "Errore in scrittura sul log eventi", Exclamation!)
		
		end if

	return li_ret

errore:

	if ib_isgrid= false then this.object.b_aggiorna.visible= '0'

		rollback;
		trap_sql(sqlca, "ERRORHANDLING01")
	
	 	tv_struttura.setRedraw(true)
	 
		return 1
	 
erroresql:

	if isValid(w_wait_snoopy) then close(w_wait_snoopy)

	if ib_isgrid= false then this.object.b_aggiorna.visible= '0'

		rollback;
		trap_sql(sqlca, "ERRORHANDLING02")
		
		 tv_struttura.setRedraw(true)
		 
		messageBox( parent.text, "Si è verificato un errore, le modifiche sono state annullate.", exclamation!)
	 
	 return 1	 



end event

event retrieveend;call super::retrieveend;if rowcount <= 0 then return

string ls_codice

ls_codice= this.getItemString(1, "codice")

this.object.gb_dati.text= "Codice: "+ls_codice

this.object.b_aggiorna.visible= false

//if f_has_p('D') = false then
//	string ls_filter
////	ls_filter= "cod_dis <> 'DIM' and cod_dis <> 'TAI' " GdS 02/02/2010
//	ls_filter= "cod_dis <> 'DIM' "	
//	idwc_cod_dis.SetFilter ( ls_filter )
//	idwc_cod_dis.Filter ( )
//end if

il_modifiedhandle= is_current_item_s.handle

tab_dettaglio.height = parentWindow().height - 350

//idw_dettaglio.height= tab_dettaglio.height -160 -idw_dettaglio.y

// li_ruolo_rga, li_utente_abilitato
 

// Se l'utente ha il ruolo supervisore per una certa funzione o Direzione Segreteria...
 
 if ( (s_session_s.s_utente_s.i_ruolo_stat= 4 OR s_session_s.s_utente_s.i_ruolo_rga= 2 OR s_session_s.s_utente_s.i_ruolo_opc= 1 OR s_session_s.s_utente_s.i_ruolo_ediz= 5 OR f_has_p('S'))/*  AND  this.getItemString(1, "cod_dis")= 'MEM' AND this.getItemString(1, "flag_npa")= '0'*/) then
	
	this.object.b_accessoremoto.visible= 1
	
else
	
	this.object.b_accessoremoto.visible= 0
	
end if

 if s_session_s.s_utente_s.s_ldp= '1' OR f_has_p('S') then
	
	this.object.b_lettera.visible= 1
	
else
	
	this.object.b_lettera.visible= 0
	
end if





end event

event updatestart;call super::updatestart;// Aggiorna la tabella storico_resp con i nuovi codici responsabilità...

integer li_anno
string ls_cod, ls_data, ls_cognome, ls_nome

if getRow()= 0 then return 0

this.acceptText()

ls_cognome= this.getItemString(getRow(), "cognome")

if( left(ls_cognome, 1)= " ") then

	messageBox(parent.text, "Eliminare gli spazi vuoti all'inizio del cognome.", exclamation!)
	
	return 1
	
end if		

ls_nome= this.getItemString(getRow(), "nome")

if( left(ls_nome, 1)= " ") then

	messageBox(parent.text, "Eliminare gli spazi vuoti all'inizio del nome.", exclamation!)
	
	return 1
	
end if	

ls_data= string(this.getItemDatetime(getRow(), "data_nas"), "dd.mm.yyyy")

if f_min ( ls_data ) = 1 then return 1

///*
// *  Se ha più di 40 anni e fa parte della div. giovani dà un warning...
// */
// 

// select datepart(year, getDate()) - datepart(year, data_nas)
// into :li_anno
// from membri_gerarchica
// where codice= :is_current_item_s.codice;
// 
//if trap_sql(sqlca, "UPDATESTART01") < 0 then return 1 
//
//if li_anno > 40 then
//	
//		ls_cod= this.getItemString(getRow(), "cod_div")
//		
//		if ls_cod= "3" OR ls_cod= "4" then
//			if messageBox(parent.text, "Fa parte della div. giovani e ha più di 40 anni.~nNon esiste una regola a riguardo, tuttavia potrebbe esserci un'inesattezza.~nVuoi effettuare l'aggiornamento della divisione?", question!, yesNo!, 2) = 1 then return 1
//		end if
//		
//end if
//		
//this.setItem(getRow(), "u_ult_mod", s_session_s.s_utente_s.s_nome_esteso)
//this.setItem(getRow(), "d_ult_mod", string(today(), "dd.mm.yyyy hh:mm") )

if this.getItemStatus(getRow(), "cod_att_ist_1", primary!)= dataModified! then
	
	ls_cod= this.getItemString(getRow(), "cod_att_ist_1")
	
	  INSERT INTO storico_resp  
         ( codice,   
           livello,   
           cod_att_ist,   
           utente,   
           data,   
           note )  
	  VALUES ( :is_current_item_s.codice,   
				  1,   
				  :ls_cod,   
				  :s_session_s.s_utente_s.s_nome_esteso,   
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
	  VALUES ( :is_current_item_s.codice,   
				  2,   
				  :ls_cod,   
				  :s_session_s.s_utente_s.s_nome_esteso, 
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

s_struttura s_struttura_s
integer li_err
long ll_currentHandle, ll_parentHandle 
treeViewItem ltv_item, ltvi_current

//ll_currentHandle= is_current_item_s.handle

tv_struttura.getItem(il_modifiedhandle, ltv_item)

s_struttura_s= ltv_item.data

select
flag_ldr,
cod_dis,
flag_npa,
cod_att_ist_1,
cod_att_ist_2,
cognome,
nome,
cod_div
into
:s_struttura_s.flag_ldr,
:s_struttura_s.cod_dis,
:s_struttura_s.flag_npa,
:s_struttura_s.responsabilita1,
:s_struttura_s.responsabilita2,
:s_struttura_s.cognome,
:s_struttura_s.nome,
:s_struttura_s.cod_div
from membri_gerarchica
where codice= :is_current_item_s.codice;

trap_sql(sqlca, "GDS1")

		
		ltv_item.statePictureIndex= 0
		if s_struttura_s.flag_ldr= "S" then ltv_item.statePictureIndex= 1
		
		
		 ltv_item.pictureIndex= 0
		if s_struttura_s.cod_dis= "MEM" and s_struttura_s.flag_npa= "0" then ltv_item.pictureIndex= gi_maxlivello + integer(s_struttura_s.cod_div )
		
		 ltv_item.bold= false
		if s_struttura_s.responsabilita1= "101" OR s_struttura_s.responsabilita2= "101" then ltv_item.bold= true
		
		
		ltv_item.label= f_iniziali(trim(s_struttura_s.cognome) + " " + trim(s_struttura_s.nome ) )
		
		/* GdS 03/04/2012 */
		
		ltv_item.data= s_struttura_s
		
ltv_item.selectedPictureIndex=  ltv_item.pictureIndex

li_err= tv_struttura.setItem(il_modifiedhandle, ltv_item)
end event

event itemfocuschanged;call super::itemfocuschanged;return 0
end event

type tabpage_andamenti from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 4059
integer height = 2812
long backcolor = 67108864
string text = "Report e andamenti"
long tabtextcolor = 33554432
string picturename = "Custom067!"
long picturemaskcolor = 536870912
gb_runreport gb_runreport
rb_4 rb_4
sle_report_struttura_corrente sle_report_struttura_corrente
rb_3 rb_3
rb_offertestatus rb_offertestatus
sle_struttura sle_struttura
sle_report sle_report
dw_reportname dw_reportname
rb_2 rb_2
rb_1 rb_1
rb_stampabollettini rb_stampabollettini
rb_offerteresp rb_offerteresp
cb_runreport cb_runreport
rb_offerte rb_offerte
rb_offertediv rb_offertediv
cb_apri cb_apri
gb_report gb_report
sle_runreport sle_runreport
rb_organigramma rb_organigramma
rb_offertetab rb_offertetab
end type

on tabpage_andamenti.create
this.gb_runreport=create gb_runreport
this.rb_4=create rb_4
this.sle_report_struttura_corrente=create sle_report_struttura_corrente
this.rb_3=create rb_3
this.rb_offertestatus=create rb_offertestatus
this.sle_struttura=create sle_struttura
this.sle_report=create sle_report
this.dw_reportname=create dw_reportname
this.rb_2=create rb_2
this.rb_1=create rb_1
this.rb_stampabollettini=create rb_stampabollettini
this.rb_offerteresp=create rb_offerteresp
this.cb_runreport=create cb_runreport
this.rb_offerte=create rb_offerte
this.rb_offertediv=create rb_offertediv
this.cb_apri=create cb_apri
this.gb_report=create gb_report
this.sle_runreport=create sle_runreport
this.rb_organigramma=create rb_organigramma
this.rb_offertetab=create rb_offertetab
this.Control[]={this.gb_runreport,&
this.rb_4,&
this.sle_report_struttura_corrente,&
this.rb_3,&
this.rb_offertestatus,&
this.sle_struttura,&
this.sle_report,&
this.dw_reportname,&
this.rb_2,&
this.rb_1,&
this.rb_stampabollettini,&
this.rb_offerteresp,&
this.cb_runreport,&
this.rb_offerte,&
this.rb_offertediv,&
this.cb_apri,&
this.gb_report,&
this.sle_runreport,&
this.rb_organigramma,&
this.rb_offertetab}
end on

on tabpage_andamenti.destroy
destroy(this.gb_runreport)
destroy(this.rb_4)
destroy(this.sle_report_struttura_corrente)
destroy(this.rb_3)
destroy(this.rb_offertestatus)
destroy(this.sle_struttura)
destroy(this.sle_report)
destroy(this.dw_reportname)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.rb_stampabollettini)
destroy(this.rb_offerteresp)
destroy(this.cb_runreport)
destroy(this.rb_offerte)
destroy(this.rb_offertediv)
destroy(this.cb_apri)
destroy(this.gb_report)
destroy(this.sle_runreport)
destroy(this.rb_organigramma)
destroy(this.rb_offertetab)
end on

type gb_runreport from groupbox within tabpage_andamenti
integer x = 18
integer y = 228
integer width = 2679
integer height = 820
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Report con raggruppamenti sui livelli di struttura"
end type

type rb_4 from radiobutton within tabpage_andamenti
integer x = 87
integer y = 476
integer width = 901
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consegne: nell~'anno con incremento"
end type

event clicked;ii_selreport= 12
sle_runreport.text= "Hai selezionato: Consegne nell'anno con incremento"
cb_runreport.enabled= true
end event

type sle_report_struttura_corrente from singlelineedit within tabpage_andamenti
integer x = 101
integer y = 1156
integer width = 1806
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "Seleziona il report"
boolean border = false
end type

type rb_3 from radiobutton within tabpage_andamenti
integer x = 87
integer y = 912
integer width = 951
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consegne: per periodo e per divisione"
end type

event clicked;ii_selreport= 13
sle_runreport.text= "Hai selezionato: Consegne (per periodo)"
cb_runreport.enabled= true
end event

type rb_offertestatus from radiobutton within tabpage_andamenti
boolean visible = false
integer x = 1984
integer y = 752
integer width = 535
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Offerte per status"
end type

event clicked;ii_selreport= 8
sle_runreport.text= "Hai selezionato: Offerte per status"
cb_runreport.enabled= true
end event

type sle_struttura from singlelineedit within tabpage_andamenti
integer x = 18
integer y = 20
integer width = 2674
integer height = 168
integer taborder = 30
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

type sle_report from singlelineedit within tabpage_andamenti
integer x = 101
integer y = 1368
integer width = 1824
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "Seleziona il report"
boolean border = false
end type

type dw_reportname from datawindow within tabpage_andamenti
integer x = 59
integer y = 1280
integer width = 2619
integer height = 912
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "dw_listobjects"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;long ll_row

cb_apri.enabled= true // false

string ls_syntax, ls_errors

ll_row= this.getRow()

f_select_current_row(this)

if isNull(ll_row) or ll_row <= 0 then return

is_dataobject= this.getItemString(ll_row, "col1")

ls_syntax= libraryExport(gs_docdir+"\"+gs_reportpath, is_dataobject, exportDataWindow!)

if ls_syntax= "" then
	messageBox(parent.text, "Errore in generazione datawindow:"+ls_syntax, exclamation!)
	return
end if

sle_report_struttura_corrente.text= "Hai selezionato: "+this.getItemString(ll_row, "col3")



end event

event doubleclicked;cb_apri.triggerEvent(clicked!)
end event

type rb_2 from radiobutton within tabpage_andamenti
boolean visible = false
integer x = 87
integer y = 624
integer width = 901
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consegne: confronto stesso periodo"
end type

event clicked;ii_selreport= 14
sle_runreport.text= "Hai selezionato: Consegne a confronto nello stesso periodo"
cb_runreport.enabled= true
end event

type rb_1 from radiobutton within tabpage_andamenti
integer x = 87
integer y = 776
integer width = 901
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consegne: per data cerimonia, luogo"
end type

event clicked;ii_selreport= 3
sle_runreport.text= "Hai selezionato: Consegne (per anno, con incremento)"
cb_runreport.enabled= true
end event

type rb_stampabollettini from radiobutton within tabpage_andamenti
integer x = 1975
integer y = 776
integer width = 549
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa bollettini"
end type

event clicked;ii_selreport= 9
sle_runreport.text= "Hai selezionato: Stampa bollettini"
cb_runreport.enabled= true
end event

type rb_offerteresp from radiobutton within tabpage_andamenti
boolean visible = false
integer x = 1047
integer y = 776
integer width = 859
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Offerte per responsabilità"
end type

event clicked;ii_selreport= 6
sle_runreport.text= "Hai selezionato: Offerte per responsabilità"
cb_runreport.enabled= true
end event

type cb_runreport from commandbutton within tabpage_andamenti
integer x = 1943
integer y = 316
integer width = 617
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Esegui"
end type

event clicked;choose case ii_selreport
		
	case 1 // Organigramma
		
		event ue_runqueryorg(1, 1)
		
	case 2 // Quadro generale struttura
		
		event ue_runqueryorg(2, 1)				
		
	case 3 // Consegne
		
		event ue_runquerystruttura(1, 1)
		
	case 4 // Offerte
		
		event ue_runquery(1, 1)		
		
	case 5 // Offerte per div.
		
		event ue_runquery(2, 1)
		
	case 6 // Offerte per resp.
		
		event ue_runquery(3, 1)
		
	case  7 // Offerte tab.
		
		event ue_runquery(4, 1)
		
	case  8 // Offerte per status
		
		event ue_runquery(6, 1)	
		
	case 9 // Stampa bollettini
		
		s_preview s_preview_s

		s_preview_s.tipo_stampa= "M"
		s_preview_s.criterio= tv_struttura.is_struttura_s.vc_nodo
		
		event ue_bollettini(s_preview_s)
		
	case 10 // Consegne ( nel periodo )
		
		// non attivo event ue_runreport(2, 1)
		
	case 11 // Consegne ( per data e luogo )
		
		// non attivo event ue_runreport(3, 1)	
		
	case 12 // Consegne
		
		event ue_runquerystruttura(2, 1)		
		
	case 13 // Consegne per periodo per divisione
		
		event ue_runreport(4, 1)			
		
	case 14 // Consegne a confronto
		
		event ue_runquerystruttura(3, 1)				
		
end choose

//this.enabled= false
end event

type rb_offerte from radiobutton within tabpage_andamenti
integer x = 1975
integer y = 480
integer width = 859
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Offerte"
end type

event clicked;ii_selreport= 4
sle_runreport.text= "Hai selezionato: Offerte"
cb_runreport.enabled= true
end event

type rb_offertediv from radiobutton within tabpage_andamenti
integer x = 1975
integer y = 636
integer width = 859
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Offerte per divisione"
end type

event clicked;ii_selreport= 5
sle_runreport.text= "Hai selezionato: Offerte per divisione"
cb_runreport.enabled= true
end event

type cb_apri from commandbutton within tabpage_andamenti
integer x = 1943
integer y = 1136
integer width = 617
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Esegui"
end type

event clicked;s_preview s_preview_s
s_struttura s_struttura_loc
treeViewItem ll_tvi
integer li_ret
long ll_handle

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)

if tv_struttura.GetItem(ll_handle, ll_tvi)= -1 then return -1

s_struttura_loc= ll_tvi.data

s_preview_s.dataObject=  is_dataobject
s_preview_s.ib_dwcreate= true
s_preview_s.ib_anteprima= false
s_preview_s.ib_allowstop= true

s_preview_s.criterio= s_struttura_loc.vc_nodo
s_preview_s.anno= year(today())
s_preview_s.livello= s_struttura_loc.livello

s_preview_s.doretrieve= true

if is_current_item_s.livello < 5 and is_dataobject= "dw_completa" then // sopra il Capitolo...

	li_ret= messageBox("Report", "L'estrazione di questo report, su questo livello,  potrebbe durare alcuni minuti;~nE' preferibile effettuare più estrazioni a livelli inferiori.~nVuoi continuare?", Question!, yesNo!, 2)
	
	if li_ret= 2 then return 0
	
end if
	
	openWithParm(w_preview, s_preview_s)
	
	//w_preview.uodw_current.setFilter("annocerimonia= "+string(year(today())) )

//		open(w_wait_snoopy)
//	
	//		w_preview.uodw_current.retrieve(is_current_item_s.vc_nodo, s_preview_s.anno, is_current_item_s.livello)
//			//w_preview.uodw_current.retrieve(is_current_item_s.vc_nodo, s_preview_s.anno,s_preview_s.livello)
//		
//		close(w_wait_snoopy)	

end event

type gb_report from groupbox within tabpage_andamenti
integer x = 18
integer y = 1076
integer width = 2094
integer height = 1184
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Report sulla struttura corrente"
end type

type sle_runreport from singlelineedit within tabpage_andamenti
integer x = 101
integer y = 332
integer width = 1806
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "Seleziona il report"
boolean border = false
end type

type rb_organigramma from radiobutton within tabpage_andamenti
integer x = 1061
integer y = 480
integer width = 901
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Struttura: organigramma e struttura"
end type

event clicked;ii_selreport= 1
sle_runreport.text= "Hai selezionato: Organigramma"
cb_runreport.enabled= true
end event

type rb_offertetab from radiobutton within tabpage_andamenti
boolean visible = false
integer x = 1975
integer y = 616
integer width = 521
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Offerte tabellare"
end type

event clicked;ii_selreport= 7
sle_runreport.text= "Hai selezionato: Offerte tabellare"
cb_runreport.enabled= true
end event

type tabpage_rif from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 4059
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
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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
s_riferimenti_s.codice= is_current_item_s.codice

if this.getRow() <= 0 then return 0

s_riferimenti_s.idx= this.getItemDecimal(this.getRow(), "idx")
s_riferimenti_s.rif_membri= true
openWithParm(w_ins_riferimenti, s_riferimenti_s)
this.retrieve(s_riferimenti_s.codice)
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

//s_session ls_session_s
//
//ls_session_s= s_session_s

mailSession mSes

mailReturnCode mRet

mailMessage mMsg

mailFileDescription a_mailFileDescription[]

integer li_ret

string ls_number, ls_message, ls_mailto

choose case  dwo.name
			
	case "b_p"
		
//		this.setItem(uodw_rif.il_newrow, "codice", is_codice)
		s_riferimenti s_riferimenti_s
		s_riferimenti_s.codice= is_current_item_s.codice
		s_riferimenti_s.idx= 0
	     s_riferimenti_s.rif_membri= true
		li_ret= openWithParm(w_ins_riferimenti, s_riferimenti_s)
		
		if li_ret >= 0 then
			this.setRedraw(false)
				this.retrieve(is_current_item_s.codice)
			this.setRedraw(true)
		end if
		
//		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
//		if wf_riferimenti()= 1 then return 1
		
	case "b_invia"
		
		open(w_check_pw)
		
		if message.doubleParm= -1 then return -1
		
		string ls_mail
		
		ls_mail= this.getItemString(row, "riferimento_descr")
		
		if this.getItemString(row, "cod_rif")= "MA" then
			if pos(ls_mail, "@")= 0 or len(trim(ls_mail) )= 0 then
				messageBox(parent.text, "Indirizzo di posta elettronica non valido.", exclamation!)
				return -1
			end if
			
			setPointer(hourGlass!)
			
			ls_mailto= gs_mailpath+ trim(ls_mail)
			
			li_ret= run(ls_mailto)
			
//			// Create a mail session
//			
//			mSes = create mailSession
//			
//			// Log on to the session
//			
//			mRet = mSes.mailLogon(mailNewSession!)
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail", 'Logon fallito.')
//					return -1
//			
//			END IF
//			
//			mMsg.Recipient[1].address= trim(ls_mail)
//			
//			// Send the mail
//			
//			mRet = mSes.mailSend(mMsg) // +cc
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail Send", 'Mail non inviata')
//					return -1
//			
//			END IF
//			
//			mSes.mailLogoff()
//			
//			DESTROY mSes
			
			return 0
			
		else // SMS
			
			long ll_idx
			
			open(w_composizione_sms)
			
			ls_message= message.stringParm
			
			if ls_message= "" then return -1
			
			mMsg.subject= "SMS"
			
			mMsg.noteText= ls_message
					
			ls_number= uodw_rif.getItemString(row, "riferimento_descr")
			ls_number= f_cleanphonenumber(ls_number)
				
			if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then return -1
			
			// Numero di cellulare= tre cifre di prefisso più 7 cifre di numero telefonico
		
			/*if len(ls_number) <= 10 then*/ //ls_number = '39'+ls_number
				
			if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
			///
			mMsg.recipient[1].name= "smsgateway"
					
			mMsg.recipient[1].address=  ls_number+"@"+s_sms_s.as_smsgateway
					
			mMsg.recipient[1].recipientType= mailTO!
	
	//SMS

			s_sms_s.as_mailuser= s_sms_s.as_smsuser
			s_sms_s.as_mailpw= s_sms_s.as_smspw
			
			s_sms_s.as_mailfrom= s_sms_s.as_smsfrom
			
			//s_sms.as_mailfrom
			
			li_ret= f_sendmail(mMsg, s_sms_s)	
			
			if li_ret = 0 then
				
				messageBox("Invio SMS", "Messaggio inviato.")
				
			else
				
				messageBox("Invio SMS", "Errore, messaggio inviato.")
				
			end if
			
		end if
		
end choose
end event

event itemchanged;//integer li_ret
//string ls_rif, ls_message
////s_session ls_session_s
//
//// Non esegue la script ancestor
//
////ls_session_s= s_session_s
//
//ls_rif= this.getItemString(row, "cod_rif")
//
//if dwo.name= "preferito" then
//	
//	long ll_found
//	
//	// da lasciare... non esegue la script ancestor
//	this.object.b_aggiorna.visible= true
//	
//	if data= '1' then
//		
//		ll_found = this.Find("cod_rif= '"+ls_rif+"' and preferito= '1'", 1, this.RowCount())
//		
//		if ll_found > 0 then
//			
//			this.setItem(ll_found, "preferito", '0')
//			return 0
//			
//		end if
//		
//	else // se data diventa 0...
//		
//		return 2
//		
//	end if
//	
//end if
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

event doubleclicked;call super::doubleclicked;integer li_ret, li_rows
string ls_filter
s_riferimenti s_riferimenti_s

if row <= 0 then return 0

if f_has_p("O")= false then return -1

s_riferimenti_s.idx= this.getItemDecimal(row, "idx")
s_riferimenti_s.rif_membri= true
s_riferimenti_s.codice= is_current_item_s.codice
s_riferimenti_s.cod_rif=  this.getItemString(row, "cod_rif")

/* 
 * Se il riferimento è email avvisa l'operatore che la modifica può essere effettuata solo dall'utente stesso
 * dalla gestione del profilo personale nello Spazio Aderenti.
 */
 
 if s_riferimenti_s.cod_rif= 'MA' then
	messageBox("Riferimenti", "L~'email può essere modificata solo dall~' utente direttamente nella sezione ~"I tuoi riferimenti~" dello Spazio Aderenti", information!)
//	return 0
end if

openWithParm(w_ins_riferimenti, s_riferimenti_s)

this.setRedraw(false)

this.retrieve( is_current_item_s.codice)

ls_filter= "cod_rif= '"+s_riferimenti_s.cod_rif+"'"
this.setFilter(ls_filter)
this.filter()

li_rows= this.rowCount()

this.setFilter("")
this.filter()

if li_rows > 0 then 

	select count(*)
	into :li_ret
	from riferimenti
	where	codice=  :is_current_item_s.codice and
				cod_rif= :s_riferimenti_s.cod_rif and 
				predefinito= '1';
	if trap_sql(sqlca, "MODRIF01") < 0 then goto fine	
	
				if li_ret= 0 then // se nessun riferimento del genere è qualificato come preferito...
					update riferimenti
					set predefinito= '1'
					where 	codice= : is_current_item_s.codice and
								cod_rif= :s_riferimenti_s.cod_rif and 
								idx= (select MAX(idx) from riferimenti
								where 	codice= : is_current_item_s.codice and
											cod_rif= :s_riferimenti_s.cod_rif);
					if trap_sql(sqlca, "MODRIF02") < 0 then goto fine	
					
					this.uof_aggiorna()
					
					if trap_sql(sqlca, "MODRIF03") < 0 then goto fine	
					
					this.retrieve( is_current_item_s.codice)						
				end if		
				
end if
			
fine: this.setRedraw(true)			

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
integer width = 4059
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
boolean ib_isgrid = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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
integer width = 4059
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
integer width = 2880
integer taborder = 90
string dataobject = "dw_info"
boolean ib_isgrid = true
boolean ib_stampatoda = true
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
	
	
	
	open(w_check_pw)
	
	if message.doubleParm= 1 then
	
		//visualizza gli importi
		uodw_storicocontributi.Object.importo.Visible= 1
		uodw_storicocontributi.Object.importo_t.Visible= 1
		uodw_storicocontributi.Object.cimporto.Visible= 1
		
		uodw_storicocontributi.object.b_importi.text= "Nascondi importi"
		
	else
		
		uodw_storicocontributi.Object.importo.Visible= 0
		uodw_storicocontributi.Object.importo_t.Visible= 0
		uodw_storicocontributi.Object.cimporto.Visible= 0
		
	end if
	
else
	
		uodw_storicocontributi.Object.importo.Visible= 0
		uodw_storicocontributi.Object.importo_t.Visible= 0
		uodw_storicocontributi.Object.cimporto.Visible= 0	
		
		uodw_storicocontributi.object.b_importi.text= "Visualizza importi"
	
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
integer width = 4059
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
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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

string ls_message, ls_nome

s_session ls_session_s

ls_session_s= s_session_s
ls_session_s.context= "Anagrafica - Liste"
ls_session_s.causale= "LISTE "

//if f_np(gc_superv)= 1 then return 0
//string ls_lista

//ls_lista= this.getItemString(this.getRow(), "cod_lista")
ls_nome= w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString(+&
				w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "cognome")+&
					" "+w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString(+&
							w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "nome")		


choose case dwo.name
		
	case "b_aggiorna"
		
		ls_message= ls_session_s.causale+" - Inserito in "+this.getItemString(row, "cod_lista")
		
		if uof_esegui(ic_aggiornamento) < 0 then return -1
			
		f_log(ls_session_s, ls_message, true)	
		
		this.object.b_aggiorna.visible= false
		
	case "b_p" 
		
		openWithParm(w_assegna_lista,  is_current_item_s.codice)
		
		if message.doubleParm < 0 then return
		
		this.retrieve( is_current_item_s.codice)
	
	case "b_m"
		
		ls_message= ls_session_s.causale+" - Rimosso da "+this.getItemString(row, "cod_lista")
		
		if uof_esegui(ic_cancellazione) <=0 then return -1 /* <= a 0 in caso non venga confermata la cancellazione */
		
		f_log(ls_session_s, ls_message, true)	
	
end choose
end event

event itemchanged;call super::itemchanged;//decimal ld_idx
long ll_found
string ls_message,	ls_tipo, ls_tipo_rif, ls_cod_lista
s_riferimenti s_riferimenti_s
		
if dwo.name= "idx" then
	
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
			r.codice=  : is_current_item_s.codice  and 
			t.cod_tipo= l.cod_tipo and
			l.cod_lista= :ls_cod_lista;

			if trap_sql(sqlca, "LISTE01") < 0 then return -1
			
			if ls_tipo_rif= "" or isNull(ls_tipo_rif) then
						
				messageBox(parent.text, "Non esiste un riferimento del tipo richiesto: inserirlo ora.")
				
				s_riferimenti_s.codice=  is_current_item_s.codice
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
integer width = 4059
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
event type integer ue_update_cod_studio ( )
integer width = 2793
integer height = 1484
integer taborder = 50
string dataobject = "ds_curr_studio"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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

event type integer ue_update_cod_studio();string ls_studio, ls_descrizione
//
//ls_codice= this.getItemString(this.getRow(), "codice")


select MAX(cod_studio) 
into :ls_studio
from esami_curr e where e.codice=  : is_current_item_s.codice and esito= 'P';

if trap_sql(sqlca, "UPDSTUDIO01") < 0 then return -1

if isNull(ls_studio) then ls_studio= "00"

//if ls_studio= "00" then return 0 // nessun riscontro nello storico di ammissione ad un livello...

/*
select descrizione
into :ls_descrizione
from esami_livelli
where cod_studio= :ls_studio;

if trap_sql(sqlca, "UPDSTUDIO02") < 0 then return -1

if messageBox(parent.text, "Anche il livello di studio in anagrafica verrà aggionato a: "+ls_descrizione+&
													"~nVuoi procedere?", question!, yesNo!, 2)= 2 then return -1
													
*/													

update membri_gerarchica 
set cod_studio= :ls_studio
where membri_gerarchica.codice= : is_current_item_s.codice;

if trap_sql(sqlca, "UPDSTUDIO02") < 0 then return -1

return 0
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_se

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_struttura_tv_tab.PointerX(), w_struttura_tv_tab.PointerY() )

end event

event itemerror;call super::itemerror;return 1
end event

event buttonclicked;call super::buttonclicked;//if f_np(gc_superv)= 1 then return 0

integer li_case, li_livello
string ls_dt1, ls_dt2, ls_messaggio

choose case dwo.name
		
	case "b_adesione"
		
		long ll_ret
		s_adesioni s_adesioni_s
		string ls_cod_studio_sessione, ls_cod_studio_attuale, ls_cod_studio_precedente
		
		// rileva il livello di studio attuale..
		
		select cod_studio
		into :ls_cod_studio_attuale
		from membri_gerarchica
		where codice= :is_current_item_s.codice;
		
		if trap_sql(sqlca, "INSADESIONI00") < 0 then return -1	
		
		li_livello= integer(ls_cod_studio_attuale)
		
		// selezione della sessione di esame a seconda del livello di studio attuale...
		
		 openWithParm(w_seleziona_sessione_esami, integer(ls_cod_studio_attuale) +1)
		
		s_adesioni_s= message.powerObjectParm
		
		if s_adesioni_s.tipo_evento= -1 then return 0
		
		s_adesioni_s.cod_studio_attuale= ls_cod_studio_attuale
		
		if f_is_aventediritto(s_adesioni_s,  is_current_item_s.codice)= 1 then return 0
		
		// se tutto è a posto inserisce l'adesione
		ll_ret= uof_esegui(ic_inserimento)
		
		ls_cod_studio_sessione= '0'+string(s_adesioni_s.tipo_evento)
		
		this.setItem(this.getRow(), "id_esami_sessioni",  s_adesioni_s.id_sessione)
		this.setItem(this.getRow(), "cod_studio",  ls_cod_studio_sessione)
		this.setItem(this.getRow(), "data_esame",  s_adesioni_s.data_evento)
		this.setItem(this.getRow(), "esito", "I")
		this.setItem(this.getRow(), "codice",  is_current_item_s.codice)
		
		this.object.b_aggiorna.visible= true
		
	case "b_diploma"
		
		integer li_ret
		long ll_row
		string ls_esito, ls_nome, ls_div
		
		open (w_diplomi)
		
			li_ret= messageBox("Seleziona il modello", "Vuoi utilizzare il modello vecchio?", Question!, YesNo!, 1)
			
			
			if li_ret= 1 then
				
				w_diplomi.uodw_diplomi.dataObject= "dw_diplomi_europa_saito"
				
			else
				
				w_diplomi.uodw_diplomi.dataObject= "dw_diplomi_europanew"
				
			end if
				
			ls_esito= uodw_se.getItemString(row, "esito")
			
			ll_row= w_diplomi.uodw_diplomi.insertRow(0)
			
			w_diplomi.uodw_diplomi.setItem(ll_row, "data_esame", uodw_se.getItemdatetime(row, "data_esame") )
			w_diplomi.uodw_diplomi.setItem(ll_row, "livello", uodw_se.getitemString(row, "cod_studio") )
			
			ls_nome= trim(uodw_se.getItemString(row, "nome"))+" "+trim(uodw_se.getItemString(row, "cognome"))
			
			ls_div= uodw_se.getItemString(row, "cod_div")
			
			ls_nome= f_iniziali(ls_nome)
			
			w_diplomi.uodw_diplomi.setItem(ll_row, "cognomenome",  ls_nome )	
			
			w_diplomi.uodw_diplomi.setItem(ll_row, "cod_div",  ls_div )	
	
		
	case "b_p" 
	
	this.setItem(this.getRow(), "codice",  is_current_item_s.codice)
	this.resetUpdate()
	
	this.setItemStatus(this.getRow(), 0, Primary!, new!)
	
//case "b_anag"
//	
//	string ls_studio, ls_codice, ls_esito, ls_cod_studio_anag
//	
//	ls_codice= this.getItemString(this.getRow(), "codice")
//	ls_studio= this.getItemString(this.getRow(), "cod_studio")
//	
//	select cod_studio
//	into :ls_cod_studio_anag
//	from membri_gerarchica
//	where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "UPDSTUDIO01") < 0 then return -1
//	
//	if ls_cod_studio_anag= ls_studio then
//		
//		messageBox(parent.text, "Il livello di studio, in anagrafica, è già aggiornato.", information!)
//		return 0
//		
//	else
//		
//		if messageBox(parent.text, "Attualmente il livello di studio, in anagrafica, è: "+mid(ls_cod_studio_anag, 2, 1)+"° . ~n"+&
//												"Vuoi aggiornarlo a: "+mid(ls_studio, 2, 1)+"° ?", question!, yesNo!, 2)= 2 then return 0
//		
//	end if
//
//	update membri_gerarchica set cod_studio= :ls_studio where codice= :ls_codice;
//	
//	return this.uof_aggiorna()

end choose
end event

event updateend;call super::updateend;if event ue_update_cod_studio() < 0 then 
	rollback;
	messageBox(parent.text, "Aggiornamento in anagrafica non eseguito", exclamation!)
end if
end event

event updatestart;call super::updatestart;datetime ldt_data
integer li_ret, idx, li_livello
string ls_cod, ls_data, ls_filter

for idx= 1 to rowCount()
	
		ldt_data= this.getItemDatetime(idx, "data_esame")
		
		ls_data= string(ldt_data,  "dd.mm.yyyy")
		
		ls_cod= this.getItemString(idx, "cod_studio")
		
		ls_filter= "cod_studio= '"+ls_cod+"' and string(data_esame, ~'dd.mm.yyyy~')= "+"'"+ls_data+"'"
		
		li_ret= this.setFilter(ls_filter) 
		
		li_ret= Filter()
		
		li_ret= rowCount()
		
		SetFilter("")
		Filter()
		
		if li_ret > 1 then
			
			messageBox("Esami", "Non è possibile inserire più righe relative ad esami di un livello nella stessa data.")
			
			this.retrieve(is_current_item_s.codice)
			
			return 1
		
		end if

next
end event

event doubleclicked;call super::doubleclicked;string ls_note

openWithParm(w_note, this.getItemString(this.getRow(), "note") )

ls_note= message.stringParm

this.setItem(this.getRow(), "note", ls_note)
end event

type tabpage_goh from userobject within tab_dettaglio
event create ( )
event destroy ( )
integer x = 18
integer y = 208
integer width = 4059
integer height = 2812
long backcolor = 81324524
string text = "Storico Gohonzon"
long tabtextcolor = 33554432
string picturename = "Custom004!"
long picturemaskcolor = 1073741824
rb_oma_sd rb_oma_sd
rb_tok_sd rb_tok_sd
rb_oka_sd rb_oka_sd
st_5 st_5
st_4 st_4
em_data em_data
em_luogo em_luogo
cb_esegui cb_esegui
st_3 st_3
st_2 st_2
st_1 st_1
rb_oma_s rb_oma_s
rb_oka_s rb_oka_s
rb_oma_r rb_oma_r
rb_tok_r rb_tok_r
rb_oka_r rb_oka_r
rb_oma_a rb_oma_a
rb_tok_a rb_tok_a
st_oma st_oma
p_oma p_oma
st_tok st_tok
p_tok p_tok
st_oka st_oka
p_oka p_oka
uodw_sg uodw_sg
rb_tok_s rb_tok_s
rb_oka_a rb_oka_a
rb_oka_tok rb_oka_tok
gb_status gb_status
end type

on tabpage_goh.create
this.rb_oma_sd=create rb_oma_sd
this.rb_tok_sd=create rb_tok_sd
this.rb_oka_sd=create rb_oka_sd
this.st_5=create st_5
this.st_4=create st_4
this.em_data=create em_data
this.em_luogo=create em_luogo
this.cb_esegui=create cb_esegui
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_oma_s=create rb_oma_s
this.rb_oka_s=create rb_oka_s
this.rb_oma_r=create rb_oma_r
this.rb_tok_r=create rb_tok_r
this.rb_oka_r=create rb_oka_r
this.rb_oma_a=create rb_oma_a
this.rb_tok_a=create rb_tok_a
this.st_oma=create st_oma
this.p_oma=create p_oma
this.st_tok=create st_tok
this.p_tok=create p_tok
this.st_oka=create st_oka
this.p_oka=create p_oka
this.uodw_sg=create uodw_sg
this.rb_tok_s=create rb_tok_s
this.rb_oka_a=create rb_oka_a
this.rb_oka_tok=create rb_oka_tok
this.gb_status=create gb_status
this.Control[]={this.rb_oma_sd,&
this.rb_tok_sd,&
this.rb_oka_sd,&
this.st_5,&
this.st_4,&
this.em_data,&
this.em_luogo,&
this.cb_esegui,&
this.st_3,&
this.st_2,&
this.st_1,&
this.rb_oma_s,&
this.rb_oka_s,&
this.rb_oma_r,&
this.rb_tok_r,&
this.rb_oka_r,&
this.rb_oma_a,&
this.rb_tok_a,&
this.st_oma,&
this.p_oma,&
this.st_tok,&
this.p_tok,&
this.st_oka,&
this.p_oka,&
this.uodw_sg,&
this.rb_tok_s,&
this.rb_oka_a,&
this.rb_oka_tok,&
this.gb_status}
end on

on tabpage_goh.destroy
destroy(this.rb_oma_sd)
destroy(this.rb_tok_sd)
destroy(this.rb_oka_sd)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.em_data)
destroy(this.em_luogo)
destroy(this.cb_esegui)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_oma_s)
destroy(this.rb_oka_s)
destroy(this.rb_oma_r)
destroy(this.rb_tok_r)
destroy(this.rb_oka_r)
destroy(this.rb_oma_a)
destroy(this.rb_tok_a)
destroy(this.st_oma)
destroy(this.p_oma)
destroy(this.st_tok)
destroy(this.p_tok)
destroy(this.st_oka)
destroy(this.p_oka)
destroy(this.uodw_sg)
destroy(this.rb_tok_s)
destroy(this.rb_oka_a)
destroy(this.rb_oka_tok)
destroy(this.gb_status)
end on

type rb_oma_sd from radiobutton within tabpage_goh
integer x = 1262
integer y = 564
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Smarrito/distrutto"
end type

event clicked;cb_esegui.enabled= true
end event

type rb_tok_sd from radiobutton within tabpage_goh
integer x = 686
integer y = 564
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Smarrito/distrutto"
end type

event clicked;if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_oka_sd from radiobutton within tabpage_goh
integer x = 32
integer y = 540
integer width = 736
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Smarrito/distrutto"
end type

event clicked;if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type st_5 from statictext within tabpage_goh
integer x = 1906
integer y = 328
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Data"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_goh
integer x = 1897
integer y = 156
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Luogo"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_data from editmask within tabpage_goh
integer x = 1833
integer y = 400
integer width = 599
integer height = 92
integer taborder = 41
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean dropdowncalendar = true
boolean dropdownright = true
end type

type em_luogo from editmask within tabpage_goh
integer x = 1833
integer y = 220
integer width = 599
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type cb_esegui from commandbutton within tabpage_goh
integer x = 1897
integer y = 580
integer width = 466
integer height = 112
integer taborder = 42
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Esegui"
boolean default = true
end type

event clicked;integer li_count
long ll_row
string ls_msg, ls_luogo, ls_data, ls_nome
s_consegna s_consegna_s[]

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.context= "Anagrafica - Storico Gohonzon"

open( w_check_pw)
if message.doubleparm= -1 then return 0

// Verifica luogo e data

ls_luogo= em_luogo.text

if isNull(ls_luogo) or ls_luogo= "" then
	
	messageBox(parent.text, "inserire il luogo.", exclamation!)
	
	return 0
	
end if

ls_data= em_data.text

if isNull(ls_data) or ls_data= "" then
	
	messageBox(parent.text, "inserire la data.", exclamation!)
	
	return 0
	
end if

if tab_dettaglio.tabpage_goh.rb_oma_a.checked then
	s_consegna_s[1].tipo_goh = 'OMA'
	s_consegna_s[1].causale = 'ACQ'
	s_consegna_s[1].descrizione_causale = 'Acquisizione'
end if

if tab_dettaglio.tabpage_goh.rb_oma_r.checked then
	s_consegna_s[1].tipo_goh = 'OMA'
	s_consegna_s[1].causale = 'RSO'
	s_consegna_s[1].descrizione_causale = 'Reso'
end if

if tab_dettaglio.tabpage_goh.rb_oma_s.checked then
	s_consegna_s[1].tipo_goh = 'OMA'
	s_consegna_s[1].causale = 'RST'
	s_consegna_s[1].descrizione_causale = 'Reso per sostituzione'
	s_consegna_s[2].tipo_goh = 'OMA'
	s_consegna_s[2].causale = 'AST'
	s_consegna_s[2].descrizione_causale = 'Acquisizione per sostituzione'
end if

if tab_dettaglio.tabpage_goh.rb_oma_sd.checked then
	s_consegna_s[1].tipo_goh = 'OMA'
	s_consegna_s[1].causale = 'RDS'
	s_consegna_s[1].descrizione_causale = 'Smarrito/Distrutto'
end if

if tab_dettaglio.tabpage_goh.rb_oka_a.checked then
	s_consegna_s[1].tipo_goh = 'OKA'
	s_consegna_s[1].causale = 'ACQ'
	s_consegna_s[1].descrizione_causale = 'Acquisizione'
end if

if tab_dettaglio.tabpage_goh.rb_oka_r.checked then
	s_consegna_s[1].tipo_goh = 'OKA'
	s_consegna_s[1].causale = 'RSO'
	s_consegna_s[1].descrizione_causale = 'Reso'
	
end if

if tab_dettaglio.tabpage_goh.rb_oka_s.checked then
	s_consegna_s[1].tipo_goh = 'OKA'
	s_consegna_s[1].causale = 'RST' // reso per sostituzione
	s_consegna_s[1].descrizione_causale = 'Reso per sostituzione'
	s_consegna_s[2].tipo_goh = 'OKA'
	s_consegna_s[2].causale = 'AST' // acquisito per sostituzione
	s_consegna_s[2].descrizione_causale = 'Acquisizione per sostituzione'
end if

// GdS
if tab_dettaglio.tabpage_goh.rb_oka_tok.checked then
	s_consegna_s[1].tipo_goh = 'OKA'
	s_consegna_s[1].causale = 'RST'
	s_consegna_s[1].descrizione_causale = 'Reso per sostituzione con Tokuso'
	s_consegna_s[2].tipo_goh = 'TOK'
	s_consegna_s[2].causale = 'AST'
	s_consegna_s[2].descrizione_causale = 'Acquisizione Tokuso, reso Okatagi'
end if

// end GdS

if tab_dettaglio.tabpage_goh.rb_oka_sd.checked then
	s_consegna_s[1].tipo_goh = 'OKA'
	s_consegna_s[1].causale = 'RDS'
	s_consegna_s[1].descrizione_causale = 'Smarrito/Distrutto'
end if


if tab_dettaglio.tabpage_goh.rb_tok_a.checked then
	s_consegna_s[1].tipo_goh = 'TOK'
	s_consegna_s[1].causale = 'ACQ'
	s_consegna_s[1].descrizione_causale = 'Acquisizione'
end if

if tab_dettaglio.tabpage_goh.rb_tok_r.checked then
	s_consegna_s[1].tipo_goh = 'TOK'
	s_consegna_s[1].causale = 'RSO'
	s_consegna_s[1].descrizione_causale = 'Reso'
end if

if tab_dettaglio.tabpage_goh.rb_tok_s.checked then
	s_consegna_s[1].tipo_goh = 'TOK'
	s_consegna_s[1].causale = 'RST'
	s_consegna_s[1].descrizione_causale = 'Reso per sostituzione'
	s_consegna_s[2].tipo_goh = 'TOK'
	s_consegna_s[2].causale = 'AST'
	s_consegna_s[2].descrizione_causale = 'Acquisizione per sostituzione'
end if

if tab_dettaglio.tabpage_goh.rb_tok_sd.checked then
	s_consegna_s[1].tipo_goh = 'TOK'
	s_consegna_s[1].causale = 'RDS'
	s_consegna_s[1].descrizione_causale = 'Smarrito/Distrutto'
end if

for ll_row= 1 to upperBound(s_consegna_s)
	
	ls_msg+= "~n"+string(ll_row)+" - Tipo Gohonzon: "+s_consegna_s[ll_row].tipo_goh+" - "+s_consegna_s[ll_row].descrizione_causale
	
next

// if messageBox(parent.text, "Verranno eseguiti i seguenti aggiornamenti in anagrafica e sullo storico Gohonzon: "+ls_msg, question!, yesNo!, 2)= 2 then return -1


//// Rimozione dal nucleo famigliare
//
//if ib_componentenucleo= true then
//	
//	ib_componentenucleo= false
//	
//	select count(*)
//	into :li_count
//	from membri_gerarchica
//	where codice_fam= :is_codice_fam;
//	if trap_sql(sqlca, "ESEGUI01") < 0 then goto errore	
//	
//	if li_count > 2 then // se il nucleo è formato da più di due persone rimuove solo un componente
//	
//		update membri_gerarchica
//		set codice_fam= ""
//		where codice= : is_current_item_s.codice;
//		
//		if trap_sql(sqlca, "ESEGUI02") < 0 then goto errore
//		
//	else // se il nucleo è formato da due sole persone lo scioglie direttamente
//		
//		update membri_gerarchica
//		set codice_fam= ""
//		where codice_fam= :is_codice_fam;
//		
//		if trap_sql(sqlca, "ESEGUI03") < 0 then goto errore		
//		
//	end if
	
//end if

// se R... selezione della causale di reso...

if upperBound(s_consegna_s)= 1 AND s_consegna_s[1].causale <> 'RDS' AND mid(s_consegna_s[1].causale, 1, 1)= 'R'  then
	
	string ls_causale
	
	open (w_gohonzon_causali_resi)
	
	ls_causale= message.stringParm
	
	if ls_causale= "" then return
	
	s_consegna_s[1].causale= ls_causale
	
end if

// Inserimento in gohonzon_storico

for ll_row= 1 to upperBound(s_consegna_s)

	  INSERT INTO gohonzon_storico  
				( codice,   
				  tipo_goh,   
				  data,   
				  luogo,   
				  cod_causale,   
				  note,
				  u_ult_mod,
				  d_ult_mod)  
	  VALUES ( 	: is_current_item_s.codice,   
				 	:s_consegna_s[ll_row].tipo_goh,   
				 	:ls_data,
				  	:ls_luogo, 
				  	:s_consegna_s[ll_row].causale,
				 	null,
					:s_session_s.s_utente_s.s_nome_esteso,
					getdate() )  ;
					 
		if trap_sql(sqlca, "ESEGUI04") < 0 then goto errore
		
			ls_nome= w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString(+&
							w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "cognome")+&
								" "+w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getItemString(+&
										w_struttura_tv_tab.tab_dettaglio.tabpage_base.uodw_aggiornamento.getRow(), "nome")					 
					
			ls_session_s.codice=  is_current_item_s.codice
			
			ls_session_s.context= "Gohonzon"
	
			f_log(ls_session_s, ls_nome+" - "+ls_msg, false)
				  
next

commit;
	if trap_sql(sqlca, "ESEGUI03") < 0 then goto errore

open(w_message)

ll_row= tab_dettaglio.tabpage_goh.uodw_sg.Retrieve ( is_current_item_s.codice)

wf_handle_rb()

return

errore:

ROLLBACK;
trap_sql(sqlca, "ESEGUI04")
open(w_message_negative)
return

end event

type st_3 from statictext within tabpage_goh
integer x = 1330
integer y = 96
integer width = 242
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Omamori"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_goh
integer x = 754
integer y = 96
integer width = 274
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 81324524
string text = "Tokuso"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_goh
integer x = 114
integer y = 96
integer width = 197
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Okatagi"
boolean focusrectangle = false
end type

type rb_oma_s from radiobutton within tabpage_goh
integer x = 1262
integer y = 384
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Sostituzione"
end type

event clicked;//cb_save.enabled= this.enabled
//cb_ripristina.enabled= this.enabled


if wf_checkstatus()= -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
	return -1	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_oka_s from radiobutton within tabpage_goh
integer x = 32
integer y = 388
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Sostituzione"
end type

event clicked;//cb_save.enabled= this.enabled
//cb_ripristina.enabled= this.enabled
//
//wf_ena_tok(false)
//

if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_oma_r from radiobutton within tabpage_goh
integer x = 1262
integer y = 296
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Restituzione"
end type

event clicked;cb_esegui.enabled= true
end event

type rb_tok_r from radiobutton within tabpage_goh
integer x = 686
integer y = 296
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Restituzione"
end type

event clicked;if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_oka_r from radiobutton within tabpage_goh
integer x = 32
integer y = 300
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Restituzione"
end type

event clicked;if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if



end event

type rb_oma_a from radiobutton within tabpage_goh
integer x = 1262
integer y = 208
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Acquisizione"
end type

event clicked;//cb_save.enabled= this.enabled
//cb_ripristina.enabled= this.enabled

if wf_checkstatus()= -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
	return -1	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_tok_a from radiobutton within tabpage_goh
integer x = 686
integer y = 208
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Acquisizione"
end type

event clicked;if wf_checkstatus()= -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
	return -1
	
else
	
	cb_esegui.enabled= true
	
end if

if wf_componente() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type st_oma from statictext within tabpage_goh
boolean visible = false
integer x = 1330
integer y = 152
integer width = 489
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "(nel nucleo famigliare)"
boolean focusrectangle = false
end type

type p_oma from picture within tabpage_goh
boolean visible = false
integer x = 1234
integer y = 96
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type st_tok from statictext within tabpage_goh
boolean visible = false
integer x = 690
integer y = 152
integer width = 489
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "(nel nucleo famigliare)"
boolean focusrectangle = false
end type

type p_tok from picture within tabpage_goh
boolean visible = false
integer x = 599
integer y = 96
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type st_oka from statictext within tabpage_goh
boolean visible = false
integer x = 114
integer y = 152
integer width = 507
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "(nel nucleo famigliare)"
boolean focusrectangle = false
end type

type p_oka from picture within tabpage_goh
boolean visible = false
integer x = 14
integer y = 96
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type uodw_sg from uodw_generica within tabpage_goh
integer y = 792
integer width = 3291
integer taborder = 50
string dataobject = "d_storico_goh"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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

if dwo.name= "b_p" then
		
//		this.setItem(uodw_rif.il_newrow, "codice", is_codice)
		s_riferimenti s_riferimenti_s
		s_riferimenti_s.codice= is_current_item_s.codice

		openWithParm(w_ins_storico_gohonzon, s_riferimenti_s)
		
		this.setRedraw(false)
			this.retrieve(is_current_item_s.codice)
		this.setRedraw(true)
	
//	this.setItem(this.getRow(), "codice", is_codice)
//	this.resetUpdate()
//	
//	this.setItemStatus(this.getRow(), 0, Primary!, new!)
//	
//	this.setColumn("storico_data")
	
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

event retrieveend;call super::retrieveend;return wf_handle_rb()
end event

event doubleclicked;call super::doubleclicked;s_riferimenti s_riferimenti_s

s_riferimenti_s.codice= is_current_item_s.codice

if row <= 0 then return 0

if f_has_p("O")= false then return -1

s_riferimenti_s.idx= this.getItemDecimal(row, "idx")

openWithParm(w_ins_storico_gohonzon, s_riferimenti_s)

this.setRedraw(false)

	this.retrieve(is_current_item_s.codice)
			
this.setRedraw(true)			

end event

type rb_tok_s from radiobutton within tabpage_goh
integer x = 686
integer y = 384
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Sostituzione"
end type

event clicked;//cb_save.enabled= this.enabled
//cb_ripristina.enabled= this.enabled
//
//wf_ena_oka(false)

if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type rb_oka_a from radiobutton within tabpage_goh
integer x = 32
integer y = 212
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Acquisizione"
end type

event clicked;if wf_checkstatus()= -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false
	
	return -1
	
else
	
	cb_esegui.enabled= true
	
end if

if wf_componente() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false
	
else
	
	cb_esegui.enabled= true
	
end if

end event

type rb_oka_tok from radiobutton within tabpage_goh
integer x = 32
integer y = 452
integer width = 736
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Sostituzione con Tokuso"
end type

event clicked;if wf_assegnatario() = -1 then
	
	cb_esegui.enabled= false
	
	this.checked= false	
	
else
	
	cb_esegui.enabled= true
	
end if
end event

type gb_status from groupbox within tabpage_goh
integer width = 174
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Azioni consentite"
end type

type tabpage_resp from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 4059
integer height = 2812
long backcolor = 67108864
string text = "Storico Responsabilità"
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
integer width = 3625
integer taborder = 70
string dataobject = "dw_storico_resp"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
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
		
//	case "b_note"
//
//		ls_note=  this.getItemString(this.getRow(), "note")
//	
//		openWithParm(w_note, ls_note)
//		
//		ls_note_old= ls_note
//		
//		ls_note= message.stringParm
//		
//		if ls_note <> ls_note_old or isNull(ls_note_old) then
//			this.setItem(this.getRow(), "note", ls_note)
//		end if
	
	case "b_p"
	
		this.setItem(this.getRow(), "codice", is_current_item_s.codice)
		this.setItem(this.getRow(), "utente", s_session_s.s_utente_s.s_nome_esteso)
	
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

event itemchanged;integer li_livello
string ls_message, ls_search, ls_old, ls_new
s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.context= "Anagrafica - Storico responsabilità"

choose case dwo.name
		
	case "livello"
		
		ls_message= "Storico responsabilità - Livello: "+string(this.getItemNumber(row, "livello"))+" - Modificato in: "+data
		
		f_log(ls_session_s, ls_message, false)
		
	case "cod_att_ist"
		
		ls_search=  this.getItemString(row, "cod_att_ist")		
		
		ls_old= this.Describe( "Evaluate('LookUpDisplay(cod_att_ist) ', "+ string(row) + ")")		
		
		ls_search= data	
		
		select descrizione into :ls_new from att_ist where cod_att_ist = :ls_search;
		
		ls_message= "Storico responsabilità: "+ls_old+" - Modificato in: "+ls_new
		
		f_log(ls_session_s, ls_message, false)
		
end choose


end event

event doubleclicked;call super::doubleclicked;string ls_note

openWithParm(w_note, this.getItemString(this.getRow(), "note") )

ls_note= message.stringParm

this.setItem(this.getRow(), "note", ls_note)
end event

type tabpage_studenti from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 4059
integer height = 2812
long backcolor = 67108864
string text = "Studenti"
long tabtextcolor = 33554432
string picturename = "Custom071!"
long picturemaskcolor = 536870912
uodw_studenti uodw_studenti
end type

on tabpage_studenti.create
this.uodw_studenti=create uodw_studenti
this.Control[]={this.uodw_studenti}
end on

on tabpage_studenti.destroy
destroy(this.uodw_studenti)
end on

type uodw_studenti from uodw_generica within tabpage_studenti
integer x = 325
integer y = 108
integer width = 2162
integer height = 1528
integer taborder = 120
string dataobject = "dw_anag_studenti"
boolean vscrollbar = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event itemfocuschanged;call super::itemfocuschanged;dataWindowChild dwc_atenei

long ll_rows

string where_clause, ls_cod_regione

if row < 1 then return 0

	if dwo.name= "studenti_id_ateneo" then
 
			if this.getChild("studenti_id_ateneo",  dwc_atenei)= -1 then return	

			ls_cod_regione= this.getItemString(row, "studenti_cod_regione")

			where_clause= " where cod_regione=~~'00~~' OR cod_regione=~~'"+ls_cod_regione+"~~'" 

			ll_rows= f_mod_select(where_clause, dwc_atenei)
  
	end if
	
return 0



 


end event

event itemchanged;call super::itemchanged;integer li_err
string ls_null, ls_message, ls_old, ls_new
s_session ls_session_s

setNull(ls_null)

ls_session_s= s_session_s
	
data = trim ( data )

ls_session_s.context= "Studenti"

ls_session_s.codice= is_current_item_s.codice

choose case dwo.name
		
	case "flag_studente"
	
	this.setItem(row, "studenti_cod_area", "00")
	this.setItem(row, "studenti_cod_regione", "00")
	this.setItem(row, "studenti_id_ateneo", 0)
	
	ls_session_s.causale= "STUDENTI"
	
	if this.getItemString(row, "flag_studente")= '0' then
		ls_old= 'No'
	else
		ls_old= 'Si'
	end if
	
	if data= '0' then
		ls_new= 'No'
	else
		ls_new= 'Si'
	end if	
			
	ls_message= ls_session_s.causale+" - "+"Studente: "+ls_old+" - Modificato in: "+ls_new
	
	case "studenti_cod_area"
		
		this.setItem(row, "studenti_cod_regione", "00")
		this.setItem(row, "studenti_id_ateneo", 0)
		
	case "studenti_cod_regione"
		
		this.setItem(row, "studenti_id_ateneo", 0)
	
end choose

	if ls_message <> "" then 

		li_err= f_log(ls_session_s, ls_message, TRUE)
		
		if li_err= -1 then messageBox("Anagrafica variazioni", "Errore in scrittura sul log eventi", Exclamation!)
		
	end if
end event

type tabpage_log from userobject within tab_dettaglio
integer x = 18
integer y = 208
integer width = 4059
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
integer width = 3648
integer height = 2812
integer taborder = 70
string dataobject = "dw_vislog"
boolean maxbox = false
boolean hscrollbar = false
boolean ib_allowstop = true
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
boolean ib_p = false
boolean ib_cerca = false
boolean ib_reset = false
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

event doubleclicked;call super::doubleclicked;string ls_note

openWithParm(w_note, this.getItemString(this.getRow(), "note") )

ls_note= message.stringParm

this.setItem(this.getRow(), "note", ls_note)
end event

type cb_ricercaanomalie from commandbutton within w_struttura_tv_tab
integer x = 1083
integer y = 12
integer width = 786
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricerca anomalie"
end type

event clicked;integer li_ret
string ls_struttura
s_ricerca_struttura s_ricerca_struttura_s
w_struttura_tv w_parent

parent.parentWindow().setRedraw(false)

if isValid(w_anomalie) then
	w_anomalie.bringToTop= true
	this.text='Torna ai risultati della ricerca'
else
	this.text=  'Ricerca anomalie'
	
		is_assegnastruttura_s.aw_struttura_tv= parent

	li_ret= OpenSheetWithParm ( w_anomalie, is_assegnastruttura_s, parent.parentWindow(), 3, original! )
	w_anomalie.setFocus()
end if

parent.parentWindow().setRedraw(true)

return 0


end event

type shl_altritipi from statichyperlink within w_struttura_tv_tab
integer x = 1083
integer y = 112
integer width = 786
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Vai ad altri tipi di ricerca"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;integer li_ret
string ls_struttura
s_ricerca_struttura s_ricerca_struttura_s

parent.parentWindow().setRedraw(false)

if isValid(w_reportrunner_tv) then
	w_reportrunner_tv.bringToTop= true
	//this.text=  'Vai ad altri tipi di ricerca' 
else
	this.text='Torna ai risultati della ricerca'
	
		is_assegnastruttura_s.aw_struttura_tv= parent

		openWithParm(w_listObjects, 'C')
		is_assegnastruttura_s.as_first_dw= message.stringParm
		
		//messageBox("test", "is_assegnastruttura_s.as_first_dw="+message.stringParm)
		
		if is_assegnastruttura_s.as_first_dw= "" then goto esci
		
		is_assegnastruttura_s.ab_vedielencodw= true
		is_assegnastruttura_s.ab_readonly= true

		is_assegnastruttura_s.as_reportpath= gs_docdir+"\"+gs_customreportpath
		
		//messageBox("Test","w_struttura_tv > is_assegnastruttura_s.as_first_dw="+is_assegnastruttura_s.as_first_dw)
	
	li_ret= OpenSheetWithParm ( w_reportrunner_tv, is_assegnastruttura_s, parent.parentWindow(), 3, original! )
	w_reportrunner_tv.setFocus()
end if

esci:

parent.parentWindow().setRedraw(true)

return 0
end event

