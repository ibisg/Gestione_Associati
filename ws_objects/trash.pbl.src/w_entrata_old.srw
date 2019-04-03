$PBExportHeader$w_entrata_old.srw
forward
global type w_entrata_old from window
end type
type dw_header from uodw_header within w_entrata_old
end type
type tab_entrata from tab within w_entrata_old
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
type tabpage_conferma from userobject within tab_entrata
end type
type uodw_conferma from uodw_generica within tabpage_conferma
end type
type tabpage_conferma from userobject within tab_entrata
uodw_conferma uodw_conferma
end type
type tab_entrata from tab within w_entrata_old
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
tabpage_bollettini tabpage_bollettini
tabpage_conferma tabpage_conferma
end type
end forward

global type w_entrata_old from window
integer width = 5093
integer height = 3304
boolean titlebar = true
string title = "Gestione cerimonie di entrata"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Information!"
event type integer ue_open ( )
event type integer ue_cercacerimonie ( )
dw_header dw_header
tab_entrata tab_entrata
end type
global w_entrata_old w_entrata_old

type variables
string is_codice, is_cod_com, is_com, is_prov, is_cap
s_strade is_strade_s
s_parm s_parm_s
u_ds_com ids_com
boolean ib_dbcancel
s_cerimonia is_cerimonia_s
s_evento is_evento_s

m_preview im_preview

dataWindowChild idwc_riferimenti, idwc_luoghi

uodw_generica iuodw_generica
uodw_generica iuodw_dati
end variables

event type integer ue_open();long ll_row

//openWithParm(w_gestione_cerimonie, 6)
//
//is_evento_s= message.powerObjectParm
//
//if isNull(is_evento_s.id) then
//	close(this)
//	return -1
//end if

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.setTransObject(sqlca)
tab_entrata.tabpage_stampe.uodw_stampa_cerimonie.setTransObject(sqlca)
tab_entrata.tabpage_conferma.uodw_conferma.setTransObject(sqlca)
tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.setTransObject(sqlca)
tab_entrata.tabpage_bollettini.uodw_boll.setTransObject(sqlca)

tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.GetChild('cod_rif', idwc_riferimenti)

dw_header.setTransObject(sqlca)

///////////
if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

dw_header.setTransObject(sqlca)

dw_header.GetChild('cod_luogo', idwc_luoghi)

idwc_luoghi.setTransObject(sqlca)

idwc_luoghi.retrieve(gs_dip_operativa)

ll_row= dw_header.retrieve(is_evento_s.id)

tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_inserimento(0)
	

////////////


return 0
end event

event type integer ue_cercacerimonie();long ll_row

//if tab_entrata.tabpage_inserimento.uodw_inserimento.uof_modificheincorso() < 0 then return -1

openWithParm(w_gestione_cerimonie, ENTRATA)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

dw_header.setTransObject(sqlca)

dw_header.GetChild('cod_luogo', idwc_luoghi)

idwc_luoghi.setTransObject(sqlca)

idwc_luoghi.retrieve(gs_dip_operativa)

ll_row= dw_header.retrieve(is_evento_s.id)

//if is_evento_s.totale_partecipanti= 0 then
	
	tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_inserimento(0)
	
//else
	
//	tab_entrata.tabpage_inserimento.uodw_inserimento.object.b_ricerca.event clicked()
	
//	tab_entrata.tabpage_inserimento.uodw_inserimento.uof_esegui(RICERCA)
	
//end if

return 0
end event

on w_entrata_old.create
this.dw_header=create dw_header
this.tab_entrata=create tab_entrata
this.Control[]={this.dw_header,&
this.tab_entrata}
end on

on w_entrata_old.destroy
destroy(this.dw_header)
destroy(this.tab_entrata)
end on

event open;im_preview= create m_preview
iuodw_generica= create uodw_generica

is_evento_s= message.powerObjectParm

event post ue_open()
end event

event closequery;if iuodw_dati.uof_modificheincorso()= 3 then return 1
if iuodw_generica.uof_modificheincorso()= 3 then return 1
end event

type dw_header from uodw_header within w_entrata_old
integer height = 288
integer taborder = 40
end type

type tab_entrata from tab within w_entrata_old
integer y = 284
integer width = 4882
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
tabpage_conferma tabpage_conferma
end type

on tab_entrata.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_stampe=create tabpage_stampe
this.tabpage_bollettini=create tabpage_bollettini
this.tabpage_conferma=create tabpage_conferma
this.Control[]={this.tabpage_inserimento,&
this.tabpage_stampe,&
this.tabpage_bollettini,&
this.tabpage_conferma}
end on

on tab_entrata.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_stampe)
destroy(this.tabpage_bollettini)
destroy(this.tabpage_conferma)
end on

event selectionchanging;long ll_row

choose case oldindex
		
	case 1
		
		if iuodw_generica.uof_modificheincorso() = 3 then return 1 // non cambia tab
		
//	case 4
//		
//	if iuodw_generica.uof_modificheincorso() = 3 then return 1 // non cambia tab
		
end choose

choose case newindex
		
	case 1
		
//		iuodw_generica= iuodw_dati
		
		return 0 // non deve eseguire la retrieve...
		
	case 2
		
		iuodw_generica=  tab_entrata.tabpage_stampe.uodw_stampa_cerimonie
		
	case 3
		
		iuodw_generica= tab_entrata.tabpage_bollettini.uodw_boll
		
	case 4
		
		iuodw_generica= tab_entrata.tabpage_conferma.uodw_conferma
		
end choose

ll_row= iuodw_generica.retrieve(is_evento_s.id)

return 0 // ll_row
end event

type tabpage_inserimento from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4846
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
integer y = 40
integer width = 4818
integer height = 2560
integer taborder = 30
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

event selectionchanging;if isValid(iuodw_dati) then
	if iuodw_dati.uof_modificheincorso() = 2 then return
end if

choose case newindex
		
	case 1
		
			iuodw_dati= tab_dati.tabpage_dati.uodw_inserimento
		
	case 2
		
		iuodw_dati= tab_dati.tabpage_riferimenti.uodw_riferimenti

//		if  NOT isNull(w_entrata.is_codice) and w_entrata.is_codice <> "" then
//			iuodw_dati.retrieve(w_entrata.is_codice)
//		else
//		//	tab_dati.tabpage_riferimenti.uodw_riferimenti.reset()
//		return 1
//		end if
		
end choose

		if  NOT isNull(w_entrata.is_codice) and w_entrata.is_codice <> "" then
			if newindex= 2 then iuodw_dati.retrieve(w_entrata.is_codice)
		else
		//	tab_dati.tabpage_riferimenti.uodw_riferimenti.reset()
		return 1
		end if


end event

type tabpage_dati from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4782
integer height = 2432
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
integer width = 4530
integer height = 2404
integer taborder = 30
string dataobject = "dw_anagrafica_aspiranti"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event updatestart;call super::updatestart;string ls_codice
decimal ld_id

ls_codice= this.getItemString(this.getRow(), "codice")

if ls_codice <> "" then return 0 // se la persona è già stata inserita non genera un nuovo codice...

// Genera il nuovo codice

ls_codice= gencod(gs_dip_operativa)

ld_id= dw_header.getItemDecimal(dw_header.getRow(), "id")

if ls_codice= "" then goto errore
	
	this.setItem(this.getRow(), "codice", ls_codice)
	
	  INSERT INTO membri_eventi  // N.B. occorre un trigger sia su eventi che su membri_gerarchica 
	  										// per gestire la cencellazione degli eventi e l'eventuale cancellazione di un membro...
         ( id,   
           codice )  
  		VALUES ( :ld_id,   
           			  :ls_codice ) ;
							 
	if trap_sql(sqlca, "MEVENTI01") < 0 then goto errore
	
	commit;
	if trap_sql(sqlca, "MEVENTI02") < 0 then goto errore
	
	return 0 // tutto ok
	
errore:
	
	rollback;
	trap_sql(sqlca, "MEVENTI03") 
	
	return 1 // non prosegue l'update

	

end event

event buttonclicked;call super::buttonclicked;integer li_ret

choose case dwo.name
		
	case "b_bollettino"
		
		s_preview s_preview_s
		
		s_preview_s.tipo_stampa= "N"
		s_preview_s.criterio= uodw_inserimento.getItemString(uodw_inserimento.getRow(), "codice")
		
		if s_preview_s.criterio= ""or isNull(s_preview_s.criterio) then
			messageBox(parent.text, "Il codice personale non è stato ancora attribuito, eseguire l'aggiornamento prima di generare un bollettino.", information!)
			return 0
		end if
		
		w_preview_bollettini iw_bollettini
		
		s_preview_s.dataObject= "r_boll_sing"
		
		w_frame_gestioneassociati.setRedraw(false)
			li_ret= openWithParm(iw_bollettini, s_preview_s)
		w_frame_gestioneassociati.setRedraw(true)
		
		return li_ret
		
	case "b_aggiorna"
		
		w_entrata.is_codice= this.getItemString(row, "codice")
		
	case "b_p"
		
		li_ret= this.setItem(row, "data_cer", dw_header.getItemDateTime(dw_header.getRow(), "data_evento") )
		if li_ret = -1 then
			messageBox(parent.text, "Assegnazione data cerimonia non riuscita", exclamation!)
			return -1
		end if
		li_ret= this.setItem(row, "luogo_cer", dw_header.getItemString(dw_header.getRow(), "cod_luogo") )
		if li_ret = -1 then
			messageBox(parent.text, "Assegnazione luogo cerimonia non riuscita", exclamation!)
			return -1	
		end if
		
		li_ret= this.setItem(row, "cod_dis", "ASP")
		if li_ret = -1 then
			messageBox(parent.text, "Assegnazione status non riuscita", exclamation!)
			return -1	
		end if
		
//	case "b_reset"
//		
//		if uof_modificheincorso()= 3 then return
//
//		uof_reset()
//		
	case "b_cerca"
		
		string ls_er
		decimal ld_id
		s_ricerca s_ricerca_s
		
//		this.object.b_m.visible= false
//		this.object.b_p.visible= false
//		this.object.b_aggiorna.visible= false
		
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
		s_assegnastruttura_s.al_ultimolivelloparent= gi_maxlivello
		s_assegnastruttura_s.as_struttura_s.vc_nodo= this.getItemString(row, "vc_parent")
		
		s_struttura s_struttura_s
		
		s_struttura_s= this.uof_struttura(s_assegnastruttura_s)
		
		if s_struttura_s.livello < 0 then return -1
		this.object.b_aggiorna.visible= '1'
		
		this.setItem(row, "vc_parent", s_struttura_s.vc_nodo)

	case "b_cap"
		
		integer i_err
		string ls_cap, ls_loc
		
		s_strade s_strade_s
		
		s_strade_s.cap= this.getItemString(row, "cap_dom")
		s_strade_s.comune= this.getItemString(row, "comune")
		s_strade_s.cod_com= this.getItemString(row, "cod_com")
		s_strade_s.provincia= this.getItemString(row, "provincia")
		
		s_strade_s= f_vercap(s_strade_s)
		
		choose case s_strade_s.return_code
				
			case 0
				
				messageBox(this.title, "Operazione annullata.", information!)
				
			case -1
				
				return -1
				
			case 1
				
				i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
							
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
			case 2
				
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
		end choose
		
end choose
end event

type tabpage_riferimenti from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4782
integer height = 2432
long backcolor = 67108864
string text = "Riferimenti"
long tabtextcolor = 8421376
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
string dataobject = "dw_riferimenti"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;if dwo.name= "b_p" then
	
	this.setItem(this.getRow(), "codice", w_entrata.is_codice)	
	
end if
end event

type tabpage_stampe from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4846
integer height = 2688
long backcolor = 67108864
string text = "Stampa lista"
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
integer width = 3543
integer height = 2616
integer taborder = 20
string dataobject = "dw_lista_aspiranti"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stampa_cerimonie

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false
im_preview.m_layoutdistampa.enabled= false

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

type tabpage_bollettini from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4846
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
integer width = 4539
integer height = 2680
integer taborder = 40
string dataobject = "r_boll_asp"
borderstyle borderstyle = stylebox!
end type

type tabpage_conferma from userobject within tab_entrata
integer x = 18
integer y = 100
integer width = 4846
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
integer width = 3671
integer height = 2640
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_conferma_aspiranti"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event buttonclicked;// Non deve eseguire la script dell'ancestor...

long ll_idx
string ls_cod
integer li_ret

datetime ldt_data
string ls_codice, ls_luogo

choose case dwo.name
		
	case "b_aggiorna" 
		
		if this.modifiedCount() <= 0 then return 0
	
//			// cancella i record relativi alla cerimonia in membri_eventi...
//		delete from membri_eventi where id= :is_evento_s.id;
//		if trap_sql(sqlca, "DEL_ASP01") < 0 then
//			rollback;
//			trap_sql(sqlca, "DEL_ASP02")
//			return -1
//		end if
		
		for ll_idx= 1 to this.rowCount()
			
			ls_cod= this.getItemString(ll_idx, "cod_dis")
			if ls_cod= "FED" then continue
			
			li_ret= this.deleteRow(ll_idx)
			
				if li_ret= -1 then
					messageBox(parent.text, "Cancellazione di persona non confermata non riuscita.", exclamation!)
					rollback;
					trap_sql(sqlca, "DEL_ASP03")
					return -1
				end if
			
		next
		
//		update eventi set stato= :gc_chiuso where id=  :is_evento_s.id;
//		if trap_sql(sqlca, "DEL_ASP04") < 0 then
//			rollback;
//			trap_sql(sqlca, "DEL_ASP05")
//			return -1
//		end if
		
		// Inserisce una riga in storico goh. se ha ricevuto il G.
		
		ldt_data= dw_header.getItemDateTime(dw_header.getRow(), "data_evento")
		ls_luogo= dw_header.getItemString(dw_header.getRow(), "luogo_evento")
		
		for ll_idx= 1 to this.rowCount()
			
			ls_codice= this.getItemString(row, "codice")
		
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
							  
			if trap_sql(sqlca, "INS_ASP01") < 0 then
				rollback;
				trap_sql(sqlca, "INS_ASP02")
				return -1
			end if

		next
		
		// cancella l'evento relativo alla cerimonia in eventi...in cascata cancella anch la membri_eventi...
		delete from eventi where id= :is_evento_s.id;
		if trap_sql(sqlca, "DEL_EV01") < 0 then
			rollback;
			trap_sql(sqlca, "DEL_EV02")
			return -1
		end if

		
		if this.uof_aggiorna() < 0 then return -1
		
		tab_entrata.tabpage_inserimento.tab_dati.tabpage_dati.uodw_inserimento.uof_reset()
		tab_entrata.tabpage_inserimento.tab_dati.tabpage_riferimenti.uodw_riferimenti.uof_reset()
	
	case "b_selezionatutti"
	
		this.setRedraw(false)
		
		for ll_idx= 1 to this.rowCount()
			
			this.setItem(ll_idx, "cod_dis", "FED")
			
		next
		
		this.setRedraw(true)
	
end choose
	
	
end event

event sqlpreview;call super::sqlpreview;//string ls_boh
//
//ls_boh= sqlsyntax
//
//return 0
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_conferma

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

