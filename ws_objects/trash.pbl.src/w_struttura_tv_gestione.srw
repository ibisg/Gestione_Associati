$PBExportHeader$w_struttura_tv_gestione.srw
forward
global type w_struttura_tv_gestione from w_struttura_tv
end type
type lv_dettaglio from listview within w_struttura_tv_gestione
end type
type dw_membri from uodw_generica within w_struttura_tv_gestione
end type
end forward

global type w_struttura_tv_gestione from w_struttura_tv
integer width = 3950
integer height = 2452
event type integer ue_insertitem ( )
event type integer ue_moveitem ( )
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event ue_trasferimenti ( )
lv_dettaglio lv_dettaglio
dw_membri dw_membri
end type
global w_struttura_tv_gestione w_struttura_tv_gestione

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
	
	open(w_preview_scheda)
	
	w_preview_scheda.dw_current.dataObject= ls_object
	
	w_preview_scheda.dw_current.reset()
	
	setpointer(hourGlass!)

w_preview_scheda.setRedraw(false)

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
	
	open(w_preview_scheda)
	
	w_preview_scheda.dw_current.dataObject= ls_object

	ll_handle = lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
	
	setpointer(hourGlass!)

	w_preview_scheda.setRedraw(false)
	
		do while ll_handle <> -1
			
			lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			tv_struttura.is_struttura_s= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, tv_struttura.is_struttura_s.livello, tv_struttura.is_struttura_s.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_scheda.dw_current.groupCalc()

//w_preview_scheda.dw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_scheda.setRedraw(true)

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
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			li_ret= w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			if ai_source= 1 then
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_master", tv_struttura.is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_master", tv_struttura.is_struttura_s.descrizione_struttura+": ")	
			else
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_master", "generale")	
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_master", ": ")					
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
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
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
				
				ll_row= w_preview_scheda.dw_current.insertRow(0)
				w_preview_scheda.dw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
				w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
				w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
				w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
				w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
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
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
			w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)	
			w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
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
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "codice", ls_codice)
			w_preview_scheda.dw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview_scheda.dw_current.setItem(ll_row, "nome", ls_nome)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
		
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

public function integer lvf_dettaglio (long tvi_handle);long ll_child_handle, ll_rows, ll_idx
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc

lv_dettaglio.deleteItems()

tv_struttura.getItem(tvi_handle, ll_tvi)

s_struttura_loc= ll_tvi.data

this.setRedraw(false)

lv_dettaglio.visible= true
dw_membri.visible= false


if s_struttura_loc.livello <  gi_maxlivello then
	
				lv_dettaglio.view= listViewList!

				ll_child_handle = tv_struttura.FindItem(childTreeItem!, tvi_handle)
				
				do while ll_child_handle <> -1
					
					tv_struttura.getItem(ll_child_handle, ll_tvi)
					
					ll_lvi.data= ll_tvi.data
							
					s_struttura_loc= ll_tvi.data
					
					ll_lvi.label= f_iniziali(s_struttura_loc.descrizione_livello)+": "+f_iniziali(s_struttura_loc.descrizione_struttura)
//					ll_lvi.label= f_iniziali(s_struttura_loc.descrizione_livello)+": "+f_iniziali(s_struttura_loc.descrizione_struttura)//+" ("+string(ll_livello)+", "+string(ll_child_handle)+")"
					ll_lvi.pictureIndex= s_struttura_loc.livello
					ll_lvi.statePictureIndex= 1
			
	
				ll_lvi.selected= false
				
				if lv_dettaglio.addItem(ll_lvi) < 0 then return -1
				
				ll_child_handle= tv_struttura.FindItem(nextTreeItem!, ll_child_handle)
				
			loop
		
elseif s_struttura_loc.livello =  gi_maxlivello then
			lv_dettaglio.event ue_list_View_mode()
			
			ll_rows= ids_membri.retrieve(s_struttura_loc.vc_nodo)
			
			if ll_rows <= 0 then return -1
			
			s_struttura_loc.livello= gi_maxlivello
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
	
				ll_lvi.selected= false
				
				if lv_dettaglio.addItem(ll_lvi) < 0 then return -1
				
			next
			
			lv_dettaglio.event ue_lv_report()
			
		else
			
			lv_dettaglio.visible= false
			dw_membri.visible= true
			
			dw_membri.retrieve(s_struttura_loc.codice)

end if

this.setRedraw(true)

return 0
end function
on w_struttura_tv_gestione.create
int iCurrent
call super::create
this.lv_dettaglio=create lv_dettaglio
this.dw_membri=create dw_membri
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_dettaglio
this.Control[iCurrent+2]=this.dw_membri
end on

on w_struttura_tv_gestione.destroy
call super::destroy
destroy(this.lv_dettaglio)
destroy(this.dw_membri)
end on

event open;call super::open;long ll_handle

ll_handle= AncestorReturnValue

dw_membri.setTransObject(sqlca)

lvf_dettaglio(ll_handle)

im_pop_lv_dettaglio= create m_pop_lv_dettaglio

return ll_handle
end event
event resize;call super::resize;lv_dettaglio.height= tv_struttura.height + gb_cerca.height

lv_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

lv_dettaglio.width= this.width - lv_dettaglio.x - 30 

dw_membri.height=tv_struttura.height + gb_cerca.height

dw_membri.x= tv_struttura.x + tv_struttura.width + 30

dw_membri.width= this.width - dw_membri.x - 30 
end event
type pb_cerca from w_struttura_tv`pb_cerca within w_struttura_tv_gestione
integer x = 1966
end type

type st_cerca from w_struttura_tv`st_cerca within w_struttura_tv_gestione
integer x = 320
end type

type sle_cerca from w_struttura_tv`sle_cerca within w_struttura_tv_gestione
integer x = 512
integer width = 1408
end type

type gb_cerca from w_struttura_tv`gb_cerca within w_struttura_tv_gestione
integer width = 2295
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_struttura_tv_gestione
integer width = 2295
boolean checkboxes = true
end type

event tv_struttura::selectionchanged;call super::selectionchanged;parent.lvf_dettaglio(newHandle)


end event

type lv_dettaglio from listview within w_struttura_tv_gestione
event type integer ue_lv_report ( )
event ue_list_view_mode ( )
integer x = 2373
integer y = 212
integer width = 1385
integer height = 1236
integer taborder = 40
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
borderstyle borderstyle = stylelowered!
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

event type integer ue_lv_report();if this.view <> listViewReport! then return -1

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

event doubleclicked;integer li_ret= 1
long ll_nodo, ll_livello, ll_handle, ll_struttura
listViewItem llvi_dettaglio
string ls_nodo
treeViewItem ltvi_struttura
s_struttura s_struttura_loc

addColumn("Nome", left!, 800)
addColumn("Status", left!, 400)
addColumn("Okatagi", left!, 400)
addColumn("Tokubetsu", left!, 400)
addColumn("Omamori", left!, 400)
addColumn("Responsabilità", left!, 400)

li_ret= getItem(index, llvi_dettaglio)

if li_ret <= 0 then return -1
	
s_struttura_loc= llvi_dettaglio.data

// coordinate del tree view della struttura

ls_nodo= s_struttura_loc.vc_nodo

ll_livello= s_struttura_loc.livello

ll_handle= s_struttura_loc.handle

if ll_livello= gi_maxlivello then
	
	openWithParm(w_schede_dati, s_struttura_loc.codice)

else
	
	li_ret= tv_struttura.selectItem(ll_handle)

end if

return 0
end event

event rightclicked;im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )
end event

type dw_membri from uodw_generica within w_struttura_tv_gestione
boolean visible = false
integer x = 2377
integer y = 212
integer width = 1367
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_anagrafica"
end type

