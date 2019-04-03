$PBExportHeader$w_entrata.srw
forward
global type w_entrata from window
end type
type dw_header from uodw_header within w_entrata
end type
type tab_entrata from tab within w_entrata
end type
type tabpage_inserimento from userobject within tab_entrata
end type
type tab_dati from tab within tabpage_inserimento
end type
type tabpage_dati from userobject within tab_dati
end type
type uodw_inserimento from uodw_anag within tabpage_dati
end type
type tabpage_dati from userobject within tab_dati
uodw_inserimento uodw_inserimento
end type
type tabpage_riferimenti from userobject within tab_dati
end type
type uodw_riferimenti from uodw_generica within tabpage_riferimenti
end type
type tabpage_riferimenti from userobject within tab_dati
uodw_riferimenti uodw_riferimenti
end type
type tab_dati from tab within tabpage_inserimento
tabpage_dati tabpage_dati
tabpage_riferimenti tabpage_riferimenti
end type
type tabpage_inserimento from userobject within tab_entrata
tab_dati tab_dati
end type
type tabpage_stampe from userobject within tab_entrata
end type
type uodw_stampa_cerimonie from uodw_generica within tabpage_stampe
end type
type tabpage_stampe from userobject within tab_entrata
uodw_stampa_cerimonie uodw_stampa_cerimonie
end type
type tabpage_bollettini from userobject within tab_entrata
end type
type uodw_boll from uodw_generica within tabpage_bollettini
end type
type tabpage_bollettini from userobject within tab_entrata
uodw_boll uodw_boll
end type
type tabpage_badge from userobject within tab_entrata
end type
type cb_stampa from commandbutton within tabpage_badge
end type
type uodw_cartellini from uodw_generica within tabpage_badge
end type
type tabpage_badge from userobject within tab_entrata
cb_stampa cb_stampa
uodw_cartellini uodw_cartellini
end type
type tabpage_conferma from userobject within tab_entrata
end type
type uodw_conferma from uodw_generica within tabpage_conferma
end type
type tabpage_conferma from userobject within tab_entrata
uodw_conferma uodw_conferma
end type
type tabpage_unisciliste from userobject within tab_entrata
end type
type uowd_unisciliste from uodw_generica within tabpage_unisciliste
end type
type tabpage_unisciliste from userobject within tab_entrata
uowd_unisciliste uowd_unisciliste
end type
type tab_entrata from tab within w_entrata
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
tabpage_bollettini tabpage_bollettini
tabpage_badge tabpage_badge
tabpage_conferma tabpage_conferma
tabpage_unisciliste tabpage_unisciliste
end type
end forward

global type w_entrata from window
integer width = 5093
integer height = 3304
boolean titlebar = true
string title = "Gestione cerimonie di entrata"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Information!"
event type integer ue_open ( )
dw_header dw_header
tab_entrata tab_entrata
end type
global w_entrata w_entrata

type variables
long il_prima
string is_codice, is_cod_com, is_com, is_prov, is_cap
s_strade is_strade_s
s_parm s_parm_s
u_ds_com ids_com
boolean ib_dbcancel
s_cerimonia is_cerimonia_s
s_evento is_evento_s

n_connection idb_connection
transaction isqlca_entrata

m_preview im_preview

dataWindowChild idwc_riferimenti, idwc_luoghi

uodw_generica iuodw_generica
uodw_generica iuodw_dati
end variables

forward prototypes
public function integer wf_modified ()
public function integer wf_riferimenti ()
public function integer wf_init_scheda (long al_row, ref uodw_generica auodw_generica)
public function integer wf_checkrif (long al_row)
end prototypes

event type integer ue_open();long ll_row

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setTransObject(sqlca)
tab_entrata.tabpage_stampe.uodw_stampa_cerimonie.setTransObject(sqlca)
tab_entrata.tabpage_conferma.uodw_conferma.setTransObject(sqlca)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.setTransObject(sqlca)
tab_entrata.tabpage_bollettini.uodw_boll.setTransObject(sqlca)
tab_entrata.tabpage_badge.uodw_cartellini.setTransObject(sqlca)

tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.GetChild('cod_rif', idwc_riferimenti)

dw_header.setTransObject(sqlca)

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

dw_header.setTransObject(sqlca)

dw_header.GetChild('cod_luogo', idwc_luoghi)

idwc_luoghi.setTransObject(sqlca)

idwc_luoghi.retrieve(s_session_s.cod_dip)

ll_row= dw_header.retrieve(is_evento_s.id)

ll_row= tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_inserimento(0)

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItem(ll_row, "id", is_evento_s.id)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItem(ll_row, "data_cer", is_evento_s.data_evento)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItem(ll_row, "luogo_cer", is_evento_s.descrizione)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItem(ll_row, "u_insert", s_session_s.s_utente_s.s_nome_esteso)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItem(ll_row, "d_insert", today())

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.resetUpdate()

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setItemStatus(ll_row, 0, Primary!, new!)

im_preview.m_inserisci.visible= false
im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_ordina.visible= false
im_preview.m_esporta.visible= false

im_preview.m_layoutdistampa.enabled= true


return 0
end event

public function integer wf_modified ();if NOT isValid(iuodw_dati) then return 0

	iuodw_dati.acceptText()
	
	if iuodw_dati.modifiedCount() > 0 or iuodw_dati.deletedCount() > 0 then
		if messageBox(this.title, "Sono stati aggiornati dei dati. Vuoi salvare prima di proseguire?", question!, okCancel!, 1)= 1 then
			
			integer li_ret
			long ll_row
			
			ll_row= tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getRow()

			li_ret=  tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_esegui(tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.ic_aggiornamento)
	
			if li_ret > 0 then
				tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.object.b_aggiorna.visible= false
			else
				return -1
			end if

			w_entrata.is_codice=tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(ll_row, "codice")

			s_session_s.codice= w_entrata.is_codice

			f_log(s_session_s, "Inseriti i dati di: "+ tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(ll_row, "cognome")+ " "+&
						tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(ll_row, "nome"), false)
						
			return 0
			
		else
			
			return 1 // annulla...
			 
		end if
		
	end if
					
return 0 // non ci sono modifiche in corso...			
					
//errore:
//		messageBox(this.title, "Errore in aggiornamento dati.", exclamation!)
//		rollback;
//		trap_sql(sqlca, "ROLLBACKANAG")
//		return -1
end function

public function integer wf_riferimenti ();integer li_rif, li_pref

if tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.getRow() <= 0 then return -1

li_rif=  tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.getItemNumber( +&
										tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.getRow(), "crif")
li_pref=  tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.getItemNumber( +&
										tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.getRow(), "cpref")

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

public function integer wf_init_scheda (long al_row, ref uodw_generica auodw_generica);

auodw_generica.reset()

if auodw_generica.uof_inserimento(al_row) < 0 then return -1

//auodw_generica.setItemStatus(al_row, 0, Primary!, new!)

auodw_generica.setItem(al_row, "id", is_evento_s.id)
auodw_generica.setItem(al_row, "data_cer", is_evento_s.data_evento)
auodw_generica.setItem(al_row, "luogo_cer", is_evento_s.descrizione)
auodw_generica.setItem(al_row, "u_insert", trim(s_session_s.s_utente_s.s_nome_esteso) )
auodw_generica.setItem(al_row, "d_insert", today())

auodw_generica.resetUpdate()

auodw_generica.setItemStatus(al_row, 0, Primary!, new!)

auodw_generica.setColumn(1)

return 0
end function

public function integer wf_checkrif (long al_row);integer li_count
string ls_nome, ls_codice

ls_codice=  tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(al_row, "codice")

if isNull(ls_codice) then return 0

ls_nome= tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(al_row, "nome")+" "+&
					 tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(al_row, "cognome")
					 
select count(*)
into :li_count
from riferimenti
where codice= :ls_codice;

if trap_sql(sqlca, "INSRIF01") < 0 then return -1

if li_count= 0 then

	if messageBox(this.title, "Vuoi inserire i riferimenti di "+ls_nome+"?", question!, yesNo!, 1)= 2 then return 0

	tab_entrata.tabpage_inserimento.tab_dati.selectTab(2)
	
end if

return 1
end function

on w_entrata.create
this.dw_header=create dw_header
this.tab_entrata=create tab_entrata
this.Control[]={this.dw_header,&
this.tab_entrata}
end on

on w_entrata.destroy
destroy(this.dw_header)
destroy(this.tab_entrata)
end on

event open;integer li_newcod= 0
s_session_s.context= "Aspiranti - Inserimento"

im_preview= create m_preview
iuodw_generica= create uodw_generica

is_evento_s= message.powerObjectParm

/*
 * Connessione al db GA per effettuare l'aggiornamento del contatore sulla
 * tabella dipendenza con adeguato isolation level
 */
 
isqlca_entrata= create transaction
idb_connection= create n_connection
 
idb_connection.uof_getinipar(gc_DBSEG)

// Solo se l'utente con cui mi voglio connettere è diverso da quello definito al momento del login:
idb_connection.is_connectionparm_s.LogID= sqlca.LogID
idb_connection.is_connectionparm_s.LogPass= sqlca.LogPass
		
idb_connection.is_connectionparm_s.lock= "TS"

if idb_connection.uof_connectdb(isqlca_entrata) < 0 then return -1

/*
 * bisogna prevedere il caso in cui non sia stata inserito in tabella dipendenze il cod_dip
 * della dipendenza operativa corrente
 */
	select 1
		into:li_newcod
		from dipendenze
	where cod_dip= :s_session_s.cod_dip using isqlca_entrata;
		
	if trap_sql ( isqlca_entrata, "Verifica dip. operativa 01" ) = -1 then
		return -1
	end if
	
	if isqlca_entrata.sqlcode= 100 then
		insert into dipendenze (counter, cod_dip)
				values (0, :s_session_s.cod_dip) using isqlca_entrata;		
		if trap_sql ( isqlca_entrata, "Insert codice per dip. 01" ) = -1 then return -1
	end if

commit using isqlca_entrata;
if trap_sql ( isqlca_entrata, "Commit Insert codice per dip. 01" ) = -1 then
	rollback using isqlca_entrata;
	return -1
end if

/*
 *  end connessione...
 */
 
event post ue_open()
end event

event closequery;integer li_ret

if(isValid(isqlca_entrata)) then idb_connection.uof_disconnectdb(isqlca_entrata)

destroy isqlca_entrata
destroy idb_connection

li_ret= iuodw_dati.uof_modificheincorso()

if li_ret= 2 then return 0
if li_ret= 3 then return 1 // Annulla

li_ret= iuodw_generica.uof_modificheincorso()

if li_ret= 2 then return 0
if li_ret= 3 then return 1 // Annulla

//if tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.event ue_aggiorna_asp(iuodw_generica.getRow() )= 1 then return 1

return 0
end event

event resize;tab_entrata.height= this.height - tab_entrata.y - 200
//tab_dettaglio.tabpage_base.height= tv_struttura.height //tv_struttura.height // + gb_cerca.height
//tab_dettaglio.x= tv_struttura.x + tv_struttura.width + 30

//tab_dettaglio.width=PixelsToUnits ( li_tabwidth,  XPixelsToUnits! )// WorkspaceWidth() - tab_dettaglio.x - 60 

//tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.height= tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.height -400
//tab_dettaglio.tabpage_base.lv_dettaglio.width= tab_dettaglio.tabpage_base.width - 30
end event

type dw_header from uodw_header within w_entrata
integer width = 4544
integer height = 372
integer taborder = 40
end type

type tab_entrata from tab within w_entrata
integer y = 380
integer width = 4581
integer height = 2804
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
tabpage_bollettini tabpage_bollettini
tabpage_badge tabpage_badge
tabpage_conferma tabpage_conferma
tabpage_unisciliste tabpage_unisciliste
end type

on tab_entrata.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_stampe=create tabpage_stampe
this.tabpage_bollettini=create tabpage_bollettini
this.tabpage_badge=create tabpage_badge
this.tabpage_conferma=create tabpage_conferma
this.tabpage_unisciliste=create tabpage_unisciliste
this.Control[]={this.tabpage_inserimento,&
this.tabpage_stampe,&
this.tabpage_bollettini,&
this.tabpage_badge,&
this.tabpage_conferma,&
this.tabpage_unisciliste}
end on

on tab_entrata.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_stampe)
destroy(this.tabpage_bollettini)
destroy(this.tabpage_badge)
destroy(this.tabpage_conferma)
destroy(this.tabpage_unisciliste)
end on

event selectionchanging;integer li_height= 140
long ll_row

choose case oldindex
		
	case 1
		
		if wf_modified()= 1 then return 1 // verifica eventuali modifiche sul tab corrente dell'inserimento dati, se è 1 non prosegue...
		
		//if  tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_modificheincorso() = 3 then return 1 // non cambia tab
		
	//	if tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.event ue_aggiorna_asp(iuodw_generica.getRow() )= 0 then return 0
		
//	case 4
//		
//	if iuodw_generica.uof_modificheincorso() = 3 then return 1 // non cambia tab
		
end choose

choose case newindex
		
	case 1
		
		//iuodw_generica= iuodw_dati
		// tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.height= w_entrata.height - li_height
		
		 
			iuodw_generica=  tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento
			
			tab_entrata.tabpage_inserimento.tab_dati.height= tab_entrata.height -  tab_entrata.tabpage_inserimento.tab_dati.y - 200//li_height
		
			//iuodw_generica.height=  tab_entrata.tabpage_inserimento.tab_dati.height - li_height
		
			return 0 // non deve eseguire la retrieve...
		
	case 2
		
		iuodw_generica=  tab_entrata.tabpage_stampe.uodw_stampa_cerimonie
		
	case 3
		
		iuodw_generica= tab_entrata.tabpage_bollettini.uodw_boll
		
	case 4
		
		iuodw_generica= tab_entrata.tabpage_badge.uodw_cartellini
		
	case 5
		
		iuodw_generica= tab_entrata.tabpage_conferma.uodw_conferma
		
	case 6
		
		iuodw_generica= tab_entrata.tabpage_unisciliste.uowd_unisciliste
		
		goto fine	
		
end choose

ll_row= iuodw_generica.retrieve(is_evento_s.id)

fine:

iuodw_generica.height= this.height - li_height


return 0 // ll_row
end event

type tabpage_inserimento from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
long backcolor = 67108864
string text = "Inserimento dati"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_dati tab_dati
end type

on tabpage_inserimento.create
this.tab_dati=create tab_dati
this.Control[]={this.tab_dati}
end on

on tabpage_inserimento.destroy
destroy(this.tab_dati)
end on

type tab_dati from tab within tabpage_inserimento
integer y = 8
integer width = 4229
integer height = 2416
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_dati tabpage_dati
tabpage_riferimenti tabpage_riferimenti
end type

on tab_dati.create
this.tabpage_dati=create tabpage_dati
this.tabpage_riferimenti=create tabpage_riferimenti
this.Control[]={this.tabpage_dati,&
this.tabpage_riferimenti}
end on

on tab_dati.destroy
destroy(this.tabpage_dati)
destroy(this.tabpage_riferimenti)
end on

event selectionchanging;if wf_modified()= 1 then return 1 // verifica eventuali modifiche sul tab corrente, se è 1 non prosegue...

if isValid(iuodw_dati) and oldindex= 2 then

end if

choose case newindex
		
	case 1
		
		iuodw_dati= tab_dati.tabpage_dati.uodw_inserimento
		
	case 2
		
		iuodw_dati= tab_dati.tabpage_riferimenti.uodw_riferimenti

end choose

if isValid(iuodw_dati) then iuodw_dati.height=this.height - iuodw_dati.y - 60

		if  NOT isNull(w_entrata.is_codice) and w_entrata.is_codice <> "" then
			if newindex= 2 AND isValid(iuodw_dati) then iuodw_dati.retrieve(w_entrata.is_codice)
		else
		//	tab_dati.tabpage_riferimenti.uodw_riferimenti.reset()
		return 1
		end if


end event

type tabpage_dati from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4192
integer height = 2288
long backcolor = 67108864
string text = "Dati"
long tabtextcolor = 16711680
string picturename = "Picture!"
long picturemaskcolor = 536870912
uodw_inserimento uodw_inserimento
end type

on tabpage_dati.create
this.uodw_inserimento=create uodw_inserimento
this.Control[]={this.uodw_inserimento}
end on

on tabpage_dati.destroy
destroy(this.uodw_inserimento)
end on

type uodw_inserimento from uodw_anag within tabpage_dati
event type integer ue_aggiorna_asp ( long al_row )
event type integer ue_modified ( )
integer width = 3927
integer height = 2264
integer taborder = 30
string dataobject = "dw_aspiranti_membri"
boolean maxbox = false
end type

event type integer ue_aggiorna_asp(long al_row);integer li_ret

s_session ls_session_s

ls_session_s= s_session_s

// verifica esistenza riferimenti

if isNull(tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.getItemString(al_row, "codice")) and &
	tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.rowCount()= 0 then
	
	if messageBox(parent.text, "Attenzione: nell'ultimo inserimento non sono stati inseriti riferimenti."+&
											"~nLi vuoi inserire ora?", exclamation!, yesNo!, 1)= 1 then
		
		tab_entrata.tabpage_inserimento.tab_dati.selectTab(2)
	
		return 1
		
	else
		
		return 0
	
	end if
	
end if

//li_ret= uof_esegui(ic_aggiornamento)
//	
//if li_ret > 0 then this.object.b_aggiorna.visible= false
//
//if li_ret <= 0 then return -1

w_entrata.is_codice= this.getItemString(al_row, "codice")

ls_session_s.codice= w_entrata.is_codice

f_log(ls_session_s, "Inseriti i dati di: "+this.getItemString(al_row, "cognome")+ " "+this.getItemString(al_row, "nome"), false)

return 0
end event

event updatestart;call super::updatestart;long ll_row
string ls_codice, ls_dip, ls_data
decimal ld_id

this.acceptText()

ll_row= this.getRow()

if isNull(ll_row) or ll_row= 0 then return 0

ls_data= string(this.getItemDatetime(ll_row, "data_nas"), "dd.mm.yyyy")

if f_min ( ls_data ) = 1 then return 1
	
ls_codice= this.getItemString(this.getRow(), "codice")

ls_dip= dw_header.getItemString(this.getRow(), "cod_dip")

if ls_codice <> "" and NOT isNull(ls_codice) then return 0 // se la persona è già stata inserita non genera un nuovo codice...

// Genera il nuovo codice

ls_codice= f_gencod( ls_dip, isqlca_entrata )

if ls_codice= "" then goto errore

w_entrata.is_codice= ls_codice

this.setItem(this.getRow(), "codice", ls_codice)

commit using isqlca_entrata;
if trap_sql(isqlca_entrata, "ASPIRANTIUPDATESTART01") < 0 then goto errore
	
return 0 // tutto ok
	
errore:
	
	rollback using isqlca_entrata;
	trap_sql(isqlca_entrata, "ASPIRANTIUPDATESTART02") 
	
	return 1 // non prosegue l'update

	

end event

event buttonclicked;call super::buttonclicked;integer li_ret, li_err

s_strade s_strade_s

choose case dwo.name
		
	case "b_bollettino"
		
		s_preview s_preview_s
		
		s_preview_s.tipo_stampa= "N"
		s_preview_s.criterio= uodw_inserimento.getItemString(uodw_inserimento.getRow(), "codice")
		s_preview_s.ib_anteprima= true	
		s_preview_s.doretrieve= true			
		
		if s_preview_s.criterio= ""or isNull(s_preview_s.criterio) then
			messageBox(parent.text, "Il codice personale non è stato ancora attribuito, eseguire l'aggiornamento prima di generare un bollettino.", information!)
			return 0
		end if
		
		w_preview iw_bollettini
		
		s_preview_s.dataObject= "r_boll_asp_codice"
		
		w_frame_gestioneassociati.setRedraw(false)
			li_ret= openWithParm(iw_bollettini, s_preview_s)
		w_frame_gestioneassociati.setRedraw(true)
		
		return li_ret
		
	case "b_aggiorna"
		
		if ancestorReturnValue= -1 then return - 1
		
		if tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.rowCount()= 0 then
			
			tab_entrata.tabpage_inserimento.tab_dati.selectTab(2)
			
			messageBox(parent.text, "Inserire i riferimenti.", exclamation!)
			
		end if
		
		//wf_checkrif(row)
		
	case "b_p_asp"
		
		if wf_modified()= 1 then return 0
		
//		if wf_checkrif(row)= 1 then return 0
				
		wf_init_scheda(row, uodw_inserimento)

	case "b_reset_asp"
		
		if uodw_inserimento.uof_modificheincorso()= 3 then return 0 // annulla l'operazione...
		
		wf_init_scheda(row, uodw_inserimento)
		
	case "b_m"
		
		if ancestorReturnValue= 0 then return
		
		//f_log(s_session_s, this.getItemString(row, "cognome")+ " "+this.getItemString(row, "nome")+": Cancellati i dati", true)
		
		wf_init_scheda(row, uodw_inserimento)
		
	case "b_cerca"
		
		string ls_er
		decimal ld_id
		s_ricerca s_ricerca_s
		
//		this.object.b_m.visible= false
//		this.object.b_p.visible= false
//		this.object.b_aggiorna.visible= false

		if wf_modified()= 1 then return 1 // verifica eventuali modifiche sul tab corrente, se è 1 non prosegue...
		
		ld_id= dw_header.getItemDecimal(dw_header.getRow(), "id")
		
		openWithParm(w_seleziona_aspiranti, ld_id)
		s_ricerca_s= message.powerObjectParm
		if s_ricerca_s.i_retcode= -1 then return -1
		
		w_entrata.is_codice= s_ricerca_s.codice
		
		if this.retrieve(w_entrata.is_codice)= 0 then this.uof_inserimento(0)

//			this.object.b_p.visible= true		
		
	case "b_forzailcap"
		
		messageBox("Attenzione", "Il C.A.P. inserito manualmente potrebbe essere scorretto.", information!)
		
		this.Object.cap_dom.Protect=0
		this.setColumn("cap_dom")
			
	case "b_struttura"
		
		s_assegnastruttura s_assegnastruttura_s
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.ai_maxlivello= gi_maxlivello		
		s_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello - 1
		s_assegnastruttura_s.as_ambito= gs_ambito
		s_assegnastruttura_s.as_struttura_s.vc_nodo= this.getItemString(row, "vc_parent")
		
		s_struttura s_struttura_s
		
		s_struttura_s= this.uof_struttura(s_assegnastruttura_s)
		
		if s_struttura_s.livello < 0 then return -1
		this.object.b_aggiorna.visible= '1'
		
		this.setItem(row, "vc_parent", s_struttura_s.vc_nodo)
		
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
		

//	case "b_cap"
//		
//		integer i_err
//		string ls_cap, ls_loc
//		
//		s_strade_s.cap= this.getItemString(row, "cap_dom")
//		s_strade_s.comune= trim(this.getItemString(row, "comune"))
//		s_strade_s.cod_com= this.getItemString(row, "cod_com")
//		s_strade_s.provincia= this.getItemString(row, "provincia")
//		
//		s_strade_s= f_vercap(s_strade_s)
//		
//		choose case s_strade_s.return_code
//				
//			case 0
//				
//				messageBox(this.title, "Operazione annullata.", information!)
//				
//			case -1
//				
//				return -1
//				
//			case 1
//				
//				i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
//							
//				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//				
//			case 2
//				
//				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//				
//		end choose
		
end choose
end event

event retrieveend;call super::retrieveend;//w_entrata.is_codice= this.getItemString(this.getRow(), "codice")
//		
//s_session_s.codice= w_entrata.is_codice
end event

event itemchanged;call super::itemchanged;this.object.b_aggiorna.visible= '1'

integer i_err, li_exists, li_ret
long ll_rows
boolean first_time = true
string ls_data, search_string, old_comune, ls_nuovaOrganizzazione, ls_omonimie, ls_ultimocarattere, ls_checkdigit

if row > 0 then
	
	data = trim ( data )
	
	old_comune= data

	CHOOSE CASE dwo.name
			
		case "codice_fiscale"
			
			ls_ultimocarattere= mid(data, len(data), 1)
			
			ls_checkdigit= f_cfcheckdigit(data)			
			
			if ls_checkdigit <> ls_ultimocarattere then
						
				messageBox(parent.text, "Il codice fiscale inserito è scorretto.", exclamation!)
						
				return 1
						
			end if					
			
		case "cognome"
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				return 1
				
			end if
			
		case "nome"
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				return 1
				
			end if
			
		case "pres_da"
			
			if match(f_trim_all(data), "[^'A-ZÁÀÉÈÍÌÓÒÚÙ]+") then
				
				messageBox(parent.text, "Sono stati inseriti caratteri non ammessi.", exclamation!)
				
				return 1
				
			end if			
			
		case "cap_dom"
		
		this.Object.cap_dom.Protect=1
			
		CASE "ccomune"
			
			s_strade s_strade_s
			
			s_strade_s.comune= trim(data)
			
			f_cap(s_strade_s)
			
			choose case s_strade_s.return_code
					
				case 0
					
					messageBox(this.title, "Operazione annullata.", information!)
					
					li_ret= 0
					
				case -1
					
					li_ret= 1
					
				case 1
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					i_err= this.setText ( s_strade_s.comune )
					
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
					
					this.setColumn("ind_dom")
								
					li_ret=0// 2
					
				case 2
								
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					//i_err= this.setText ( s_strade_s.comune )
					data= s_strade_s.comune
					
					this.setColumn("ind_dom")
					
					//return 2
					
					li_ret= 0  //0
					
			end choose
			
			return li_ret
			
		CASE "data_nas"
			
			if f_min ( data ) = 1 then
					return 1
				else
					return 0
			end if
			
	END CHOOSE
	
end if

if dwo.name= "nome" then
	
	integer li_count_a, li_count_m, li_count_d
	s_ricercanominativa s_ricercanominativa_s
	
	s_ricercanominativa_s.cognome= "%"+this.getItemString(row, "cognome")+"%"
	s_ricercanominativa_s.nome= "%"+data+"%"
	
	// Verifica eventuali omonimie tra gli aspiranti (già inserito in un'altra cerimonia)

	SELECT count(*)
		into :li_count_a
	 FROM aspiranti_membri   
	where aspiranti_membri.cognome like :s_ricercanominativa_s.cognome and aspiranti_membri.nome like :s_ricercanominativa_s.nome;
	
	if trap_sql(sqlca, "VERDOPPIINS01") < 0 then return 1
	
	if li_count_a > 0 then
		
		ls_omonimie= "Sono presenti omonimi in una lista di aspiranti membri non ancora confermata: verificare."
		
		messageBox("Verifica omonimie", ls_omonimie)
		
		goto doppione
		
	end if
	
	// Verifica eventuali omonimie tra i membri (già membro)	
	
	SELECT count(*)
		into :li_count_m
	 FROM membri_gerarchica   
	where membri_gerarchica.cognome like :s_ricercanominativa_s.cognome and membri_gerarchica.nome like :s_ricercanominativa_s.nome;
	
	if trap_sql(sqlca, "VERDOPPIINS02") < 0 then return 1
	
	if li_count_m > 0 then
		
		ls_omonimie= "Sono presenti omonimi nell'anagrafica membri: verificare."
		
		messageBox("Verifica omonimie", ls_omonimie)
		
		goto doppione
		
	end if
	
	// Verifica eventuali omonimie tra i dimissionari (dimissionari che vogliono rientrare, non devono essere reinseriti li ri recuperra dalla tabella dimissionari)
	
	SELECT count(*)
		into :li_count_d
	 FROM membri_dim   
	where membri_dim.cognome like :s_ricercanominativa_s.cognome and membri_dim.nome like :s_ricercanominativa_s.nome;
	
	if trap_sql(sqlca, "VERDOPPIINS01") < 0 then return 1
	
	if li_count_d > 0 then
		
		ls_omonimie= "Sono presenti omonimi nell'elenco dei dimissionari: verificare.~nLa probabile ragione è la volontà del dimissionario di rientrare.~nLa procedura di reinserimento deve essere svolta da un operatore appartenente alla direzione segreteria"
		
		messageBox("Verifica omonimie", ls_omonimie)
		
		goto doppione
		
	end if
	
	return 0

	doppione:
	
		openWithParm(w_ricerca_doppioni, s_ricercanominativa_s)
	
	return 0

end if




end event

type tabpage_riferimenti from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4192
integer height = 2288
long backcolor = 67108864
string text = "Riferimenti"
long tabtextcolor = 255
string picturename = "Custom020!"
long picturemaskcolor = 536870912
uodw_riferimenti uodw_riferimenti
end type

on tabpage_riferimenti.create
this.uodw_riferimenti=create uodw_riferimenti
this.Control[]={this.uodw_riferimenti}
end on

on tabpage_riferimenti.destroy
destroy(this.uodw_riferimenti)
end on

type uodw_riferimenti from uodw_generica within tabpage_riferimenti
integer width = 3049
integer taborder = 40
string dataobject = "dw_aspiranti_riferimenti"
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;integer li_ret

if dwo.name= "b_p_asp" then
	
	this.setItem(row, "codice", w_entrata.is_codice)	
	this.setItem(row, "id", is_evento_s.id)
			
	s_riferimenti s_riferimenti_s
	s_riferimenti_s.codice= is_codice
	s_riferimenti_s.id= is_evento_s.id
	s_riferimenti_s.idx= 0
	s_riferimenti_s.rif_membri= false
	s_riferimenti_s.id= is_evento_s.id
	li_ret= openWithParm(w_ins_aspiranti_riferimenti, s_riferimenti_s)
	if li_ret >= 0 then
		this.setRedraw(false)
		 this.retrieve(is_codice)
		this.setRedraw(true)
	end if
	
end if
end event

event itemchanged;string ls_rif

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
	
//case "preferito"
//	
//	long ll_found
//	
//	if data= '0' then return 
//	
//	ll_found = this.Find("cod_rif= '"+ls_rif+"' and preferito= '1'", 1, this.RowCount())
//	
//	if ll_found > 0 then
//		
//		messageBox(parent.text, "Può essere indicato solo un riferimento preferito per tipo.", information!)
//		return 1
//		
//	end if
	
end choose
end event

event doubleclicked;call super::doubleclicked;s_riferimenti s_riferimenti_s
s_riferimenti_s.codice= is_codice

if row <= 0 then return 0

s_riferimenti_s.idx= this.getItemDecimal(row, "idx")
s_riferimenti_s.rif_membri= false

openWithParm(w_ins_riferimenti, s_riferimenti_s)
this.retrieve(is_codice)
end event

type tabpage_stampe from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
long backcolor = 67108864
string text = "Lista partecipanti"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_stampa_cerimonie uodw_stampa_cerimonie
end type

on tabpage_stampe.create
this.uodw_stampa_cerimonie=create uodw_stampa_cerimonie
this.Control[]={this.uodw_stampa_cerimonie}
end on

on tabpage_stampe.destroy
destroy(this.uodw_stampa_cerimonie)
end on

type uodw_stampa_cerimonie from uodw_generica within tabpage_stampe
integer width = 4343
integer height = 2416
integer taborder = 20
string dataobject = "dw_lista_aspiranti"
boolean maxbox = false
boolean ib_isgrid = true
boolean ib_stampatoda = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stampa_cerimonie

im_preview.m_layoutdistampa.enabled= true
im_preview.m_impostapagina.enabled= true

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name

	case "b_sposta"
	
	decimal ld_id
	
		openWithParm(w_sposta_cerimonia, is_evento_s)
		
		ld_id= message.doubleParm
		
		if isNull(ld_id) OR ld_id<= 0 then return -1
			
		string ls_codice
		
		ls_codice= this.getItemString(row, "codice")
		
		update aspiranti_membri 
		set id= :ld_id, 
		data_cer= (select data_evento from eventi where id= :ld_id),
		luogo_cer= (select descrizione_evento from eventi where id= :ld_id)
		where codice= :ls_codice;
		if trap_sql(sqlca, "SPOSTACER01") < 0 then goto errore
	
		commit;
		if trap_sql(sqlca, "SPOSTACER02") < 0 then goto errore
		
		open(w_message)
		
		iuodw_generica.retrieve(is_evento_s.id)
		
		return 0
	
	errore:
	
		rollback;
		
		open(w_message_negative)
		
		return -1
		
	case "b_nascondi"
		
		openWithParm(w_set_visible_columns, iuodw_generica )
		
end choose
end event

type tabpage_bollettini from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
long backcolor = 67108864
string text = "Stampa bollettini"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_boll uodw_boll
end type

on tabpage_bollettini.create
this.uodw_boll=create uodw_boll
this.Control[]={this.uodw_boll}
end on

on tabpage_bollettini.destroy
destroy(this.uodw_boll)
end on

type uodw_boll from uodw_generica within tabpage_bollettini
integer width = 4494
integer height = 2416
integer taborder = 40
string dataobject = "r_boll_asp"
boolean maxbox = false
boolean hsplitscroll = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_boll

im_preview.m_layoutdistampa.enabled= true
im_preview.m_impostapagina.enabled= true

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

type tabpage_badge from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
long backcolor = 67108864
string text = "Stampa cartellini"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_stampa cb_stampa
uodw_cartellini uodw_cartellini
end type

on tabpage_badge.create
this.cb_stampa=create cb_stampa
this.uodw_cartellini=create uodw_cartellini
this.Control[]={this.cb_stampa,&
this.uodw_cartellini}
end on

on tabpage_badge.destroy
destroy(this.cb_stampa)
destroy(this.uodw_cartellini)
end on

type cb_stampa from commandbutton within tabpage_badge
integer x = 3872
integer y = 100
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Setup etichette"
end type

event clicked;uodw_cartellini.event ue_stampa()
end event

type uodw_cartellini from uodw_generica within tabpage_badge
event type integer ue_stampa ( )
integer height = 2416
integer taborder = 40
string dataobject = "dw_labels_asp"
end type

event type integer ue_stampa();long ll_etichette_a_vuoto, ll_to_delete, ll_idx

openWithParm(w_setup_labels, this)

ll_etichette_a_vuoto= message.doubleParm

uodw_cartellini.setRedraw(false)

if il_prima= 0 then
	
	il_prima= ll_etichette_a_vuoto
	
	for ll_idx= 1 to il_prima
		
		uodw_cartellini.insertRow(1)
		
	next
	
elseif il_prima < ll_etichette_a_vuoto then
	
	for ll_idx= il_prima + 1 to ll_etichette_a_vuoto
		
		uodw_cartellini.insertRow(1)
		
	next
	
elseif il_prima > ll_etichette_a_vuoto then
	
	ll_to_delete= il_prima - ll_etichette_a_vuoto
	
	uodw_cartellini.setRow(1)
	
	for ll_idx= 1 to ll_to_delete
		
		uodw_cartellini.deleteRow(0)
		
	next
	
end if

uodw_cartellini.setRedraw(true)

il_prima= ll_etichette_a_vuoto

return 0
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_cartellini

im_preview.m_aggiungi.visible= false
im_preview.m_inserisci.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_ordina.visible= false
im_preview.m_layoutdistampa.enabled= false
im_preview.m_impostapagina.enabled= false

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )



end event

type tabpage_conferma from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
long backcolor = 67108864
string text = "Conferma partecipazione"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_conferma uodw_conferma
end type

on tabpage_conferma.create
this.uodw_conferma=create uodw_conferma
this.Control[]={this.uodw_conferma}
end on

on tabpage_conferma.destroy
destroy(this.uodw_conferma)
end on

type uodw_conferma from uodw_generica within tabpage_conferma
integer width = 3406
integer height = 2416
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_conferma_aspiranti"
boolean ib_isgrid = true
boolean ib_querymode = true
end type

event buttonclicked;// Non deve eseguire la script dell'ancestor...

long ll_idx
string ls_cod, ls_goh, ls_struttura, ls_div, ls_null, ls_tok
integer li_ret, li_anno, li_count

datetime ldt_data
string ls_codice, ls_luogo, ls_cognome, ls_nome
s_session ls_session_s

choose case dwo.name
		
	case "b_aggiorna" 
		
		if this.getItemNumber(this.getRow(), "ctotconf") = 0 then
			if messageBox(parent.text, "Attenzione: nessun partecipante risulta essere stato confermato.~n"+&
												"La cerimonia verrà cancellata e nessun partecipante verrà inserito in anagrafica.~n"+&
													"Confermi l'operazione?", exclamation!, yesNo!, 2)= 2 then return 0
			else
													
													
			if messageBox(parent.text, "I dati dei partecipanti verranno inseriti in anagrafica. Confermi l'operazione?", question!, yesNo!, 2)= 2 then return 0													
													
		end if

		for ll_idx= 1 to this.rowCount()
			
			ls_cod= this.getItemString(ll_idx, "cconf") // conferma si/no...
			
			if ls_cod= "0" then continue
			
			ls_codice= this.getItemString(ll_idx, "codice")
			
			ls_goh=  this.getItemString(ll_idx, "flag_goh")
			
			ls_cognome= this.getItemString(ll_idx, "cognome")
			ls_nome= this.getItemString(ll_idx, "nome")
			
			ls_struttura= this.getItemString(ll_idx, "vc_parent")
			
			ls_div=  this.getItemString(ll_idx, "cod_div")

			  INSERT INTO membri_gerarchica  
						( codice,   
						  codice_fam,   
						  cognome,   
						  nome,   
						  citta_nas,   
						  prov_nas,   
						  data_nas,   
						  cod_nazione,   
						  cod_div,   
						  ind_dom,   
						  cap_dom,   
						  cod_com,   
						  cod_prof,   
						  pres_da,   
						  data_cer,   
						  luogo_cer,   
						  cod_att_ist_1,   
						  cod_att_ist_2,   
						  codice_staff,   
						  cod_studio,   
						  cod_dis,   
						  u_insert,   
						  d_insert,   
						  u_ult_mod,   
						  d_ult_mod,   
						  vc_parent,
						  vc_gruppoentrata,
						  flag_ldr,
						  flag_npa,
						  cod_cittadinanza,
						  codice_fiscale)  
				  SELECT aspiranti_membri.codice,   
							aspiranti_membri.codice_fam,   
							aspiranti_membri.cognome,   
							aspiranti_membri.nome,   
							aspiranti_membri.citta_nas,   
							aspiranti_membri.prov_nas,   
							aspiranti_membri.data_nas,   
							aspiranti_membri.cod_nazione,   
							aspiranti_membri.cod_div,   
							aspiranti_membri.ind_dom,   
							aspiranti_membri.cap_dom,   
							aspiranti_membri.cod_com,   
							aspiranti_membri.cod_prof,   
							aspiranti_membri.pres_da,   
							aspiranti_membri.data_cer,   
							aspiranti_membri.luogo_cer,   
							'000',   
							'000',   
							'000',   
							'00',   
							'MEM',   
							aspiranti_membri.u_insert,   
							aspiranti_membri.d_insert,   
							aspiranti_membri.u_ult_mod,   
							aspiranti_membri.d_ult_mod,   
							aspiranti_membri.vc_parent,
							aspiranti_membri.vc_parent,
							'N',
							'0',
							aspiranti_membri.cod_cittadinanza,
							codice_fiscale
					 FROM aspiranti_membri  where aspiranti_membri.id=  :is_evento_s.id and aspiranti_membri.codice= :ls_codice;

					if trap_sql(sqlca, "INSASPIRANTI01 - Codice: "+ls_codice+" - "+ls_cognome+" "+ls_nome ) < 0 then goto errore
					
					// Riferimenti
					
						insert into riferimenti
						select 
							codice,
							cod_rif, 
							riferimento_descr,
							predefinito,
							note,
							"N"
						from aspiranti_riferimenti
						where aspiranti_riferimenti.codice= :ls_codice;
						if trap_sql(sqlca, "INSASPIRANTI01.1") < 0 then goto errore						
					
		
					// Inserisce una riga in storico goh. se ha ricevuto il G.
					
					ldt_data= dw_header.getItemDateTime(dw_header.getRow(), "data_evento")
					ls_luogo= dw_header.getItemString(dw_header.getRow(), "descrizione_evento")	
					
					if ls_goh= 'S' then
						
						INSERT INTO gohonzon_storico  
							( codice,   
							  tipo_goh,   
							  data,   
							  luogo,   
							  cod_causale,   
							  note )  
						  VALUES (	:ls_codice,   
										"OKA",   
										:ldt_data,   
										:ls_luogo,
										"ACQ",   
										null )  ;
						
										  
						if trap_sql(sqlca, "INSASPIRANTI02") < 0 then goto errore
						
					end if
					
//			/*
//			 * Inserisce un record in consegne_storico, se il gruppo non esiste esegue una insert altrimenti esegue un' update
//			 */
//			 
//			 li_anno= year(date(ldt_data))
//			 
//			 
//			  select count(*) into :li_count from consegne_storico where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//			  
//			  if li_count= 0 or isNull(li_count) then
//				
//				insert into consegne_storico(vc_nodo, anno, data_cer, luogo_cer) values(:ls_struttura, :li_anno, :ldt_data, :ls_luogo);
//				
//			 end if
//			 
//			 if ls_goh= 'S' then // se ha ricevuto il G...
//			 
//				 choose case integer(ls_div)
//						
//					case 1
//				 
//						 update consegne_storico set UG= UG+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						 
//					case 2
//						
//						 update consegne_storico set DG= DG+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;		
//						
//					case 3
//						
//						 update consegne_storico set GUG= GUG+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						
//					case 4
//						
//						 update consegne_storico set GDG= GDG+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						
//				end choose
//				
//			else // se invece è solo diventato membro...
//				
//				 choose case integer(ls_div)
//						
//					case 1
//				 
//						 update consegne_storico set UM= UM+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						 
//					case 2
//						
//						 update consegne_storico set DM= DM+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						
//					case 3
//						
//						 update consegne_storico set GUM= GUM+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						
//					case 4
//						
//						 update consegne_storico set GDM= GDM+1 where vc_nodo= :ls_struttura and anno= :li_anno and data_cer= :ldt_data and luogo_cer= :ls_luogo;
//						
//				end choose				
//				
//			end if
//			
//			if trap_sql(sqlca, "UPDSTORICOCONSEGNE01") < 0 then return -1
			 
			 /*
			  * fine aggiornamento di consegne_storico
			  */
			  
			  		ls_session_s.gm= 'M'
			  		if ls_goh= 'S'  then ls_session_s.gm= 'G'
					
					ls_session_s.codice= ls_codice
					ls_session_s.causale= 'STATUS'
					ls_session_s.status_src= 'ASP'
					ls_session_s.status_tgt= 'MEM'
					ls_session_s.struttura_src= ls_struttura
					ls_session_s.s_utente_s= s_session_s.s_utente_s
					ls_session_s.context= "Aspiranti"
					ls_session_s.tipo_variazione_src= "DA-ASP"
					ls_session_s.tipo_variazione_tgt= "A-MEM"
					
					if f_log(ls_session_s, "Inserito in anagrafica: "+ls_cognome+" "+ls_nome, false) < 0 then goto errore

		next
		
		// cancella l'evento relativo alla cerimonia in eventi...in cascata cancella anche la aspiranti_membri+aspiranti_riferimenti...
		
		delete from aspiranti_riferimenti where id= :is_evento_s.id;
		if trap_sql(sqlca, "DELETEASPIRANTI01.2") < 0 then goto errore		
				
		delete from aspiranti_membri where id= :is_evento_s.id;
		if trap_sql(sqlca, "DELETEASPIRANTI01.3") < 0 then goto errore
		
		delete from eventi where id= :is_evento_s.id;
		if trap_sql(sqlca, "DELETEASPIRANTI01.1") < 0 then goto errore				
		
//	f_log(s_session_s, "Confermata cerimonia: "+is_evento_s.descrizione, false)
		
	commit;
	if trap_sql(sqlca, "COMMITASPIRANTI01") < 0 then goto errore
	
//	dw_header.reset()
//	tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_reset()
//	tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.uof_reset()
	
	open(w_message)
	
	close(w_entrata)

	return 0
		
	errore:

		rollback;
		trap_sql(sqlca, "ROLLBACKASPIRANTI01")
		
		open(w_message_negative)
		
		return -1
	
//	case "b_selezionatutti"
//	
//		this.setRedraw(false)
//		
//		for ll_idx= 1 to this.rowCount()
//			
//			this.setItem(ll_idx, "cconf", "S")
//			
//		next
//		
//		this.setRedraw(true)
	
end choose

return 0



	
	
	
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_conferma

im_preview.m_layoutdistampa.enabled= true
im_preview.m_impostapagina.enabled= true

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

event itemchanged;call super::itemchanged;//this.resetUpdate()
//
//this.setItemStatus(this.getRow(), 0, Primary!, new!)
end event

event retrieveend;call super::retrieveend;//long ll_idx
//
//this.setRedraw(false)
//
//for ll_idx= 1 to this.rowCount()
//	
//	this.setItem(ll_idx, "cconf", "S")
//	
//next
//
//this.setRedraw(true)
end event

type tabpage_unisciliste from userobject within tab_entrata
boolean visible = false
integer x = 18
integer y = 100
integer width = 4544
integer height = 2688
boolean enabled = false
long backcolor = 67108864
string text = "Unisci liste entrate e consegne"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uowd_unisciliste uowd_unisciliste
end type

on tabpage_unisciliste.create
this.uowd_unisciliste=create uowd_unisciliste
this.Control[]={this.uowd_unisciliste}
end on

on tabpage_unisciliste.destroy
destroy(this.uowd_unisciliste)
end on

type uowd_unisciliste from uodw_generica within tabpage_unisciliste
integer taborder = 50
string dataobject = "dw_unisci_liste"
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;call super::buttonclicked;if dwo.name= "b_seleziona" then
	
	
	decimal ld_id_evento
	openWithParm(w_unisci_cerimonie,is_evento_s.cod_dip)
	
	ld_id_evento= message.doubleParm
	
	if ld_id_evento= 0 then return -1
	
	this.reset()
	
	this.retrieve(is_evento_s.id, ld_id_evento)
	
end if
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uowd_unisciliste

im_preview.m_layoutdistampa.enabled= true
im_preview.m_impostapagina.enabled= true

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

