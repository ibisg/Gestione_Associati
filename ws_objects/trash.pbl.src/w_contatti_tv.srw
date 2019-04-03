$PBExportHeader$w_contatti_tv.srw
forward
global type w_contatti_tv from window
end type
type pb_estesa from picturebutton within w_contatti_tv
end type
type pb_trova from picturebutton within w_contatti_tv
end type
type sle_cerca from singlelineedit within w_contatti_tv
end type
type tv_struttura from uotv_struttura within w_contatti_tv
end type
end forward

global type w_contatti_tv from window
boolean visible = false
integer width = 2089
integer height = 1808
boolean titlebar = true
string title = "Gestione della struttura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Library5!"
boolean clientedge = true
event type integer ue_inserisci_struttura ( long al_handle )
event type integer ue_modifica_struttura ( long al_handle )
event type integer ue_mcompleta ( )
event type integer ue_cercanodo ( )
event type integer ue_bollettini ( s_preview as_preview_s )
pb_estesa pb_estesa
pb_trova pb_trova
sle_cerca sle_cerca
tv_struttura tv_struttura
end type
global w_contatti_tv w_contatti_tv

type variables
boolean ib_dragdrop= false

dataStore ids_membri, ids_struttura

long	il_livello
long il_queue[], il_foundhandle
m_pop_tv im_pop_tv
m_pop_lv_dettaglio im_pop_lv_dettaglio

s_struttura is_struttura_s
s_preview is_preview_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object
end variables

forward prototypes
public function s_struttura wf_aggiorna_parent (ref s_struttura as_struttura_src, s_struttura as_struttura_tgt)
end prototypes

event ue_inserisci_struttura;return 0
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

event type integer ue_cercanodo();long ll_rows
string ls_struttura
s_ricerca_struttura s_ricerca_struttura_s

ids_struttura.reset()

SetPointer ( hourglass! )
w_frame_gestioneassociati.SetRedraw ( false )

ll_rows= ids_struttura.retrieve("%"+sle_cerca.text+"%", gs_ambito+"%")

choose case ll_rows
		
	case 0
		
		messageBox(this.title, "Ricerca senza esito.", exclamation!)
		
		goto notfound
		
	case 1
		
		ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
		
		if ids_struttura.getItemString(1, "vc_nodo")= "" then
			ls_struttura= ids_struttura.getItemString(1, "vc_parent")+"."+ids_struttura.getItemString(1, "struttura_descrizione")	
		else
			ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
		end if
		
	case is > 1
		
		s_ricerca_struttura_s.descrizione= sle_cerca.text
		s_ricerca_struttura_s.ambito= gs_ambito

		if OpenWithParm (w_ricerca_struttura, s_ricerca_struttura_s) < 0 then return -1

		ls_struttura= message.stringParm
		
end choose

if ls_struttura <> ""  then

	tv_struttura.uf_cerca_nodo(ls_struttura)
	
end if

w_frame_gestioneassociati.SetRedraw ( true )

return ll_rows

notfound: 

sle_cerca.selectText(1, len(sle_cerca.text) )
sle_cerca.setFocus()

w_frame_gestioneassociati.SetRedraw ( true )

return 0
end event

event type integer ue_bollettini(s_preview as_preview_s);integer li_ret

w_preview_bollettini iw_bollettini

as_preview_s.dataObject= "r_boll_sing"

w_frame_gestioneassociati.setRedraw(false)
	li_ret= openWithParm(iw_bollettini, as_preview_s)
w_frame_gestioneassociati.setRedraw(true)

return li_ret
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

on w_contatti_tv.create
this.pb_estesa=create pb_estesa
this.pb_trova=create pb_trova
this.sle_cerca=create sle_cerca
this.tv_struttura=create tv_struttura
this.Control[]={this.pb_estesa,&
this.pb_trova,&
this.sle_cerca,&
this.tv_struttura}
end on

on w_contatti_tv.destroy
destroy(this.pb_estesa)
destroy(this.pb_trova)
destroy(this.sle_cerca)
destroy(this.tv_struttura)
end on

event resize;tv_struttura.height= this.height - 180  - tv_struttura.y // ok così

end event

event open;ids_struttura= create dataStore
ids_struttura.DataObject = "dw_ricerca_struttura"
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

return ll_handle
end event

type pb_estesa from picturebutton within w_contatti_tv
integer x = 1216
integer y = 24
integer width = 206
integer height = 128
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "cerca_bface.bmp"
alignment htextalign = left!
end type

event clicked;string ls_struttura

open(w_ricerca_generica)

ls_struttura= message.stringParm

SetPointer ( hourglass! )
w_frame_gestioneassociati.SetRedraw ( false )

if ls_struttura <> ""  then

	tv_struttura.uf_cerca_nodo(ls_struttura)
	
end if

w_frame_gestioneassociati.SetRedraw ( true )

return 0

end event

type pb_trova from picturebutton within w_contatti_tv
integer x = 1051
integer y = 36
integer width = 119
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
boolean default = true
boolean originalsize = true
string picturename = "doublenextarrow.gif"
alignment htextalign = left!
end type

event clicked;if sle_cerca.text= "" then
	messageBox(parent.title, "Inserire un nome da  cercare.", information!)
	return -1
end if

this.enabled= false
event ue_cercanodo()
this.enabled= true
end event

type sle_cerca from singlelineedit within w_contatti_tv
integer x = 27
integer y = 32
integer width = 1015
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
textcase textcase = upper!
boolean hideselection = false
end type

event getfocus;this.selectText(1, len(this.text) )
end event

type tv_struttura from uotv_struttura within w_contatti_tv
integer x = 27
integer y = 152
integer width = 1874
integer height = 1236
integer taborder = 30
long backcolor = 16777215
borderstyle borderstyle = stylebox!
boolean hideselection = false
end type

event rightclicked;integer li_ret
long ll_handle
treeviewItem ll_tvi
	
ll_handle = this.FindItem(currentTreeItem!, 0)
	
li_ret= this.getItem(ll_handle, ll_tvi)
	
is_struttura_s= ll_tvi.data

if ll_tvi.level  > gi_maxlivello then return -1

parent.im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )


end event

