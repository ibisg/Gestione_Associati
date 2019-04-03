$PBExportHeader$w_struttura_tv_new.srw
forward
global type w_struttura_tv_new from window
end type
type pb_cerca from picturebutton within w_struttura_tv_new
end type
type st_cerca from statictext within w_struttura_tv_new
end type
type sle_cerca from singlelineedit within w_struttura_tv_new
end type
type tv_struttura from uotv_struttura within w_struttura_tv_new
end type
type gb_cerca from groupbox within w_struttura_tv_new
end type
end forward

global type w_struttura_tv_new from window
boolean visible = false
integer width = 4933
integer height = 2880
boolean titlebar = true
string title = "Gestione della struttura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Library5!"
boolean clientedge = true
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_inserisci_struttura ( long al_handle )
event type integer ue_modifica_struttura ( long al_handle )
event type integer ue_mcompleta ( )
event type integer ue_cercanodo ( )
event ue_properties ( s_struttura as_struttura_s )
event type integer ue_runquery ( )
pb_cerca pb_cerca
st_cerca st_cerca
sle_cerca sle_cerca
tv_struttura tv_struttura
gb_cerca gb_cerca
end type
global w_struttura_tv_new w_struttura_tv_new

type variables
boolean ib_dragdrop= false

dataStore ids_membri, ids_struttura

long	il_livello
long il_queue[], il_foundhandle
m_pop_tv im_pop_tv
m_pop_lv_dettaglio im_pop_lv_dettaglio

s_struttura is_struttura_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object
end variables

forward prototypes
public function s_struttura wf_aggiorna_parent (ref s_struttura as_struttura_src, s_struttura as_struttura_tgt)
end prototypes

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

event ue_inserisci_struttura;return 0
end event

event ue_mcompleta;return openWithParm(w_completa, tv_struttura.is_struttura_s.vc_nodo)
end event

event type integer ue_cercanodo();long ll_rows
string ls_struttura

ids_struttura.reset()

SetPointer ( hourglass! )
w_frame_gestioneassociati.SetRedraw ( false )

ll_rows= ids_struttura.retrieve("%"+sle_cerca.text+"%")

choose case ll_rows
		
	case 0
		
		messageBox(this.title, "Struttura non trovata.", exclamation!)
		
		goto notfound
		
	case 1
		
		ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
		
	case is > 1

		if OpenWithParm (w_ricerca_struttura, "%"+sle_cerca.text+"%") < 0 then return -1

		ls_struttura= message.stringParm
		
end choose

if ls_struttura <> ""  then

	tv_struttura.uf_cerca_nodo(ls_struttura)
	
end if

notfound: 

sle_cerca.selectText(1, len(sle_cerca.text) )
sle_cerca.setFocus()

w_frame_gestioneassociati.SetRedraw ( true )

return 0
end event

event ue_properties(s_struttura as_struttura_s);w_properties iw_properties

w_frame_gestioneassociati.setRedraw(false)
	openSheetWithParm(iw_properties, as_struttura_s, w_frame_gestioneassociati, 2, cascaded!)
w_frame_gestioneassociati.setRedraw(true)

is_struttura_s= message.powerObjectParm

this.title= is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura

//integer ii_anno
////
////dw_dettaglio.Object.t_header.Text = is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura
//
//ii_anno= year(today())
//
////dw_dettaglio.Object.t_header.Text = f_descrizione_struttura_fill(is_struttura_s.vc_nodo)
//
//
//dw_dettaglio.retrieve(tv_struttura.is_struttura_s.vc_nodo+"%", tv_struttura.is_struttura_s.livello, ii_anno)
end event

public function s_struttura wf_aggiorna_parent (ref s_struttura as_struttura_src, s_struttura as_struttura_tgt);integer li_len_parent, li_len_nodo, li_len_src_parent
long ll_livello, ll_nodo
string ls_query, ls_parent, ls_nodo, ls_newparent, ls_nuova_parent, ls_codice, ls_substring_org, ls_src_parent


	/*
	 * Estrae tutti i nodi che devono essere spostati sotto lil nuovo nodo parent....
	 */

	ls_query= "select livello, id_nodo, codice, vc_nodo, vc_parent from struttura where (vc_parent like "+"'" +as_struttura_src.vc_parent+"."+as_struttura_src.codice+"%')"+ &
					" OR (vc_parent= "+"'" +as_struttura_src.vc_parent+"' and codice= '"+as_struttura_src.codice+"') order by livello"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "UPDPARENT01") < 0 then goto errore
	
	setPointer(hourGlass!)

		do while sqlca.sqlcode <> 100
			
			// per tutti i nodi che hanno come stringa iniziale della loro parent la vecchia parent
			fetch query_cur into
			:ll_livello,
			:ll_nodo,
			:ls_codice,
			:ls_nodo,
			:ls_parent;
			if sqlca.sqlcode= 100 then continue
			
			// Stacca la sottostringa a destra della vecchia parent
			
			ls_substring_org= mid(ls_parent, len(as_struttura_src.vc_parent) + 1, len(ls_parent) )
			
			if ls_substring_org= "" then
				ls_nuova_parent= as_struttura_tgt.vc_nodo
			else
				ls_nuova_parent= as_struttura_tgt.vc_nodo+ls_substring_org
			end if
			
			// Ora aggiorna tutte le parent relative al nodo estratto...
			
			update struttura set vc_parent= :ls_nuova_parent where current of query_cur;
			if trap_sql(sqlca, "UPDPARENT02") < 0 then goto errore	
	
		loop
		
close query_cur;
trap_sql(sqlca, "UPDPARENT03")

// Aggiorna il campo id_parent ponendolo uguale all'id del nuovo nodo parent...
as_struttura_src.vc_parent= as_struttura_tgt.vc_parent

goto ok

errore: as_struttura_src.livello= -1

ok: return as_struttura_src
end function

on w_struttura_tv_new.create
this.pb_cerca=create pb_cerca
this.st_cerca=create st_cerca
this.sle_cerca=create sle_cerca
this.tv_struttura=create tv_struttura
this.gb_cerca=create gb_cerca
this.Control[]={this.pb_cerca,&
this.st_cerca,&
this.sle_cerca,&
this.tv_struttura,&
this.gb_cerca}
end on

on w_struttura_tv_new.destroy
destroy(this.pb_cerca)
destroy(this.st_cerca)
destroy(this.sle_cerca)
destroy(this.tv_struttura)
destroy(this.gb_cerca)
end on

event resize;

tv_struttura.height= this.height - 180 - gb_cerca.height
gb_cerca.y= tv_struttura.y + tv_struttura.height
st_cerca.y= gb_cerca.y + 60
sle_cerca.y= st_cerca.y
pb_cerca.y= st_cerca.y

end event

event open;ids_struttura= create dataStore
ids_struttura.DataObject = "ds_ricerca_struttura"
ids_struttura.setTransObject(sqlca)

im_pop_tv= create m_pop_tv
ids_membri= create dataStore
ids_membri.DataObject = "ds_vw_membri"
ids_membri.setTransObject(sqlca)

// Inserisce gli item relativi al livello 0 (root )

long ll_handle

//tv_struttura.il_fino_a_quale_livello= MAX_LIVELLO - 1

if tv_struttura.uf_populate(0) < 0 then return -1

ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
tv_struttura.ExpandItem ( ll_handle )

sle_cerca.setFocus()

return 0
end event

type pb_cerca from picturebutton within w_struttura_tv_new
integer x = 1605
integer y = 2468
integer width = 265
integer height = 124
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean originalsize = true
string picturename = "cerca_white.bmp"
alignment htextalign = right!
end type

event clicked;parent.event ue_cercanodo()
end event

type st_cerca from statictext within w_struttura_tv_new
integer x = 59
integer y = 2468
integer width = 183
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trova:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_cerca from singlelineedit within w_struttura_tv_new
integer x = 251
integer y = 2468
integer width = 1262
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selectText(1, len(this.text) )
end event

type tv_struttura from uotv_struttura within w_struttura_tv_new
integer width = 1957
integer height = 2396
integer taborder = 30
long backcolor = 16777215
integer indent = 150
boolean checkboxes = false
boolean trackselect = true
boolean ib_people = true
end type

event rightclicked;integer li_ret
long ll_handle
treeviewItem ll_tvi
	
ll_handle = this.FindItem(currentTreeItem!, 0)
	
li_ret= this.getItem(ll_handle, ll_tvi)
	
is_struttura_s= ll_tvi.data

if ll_tvi.level >= MAX_LIVELLO then return -1

parent.im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )

//if s_struttura_loc.livello >= MAX_LIVELLO then im_pop_tv.m_offerte.enabled= false


end event

type gb_cerca from groupbox within w_struttura_tv_new
integer x = 18
integer y = 2404
integer width = 1957
integer height = 208
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 81324524
borderstyle borderstyle = stylelowered!
end type

