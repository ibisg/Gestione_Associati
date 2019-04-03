$PBExportHeader$w_struttura_tv_old.srw
forward
global type w_struttura_tv_old from window
end type
type st_1 from statictext within w_struttura_tv_old
end type
type pb_trova from picturebutton within w_struttura_tv_old
end type
type sle_cerca from singlelineedit within w_struttura_tv_old
end type
type tv_struttura from uotv_struttura within w_struttura_tv_old
end type
end forward

global type w_struttura_tv_old from window
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
st_1 st_1
pb_trova pb_trova
sle_cerca sle_cerca
tv_struttura tv_struttura
end type
global w_struttura_tv_old w_struttura_tv_old

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

on w_struttura_tv_old.create
this.st_1=create st_1
this.pb_trova=create pb_trova
this.sle_cerca=create sle_cerca
this.tv_struttura=create tv_struttura
this.Control[]={this.st_1,&
this.pb_trova,&
this.sle_cerca,&
this.tv_struttura}
end on

on w_struttura_tv_old.destroy
destroy(this.st_1)
destroy(this.pb_trova)
destroy(this.sle_cerca)
destroy(this.tv_struttura)
end on

event resize;tv_struttura.height= this.height - 180  - tv_struttura.y //- gb_cerca.height
//gb_cerca.y= tv_struttura.y + tv_struttura.height
//st_cerca.y= gb_cerca.y + 60
//sle_cerca.y= st_cerca.y
//pb_cerca.y= st_cerca.y

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

type st_1 from statictext within w_struttura_tv_old
integer x = 1472
integer y = 80
integer width = 215
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Cerca..."
boolean focusrectangle = false
end type

type pb_trova from picturebutton within w_struttura_tv_old
integer x = 1705
integer y = 64
integer width = 197
integer height = 120
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "cerca_bface.bmp"
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

type sle_cerca from singlelineedit within w_struttura_tv_old
integer x = 27
integer y = 64
integer width = 1417
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
boolean hideselection = false
end type

event getfocus;this.selectText(1, len(this.text) )
end event

type tv_struttura from uotv_struttura within w_struttura_tv_old
integer x = 27
integer y = 216
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

if ll_tvi.level  >= gi_maxlivello then return -1

if gi_classediutenza >= gc_op then
	parent.im_pop_tv.m_listedidistribuzione.enabled= false
end if

parent.im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )


end event

