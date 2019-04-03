$PBExportHeader$w_struttura_tv.srw
forward
global type w_struttura_tv from window
end type
type dw_target from datawindow within w_struttura_tv
end type
type pb_estesa from picturebutton within w_struttura_tv
end type
type pb_trova from picturebutton within w_struttura_tv
end type
type sle_cerca from singlelineedit within w_struttura_tv
end type
type tv_struttura from uotv_struttura within w_struttura_tv
end type
end forward

global type w_struttura_tv from window
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
event type integer ue_cercanodo ( string as_struttura )
event type integer ue_ricerca_struttura ( string as_ambito )
event ue_tvdim ( )
event type integer ue_moveitem ( w_struttura_tv aw_struttura_tv )
dw_target dw_target
pb_estesa pb_estesa
pb_trova pb_trova
sle_cerca sle_cerca
tv_struttura tv_struttura
end type
global w_struttura_tv w_struttura_tv

type variables
boolean ib_dragdrop= false

dataStore ids_membri, ids_struttura
dataWindowChild idwc_target

long	il_livello
long il_queue[], il_foundhandle
//m_pop_tv im_pop_tv

s_struttura is_struttura_s
s_assegnastruttura is_assegnastruttura_s
s_preview is_preview_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object

string is_searchstring

end variables

forward prototypes
public function s_struttura wf_aggiorna_parent (ref s_struttura as_struttura_src, s_struttura as_struttura_tgt)
public subroutine wf_dim (integer xpos)
end prototypes

event ue_inserisci_struttura;return 0
end event

event type integer ue_cercanodo(string as_struttura);if as_struttura <> ""  then

//	messageBox("test", "ok")

this.SetRedraw ( false )

	tv_struttura.uf_cerca_nodo(as_struttura)

this.SetRedraw ( true )

end if

return 0
end event

event type integer ue_ricerca_struttura(string as_ambito);long ll_rows
string ls_struttura, ls_cerca
s_ricerca_struttura s_ricerca_struttura_s

ids_struttura.reset()

SetPointer ( hourglass! )

/*w_frame_gestioneassociati*/ parentWindow().SetRedraw ( false )

ls_cerca= f_trim_all(sle_cerca.text)

ll_rows= ids_struttura.retrieve("%"+ls_cerca+"%", as_ambito+"%")

choose case ll_rows
		
	case 0
		
		messageBox(this.title, "Ricerca senza esito.", exclamation!)
		
		goto notfound
		
	case 1
		
		ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
		
		if ids_struttura.getItemString(1, "vc_nodo")= "" then
			ls_struttura= trim(ids_struttura.getItemString(1, "vc_parent"))+"."+trim(ids_struttura.getItemString(1, "struttura_descrizione"))	
		else
			ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
		end if
		
		event ue_cercanodo(ls_struttura)

	case is > 1
		
		s_ricerca_struttura_s.descrizione= ls_cerca
		s_ricerca_struttura_s.ambito= as_ambito
		s_ricerca_struttura_s.aw_struttura_tv= this
		/*w_frame_gestioneassociati*/ //parentWindow().SetRedraw ( true )
		if OpenWithParm (w_ricerca_struttura, s_ricerca_struttura_s) < 0 then return -1
//		w_ricerca_struttura.bringToTop= true
		ls_struttura= message.stringParm
		event ue_cercanodo(ls_struttura)
		
end choose

parentWindow().SetRedraw ( true )
return 0

notfound: 

sle_cerca.selectText(1, len(sle_cerca.text) )
sle_cerca.setFocus()

/* w_frame_gestioneassociati*/ parentWindow().SetRedraw ( true )

return 1
end event

event type integer ue_moveitem(w_struttura_tv aw_struttura_tv);return tv_struttura.uf_moveitem(tv_struttura.is_struttura_s.handle, aw_struttura_tv) 
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

public subroutine wf_dim (integer xpos);tv_struttura.width= ( xpos*WorkspaceWidth() ) / 100
return
end subroutine

on w_struttura_tv.create
this.dw_target=create dw_target
this.pb_estesa=create pb_estesa
this.pb_trova=create pb_trova
this.sle_cerca=create sle_cerca
this.tv_struttura=create tv_struttura
this.Control[]={this.dw_target,&
this.pb_estesa,&
this.pb_trova,&
this.sle_cerca,&
this.tv_struttura}
end on

on w_struttura_tv.destroy
destroy(this.dw_target)
destroy(this.pb_estesa)
destroy(this.pb_trova)
destroy(this.sle_cerca)
destroy(this.tv_struttura)
end on

event resize;tv_struttura.height= this.height - 160  - tv_struttura.y // ok così

end event

event open;ids_struttura= create dataStore
ids_struttura.DataObject = "dw_ricerca_struttura"
ids_struttura.setTransObject(sqlca)

/// GdS test

dw_target.GetChild('target', idwc_target)
idwc_target.setTransObject(sqlca)
dw_target.insertRow(0)

///

ids_membri= create dataStore
ids_membri.DataObject = "ds_vw_membri"
ids_membri.setTransObject(sqlca)

// Inserisce gli item relativi al livello 0 (root )

long ll_handle

is_assegnastruttura_s= message.powerObjectParm

tv_struttura.is_tvinit_s.ai_maxlivello= is_assegnastruttura_s.ai_maxlivello
tv_struttura.is_tvinit_s.as_ambito= is_assegnastruttura_s.as_ambito
if tv_struttura.is_tvinit_s.ai_ultimolivelloparent= 0 then tv_struttura.is_tvinit_s.ai_ultimolivelloparent= is_assegnastruttura_s.ai_maxlivello

//tv_struttura.il_fino_a_quale_livello= MAX_LIVELLO - 1

if tv_struttura.uf_populate(0) < 0 then return -1

ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
tv_struttura.ExpandItem ( ll_handle )
tv_struttura.selectItem(ll_handle)

sle_cerca.setFocus()

//tv_struttura.setFocus()

return ll_handle
end event

event close;if isValid(w_reportrunner) then close(w_reportrunner)
end event

event timer;string ls_cerca
long ll_rows

ls_cerca= f_trim_all(dw_target.getItemString(dw_target.getRow(), "target") )

ll_rows= idwc_target.retrieve("%"+ls_cerca+"%", gs_ambito+"%")
end event

type dw_target from datawindow within w_struttura_tv
integer x = 37
integer y = 20
integer width = 992
integer height = 108
integer taborder = 10
string title = "none"
string dataobject = "edw_target_ricerca"
boolean livescroll = true
end type

event editchanged;string ls_cerca
long ll_rows

timer(0, parent)

//if integer(data)= 0 then
//	
////	event ue_totale(row, dec(data) )
//
////	ls_cerca= f_trim_all(sle_cerca.text)
////	
////	ll_rows= ids_struttura.retrieve("%"+ls_cerca+"%", as_ambito+"%")
//	
//else
	
	timer(0.50, parent)
	
//end if
end event

type pb_estesa from picturebutton within w_struttura_tv
integer x = 1184
integer y = 16
integer width = 206
integer height = 128
integer taborder = 50
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "cerca_bface.bmp"
alignment htextalign = left!
string powertiptext = "Alti tipi di ricerca..."
end type

event clicked;string ls_struttura
s_ricerca_struttura s_ricerca_struttura_s
w_struttura_tv w_parent

parent.parentWindow().setRedraw(false)

is_assegnastruttura_s.aw_struttura_tv= parent

is_assegnastruttura_s.as_first_dw= "dw_lista_sintetica"
is_assegnastruttura_s.ab_vedielencodw= true
is_assegnastruttura_s.as_reportpath= gs_docdir+"\"+gs_customreportpath

if isValid(w_reportrunner) then
	w_reportrunner.bringToTop= true
else
	OpenSheetWithParm ( w_reportrunner /*w_ricerca_tv_sheet*/, is_assegnastruttura_s, parent.parentWindow(), 3, original! )
	w_reportrunner.setFocus()
end if

parent.parentWindow().setRedraw(true)

return 0
end event

type pb_trova from picturebutton within w_struttura_tv
integer x = 1051
integer y = 28
integer width = 119
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
boolean default = true
string picturename = "doublenextarrow.gif"
alignment htextalign = left!
end type

event clicked;integer li_ret

if sle_cerca.text= "" then
	messageBox(parent.title, "Inserire un nome da  cercare.", information!)
	return -1
end if

if isValid(w_ricerca_tv_sheet) then close(w_ricerca_tv_sheet)

//if sle_cerca.text= is_searchstring then return 0

string ls_text

ls_text=  f_trim_all(sle_cerca.text)

is_searchstring= ls_text

open(w_wait_snoopy)
	this.enabled= false
	li_ret= event ue_ricerca_struttura(is_assegnastruttura_s.as_ambito)
	this.enabled= true
close(w_wait_snoopy)

if li_ret= 0 then
	tv_struttura.setFocus()
else
	sle_cerca.setFocus()
end if
end event

type sle_cerca from singlelineedit within w_struttura_tv
integer x = 1623
integer y = 12
integer width = 1015
integer height = 108
integer taborder = 20
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

type tv_struttura from uotv_struttura within w_struttura_tv
integer x = 27
integer y = 152
integer width = 1874
integer height = 1236
integer taborder = 40
string dragicon = ""
integer weight = 0
string pointer = ""
long textcolor = 0
long backcolor = 16777215
borderstyle borderstyle = stylebox!
integer indent = 0
boolean disabledragdrop = true
boolean trackselect = false
string picturename[] = {"","","","","","","","","","","",""}
long picturemaskcolor = 553648127
string statepicturename[]
long statepicturemaskcolor = 0
end type

