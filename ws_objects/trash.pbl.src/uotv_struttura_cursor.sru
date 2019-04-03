$PBExportHeader$uotv_struttura_cursor.sru
forward
global type uotv_struttura_cursor from treeview
end type
end forward

global type uotv_struttura_cursor from treeview
integer width = 480
integer height = 400
string dragicon = "DataPipeline!"
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer indent = 100
boolean hasbuttons = false
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
boolean checkboxes = true
boolean trackselect = true
boolean fullrowselect = true
string picturename[] = {"wi0064-48.gif","foot_orange.gif","foot_blue.gif","foot_red.gif","foot_yellow.gif","foot_green.gif","foot_orange.gif","CharlieBrown2.gif","lucy_32x32.jpg","Linus.gif","Sally.gif","warning.gif","bullet_square_yellow.gif",""}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 536870912
string statepicturename[] = {"house.bmp","D_RED.BMP","D_yellow.bmp","D_GRAY.BMP","d_green.bmp"}
long statepicturemaskcolor = 536870912
end type
global uotv_struttura_cursor uotv_struttura_cursor

type variables
boolean ib_dragdrop= false, ib_searchend= false
datastore ids_membri, ids_populate

long	il_livello
long il_queue[], il_foundhandle
long il_tot, il_current

s_struttura is_struttura_s, is_struttura_root_s

s_tvinit is_tvinit_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object
end variables

forward prototypes
public function integer uf_insertitem (long al_handleparent)
public function integer uf_visualizzanuovoitem (long al_handleparent)
public function long uf_cerca_nodo (string as_struttura)
public function integer uf_aggiorna_membri (s_struttura as_struttura_src, s_struttura as_struttura_tgt)
public function s_struttura uf_aggiorna_parent (s_struttura as_struttura_src, s_struttura as_struttura_tgt)
public function integer uf_populate (long al_handle)
public function integer uf_moveitem (long al_handleparent, w_struttura_tv aw_struttura_tv)
public function integer uf_modifyitem (long al_handle)
end prototypes

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

	if uf_visualizzanuovoitem(al_handleparent)= -1 then return -1

this.setRedraw(true)

return 1

end function

public function integer uf_visualizzanuovoitem (long al_handleparent);integer li_ret= 0
long ll_child
treeViewItem ll_tvi

//this.setRedraw(false)

	do while ll_child <> -1
		ll_child= this.findItem(childTreeItem!, al_handleparent)
		this.deleteItem(ll_child)
	loop
	
	if this.getItem(al_handleparent, ll_tvi) < 0 then goto esci
	
	ll_tvi.expanded=  false
	ll_tvi.expandedOnce=  false
	ll_tvi.children=  true
	ll_tvi.selected=  true //false
	
	li_ret= this.setItem(al_handleparent, ll_tvi)
	li_ret= this.expandItem(al_handleparent)
	
	esci:

//this.setRedraw(true)

return li_ret

end function

public function long uf_cerca_nodo (string as_struttura);boolean lb_found
integer li_ret
long ll_handle
string ls_token, ls_match, ls_nodo, ls_struttura, ls_mid, ls_ambito
treeViewItem ltvi_item
s_struttura s_struttura_s

ib_searchend= false

// handle del nodo root
ll_handle= this.findItem(rootTreeItem!, 0)

ls_struttura= as_struttura


// Di questa string prende il primo token delimitato dal punto
//ls_token= f_get_token(as_struttura, ".")

////

		// acquisisce i dati relativi al nodo
		ancora:
		li_ret= this.getItem(ll_handle, ltvi_item)
		if li_ret= -1 then return -1
		s_struttura_s= ltvi_item.data
		
		ls_mid= mid(ls_struttura, 1, len(s_struttura_s.vc_nodo))
		if ls_mid <> s_struttura_s.vc_nodo then
			
			ll_handle= this.findItem(NextTreeItem!, ll_handle)
			
			goto ancora
			
		end if
		
		ls_ambito= s_struttura_s.vc_nodo

////

// Struttura da cercare al netto della stringa che delimita l'ambito
as_struttura= mid(as_struttura, len(ls_ambito) + 2, len(as_struttura) )

ricerca:

if as_struttura= "" then // se è blank vuol dire che sono già sul punto giusto

				ib_searchend= true
				this.selectItem(ll_handle)
				this.SetFirstVisible ( ll_handle )
				return ll_handle
				
end if
			
			// altrimenti seleziona l'item e ne provoca il popolamento
			this.selectItem(ll_handle)
			
			// cerca il child
			ll_handle= this.findItem(childTreeItem!, ll_handle)

			// aggiunge il livello successivo di struttura
			if ls_token= "" then
				ls_token= f_get_token(as_struttura, ".")
			else
				ls_token += "."+ f_get_token(as_struttura, ".")
			end if

			lb_found= false

			do while NOT lb_found
				
				// a partire dal child trovato precedentemente 
				li_ret= this.getItem(ll_handle, ltvi_item)
				if li_ret= -1 then return -1
				
				// acquisisce i dati relativi al nodo
				s_struttura_s= ltvi_item.data
				
				if s_struttura_s.livello > is_tvinit_s.ai_maxlivello then
					ls_match= s_struttura_s.vc_nodo+"."+trim(s_struttura_s.cognome)+" "+trim(s_struttura_s.nome)
				else
					ls_match= s_struttura_s.vc_nodo
				end if
				
				ls_nodo= ls_ambito+"."+ls_token
				if ls_match= ls_nodo then
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

if as_struttura_src.livello= is_tvinit_s.ai_maxlivello then
	
	ls_query= "select vc_parent from membri_gerarchica where (vc_parent= "+"'" +as_struttura_src.vc_nodo+"')"	
	
	select vc_parent into :il_tot from membri_gerarchica where vc_parent= :as_struttura_src.vc_nodo;
	if trap_sql(sqlca, "COUNT01") < 0 then goto errore
	
else
	
	ls_query= "select vc_parent from membri_gerarchica where (vc_parent like "+"'" +as_struttura_src.vc_nodo+"%')"
	
	select vc_parent into :il_tot from membri_gerarchica where (vc_parent like :as_struttura_src.vc_nodo+"%");
	if trap_sql(sqlca, "COUNT02") < 0 then goto errore
	
end if

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "UPDMEMBRI01") < 0 then goto errore
	
	open(w_wait_meter)
	w_wait_meter.title= "Aggiornamento: "+as_struttura_src.vc_nodo
	
	setPointer(hourGlass!)
	
	il_current= 0

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
			
			il_current++
			
			w_wait_meter.hpb_meter.position= (il_current/il_tot)*100
			
		loop
		
		close(w_wait_meter)
		
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
long ll_livello, ll_rows
string ls_query, ls_parent, ls_nodo, ls_newparent, ls_nuova_parent, ls_codice, ls_substring_org, ls_src_parent, ls_nuovo_nodo
string ls_parent_right, ls_nodo_right, ls_parent_left
datetime ldt_oggi	

dataStore lds_aggiornaparent

lds_aggiornaparent= create dataStore

/*
 * Estrae tutti i nodi che devono essere spostati sotto lil nuovo nodo parent....
 */

if as_struttura_src.livello= is_tvinit_s.ai_maxlivello then // se siamo al livello di gruppo...
	// estrae solo il nodo da spostare in quanto sotto non ci può essere nulla...
	
	lds_aggiornaparent.dataObject= "ds_aggiorna_parent"
	
//	select count(*) into :il_tot from struttura where vc_nodo= :as_struttura_src.vc_nodo;	
//	if trap_sql(sqlca, "COUNT01") < 0 then goto errore
	
else
	// estrae il nodo da spostare + tutti i nodi al di sotto...
	
	lds_aggiornaparent.dataObject= "ds_aggiorna_parent_like"
					
//	select count(*) into :il_tot from struttura where vc_parent like :as_struttura_src.vc_nodo+".%" /*OR vc_nodo= :as_struttura_src.vc_nodo*/ ;
//	if trap_sql(sqlca, "COUNT02") < 0 then goto errore
	
end if

lds_aggiornaparent.setTransObject(sqlca)

setPointer(hourGlass!)
	
ll_rows= lds_aggiornaparent.retrieve(as_struttura_src.vc_nodo)

il_tot= ll_rows

if ll_rows <= 0 then goto errore
	
	open(w_wait_meter)
	
	w_wait_meter.title= "Aggiornamento: "+as_struttura_src.vc_nodo

		for il_current= 1 to ll_rows
				
			ll_livello= 	lds_aggiornaparent.getItemNumber(il_current, "livello")
			ls_codice=  	lds_aggiornaparent.getItemString(il_current, "codice")
			ls_nodo=  	lds_aggiornaparent.getItemString(il_current, "vc_nodo")
			ls_parent=  lds_aggiornaparent.getItemString(il_current, "vc_parent")
			
			// aggiorna la tabella struttura_storico...			
				
				ldt_oggi= datetime(date(today()))

				insert into struttura_storico ( livello, codice, vc_nodo, vc_parent, relazione, descrizione,data)
				select livello, codice, vc_nodo, vc_parent, relazione, descrizione, :ldt_oggi from struttura where vc_nodo = :ls_nodo;
				
				if trap_sql(sqlca, "INSSTRUTTURASTORICO01") < 0 then goto errore
				
			// fine aggiornamento storico...	
			
			// ritaglia la parte di coordinata della parent che va conservata...
			ls_parent_right= f_parse_struttura(ls_parent, as_struttura_tgt.livello)
			
			// ritaglia la parte di coordinata del nodo che va conservata...
			ls_nodo_right= f_parse_struttura(ls_nodo, as_struttura_tgt.livello)
			
			// vc_nodo rappresenta la coordinata del nuovo nodo parent
			ls_parent_left= as_struttura_tgt.vc_nodo
			
				if ls_parent_right= "" then
					ls_nuova_parent= ls_parent_left
				else
					ls_nuova_parent= as_struttura_tgt.vc_nodo+"."+ls_parent_right				
				end if
			
				if ls_nodo_right= "" then
					ls_nuovo_nodo= ls_parent_left+"."+ls_codice
				else
					ls_nuovo_nodo= as_struttura_tgt.vc_nodo+"."+ls_nodo_right				
				end if
				
				if as_struttura_src.livello= ll_livello then
					as_struttura_src.vc_nodo= ls_nuovo_nodo
					as_struttura_src.vc_parent= ls_nuova_parent
				end if
				
				if ll_livello= is_tvinit_s.ai_maxlivello then // se siamo al livello di gruppo aggiorna la tabella membri_gerarchica...
					
						update membri_gerarchica set vc_parent= :ls_nuovo_nodo where vc_parent= :ls_nodo;
						if trap_sql(sqlca, "UPDMEMBRI02") < 0 then goto errore	
						
				end if
			
				// messageBox("test", ls_nodo+" - "+ls_nuovo_nodo)
				update struttura set vc_parent= :ls_nuova_parent, vc_nodo=  :ls_nuovo_nodo where vc_nodo= :ls_nodo; 
				if trap_sql(sqlca, "UPDPARENT02") < 0 then goto errore
				
				w_wait_meter.hpb_meter.position= (il_current/il_tot)*100
	
		next
		
		close(w_wait_meter)

return as_struttura_tgt

errore: as_struttura_tgt.livello= -1

return as_struttura_tgt


end function

public function integer uf_populate (long al_handle);integer li_length, li_idx= 1
long ll_handle, ll_rows, ll_idx, ll_children
string ls_query
treeViewItem ll_tvi
s_struttura s_struttura_root_s, s_struttura_child_s

// Trova le coordinate del nodo root
if  al_handle= 0 then

	select livello,  vc_parent
		into 	:s_struttura_root_s.livello,
				:s_struttura_root_s.vc_nodo
		from struttura
		where vc_nodo = :gs_ambiti[1];
		
		if trap_sql(sqlca, "ROOT01") < 0 then return -1
		
	// codice da sistemare, decidere se nell'estrazione lasciare select livello -1 o no
		
	is_tvinit_s.ai_numerolivellivisualizzati= is_tvinit_s.ai_maxlivello - s_struttura_root_s.livello +1
	
else
	
	if this.getItem(al_handle, ll_tvi) < 0 then goto errore

//	is_struttura_s= ll_tvi.data
	s_struttura_root_s=  ll_tvi.data

end if

li_length=  len(is_struttura_s.vc_nodo)

if s_struttura_root_s.livello < is_tvinit_s.ai_maxlivello then
	
	if trap_sql(sqlca, "LIV0") < 0 then goto errore
	
	/////
	
	ls_query=	"select struttura.livello, vc_nodo, relazione, vc_parent, codice, struttura_livelli.descrizione, struttura.descrizione "+&
					" from struttura, struttura_livelli "+&
					" where vc_parent = '"+s_struttura_root_s.vc_nodo+ "' and struttura.livello= struttura_livelli.livello and ("

	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_nodo like '"+gs_ambiti[li_idx]+"%') order by vc_nodo"
			
		else
			
			ls_query += "vc_nodo like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next


	DECLARE nodi_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC nodi_cur ;
	if trap_sql(sqlca, "RUNQUERYNODI") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch  nodi_cur
			into :s_struttura_child_s.livello, :s_struttura_child_s.vc_nodo, :s_struttura_child_s.relazione, : s_struttura_child_s.vc_parent, :s_struttura_child_s.codice,  :s_struttura_child_s.descrizione_livello, :s_struttura_child_s.descrizione_struttura;

			if sqlca.sqlcode= 100 then continue
			
		if ll_tvi.expandedonce= false then
		
			
			//if s_struttura_child_s.flag_attiva= 1 then
				ll_tvi.pictureIndex= s_struttura_child_s.livello
			//else
				//ll_tvi.pictureIndex= 12
			//end if
			
			// GdS 25/08/2011
//			if is_struttura_s.livello= 2 then
//				ll_tvi.selectedPictureIndex= 13
//			else
//				ll_tvi.selectedPictureIndex= 14
//			end if
			
			if s_struttura_child_s.livello > is_tvinit_s.ai_ultimolivelloparent then
				
				ll_tvi.children= false
				
			else
				
				if s_struttura_child_s.livello <= is_tvinit_s.ai_ultimolivelloparent then ll_tvi.children= true
					
			end if

			ll_tvi.selected= false
			ll_tvi.bold= false
				
			ll_handle = this.InsertItemLast(al_handle,ll_tvi)
			
			s_struttura_child_s.handle= ll_handle
			ll_tvi.data= s_struttura_child_s
								
					ll_tvi.label= f_iniziali(s_struttura_child_s.descrizione_livello)+": "+f_iniziali(s_struttura_child_s.descrizione_struttura)  +" - ["+s_struttura_child_s.codice+"] " /*+string(ll_handle) +" ("+is_struttura_s.cod_dip+")"	*/
						
			this.setItem(ll_handle, ll_tvi)
			
		end if // if ll_tvi.expandedonce= false...
	
	loop
		
	close nodi_cur;
	
else		// >= ii_maxlivello...

			declare membri_cur cursor for 
			
			  SELECT membri_gerarchica.codice,   
				membri_gerarchica.cognome,   
				membri_gerarchica.nome,   
				membri_gerarchica.cod_div,   
				divisione.descrizione,
				membri_gerarchica.citta_nas,   
				membri_gerarchica.prov_nas,   
				membri_gerarchica.data_nas,   
				membri_gerarchica.ind_dom,
				membri_gerarchica.cap_dom, 
				membri_gerarchica.cod_nazione,   
				membri_gerarchica.cod_div,   
				membri_gerarchica.ind_dom,   
				membri_gerarchica.cap_dom, 
				tab_comuni.comune,   
				tab_comuni.provincia,
				professioni.descrizione,
				membri_gerarchica.pres_da,   
				membri_gerarchica.data_cer,   
				membri_gerarchica.luogo_cer,   
				att_ist_a.descrizione,   
				att_ist_b.descrizione, 
				esami_livelli.descrizione,
				membri_gerarchica.flag_goh,   
				membri_gerarchica.flag_tok,   
				membri_gerarchica.flag_oma,   
				membri_gerarchica.flag_er,
				membri_stato.descrizione,
				membri_gerarchica.cod_dis,
				membri_gerarchica.flag_ldr, 
				membri_gerarchica.flag_npa
			FROM membri_gerarchica
			INNER JOIN divisione ON divisione.cod_div = membri_gerarchica.cod_div
			INNER JOIN membri_stato ON membri_gerarchica.cod_dis = membri_stato.cod_dis
			INNER JOIN esami_livelli ON membri_gerarchica.cod_studio = esami_livelli.cod_studio
			LEFT OUTER JOIN tab_comuni ON membri_gerarchica.cod_com = tab_comuni.cod_com
			LEFT OUTER JOIN professioni ON membri_gerarchica.cod_prof = professioni.cod_prof
			LEFT OUTER JOIN att_ist AS att_ist_a ON membri_gerarchica.cod_att_ist_1 = att_ist_a.cod_att_ist
			LEFT OUTER JOIN att_ist AS att_ist_b ON membri_gerarchica.cod_att_ist_2 = att_ist_b.cod_att_ist
			WHERE membri_gerarchica.vc_parent = :s_struttura_root_s.vc_nodo;
			
			if trap_sql(sqlca, "UFPOP01") < 0 then goto errore
			
			s_struttura_child_s.livello= is_tvinit_s.ai_maxlivello + 1
			s_struttura_child_s.handle= ll_handle
			
			open membri_cur;
			
			do while sqlca.sqlcode <> 100
				
				s_struttura_child_s.vc_nodo= s_struttura_root_s.vc_nodo
				
				fetch membri_cur into
				:s_struttura_child_s.codice,
				:s_struttura_child_s.cognome,
				:s_struttura_child_s.nome,
				:s_struttura_child_s.cod_div,
				:s_struttura_child_s.divisione,
				:s_struttura_child_s.citta_nas,
				:s_struttura_child_s.prov_nas,
				:s_struttura_child_s.data_nas,
				:s_struttura_child_s.ind_dom,
				:s_struttura_child_s.cap_dom,
				:s_struttura_child_s.comune,
				:s_struttura_child_s.provincia,
				:s_struttura_child_s.professione,
				:s_struttura_child_s.pres_da,
				:s_struttura_child_s.data_cer,
				:s_struttura_child_s.luogo_cer,
				:s_struttura_child_s.responsabilita1,
				:s_struttura_child_s.responsabilita2,
				:s_struttura_child_s.livello_studio,
				:s_struttura_child_s.flag_goh,
				:s_struttura_child_s.flag_tok,
				:s_struttura_child_s.flag_oma,
				:s_struttura_child_s.flag_er,
				:s_struttura_child_s.status,
				:s_struttura_child_s.cod_dis,
				:s_struttura_child_s.flag_ldr,
				:s_struttura_child_s.flag_npa;
				
				if sqlca.sqlcode= 100 then continue
				
				
					if s_struttura_child_s.flag_npa= '1' then
						
							ll_tvi.PictureIndex= 0
							ll_tvi.statePictureIndex= 0
						
					else
						
							ll_tvi.PictureIndex= is_tvinit_s.ai_maxlivello + s_struttura_child_s.cod_div

							if s_struttura_child_s.flag_ldr= 'S' then
	//							ll_tvi.bold= true
								ll_tvi.statePictureIndex= 1
							else
	//							ll_tvi.bold= false
								ll_tvi.statePictureIndex= 0
							end if
					end if
					
					ll_tvi.bold= false
					if lower(s_struttura_child_s.responsabilita1)= "gruppo" or lower(s_struttura_child_s.responsabilita2)= "gruppo" then ll_tvi.bold= true	
					
					ll_tvi.children= false
					ll_tvi.selected= false
						
					ll_handle = this.InsertItemLast(al_handle,ll_tvi)
					
					ll_tvi.label= f_iniziali(trim(s_struttura_child_s.cognome)+" "+trim(s_struttura_child_s.nome))//+string(ll_handle)
					
					s_struttura_child_s.handle= ll_handle
					ll_tvi.data= s_struttura_child_s
					
											
					this.setItem(ll_handle, ll_tvi)
					
				loop
				
				close membri_cur;
				
end if

//this.setRedraw(true)

return ll_handle

errore:

//this.setRedraw(true)

//setPointer(lpt_oldpointer)

return -1


end function

public function integer uf_moveitem (long al_handleparent, w_struttura_tv aw_struttura_tv);integer li_ret
long ll_handlenew
long ll_child
string ls_codice, ls_descrizione
treeViewItem ltvi_new, ltvi_parent, ll_tvi
s_struttura s_struttura_tgt
s_assegnastruttura s_assegnastruttura_s

if this.getItem(al_handleparent, ltvi_parent) < 0 then goto errore

// ricava dal parent vc_nodo e livello

s_assegnastruttura_s.as_struttura_s= ltvi_parent.data

s_assegnastruttura_s.ai_maxlivello= is_tvinit_s.ai_maxlivello
s_assegnastruttura_s.as_ambito= is_tvinit_s.as_ambito
s_assegnastruttura_s.aw_struttura_tv= aw_struttura_tv

openWithParm(w_moveitem, s_assegnastruttura_s)

s_struttura_tgt= message.powerObjectParm
if s_struttura_tgt.livello= -1 then goto errore

this.setRedraw(false)

/*if */uf_visualizzanuovoitem(al_handleparent)/*= -1 then goto errore*/

// ora il nuovo parent

al_handleparent= s_struttura_tgt.handle

//if uf_visualizzanuovoitem(al_handleparent)= -1 then goto errore

uf_cerca_nodo(s_struttura_tgt.vc_nodo)

/*al_handleparent= FindItem ( currentTreeItem!, 0 )

if uf_visualizzanuovoitem(al_handleparent)= -1 then goto errore*/

this.setRedraw(true)

return 1

errore: 

this.setRedraw(true)

return -1

end function

public function integer uf_modifyitem (long al_handle);long ll_currenthandle
treeViewItem ltv_item, ltvi_handle
s_struttura s_struttura_s

if this.getItem(al_handle, ltvi_handle) < 0 then return -1

// ricava dal parent vc_nodo e livello

s_struttura_s= ltvi_handle.data

openWithParm(w_modifyitem, s_struttura_s)

s_struttura_s= message.powerObjectParm

if s_struttura_s.descrizione_struttura= "" then return -1

this.setRedraw(false)
	
	ltvi_handle.label= f_iniziali(s_struttura_s.descrizione_livello+": "+s_struttura_s.descrizione_struttura)
	ltvi_handle.data= s_struttura_s
	
	this.setItem(al_handle, ltvi_handle)

this.setRedraw(true)

return 0

end function

on uotv_struttura_cursor.create
end on

on uotv_struttura_cursor.destroy
end on

event itempopulate;treeviewitem ltvi_clicked

if ib_dragdrop then return 0

if getItem(handle, ltvi_clicked) < 0 then return -1

is_struttura_s= ltvi_clicked.data

if ltvi_clicked.expandedOnce= false then 
	uf_populate(handle)
	ib_searchend= true
end if

return 0
end event

event begindrag;//treeViewItem ltvi_item
//
//if this.getItem(handle, ltvi_item)=  -1 then return -1
//
//if ltvi_item.level > is_tvinit_s.ai_maxlivello then return -1
//
//This.Drag(Begin!)
//
//ib_dragdrop= true
//
//This.GetItem(handle, itvi_dragged_object)
//itvi_dragged_object.selected= false
//setItem(handle, itvi_dragged_object)
//il_oldhandle= handle
//
//il_DragLevel= itvi_dragged_object.level
end event

event dragdrop;//long ll_droppedhandle, ll_newparenthandle, ll_child_handle, ll_todelete
//integer li_ret
//s_struttura s_struttura_source, s_struttura_target, s_struttura_new
//treeViewItem ltvi_target, ltvi_source, ltvi_newitem
//
//SetDropHighlight(0)
//
//ll_newparenthandle= handle // handle del target...
//
//li_ret= This.getItem(ll_newparenthandle, ltvi_target)
//if li_ret= -1 then return -1
//s_struttura_target= ltvi_target.data // prende i dati relativi al target item...
//
//li_ret= this.getItem(il_oldhandle, ltvi_source)
//if li_ret= -1 then return -1
//s_struttura_source= ltvi_source.data // prende i dati relativi al source item...
//
//il_DropLevel= ltvi_target.level
//
//if il_DropLevel = il_DragLevel - 1 then
//	
//	li_ret= messageBox("Modifica struttura", "Stai spostando: "+&
//			s_struttura_source.descrizione_livello+" "+s_struttura_source.descrizione_struttura+"~nin: "+&
//				s_struttura_target.descrizione_livello+" "+s_struttura_target.descrizione_struttura+".~nConfermi lo spostamento?", question!, yesNo!, 2)
//				
//	if li_ret= 2 then
//		drag(cancel!)
//		ib_dragdrop= false
//		return -1
//	end if
//		
////		Aggiornamento...
//
//		s_struttura_new= uf_aggiorna_parent(s_struttura_source, s_struttura_target)
//		
//		if s_struttura_new.livello= -1 then
//			messageBox("Modifica struttura", "Errore in aggiornamento struttura", exclamation!)
//			Drag(cancel!)
//	 	 	ib_dragdrop= false
//		  	goto errore
//		end if		
//		
//		commit;
//		if trap_sql(sqlca, "COMMITUPDSTRUTTURA") < 0 then goto errore
//		
//		ib_dragdrop= false
//		
//		if This.DeleteItem(il_oldhandle)= -1 then 
//			messageBox("Modifica struttura", "Errore in cancellazione item src", exclamation!)
//			goto errore
//		end if
//
//			// Inserisce il nuovo item nel treeView dopo l'aggiornamento in DB...
//
//	 		ib_dragdrop= false
//			 
//			 this.setRedraw(false)
//
//					/*ll_child_handle= insertItemLast(ll_newparenthandle, ltvi_source)
//					
//					li_ret= This.getItem(ll_child_handle, ltvi_newitem)
//					if li_ret= -1 then return -1
//					ltvi_newitem.expandedOnce= false
//					ltvi_newitem.expanded= false
//					ltvi_newitem.children= true
//					ltvi_newitem.selected= false
//					ltvi_newitem.StatePictureIndex= 0
//					ltvi_newitem.data= s_struttura_new
//					
//					setItem(ll_child_handle, ltvi_newitem)*/
//					
////					selectItem(ll_child_handle)
//
//					ll_todelete= this.findItem(childTreeItem!, ll_newparenthandle)
//					
//					do while ll_todelete > 0
//						
//						if this.deleteItem(ll_todelete)= -1 then
//							messageBox("Modifica struttura", "Errore in cancellazione item tgt", exclamation!)
//							goto errore
//						end if
//						
//						ll_todelete= this.findItem(childTreeItem!, ll_newparenthandle)
//						
//					loop
//
//
//					li_ret= This.getItem(ll_newparenthandle, ltvi_newitem)
//					if li_ret= -1 then return -1
//					ltvi_newitem.expandedOnce= false
//					ltvi_newitem.expanded= false
//					ltvi_newitem.children= true
//					ltvi_newitem.selected= false
////					ll_newparenthandle.StatePictureIndex= 0
////					ll_newparenthandle.data= s_struttura_new
//					
//					setItem(ll_newparenthandle, ltvi_newitem)
//					
//					this.expandItem(ll_newparenthandle)
//					
//					this.setRedraw(true)
//		
//else
//	
//	 Drag(cancel!)
//	 
//	 ib_dragdrop= false
//	 
//end if
//
//return 0
//
//errore:
//
//	this.setRedraw(true)
//
//	rollback;
//	trap_sql(sqlca, "ROLLBACKUPDSTRUTTURA")
//	
//	il_DropTarget = 0
//	
//	return -1
end event

event dragwithin;//TreeViewItem ltvi_Over
//
//If GetItem(handle, ltvi_Over) = -1 Then
//	SetDropHighlight(0)
//	il_DropTarget = 0
//	Return
//End If
//
//il_DropLevel= il_DragLevel - 1
//
//if ltvi_Over.level = il_DropLevel then
//
//	SetDropHighlight(handle)
//	il_DropTarget = handle
//
//else
//			
//	SetDropHighlight(0)
//	il_DropTarget = 0
//		
//end if
//
////setRedraw(true)
//
//return 0
end event

event constructor;ids_membri= create dataStore
ids_membri.DataObject = 'ds_retrievemembri'
ids_membri.setTransObject(sqlca)

ids_populate= create dataStore
ids_populate.DataObject = 'ds_populate'
ids_populate.setTransObject(sqlca)

//if il_ultimolivelloparent= 0 then il_ultimolivelloparent= ii_maxlivello


end event

event selectionchanging;treeViewItem ltvi_new_item

//if ib_dragdrop then return 0

if getItem(newhandle, ltvi_new_item) < 0 then return -1

is_struttura_s= ltvi_new_item.data

ltvi_new_item.selectedPictureIndex= ltvi_new_item.PictureIndex

this.setItem(newhandle, ltvi_new_item)

if ltvi_new_item.expandedOnce= false then expandItem(newHandle) 
end event

event clicked;//treeViewItem ltvi_new_item
//
////if ib_dragdrop then return 0
//
//if getItem(handle, ltvi_new_item) < 0 then return -1
//
//is_struttura_s= ltvi_new_item.data
//
//ltvi_new_item.selectedPictureIndex= ltvi_new_item.PictureIndex
//
//this.setItem(handle, ltvi_new_item)
//
//if ltvi_new_item.expandedOnce= false then expandItem(Handle) 
end event

event key;if key= KeyF5! then
	
	integer li_level, li_ret
	long ll_handle
	s_struttura ls_struttura_s
	treeViewItem ltvi_item

	ll_handle = this.FindItem(currentTreeItem!, 0)

	if ll_handle= -1 then return
	
	li_ret= getItem(ll_handle, ltvi_item)
	
	ls_struttura_s= ltvi_item.data
	
	if ls_struttura_s.livello > gi_maxlivello then return

	this.uf_visualizzanuovoitem(ll_handle)
	
end if
end event

