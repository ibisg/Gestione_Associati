$PBExportHeader$w_struttura_tv_vert.srw
forward
global type w_struttura_tv_vert from window
end type
type st_3 from statictext within w_struttura_tv_vert
end type
type st_2 from statictext within w_struttura_tv_vert
end type
type st_1 from statictext within w_struttura_tv_vert
end type
type tv_dettaglio from treeview within w_struttura_tv_vert
end type
type dw_scheda from datawindow within w_struttura_tv_vert
end type
type tv_struttura from treeview within w_struttura_tv_vert
end type
end forward

global type w_struttura_tv_vert from window
integer width = 4663
integer height = 1840
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 33026267
string pointer = "Arrow!"
boolean clientedge = true
event type integer ue_queryofferte ( ref treeview atv_handled,  long al_handle )
event type integer ue_runquery ( integer ai_qualequery )
event type integer ue_espandi_livello ( )
st_3 st_3
st_2 st_2
st_1 st_1
tv_dettaglio tv_dettaglio
dw_scheda dw_scheda
tv_struttura tv_struttura
end type
global w_struttura_tv_vert w_struttura_tv_vert

type variables
pointer i_oldpointer
dataStore ids_struttura, ids_membri_gerarchica
treeViewItem  li_tvi_corrente
long il_nodo_corrente, il_livello
s_struttura s_struttura_s

m_pop_tv im_pop_tv
m_pop_tv_dettaglio im_pop_tv_dettaglio
end variables

forward prototypes
public function integer tvf_discenditv (long ll_livello, long ll_nodo, long ll_parent)
public function integer tvf_populate_ds (long al_handle)
public function long tvf_populate (long tvi_handle)
public function integer tvf_dettaglio (long ll_livello, long ll_nodo, long ltvi_handle)
end prototypes

event ue_queryofferte;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura
long ll_livello, ll_nodo, ll_totale_persone, ll_row
decimal ld_importo, ld_zero

treeViewItem ll_tvi

atv_handled.getItem(al_handle, ll_tvi)

ll_livello=ll_tvi.level + il_livello

ll_nodo= ll_tvi.data

//messageBox("test", string(ll_livello)+","+string(ll_nodo) )

//		ll_tvi.label= f_iniziali(ls_descrizione)

ls_query= f_creaqueryofferte(ll_livello, ll_nodo)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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
	
	ll_row= dw_scheda.insertRow(0)
	dw_scheda.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
	dw_scheda.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
	dw_scheda.setItem(ll_row, "status", ls_status)
	dw_scheda.setItem(ll_row, "importo", ld_importo)
	dw_scheda.setItem(ll_row, "zero", ld_zero)
	dw_scheda.setItem(ll_row, "totale_persone", ll_totale_persone)
	dw_scheda.setItem(ll_row, "cod_div", ls_cod_div)

loop

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


end event

event ue_runquery;integer li_ret
long ll_handle
treeviewItem ll_tvi

setpointer(hourGlass!)
setRedraw(false)

dw_scheda.dataObject= 'dw_testqueryofferte_ff'

dw_scheda.setTransObject(sqlca)

dw_scheda.reset()

if ai_qualequery= 1 then
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	li_ret= event ue_queryofferte(tv_struttura, ll_handle)
	
else

	ll_handle = tv_dettaglio.FindItem(currentTreeItem!, 0)
	
	do while ll_handle <> -1
		
		tv_dettaglio.getItem(ll_handle, ll_tvi)
		
		if ll_tvi.statePictureIndex= 2 then
	
			li_ret= event ue_queryofferte(tv_dettaglio, ll_handle)
			
		end if
		
		ll_handle = tv_dettaglio.FindItem(nextTreeItem!, ll_handle)
		
	loop

end if

dw_scheda.groupCalc()

dw_scheda.Object.DataWindow.Print.Preview= 'Yes'

setRedraw(true)

return li_ret
end event

event ue_espandi_livello;integer li_ret
long ll_handle, ll_livello
s_struttura s_struttura_loc
treeViewItem ltvi_struttura

ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
 tv_struttura.GetItem(ll_handle, ltvi_struttura)

s_struttura_loc.livello= ltvi_struttura.level
s_struttura_loc.descrizione_struttura=  ltvi_struttura.label

openWIthParm(w_espandi_livello, s_struttura_loc)

ll_livello= message.doubleParm

li_ret= f_espandilivelli(tv_struttura, ll_livello, ltvi_struttura)

return 0
end event

public function integer tvf_discenditv (long ll_livello, long ll_nodo, long ll_parent);long ll_lev1, ll_codice_membro, ll_cod_div
string ls_relazione, ls_codice, ls_descrizione, ls_cognome, ls_nome, ls_cod_dip
treeViewItem ll_tvi

//do while ll_livello<  MAX_LIVELLO
//
//	declare child_cur cursor for
//	
//	select livello, id_nodo, relazione, id_parent, codice, descrizione
//	from struttura
//	where	livello= :ll_livello + 1 and id_parent= :ll_nodo;
//	if trap_sql(sqlca, "LIV0") < 0 then return -1
//	
//	open child_cur;
//	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
//	
//	do while sqlca.sqlcode <> 100
//		
//		fetch child_cur into
//		:ll_livello,
//		:ll_nodo,
//		:ls_relazione,
//		:ll_parent,
//		:ls_codice,
//		:ls_descrizione;
//		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
//		
//		if sqlca.sqlcode= 100 then continue
//		
//		ll_tvi.data= ll_nodo
//		ll_tvi.level= ll_livello
//		ll_tvi.label= f_iniziali(ls_descrizione)
//		ll_tvi.pictureIndex= ll_livello
//		ll_tvi.selected= false
//		
//		ll_lev1 = tv_struttura.InsertItemSort(tvi_handle,ll_tvi)
//		
//	loop
//	
//	close child_cur;
//	
//loop
	

return 0
end function

public function integer tvf_populate_ds (long al_handle);integer li_ret
long ll_lev1, ll_livello, ll_nodo, ll_parent, ll_codice_membro, ll_cod_div, ll_idx, ll_ret
string ls_relazione, ls_codice, ls_descrizione, ls_cognome, ls_nome, ls_cod_dip
treeViewItem ll_tvi
s_struttura s_struttura_loc

tv_struttura.getItem(al_handle, ll_tvi)

ll_livello= ll_tvi.level

if ll_livello > 0 then

	s_struttura_loc= ll_tvi.data

	ll_nodo= s_struttura_loc.id_nodo
	
end if

if ll_livello <  MAX_LIVELLO then
	
	ll_ret=  ids_struttura.retrieve( ll_livello , ll_nodo )
	if ll_ret= -1 then return -1
	
	for ll_idx= 1 to ids_struttura.rowCount()
		
		ll_livello= ids_struttura.getItemNumber(ll_idx, "livello")
		ll_nodo= ids_struttura.getItemNumber(ll_idx, "id_nodo")
		ls_relazione= ids_struttura.getItemString(ll_idx, "relazione")
		ll_parent= ids_struttura.getItemNumber(ll_idx, "id_parent")
		ls_codice= ids_struttura.getItemString(ll_idx, "codice")
		ls_descrizione= ids_struttura.getItemString(ll_idx, "descrizione")
		
//		ll_tvi.data= ll_nodo
		ll_tvi.level= ll_livello
		
		s_struttura_s.livello= ll_livello
		s_struttura_s.id_nodo= ll_nodo
		
		ll_tvi.data= s_struttura_s
		ll_tvi.label= f_iniziali(ls_descrizione)
		ll_tvi.pictureIndex= ll_livello
		ll_tvi.selected= false
		
		ll_lev1 = tv_struttura.InsertItemSort(al_handle,ll_tvi)
		
	next

else
	
//	if ids_membri_gerarchica.retrieve(ll_livello, ll_nodo)= -1 then return -1
//	
//	
//	for ll_idx= 1 to ids_membri_gerarchica.rowCount()
//		
//		ls_codice= ids_membri_gerarchica.getItemString(ll_idx, "codice")
//		ls_cognome= ids_membri_gerarchica.getItemString(ll_idx, "cognome")
//		ls_nome= ids_membri_gerarchica.getItemString(ll_idx, "nome")
//		ll_cod_div= long(ids_membri_gerarchica.getItemString(ll_idx, "cod_div"))
//	
//		ll_tvi.data= ls_codice
//		ll_tvi.level= ll_livello
//		ll_tvi.label= f_iniziali(ls_cognome+" "+ls_nome)
//		ll_tvi.pictureIndex= ll_livello+ll_cod_div
//		ll_tvi.selected= false
//		ll_tvi.children= false
//		ll_tvi.bold= false
//		
//		ll_lev1 = tv_struttura.InsertItemSort(al_handle,ll_tvi)
//		
//	next
		
end if
	

return 0
end function

public function long tvf_populate (long tvi_handle);long ll_lev1, ll_livello, ll_nodo, ll_parent, ll_codice_membro, ll_cod_div
string ls_relazione, ls_codice, ls_descrizione, ls_cognome, ls_nome, ls_cod_dip
treeViewItem ll_tvi

//ll_lev1 = tv_struttura.FindItem(CurrentTreeItem!, 0)

tv_struttura.getItem(tvi_handle, ll_tvi)

ll_livello= ll_tvi.level

if ll_livello > 0 then

//	s_struttura_loc= ll_tvi.data

	ll_nodo= ll_tvi.data
	
end if

if ll_livello <  MAX_LIVELLO then

	declare child_cur cursor for
	
	select livello, id_nodo, relazione, id_parent, codice, descrizione
	from struttura
	where	livello= :ll_livello + 1 and id_parent= :ll_nodo;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:ll_livello,
		:ll_nodo,
		:ls_relazione,
		:ll_parent,
		:ls_codice,
		:ls_descrizione;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		ll_tvi.data= ll_nodo
		
		ll_tvi.label= f_iniziali(ls_descrizione)
		ll_tvi.pictureIndex= ll_livello
		ll_tvi.selected= false
		
		
		
		ll_lev1 = tv_struttura.InsertItemLast(tvi_handle,ll_tvi)
		
	loop
	
	close child_cur;

else
	
	declare root_cur_membri cursor for
	
	select codice, cognome, nome, cod_div
	from membri_gerarchica
	where livello= :ll_livello and id_nodo= :ll_nodo
	order by cod_div, cognome, nome;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open root_cur_membri;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch root_cur_membri into
		:ls_codice,
		:ls_cognome,
		:ls_nome,
		:ll_cod_div;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		ll_tvi.data= ls_codice
		ll_tvi.level= ll_livello
		
		ll_tvi.data= ll_nodo
		
		ll_tvi.label= f_iniziali(ls_cognome+" "+ls_nome)
		ll_tvi.pictureIndex= ll_livello+ll_cod_div
		ll_tvi.selected= false
		ll_tvi.children= false
		ll_tvi.bold= false
		
		ll_lev1 = tv_struttura.InsertItemLast(tvi_handle,ll_tvi)
		
//		tv_struttura.setItem(tvi_handle, ll_tvi)
		
	loop
	
	close root_cur_membri;
		
end if
	

return 0
end function

public function integer tvf_dettaglio (long ll_livello, long ll_nodo, long ltvi_handle);long ll_lev1, ll_parent, ll_codice_membro, ll_cod_div, ll_todelete, ll_ret
string ls_relazione, ls_codice, ls_descrizione, ls_cognome, ls_nome, ls_cod_dip
long ll_livellostruttura
treeViewItem ll_tvi

if ll_livello <  MAX_LIVELLO then

	declare child_cur cursor for
	
	select livello, id_nodo, relazione, id_parent, codice, descrizione
	from struttura
	where	livello= :ll_livello + 1 and id_parent= :ll_nodo;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:ll_livello,
		:ll_nodo,
		:ls_relazione,
		:ll_parent,
		:ls_codice,
		:ls_descrizione;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		ll_tvi.data=  ll_nodo
//		ll_tvi.level= ll_livello
		ll_tvi.label= f_iniziali(ls_descrizione)
		ll_tvi.pictureIndex= ll_livello
		ll_tvi.statePictureIndex= 2
		ll_tvi.selected= false
		
		ll_lev1 = tv_dettaglio.InsertItemLast(0, ll_tvi)
		
	loop
	
	close child_cur;

else
	
	declare root_cur_membri cursor for
	
	select codice, cognome, nome, cod_div
	from membri_gerarchica
	where livello= :ll_livello and id_nodo= :ll_nodo
	order by cod_div, cognome, nome;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open root_cur_membri;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch root_cur_membri into
		:ls_codice,
		:ls_cognome,
		:ls_nome,
		:ll_cod_div;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
//		ll_tvi.data= ls_codice
//		ll_tvi.level= ll_livello
		
		ll_tvi.data=  ll_nodo
		
		ll_tvi.label= f_iniziali(ls_cognome+" "+ls_nome)
		ll_tvi.pictureIndex= ll_livello+ll_cod_div
		ll_tvi.selected= false
		ll_tvi.statePictureIndex=  2
		
		ll_lev1 = tv_dettaglio.InsertItemLast(0,ll_tvi)
		
	loop
	
	close root_cur_membri;
		
end if
	

return 0
end function

on w_struttura_tv_vert.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.tv_dettaglio=create tv_dettaglio
this.dw_scheda=create dw_scheda
this.tv_struttura=create tv_struttura
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.tv_dettaglio,&
this.dw_scheda,&
this.tv_struttura}
end on

on w_struttura_tv_vert.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.tv_dettaglio)
destroy(this.dw_scheda)
destroy(this.tv_struttura)
end on

event resize;tv_struttura.height= this.height - 160 -136
tv_dettaglio.height= tv_struttura.height
//tv_struttura.width= this.width - 120
dw_scheda.height= tv_struttura.height
//dw_scheda= pointerX()


dw_scheda.width= this.width - 120  - ( tv_struttura.width + tv_dettaglio.width )
end event

event open;ids_struttura= create dataStore
ids_membri_gerarchica= create dataStore

//dw_scheda.Object.DataWindow.Print.Preview= 'Yes'
//dw_scheda.Object.DataWindow.Zoom = 80
dw_scheda.setTransObject(sqlca)

ids_struttura.dataObject= "ds_struttura_query"
ids_membri_gerarchica.dataObject= "ds_membri_gerarchica_query"

ids_struttura.setTransObject(sqlca)
ids_membri_gerarchica.setTransObject(sqlca)

im_pop_tv= create m_pop_tv
im_pop_tv_dettaglio= create m_pop_tv_dettaglio

// Inserisce gli item relativi al livello 0 (root )

long ll_handle

//tvf_populate_ds(0)
tvf_populate(0)
ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
tv_struttura.ExpandItem ( ll_handle )
	
dw_scheda.setFocus()

return 0
end event

type st_3 from statictext within w_struttura_tv_vert
integer x = 2432
integer y = 80
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 33026267
string text = "Anteprima report"
boolean focusrectangle = false
end type

type st_2 from statictext within w_struttura_tv_vert
integer x = 1577
integer y = 80
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 33026267
string text = "Dettaglio"
boolean focusrectangle = false
end type

type st_1 from statictext within w_struttura_tv_vert
integer y = 80
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 33026267
string text = "Struttura"
boolean focusrectangle = false
end type

type tv_dettaglio from treeview within w_struttura_tv_vert
event ue_queryoffertedettaglio ( )
integer x = 1577
integer y = 136
integer width = 846
integer height = 1620
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 16777215
integer indent = 125
boolean haslines = false
boolean checkboxes = true
boolean trackselect = true
string picturename[] = {"Globals!","a.gif","t.gif","h.gif","c.gif","s.gif","g.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer picturewidth = 32
integer pictureheight = 32
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event ue_queryoffertedettaglio;long ll_handle, ll_nexthandle

ll_handle = tv_dettaglio.FindItem(RootTreeItem!, 0)

do while ll_handle <> -1



ll_handle= tv_dettaglio.FindItem ( nextTreeItem!, ll_handle )

loop
end event

event selectionchanged;treeViewItem ll_tvi, ll_tvi_struttura
integer li_ret
long ll_handle, ll_livello, ll_nodo, ll_ret, ll_todelete
//s_struttura s_struttura_loc
//
////getItem(newhandle, ll_tvi)
//ll_handle = tv_struttura.FindItem(CurrentTreeItem!, 0)
//tv_struttura.getItem(ll_handle, ll_tvi_struttura)
//
//if ll_tvi_struttura.level = MAX_LIVELLO then
//	
//	string ls_codice
//	
////	s_struttura_loc= ll_tvi.data
////	
////	ls_codice= s_struttura_loc.codice
//	
//	this.setRedraw(false)
//	
//	dw_scheda.dataObject= 'dw_scheda_anagrafica_gerarchica_prova'
//	
//	dw_scheda.setTransObject(sqlca)
//
//	dw_scheda.retrieve(ls_codice)  //> 0 then cb_stampa.enabled= true
//
//	this.setRedraw(true)
//	
//else
//	
//ll_ret= tv_dettaglio.findItem(rootTreeItem!, ll_todelete)

//if NOT keyDown(KeyControl!) then 
//
//	do while ll_ret <> -1
//		
//		tv_dettaglio.deleteItem(ll_todelete)
//		
//		ll_ret= tv_dettaglio.findItem(nextTreeItem!, ll_todelete)
//		
//	loop
	
//end if
//
	tv_dettaglio.getItem(newhandle, ll_tvi)

	ll_tvi.selected= true
	ll_tvi.children= true
//	ll_tvi.bold= true
//
//ll_livello= ll_tvi.level + ll_tvi_struttura.level
//
////	s_struttura_loc= ll_tvi_struttura.data
//	
	tv_dettaglio.setItem(newhandle, ll_tvi)
//	
//	tvf_dettaglio(ll_livello, ll_nodo,  ll_tvi_struttura.data)
//	
//end if
end event

event rightclicked;//messagebox("test", "dettaglio")
im_pop_tv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )
end event

event itemexpanding;long ll_livello, ll_struttura, ll_nodo, ll_ret, ll_todelete
treeViewItem ltvi_dettaglio, ltvi_struttura

//getItem(handle, ltvi_dettaglio)
//
//ll_nodo= ltvi_dettaglio.data
//
//ll_livello= ltvi_dettaglio.level +il_livello

if NOT keyDown(KeyControl!) then 
	
	ll_ret= tv_dettaglio.findItem(rootTreeItem!, ll_todelete)

	do while ll_ret <> -1
		
		tv_dettaglio.deleteItem(ll_todelete)
		
		ll_ret= tv_dettaglio.findItem(nextTreeItem!, ll_todelete)
		
	loop
	
end if

if ltvi_dettaglio.expandedOnce= false then
	
	getItem(handle, ltvi_dettaglio)

	ll_nodo= ltvi_dettaglio.data

	ll_livello= ltvi_dettaglio.level +il_livello
	
	tvf_dettaglio(ll_livello, ll_nodo, handle)

end if

return 0
end event

type dw_scheda from datawindow within w_struttura_tv_vert
integer x = 2432
integer y = 136
integer width = 1637
integer height = 1504
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event retrievestart;return 2
end event

event buttonclicked;openWithParm(w_dw_print_options, dw_scheda)
end event

event resize;
tv_struttura.width= w_struttura_tv.width -(  newwidth - tv_dettaglio.width + 120 )
tv_dettaglio.X= tv_struttura.width + 20
end event

type tv_struttura from treeview within w_struttura_tv_vert
integer y = 136
integer width = 1568
integer height = 1620
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 16777215
integer indent = 125
boolean linesatroot = true
boolean trackselect = true
boolean fullrowselect = true
boolean singleexpand = true
string picturename[] = {"Globals!","a.gif","t.gif","h.gif","c.gif","s.gif","g.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;//// Inserisce gli item relativi al livello 0 (root )
//
//long ll_handle
//	
//tvf_populate_ds(0)
//ll_handle= findItem(rootTreeItem!, 0)
//ExpandItem ( ll_handle )
//	
//dw_scheda.setFocus()
//
//return 0
end event

event itemexpanding;integer li_ret
treeViewItem ll_tvi

li_ret= getItem(handle, ll_tvi)
	
if ll_tvi.expandedOnce= false then  tvf_populate(handle)
	return 0
end event

event selectionchanged;long ll_nodo, ll_todelete, ll_ret
s_struttura s_struttura_loc
treeViewItem ll_tvi, ll_tvi_old
integer li_ret

ll_ret= tv_dettaglio.findItem(rootTreeItem!, ll_todelete)

getItem(oldhandle, ll_tvi_old)

getItem(newhandle, ll_tvi)

//if ll_tvi_old.level = ll_tvi.level then //messageBox("test", "Livelli uguaili")

if NOT (keyDown(KeyControl!) and ll_tvi_old.level = ll_tvi.level ) then 

	do while ll_ret <> -1
		
		tv_dettaglio.deleteItem(ll_todelete)
		
		ll_ret= tv_dettaglio.findItem(nextTreeItem!, ll_todelete)
		
	loop
	
end if

//if ll_tvi.level > MAX_LIVELLO then
	
	ll_tvi.selected= true
	ll_tvi.children= true
//	ll_tvi.bold= true

//	s_struttura_loc.livello= ll_tvi.level
//	s_struttura_loc.id_nodo= newhandle

ll_nodo= 	ll_tvi.data

il_livello= ll_tvi.level
	
	setItem(newhandle, ll_tvi)
	
	tvf_dettaglio( ll_tvi.level,  ll_nodo, 0)
	
//end if
end event

event rightclicked;//setpointer(hourGlass!)
//setRedraw(false)
//ExpandAll ( handle )
//setRedraw(true)
//messagebox("test", "struttura")
//im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )

//parent.event ue_espandi_livello()
end event

