$PBExportHeader$uotv_struttura_senzapersone.sru
forward
global type uotv_struttura_senzapersone from treeview
end type
end forward

global type uotv_struttura_senzapersone from treeview
integer width = 480
integer height = 400
string dragicon = "DataPipeline!"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer indent = 125
boolean linesatroot = true
boolean disabledragdrop = false
grsorttype sorttype = ascending!
string picturename[] = {"wi0064-48.gif","Library!","download01.jpg","download01.jpg","download01.jpg","download01.jpg","download01.jpg","download01.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif","LibraryOpen!","download03.jpg"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
event type boolean ue_searchcompare ( long al_handle,  string as_attributo,  any aa_target,  boolean ab_respectcase,  boolean ab_fullcompare )
end type
global uotv_struttura_senzapersone uotv_struttura_senzapersone

type variables
boolean ib_people, ib_dragdrop= false

long	il_livello, il_fino_a_quale_livello
long il_queue[], il_foundhandle
m_pop_tv im_pop_tv
m_pop_lv_dettaglio im_pop_lv_dettaglio

s_struttura is_struttura_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object
end variables

forward prototypes
public function integer uf_moveitem (long al_handleparent)
public function integer uf_insertitem (long al_handleparent)
public function integer uf_cerca_nodo (string as_struttura)
public function integer uf_aggiorna_membri (s_struttura as_struttura_src, s_struttura as_struttura_tgt)
public function s_struttura uf_aggiorna_parent (s_struttura as_struttura_src, s_struttura as_struttura_tgt)
public function integer uf_populate (long al_handle)
end prototypes

event ue_searchcompare;boolean lb_found= false
integer li_ret
string ls_source, ls_target
treeViewItem ltvi_item

if getItem(al_handle, ltvi_item)= -1 then return false

//parent.setMicroHelp("Sto cercando in "+ltvi_item.label)

if lower(as_attributo)= 'label' then 

	if ab_respectCase then
		
		ls_source= ltvi_item.label
		ls_target= string(aa_target)
	else
		
		ls_source= upper(ltvi_item.label)
		ls_target= upper(string(aa_target))
		
	end if
	
	if ab_fullCompare then
		
		if ls_source= ls_target then lb_found= true // return true
	
	else
		
		if pos(ls_source, ls_target) > 0 then lb_found= true // return true
		
	end if

else
	
	if className(ltvi_item.data) = 'string' then
		
		if ab_respectCase then
			
			ls_source= string(ltvi_item.data)
			
			ls_target= string(aa_target)
			
		else
			
			ls_source= upper(string(ltvi_item.data))
			ls_target= upper(string(aa_target))
			
		end if
		
		if ab_fullCompare then
			
			if ls_source= ls_target then lb_found= true // return true
				
		else
			
			if pos(ls_source, ls_target) > 0 then lb_found = true // return true
			
		end if
	
	else
	
		if ltvi_item.data= aa_target then lb_found= true //return true
	
	end if

end if

return lb_found // false
end event

public function integer uf_moveitem (long al_handleparent);integer li_ret
long ll_handlenew
long ll_child
string ls_codice, ls_descrizione
treeViewItem ltvi_new, ltvi_parent, ll_tvi
s_struttura s_struttura_s, s_struttura_tgt

if this.getItem(al_handleparent, ltvi_parent) < 0 then goto errore

// ricava dal parent vc_nodo e livello

s_struttura_s= ltvi_parent.data

openWithParm(w_moveitem, s_struttura_s)

s_struttura_tgt= message.powerObjectParm
if s_struttura_tgt.livello= -1 then return -1

this.setRedraw(false)

do while ll_child <> -1
	ll_child= this.findItem(childTreeItem!, al_handleparent)
	this.deleteItem(ll_child)
loop

if this.getItem(al_handleparent, ll_tvi) < 0 then goto errore

ll_tvi.expanded=  false
ll_tvi.expandedOnce=  false
ll_tvi.children=  true
ll_tvi.selected=  false

li_ret= this.setItem(al_handleparent, ll_tvi)
li_ret= this.expandItem(al_handleparent)

// ora il nuovo parent

al_handleparent= s_struttura_tgt.handle

do while ll_child <> -1
	ll_child= this.findItem(childTreeItem!, al_handleparent)
	this.deleteItem(ll_child)
loop

if this.getItem(al_handleparent, ll_tvi) < 0 then goto errore

ll_tvi.expanded=  false
ll_tvi.expandedOnce=  false
ll_tvi.children=  true
ll_tvi.selected=  false

li_ret= this.setItem(al_handleparent, ll_tvi)
li_ret= this.expandItem(al_handleparent)

this.setRedraw(true)

return li_ret

errore: return -1

end function

public function integer uf_insertitem (long al_handleparent);integer li_ret
long ll_handlenew
long ll_child
string ls_codice, ls_descrizione
treeViewItem ltvi_new, ltvi_parent, ll_tvi
s_struttura s_struttura_s

if this.getItem(al_handleparent, ltvi_parent) < 0 then return -1

// ricava dal parent vc_nodo e livello

s_struttura_s= ltvi_parent.data

openWithParm(w_insertitem, s_struttura_s)

if message.doubleParm= -1 then return -1

this.setRedraw(false)

do while ll_child <> -1
	ll_child= this.findItem(childTreeItem!, al_handleparent)
	this.deleteItem(ll_child)
loop

if this.getItem(al_handleparent, ll_tvi) < 0 then return -1

ll_tvi.expanded=  false
ll_tvi.expandedOnce=  false
ll_tvi.children=  true
ll_tvi.selected=  false

li_ret= this.setItem(al_handleparent, ll_tvi)
li_ret= this.expandItem(al_handleparent)

this.setRedraw(true)

return li_ret

end function

public function integer uf_cerca_nodo (string as_struttura);boolean lb_found
long ll_handle
string ls_token
treeViewItem ltvi_item
s_struttura s_struttura_s

ll_handle= this.findItem(rootTreeItem!, 0)

as_struttura= mid(as_struttura, len(gs_ambito) + 1, len(as_struttura) )

ls_token= f_get_token(as_struttura, ".")

ricerca: if as_struttura= "" then
				this.selectItem(ll_handle)
				return 0
			end if
			
			this.selectItem(ll_handle)
			
			ll_handle= this.findItem(childTreeItem!, ll_handle)

			ls_token += "."+ f_get_token(as_struttura, ".")

			lb_found= false

			do while NOT lb_found
				
				if this.getItem(ll_handle, ltvi_item)= -1 then return -1
				
				s_struttura_s= ltvi_item.data
				
				if s_struttura_s.vc_nodo= gs_ambito+ls_token then
					lb_found= true
					continue
				end if
				
				ll_handle= this.findItem(nextTreeItem!, ll_handle)
				
			loop

goto ricerca
end function

public function integer uf_aggiorna_membri (s_struttura as_struttura_src, s_struttura as_struttura_tgt);integer li_len_parent, li_len_nodo, li_len_src_parent
long ll_livello
string ls_query, ls_parent, ls_nodo, ls_newparent, ls_nuova_parent, ls_codice, ls_substring_org, ls_src_parent, ls_nuovo_nodo


	/*
	 * Estrae tutti i nodi che devono essere spostati sotto lil nuovo nodo parent....
	 */

if as_struttura_src.livello= gi_maxlivello then
	
	ls_query= "select vc_parent from membri_gerarchica where (vc_parent= "+"'" +as_struttura_src.vc_nodo+"')"	
	
else
	
	ls_query= "select vc_parent from membri_gerarchica where (vc_parent like "+"'" +as_struttura_src.vc_nodo+"%')"
	
end if

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "UPDMEMBRI01") < 0 then goto errore
	
	setPointer(hourGlass!)

		do while sqlca.sqlcode <> 100
			
			// per tutti i nodi che hanno come stringa iniziale della loro parent la vecchia parent
			fetch query_cur into
			:ls_parent;
			if sqlca.sqlcode= 100 then continue
			
			// Stacca la sottostringa a destra della vecchia parent
			
			ls_substring_org= f_parse_struttura(ls_parent, as_struttura_tgt.livello)
			
			if ls_substring_org= "" then
				ls_nuova_parent= as_struttura_tgt.vc_nodo
			else
				ls_nuova_parent= as_struttura_tgt.vc_parent+"."+ls_substring_org
			end if
			
			update membri_gerarchica set vc_parent= :ls_nuova_parent where current of query_cur;
			if trap_sql(sqlca, "UPDMEMBRI02") < 0 then goto errore	
	
		loop
		
close query_cur;
trap_sql(sqlca, "UPDMEMBRI03")

// Aggiorna la tabella

// Aggiorna il campo id_parent ponendolo uguale all'id del nuovo nodo parent...
as_struttura_src.vc_parent= as_struttura_tgt.vc_parent

return 0

errore: 

return -1


end function

public function s_struttura uf_aggiorna_parent (s_struttura as_struttura_src, s_struttura as_struttura_tgt);integer li_len_parent, li_len_nodo, li_len_src_parent
long ll_livello
string ls_query, ls_parent, ls_nodo, ls_newparent, ls_nuova_parent, ls_codice, ls_substring_org, ls_src_parent, ls_nuovo_nodo
string ls_parent_right, ls_nodo_right, ls_parent_left


	/*
	 * Estrae tutti i nodi che devono essere spostati sotto lil nuovo nodo parent....
	 */

if as_struttura_src.livello= gi_maxlivello then
	
	ls_query= "select livello, codice, vc_nodo, vc_parent from struttura where (vc_nodo= "+"'" +as_struttura_src.vc_nodo+"') order by livello"	
	
else
	
	ls_query= "select livello, codice, vc_nodo, vc_parent from struttura where (vc_parent like "+"'" +as_struttura_src.vc_nodo+"%') OR (vc_nodo= "+"'"+ as_struttura_src.vc_nodo+"') "+"order by livello"
	
end if

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "UPDPARENT01") < 0 then goto errore
	
	setPointer(hourGlass!)

		do while sqlca.sqlcode <> 100
			
			// per tutti i nodi che hanno come stringa iniziale della loro parent la vecchia parent
			fetch query_cur into
			:ll_livello,
			:ls_codice,
			:ls_nodo,
			:ls_parent;
			if sqlca.sqlcode= 100 then continue
			
			ls_parent_right= f_parse_struttura(ls_parent, as_struttura_tgt.livello)
			
			ls_nodo_right= f_parse_struttura(ls_nodo, as_struttura_tgt.livello)
			
			ls_parent_left= as_struttura_tgt.vc_nodo
			
			if ls_parent_right= "" then
				ls_nuova_parent= ls_parent_left
			else
				ls_nuova_parent= ls_parent_left+"."+ls_parent_right				
			end if
			
			if ls_nodo_right= "" then
				ls_nuovo_nodo= ls_parent_left+"."+ls_codice
			else
				ls_nuovo_nodo= ls_parent_left+"."+ls_nodo_right				
			end if
			
			update struttura set vc_parent= :ls_nuova_parent, vc_nodo=  :ls_nuovo_nodo where current of query_cur;
			if trap_sql(sqlca, "UPDPARENT02") < 0 then goto errore	
			
			
			// se livello = gruppo allora aggiorna la tabella membri ponendo vc_parent= ls_nuovo_nodo dove vc_parent = as_struttura_src.vc_nodo
	
		loop
		
close query_cur;
trap_sql(sqlca, "UPDPARENT03")

// Aggiorna il campo vc_parent ponendolo uguale all'id del nuovo nodo parent...
as_struttura_src.vc_parent= ls_nuova_parent
as_struttura_src.vc_nodo= ls_nuovo_nodo

return as_struttura_src

errore: as_struttura_src.livello= -1


end function

public function integer uf_populate (long al_handle);integer li_length
long ll_handle
string ls_ambito
treeViewItem ll_tvi

setPointer(hourGlass!)

setRedraw(false)

if  al_handle= 0 then
	
	select livello -1,  vc_parent
	into 	:is_struttura_s.livello,
			:is_struttura_s.vc_nodo
	from struttura
	where vc_nodo = :gs_ambito;
	if trap_sql(sqlca, "ROOT01") < 0 then return -1
	

//	is_struttura_s.vc_nodo= is_struttura_s.vc_parent
	
else
	
	if this.getItem(al_handle, ll_tvi) < 0 then return -1

	is_struttura_s= ll_tvi.data
	
//	is_struttura_s.vc_parent= is_struttura_s.vc_nodo

end if

ls_ambito= gs_ambito
li_length=  len(is_struttura_s.vc_nodo)

//if len(is_struttura_s.vc_nodo) <  len(is_ambito) then
//	li_length=  len(is_struttura_s.vc_nodo)
//	ls_ambito= mid(is_ambito, 1, li_length)
//end if

if is_struttura_s.livello <=  gi_maxlivello  then
	
	declare child_cur cursor for
	
	select struttura.livello, vc_nodo, relazione, vc_parent, codice, livelli_struttura.descrizione, struttura.descrizione, struttura.cod_dip
	from struttura, livelli_struttura
	where	struttura.livello= :is_struttura_s.livello +1 and vc_parent = :is_struttura_s.vc_nodo and
				struttura.livello= livelli_struttura.livello and vc_nodo like :gs_ambito+'%';
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:is_struttura_s.livello,
		:is_struttura_s.vc_nodo,
		:is_struttura_s.relazione,
		:is_struttura_s.vc_parent,
		:is_struttura_s.codice,
		:is_struttura_s.descrizione_livello,
		:is_struttura_s.descrizione_struttura,
		:is_struttura_s.cod_dip;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		if ll_tvi.expandedonce= false then
		
			ll_tvi.pictureIndex= is_struttura_s.livello
			if is_struttura_s.livello= 2 then
				ll_tvi.selectedPictureIndex= 13
			else
				ll_tvi.selectedPictureIndex= 14
			end if
			
			ll_tvi.children= true
			if is_struttura_s.livello = gi_maxlivello then ll_tvi.children= false
			ll_tvi.selected= false
			ll_tvi.bold= false
			
//			ll_tvi.label= f_iniziali(ls_descrizione_livello)+": "+f_iniziali(ls_descrizione_struttura)/*+" ("+string(ll_livello)+", "+string(ll_handle)+")"*/
			
			ll_handle = this.InsertItemLast(al_handle,ll_tvi)
			
			is_struttura_s.handle= ll_handle
			ll_tvi.data= is_struttura_s
			
			if is_struttura_s.cod_dip= "" or isNull(is_struttura_s.cod_dip) then
			
				ll_tvi.label= f_iniziali(is_struttura_s.descrizione_livello)+": "+f_iniziali(is_struttura_s.descrizione_struttura) //+" ("+is_struttura_s.codice+")"
				
			else
								
				ll_tvi.label= f_iniziali(is_struttura_s.descrizione_livello)+": "+f_iniziali(is_struttura_s.descrizione_struttura) +" ("+is_struttura_s.cod_dip+")"				
			
		end if
						
			this.setItem(ll_handle, ll_tvi)
			
		end if
		
	loop
	
	close child_cur;

end if

setRedraw(true)
	

return ll_handle
end function

on uotv_struttura_senzapersone.create
end on

on uotv_struttura_senzapersone.destroy
end on

event selectionchanged;treeViewItem ltvi_new_item

if ib_dragdrop then return 0

if getItem(newhandle, ltvi_new_item) < 0 then return -1

if ltvi_new_item.level > il_fino_a_quale_livello  then return 0

is_struttura_s= ltvi_new_item.data

if ltvi_new_item.expandedOnce= false then expandItem(newHandle) 
end event

event itemcollapsing;//treeviewitem ltvi_clicked
//
//if getItem(handle, ltvi_clicked) < 0 then return -1
//
////if ltvi_clicked.expandedOnce= false then uf_populate(handle)
////this.CollapseItem ( handle )
//
//return 0
end event

event itempopulate;treeviewitem ltvi_clicked

if ib_dragdrop then return 0

if getItem(handle, ltvi_clicked) < 0 then return -1

//if ltvi_clicked.level > il_fino_a_quale_livello  then return 0

 if ltvi_clicked.expandedOnce= false then  uf_populate(handle)

return 0
end event

event begindrag;treeViewItem ltvi_item

if this.getItem(handle, ltvi_item)=  -1 then return -1

if ltvi_item.level > gi_maxlivello then return -1

This.Drag(Begin!)

ib_dragdrop= true

This.GetItem(handle, itvi_dragged_object)
itvi_dragged_object.selected= false
setItem(handle, itvi_dragged_object)
il_oldhandle= handle

il_DragLevel= itvi_dragged_object.level
end event

event dragdrop;long ll_droppedhandle, ll_newparenthandle, ll_child_handle
integer li_ret
s_struttura s_struttura_source, s_struttura_target, s_struttura_new
treeViewItem ltvi_target, ltvi_source//, ltvi_newitem

SetDropHighlight(0)

ll_newparenthandle= handle // handle del target...

li_ret= This.getItem(ll_newparenthandle, ltvi_target)
if li_ret= -1 then return -1
s_struttura_target= ltvi_target.data // prende i dati relativi al target item...

li_ret= this.getItem(il_oldhandle, ltvi_source)
if li_ret= -1 then return -1
s_struttura_source= ltvi_source.data // prende i dati relativi al source item...

il_DropLevel= ltvi_target.level

if il_DropLevel = il_DragLevel - 1 then
	
	li_ret= messageBox("Modifica struttura", "Stai spostando: "+&
			s_struttura_source.descrizione_livello+" "+s_struttura_source.descrizione_struttura+"~nin: "+&
				s_struttura_target.descrizione_livello+" "+s_struttura_target.descrizione_struttura+".~nConfermi lo spostamento?", question!, yesNo!, 2)
				
	if li_ret= 2 then
		drag(cancel!)
		ib_dragdrop= false
		return -1
	end if
		
//		Aggiornamento...

		s_struttura_new= uf_aggiorna_parent(s_struttura_source, s_struttura_target)
		
		if s_struttura_new.livello= -1 then
			messageBox("Modifica struttura", "Errore in aggiornamento struttura", exclamation!)
			Drag(cancel!)
	 	 	ib_dragdrop= false
		  	goto errore
		end if		
		
		li_ret= uf_aggiorna_membri(s_struttura_source, s_struttura_new)
		
		if li_ret= -1 then
			messageBox("Modifica struttura", "Errore in aggiornamento tabella membri", exclamation!)
			Drag(cancel!)
	 	 	ib_dragdrop= false
		  	goto errore
		end if	
		
		commit;
		if trap_sql(sqlca, "COMMITUPDSTRUTTURA") < 0 then goto errore
		
		ib_dragdrop= false
		
		if This.DeleteItem(il_oldhandle)= -1 then 
			messageBox("Modifica struttura", "Errore in cancellazione src item", exclamation!)
			goto errore
		end if
		
//		if ltvi_target.expandedOnce= true then
//			
//			ll_child_handle= findItem(childTreeItem!, ll_newparenthandle)
//		
//			do while ll_child_handle <> -1
//				li_ret= this.deleteItem(ll_child_handle)
//				ll_child_handle= findItem(childTreeItem!, ll_newparenthandle)
//				if ll_child_handle= -1 then continue
//			loop
//			
//			
////			ltvi_target.expandedOnce= true
//			ltvi_target.children= true
//			ltvi_target.selected= false
//			
//			setItem(ll_newparenthandle, ltvi_target)
//			
//			uf_populate(ll_newparenthandle)

			// Inserisce il nuovo item nel treeView dopo l'aggiornamento in DB...


			if ltvi_target.expandedOnce= true then
				ltvi_source.StatePictureIndex= 0
				ltvi_source.data= s_struttura_new
	
				ll_child_handle= insertItemLast(ll_newparenthandle, ltvi_source)
				setItem(ll_child_handle, ltvi_source)
			end if
			
//		end if
		
else
	
	 Drag(cancel!)
	 
	 ib_dragdrop= false
	 
end if

return 0

errore:

	rollback;
	
	il_DropTarget = 0
	
	return -1

//This.SetRedraw(TRUE)
end event

event dragwithin;TreeViewItem ltvi_Over

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	il_DropTarget = 0
	Return
End If

il_DropLevel= il_DragLevel - 1

if ltvi_Over.level = il_DropLevel then

	SetDropHighlight(handle)
	il_DropTarget = handle

else
			
	SetDropHighlight(0)
	il_DropTarget = 0
		
end if

//setRedraw(true)

return 0
end event

event constructor;if il_fino_a_quale_livello= 0 then il_fino_a_quale_livello= gi_maxlivello
end event

