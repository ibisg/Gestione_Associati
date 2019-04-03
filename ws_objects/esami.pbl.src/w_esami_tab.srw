$PBExportHeader$w_esami_tab.srw
forward
global type w_esami_tab from window
end type
type tab_esami from tab within w_esami_tab
end type
type tabpage_inserimento from userobject within tab_esami
end type
type cb_reset from commandbutton within tabpage_inserimento
end type
type mle_criteri from multilineedit within tabpage_inserimento
end type
type uodw_import from uodw_generica within tabpage_inserimento
end type
type st_1 from statictext within tabpage_inserimento
end type
type pb_struttura from picturebutton within tabpage_inserimento
end type
type cb_importa from commandbutton within tabpage_inserimento
end type
type cb_estrazione from commandbutton within tabpage_inserimento
end type
type gb_criteri from groupbox within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_esami
cb_reset cb_reset
mle_criteri mle_criteri
uodw_import uodw_import
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_estrazione cb_estrazione
gb_criteri gb_criteri
end type
type tabpage_lista from userobject within tab_esami
end type
type uodw_lista from uodw_generica within tabpage_lista
end type
type tabpage_lista from userobject within tab_esami
uodw_lista uodw_lista
end type
type tabpage_esito from userobject within tab_esami
end type
type cbx_nascondi from checkbox within tabpage_esito
end type
type pb_ricerca from picturebutton within tabpage_esito
end type
type st_3 from statictext within tabpage_esito
end type
type st_min from statictext within tabpage_esito
end type
type uodw_esito from uodw_generica within tabpage_esito
end type
type cb_soglia from commandbutton within tabpage_esito
end type
type cb_aggiorna from commandbutton within tabpage_esito
end type
type cbx_aggiorna from checkbox within tabpage_esito
end type
type em_da from editmask within tabpage_esito
end type
type em_a from editmask within tabpage_esito
end type
type cb_filtra from commandbutton within tabpage_esito
end type
type cb_annulla from commandbutton within tabpage_esito
end type
type rb_presenti from radiobutton within tabpage_esito
end type
type rb_tutti from radiobutton within tabpage_esito
end type
type rb_respinti from radiobutton within tabpage_esito
end type
type rb_promossi from radiobutton within tabpage_esito
end type
type rb_assenti from radiobutton within tabpage_esito
end type
type gb_filtra from groupbox within tabpage_esito
end type
type gb_1 from groupbox within tabpage_esito
end type
type gb_2 from groupbox within tabpage_esito
end type
type tabpage_esito from userobject within tab_esami
cbx_nascondi cbx_nascondi
pb_ricerca pb_ricerca
st_3 st_3
st_min st_min
uodw_esito uodw_esito
cb_soglia cb_soglia
cb_aggiorna cb_aggiorna
cbx_aggiorna cbx_aggiorna
em_da em_da
em_a em_a
cb_filtra cb_filtra
cb_annulla cb_annulla
rb_presenti rb_presenti
rb_tutti rb_tutti
rb_respinti rb_respinti
rb_promossi rb_promossi
rb_assenti rb_assenti
gb_filtra gb_filtra
gb_1 gb_1
gb_2 gb_2
end type
type tab_esami from tab within w_esami_tab
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_esito tabpage_esito
end type
type dw_header from uodw_header within w_esami_tab
end type
type s_cons from structure within w_esami_tab
end type
end forward

type s_cons from structure
	string		v_codice
	string		v_nomin
	string		v_loc
	datetime		v_data
	string		v_citta
	string		v_turno
	string		v_causale
	string		v_tipo_goh
end type

global type w_esami_tab from window
integer x = 5
integer y = 4
integer width = 5527
integer height = 3016
boolean titlebar = true
string title = "Esami di studio"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Query5!"
toolbaralignment toolbaralignment = alignatleft!
event type integer ue_open ( )
event type integer save ( )
event ordina ( )
event importa ( )
event stampa ( )
event type integer ue_salva_come ( )
tab_esami tab_esami
dw_header dw_header
end type
global w_esami_tab w_esami_tab

type variables
 boolean ib_oktoggle
 
 datetime idt_data_ultimo_esame, idt_data_cerimonia_soglia, idt_data_diploma
 
 integer ii_livello_resp_soglia
 
 long il_righeestratte
 
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status, is_a_g, is_liste_congelate

DataWindowChild idwc_liv, idwc_luoghi

m_preview im_preview

s_evento is_evento_s
s_struttura is_struttura_s

end variables

forward prototypes
public subroutine wf_rinumera (datawindow adw_arg)
end prototypes

event type integer ue_open();integer li_criteri
long ll_row
string ls_descrizione_livello, ls_descrizione_evento, ls_criteri

im_preview= create m_preview

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

tab_esami.enabled= false

tab_esami.tabpage_inserimento.uodw_import.setRedraw(false)

tab_esami.tabpage_inserimento.uodw_import.setTransObject(sqlca)

dw_header.setTransObject(sqlca)
dw_header.GetChild('cod_luogo', idwc_luoghi)

idwc_luoghi.setTransObject(sqlca)

idwc_luoghi.retrieve(s_session_s.cod_dip)

ll_row= dw_header.retrieve(is_evento_s.id)

is_liv = "0"+string(is_evento_s.tipo_evento - 1)

select data_ultimo_esame, data_cerimonia_soglia, data_diploma, livello_resp_soglia, a_g, liste_congelate
into :idt_data_ultimo_esame, :idt_data_cerimonia_soglia, :idt_data_diploma, :ii_livello_resp_soglia, :is_a_g, :is_liste_congelate
from esami_sessioni
where esami_sessioni.id= :is_evento_s.id_esami_sessioni;

select descrizione_evento
into :ls_descrizione_evento
from eventi
where eventi.id= :is_evento_s.id;


if isNull(idt_data_diploma) then
	
	messageBox(this.title, "Non è stata definita la data diploma nella sessione d'esame~nLl'aggiornamento non verrà effettuato.")
	
	return 0
	
end if

if trap_sql(sqlca, "SELECTSESSIONE01") < 0 then return -1

tab_esami.tabpage_inserimento.gb_criteri.text= ls_descrizione_evento+" - Criteri predefiniti di partecipazione all'esame del "+string(is_evento_s.tipo_evento)+"° livello"

if NOT isNull(idt_data_ultimo_esame) then
	li_criteri++
	ls_criteri= string(li_criteri)+"- possono partecipare coloro che hanno sostenuto l'esame precedente entro il: "+string(idt_data_ultimo_esame, "dd.mm.yyyy")+" (compreso)"+"~r~n"
end if

if NOT isNull(idt_data_cerimonia_soglia) then
	li_criteri++
	ls_criteri+= string(li_criteri)+"- possono partecipare coloro che sono diventati membri entro il: "+string(idt_data_cerimonia_soglia, "dd.mm.yyyy")+" (compreso)"+"~r~n"
end if	

if ii_livello_resp_soglia > 0 then
	select descrizione into :ls_descrizione_livello from struttura_livelli where livello= :ii_livello_resp_soglia;
	if trap_sql(sqlca, "LISTELIVELLI01") < 0 then return -1
	
	li_criteri++
	ls_criteri= ls_criteri + string(li_criteri)+"- possono partecipare coloro che hanno almeno una responsabilità di "+ls_descrizione_livello+"~r~n"
end if	

choose case is_a_g
		
	case 'A'
		li_criteri++
		ls_criteri = ls_criteri+string(li_criteri)+"- possono partecipare coloro che appartengono ai gruppi adulti"+"~r~n"
	case 'G'
		li_criteri++
		ls_criteri = ls_criteri+string(li_criteri)+"- possono partecipare coloro che appartengono ai gruppi giovani"
	case else
		//tab_esami.tabpage_inserimento.st_criterio4.visible= false
		
end choose

tab_esami.tabpage_inserimento.mle_criteri.text= ls_criteri
	
tab_esami.tabpage_inserimento.uodw_import.setRedraw(true)

select count(*)
into :ll_row
from esami
where id= :is_evento_s.id;

if trap_sql(sqlca, "COUNTLISTA01") < 0 then return -1

//close(w_wait_snoopy_writing)

if ll_row= 0 then
	
	messageBox(this.title, "Nessuna lista è stata ancora generata per questo evento.", information!)
	
	tab_esami.enabled= true
	
	tab_esami.tabpage_inserimento.cb_estrazione.event clicked()
	
	tab_esami.tabpage_inserimento.cb_estrazione.enabled= true
	tab_esami.tabpage_inserimento.pb_struttura.enabled= true
	
else
	
	tab_esami.enabled= true
	tab_esami.tabpage_inserimento.enabled= false
	tab_esami.tabpage_lista.enabled= true
	tab_esami.tabpage_esito.enabled= true
	tab_esami.selectTab(tab_esami.tabpage_lista)
	
	if is_liste_congelate= 'S' then tab_esami.tabpage_lista.uodw_lista.object.b_cancella.visible= false
	
end if

return 0
end event

event save;//dw_elenco.SetRedraw ( false )
//
//if dw_elenco.Update ( ) = -1 then
//	
//	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
//		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
//		halt close
//	end if
//	
//	f_log_err ( gs_context, sqlca.SqlErrText )
//	rollback;
//	
//	OpenWithParm ( w_msgauto, "Modifiche annullate" )
//	
//	dw_elenco.SetRedraw ( true )
//	
//	return -1
//	
//else
//	
//	commit;
//	
//	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
//		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
//		halt close
//	end if
//
//	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
//	
//	dw_elenco.SetRedraw ( true )
//	
//	cb_save.enabled = false
//	
//end if

return 0

end event

event ordina();//OpenWithParm ( w_ordina, dw_elenco )
//dw_elenco.SetSort ( message.StringParm )
//dw_elenco.Sort ( )

end event

event importa();integer li_sqlcode, li_ret, li_count
long ll_rows, ll_count, ll_row
string ls_codice

ds_lista = create uo_ds_gen
ds_lista.DataObject = "ds_lista"
ds_lista.SetTransObject ( sqlca )

open(w_wait_meter)

for ll_count = 1 to tab_esami.tabpage_inserimento.uodw_import.RowCount ()
	
		ll_row= ds_lista.InsertRow ( 0 )
		
		ds_lista.SetItem ( ll_row, "id", is_evento_s.id )
		ds_lista.SetItem ( ll_row, "codice", tab_esami.tabpage_inserimento.uodw_import.GetItemString ( ll_count, "codice" ) )
		ds_lista.SetItem ( ll_row, "cod_studio", is_liv )
		ds_lista.SetItem ( ll_row, "esito", "A" )
//		ds_lista.SetItem(ll_row, "raggruppamento", "" /*is_struttura_s.vc_nodo*/)
//		ds_lista.SetItem(ll_row, "livello", is_struttura_s.livello)		
		
		ls_codice= tab_esami.tabpage_inserimento.uodw_import.GetItemString ( ll_count, "codice" )
		
		insert into esami
		(id, codice, cod_studio, esito)
		values(	:is_evento_s.id, 
					:ls_codice, 
					:is_liv,
					"A");
				
		if trap_sql(sqlca, "INSESAMI01") < 0 then 	
			//messagebox("test", 'codice doppio: '+ls_codice)
			close(w_wait_meter)
			return		
			end if
		
		// progress bar che scorre a scatti di 100 (ad evitare di appesantire con aggiornamento troppo frequente)...
		
		il_righeestratte=  tab_esami.tabpage_inserimento.uodw_import.rowCount()
		if  il_righeestratte > 1000 then
		
			li_count++
			
			if li_count = 100 then
				
				w_wait_meter.hpb_meter.position= (ll_count/il_righeestratte)*100
				
				li_count= 0
				
			end if
			
		else
			
				w_wait_meter.hpb_meter.position= (ll_count/il_righeestratte)*100
			
		end if		
		
	
next

delete 
from  esami_raggruppamento
where id= :is_evento_s.id;

if trap_sql(sqlca, "DELLISTA00") < 0 then return

insert into esami_raggruppamento
(id, livello_master, vc_nodo_master, livello, vc_nodo)
values ( :is_evento_s.id, :is_struttura_s.livello, : is_struttura_s.vc_nodo, :is_struttura_s.livello, :is_struttura_s.vc_nodo);

if trap_sql(sqlca, "INSLISTA01") < 0 then return

li_sqlcode= sqlca.sqlcode

//li_ret= ds_lista.Update()

close(w_wait_meter)

if li_ret = -1 OR li_sqlcode < 0 then
	
	rollback;
	destroy ds_lista
	OpenWithParm ( w_msg, "Importazione annullata: SQLCODE= "+string(li_sqlcode ) )
	
	return
	
end if

commit;
destroy ds_lista
OpenWithParm ( w_msg, "Importazione effettuata" )	

tab_esami.selectTab(tab_esami.tabpage_lista)
tab_esami.tabpage_lista.enabled= true
tab_esami.tabpage_inserimento.enabled= false
tab_esami.tabpage_esito.enabled= true

return

end event

event stampa;//dw_elenco.SetRedraw ( false )
////dw_elenco.Object.n_pag.visible = 1
////dw_elenco.Object.DataWindow.Footer.Height = 165
//
//OpenWithParm ( w_dw_print_options, this.dw_elenco )
//
////dw_elenco.Object.n_pag.visible = 0
////dw_elenco.Object.DataWindow.Footer.Height = 85
//dw_elenco.SetRedraw ( true )
//
end event

event ue_salva_come;////int li_colnum
//string ls_colname, ls_msg
//
//open ( w_aut_print )
//
//if Message.DoubleParm = -1 then return -1
//
//ls_msg = "Salvato su file per " + Message.StringParm
//
//if dw_elenco.SaveAs()= -1 then return -1
//
//f_log ( gs_context, ls_msg )
//
return 0
end event

public subroutine wf_rinumera (datawindow adw_arg);boolean lb_exit
integer li_num=0
long ll_breakrow= 1, ll_start= 2, ll_end, ll_idx

lb_exit  = false

DO WHILE lb_exit= false
	
	  ll_breakrow = adw_arg.FindGroupChange(ll_start, 1)
	  
		IF ll_breakrow <= 0 THEN 
		
			lb_exit= true
			ll_end= adw_arg.rowCount()+1
			//continue
			
		else
			
			ll_end= ll_breakrow
		
		end if			
			 
		for ll_idx= ll_start to ll_end
			
			li_num++
			
			adw_arg.setItem(ll_idx -1, "numerazione", li_num) 
			
		next

	 // Increment starting row to find next break
	 
	  ll_start = ll_end+1
	  li_num= 0
	 

LOOP

return

end subroutine

on w_esami_tab.create
this.tab_esami=create tab_esami
this.dw_header=create dw_header
this.Control[]={this.tab_esami,&
this.dw_header}
end on

on w_esami_tab.destroy
destroy(this.tab_esami)
destroy(this.dw_header)
end on

event open;is_evento_s= message.powerObjectParm

PostEvent ( "ue_open" )

end event

event closequery;tab_esami.tabpage_lista.uodw_lista.acceptText()
tab_esami.tabpage_esito.uodw_esito.acceptText()

if tab_esami.tabpage_esito.uodw_esito.modifiedCount() > 0 then
	choose case messageBox(this.title, "Esiti esami: sono stati aggiornati dei dati. Vuoi salvare le modifiche?", question!, yesNoCancel!, 1)
		case 1

		if tab_esami.tabpage_esito.uodw_esito.update()> 0 then
			commit;
			if trap_sql(sqlca, "COMMITESITIESAMI") < 0 then goto errore
		else
			goto errore
		end if
	 	case 2 
			if messageBox(this.title, "Attenzione: verranno annullati tutti i dati inseriti e non ancora aggiornati.~nVuoi proseguire?", question!, okCancel!, 2)= 2 then return 1
			return 0
			
		case 3 
			return 1
	end choose
end if
					
return 0					
					
errore:
		messageBox(this.title, "Errore in aggiornamento dati.", exclamation!)
		rollback;
		trap_sql(sqlca, "ROLLBACKLISTAESAMI")
		return -1
end event

event resize;//gb_dett.width= this.width - 90
//dw_elenco.width= gb_dett.width - 400
//cb_estrai.x= dw_elenco.width + 80
//cb_save.x= dw_elenco.width + 80
//cb_annulla.x= dw_elenco.width + 80
//
//
//gb_dett.height= this.height - 200 - gb_dett.y
//
//dw_elenco.height= gb_dett.height -240
//

tab_esami.height= this.height - 180 - tab_esami.y
tab_esami.width= this.width - 120
tab_esami.tabpage_inserimento.uodw_import.height= tab_esami.height - 120 - tab_esami.tabpage_inserimento.uodw_import.y

tab_esami.tabpage_lista.uodw_lista.height= tab_esami.height - 120 - tab_esami.tabpage_lista.uodw_lista.y
tab_esami.tabpage_lista.uodw_lista.width= tab_esami.tabpage_lista.width - 30
tab_esami.tabpage_esito.uodw_esito.height= tab_esami.height - 120 - tab_esami.tabpage_esito.uodw_esito.y
end event

type tab_esami from tab within w_esami_tab
event create ( )
event destroy ( )
integer x = 27
integer y = 384
integer width = 5239
integer height = 2360
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 81324524
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_esito tabpage_esito
end type

on tab_esami.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_lista=create tabpage_lista
this.tabpage_esito=create tabpage_esito
this.Control[]={this.tabpage_inserimento,&
this.tabpage_lista,&
this.tabpage_esito}
end on

on tab_esami.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_lista)
destroy(this.tabpage_esito)
end on

event selectionchanging;integer li_livello
long ll_idx, ll_rows
string ls_nodo

if oldindex= 2 then

	choose case tab_esami.tabpage_lista.uodw_lista.uof_modificheincorso()
			
		case 1
			
				tab_esami.tabpage_lista.uodw_lista.uof_aggiorna()
				
		case 2
			
			// non salva
			
		case 3
			
			return 1 // annulla il cambio di selezione...
			
	end choose

end if

if oldindex= 3 then

	choose case tab_esami.tabpage_esito.uodw_esito.uof_modificheincorso()
			
		case 1
			
				tab_esami.tabpage_esito.uodw_esito.uof_aggiorna()
				
		case 2
			
			// non salva
			
		case 3
			
			return 1 // annulla il cambio di selezione...
			
	end choose

end if

setPointer(hourGlass!)

choose case newindex
		
	case 2
		
		open(w_wait_snoopy)		
		
		
		tab_esami.tabpage_lista.uodw_lista.setTransObject(sqlca)
		tab_esami.tabpage_lista.uodw_lista.SetRedraw ( false )
		ll_rows= tab_esami.tabpage_lista.uodw_lista.Retrieve ( is_evento_s.id )

		select livello, vc_nodo
		into :li_livello, :ls_nodo
		from esami_raggruppamento
		where
		id=  :is_evento_s.id;

		if trap_sql(sqlca, "SELCHANGING01") < 0 then return -1
		
		if li_livello= 0 then li_livello= is_struttura_s.livello
		
		tab_esami.tabpage_lista.uodw_lista.setRedraw(false)
		
		for ll_idx= 1 to  tab_esami.tabpage_lista.uodw_lista.rowCount()
			
			ls_nodo= tab_esami.tabpage_lista.uodw_lista.getItemString(ll_idx, "vc_parent")
			
			ls_nodo= f_parse_struttura_left(ls_nodo, li_livello)
			
			tab_esami.tabpage_lista.uodw_lista.setItem(ll_idx, "raggruppamento", ls_nodo)
			tab_esami.tabpage_lista.uodw_lista.setItem(ll_idx, "livello", li_livello)			
			
		next
		
		tab_esami.tabpage_lista.uodw_lista.sort()
		
		tab_esami.tabpage_lista.uodw_lista.groupCalc()
		
		wf_rinumera(tab_esami.tabpage_lista.uodw_lista)
		
		tab_esami.tabpage_lista.uodw_lista.resetUpdate()
		
		tab_esami.tabpage_lista.uodw_lista.setRedraw(true)
		
		close(w_wait_snoopy)		
		
	case 3
		
		open(w_wait_snoopy)
		
		tab_esami.tabpage_esito.uodw_esito.setTransObject(sqlca)
		tab_esami.tabpage_esito.uodw_esito.SetRedraw ( false )
		ll_rows= tab_esami.tabpage_esito.uodw_esito.Retrieve ( is_evento_s.id )
		
		select livello, vc_nodo
		into :li_livello, :ls_nodo
		from esami_raggruppamento
		where
		id=  :is_evento_s.id;
		
		if li_livello= 0 then li_livello= is_struttura_s.livello
		
		tab_esami.tabpage_esito.uodw_esito.setRedraw(false)
		
		ll_rows= tab_esami.tabpage_esito.uodw_esito.rowCount()
		
		for ll_idx= 1 to ll_rows
			
			ls_nodo= tab_esami.tabpage_esito.uodw_esito.getItemString(ll_idx, "vc_parent")
			
			ls_nodo= f_parse_struttura_left(ls_nodo, li_livello)
			
			tab_esami.tabpage_esito.uodw_esito.setItem(ll_idx, "raggruppamento", ls_nodo)
			tab_esami.tabpage_esito.uodw_esito.setItem(ll_idx, "livello", li_livello)
			
		next
		
		tab_esami.tabpage_esito.uodw_esito.sort()
		
		tab_esami.tabpage_esito.uodw_esito.resetUpdate()
		
		tab_esami.tabpage_esito.uodw_esito.SetRedraw ( true )	
		
		close(w_wait_snoopy)		
		
		
end choose
end event

type tabpage_inserimento from userobject within tab_esami
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5202
integer height = 2244
long backcolor = 81324524
string text = "Inserimento partecipanti"
long tabtextcolor = 16711680
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
cb_reset cb_reset
mle_criteri mle_criteri
uodw_import uodw_import
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_estrazione cb_estrazione
gb_criteri gb_criteri
end type

on tabpage_inserimento.create
this.cb_reset=create cb_reset
this.mle_criteri=create mle_criteri
this.uodw_import=create uodw_import
this.st_1=create st_1
this.pb_struttura=create pb_struttura
this.cb_importa=create cb_importa
this.cb_estrazione=create cb_estrazione
this.gb_criteri=create gb_criteri
this.Control[]={this.cb_reset,&
this.mle_criteri,&
this.uodw_import,&
this.st_1,&
this.pb_struttura,&
this.cb_importa,&
this.cb_estrazione,&
this.gb_criteri}
end on

on tabpage_inserimento.destroy
destroy(this.cb_reset)
destroy(this.mle_criteri)
destroy(this.uodw_import)
destroy(this.st_1)
destroy(this.pb_struttura)
destroy(this.cb_importa)
destroy(this.cb_estrazione)
destroy(this.gb_criteri)
end on

type cb_reset from commandbutton within tabpage_inserimento
integer x = 3931
integer y = 212
integer width = 347
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Reset risultati"
end type

event clicked;uodw_import.reset()
end event

type mle_criteri from multilineedit within tabpage_inserimento
integer x = 46
integer y = 64
integer width = 3397
integer height = 376
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type uodw_import from uodw_generica within tabpage_inserimento
integer x = 23
integer y = 504
integer width = 3867
integer height = 720
integer taborder = 30
string dataobject = "dw_import_sp"
boolean ib_isgrid = true
boolean ib_querymode = true
boolean ib_readonly = true
boolean ib_stampatoda = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_import

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row (this)
//if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
//	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
//end if
end event

event sqlpreview;call super::sqlpreview;//integer li_pos
//string ls_sql, ls_syntax, ls_where

//f_sql_use_like(sqlType, sqlsyntax, uodw_import, true)

//li_pos= lastpos(lower(sqlsyntax), "where")
//
//// costruisce la query...
//
//if is_liv= '00' then // Nessun esame...
//
//	if li_pos >0 then
//		ls_syntax= " and membri_gerarchica.cod_dis in ('MEM', 'TFE')  and membri_gerarchica.cod_studio= '"+is_liv+"'"
//	else
//		ls_syntax= " where membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"	
//	end if
//	
//else
//
//	if li_pos >0 then
//		ls_syntax= " and membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"
//	else
//		ls_syntax= " where membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"
//	end if
//	
//end if
//
//// 3 casi per i criteri
//
//if NOT isNull(idt_data_ultimo_esame) AND NOT isNull(idt_data_cerimonia_soglia) then
//	
//			ls_syntax+= " and esami_curr.data_esame <= '"+string(idt_data_ultimo_esame, "dd.mm.yyyy")+"' and membri_gerarchica.data_cer <= '"+string(idt_data_cerimonia_soglia, "dd.mm.yyyy")+"'"
//	
//elseif NOT isNull(idt_data_ultimo_esame) AND isNull(idt_data_cerimonia_soglia) then
//	
//			ls_syntax+= " and esami_curr.data_esame <= '"+string(idt_data_ultimo_esame, "dd.mm.yyyy")+"'"
//	
//elseif isNull(idt_data_ultimo_esame) AND NOT isNull(idt_data_cerimonia_soglia) then
//	
//			ls_syntax+= " and membri_gerarchica.data_cer <= '"+string(idt_data_cerimonia_soglia, "dd.mm.yyyy")+"'"
//	
//end if
//
//// più gli altri due...
//
//	if ii_livello_resp_soglia > 0 then
//		
//					ls_syntax+= " and 	( select MIN(a.livello) from membri_gerarchica m1, att_ist a "+&
//					               " where (m1.cod_att_ist_1= a.cod_att_ist OR m1.cod_att_ist_2= a.cod_att_ist)"+&
//								 " and m1.codice= membri_gerarchica.codice and a.livello > 0) <= "+string(ii_livello_resp_soglia)
//								 
//	end if
//	
//	choose case is_a_g
//			
//		case 'A'
//
//					ls_syntax+= " and 	membri_gerarchica.cod_div IN ('1', '2')"
//								 
//		case 'G'
//			
//
//					ls_syntax+= " and 	membri_gerarchica.cod_div IN ('3', '4')"	
//								 
//		end choose	
//
//
//// esclude le persone già presenti in altre liste...
//ls_syntax += " and membri_gerarchica.codice NOT IN  (select codice from esami, eventi where esami.id= eventi.id and eventi.tipo_evento= "+string(is_evento_s.tipo_evento)+" )"
// 
//// Conteggio degli aventi diritto...
//
//il_righeestratte= f_conteggioaventidiritto_dyn(is_liv,  idt_data_cerimonia_soglia, idt_data_ultimo_esame, ii_livello_resp_soglia, is_a_g)
//
//if il_righeestratte > 500 then
//	if messageBox(parent.text, "Saranno estratte "+string(il_righeestratte)+" persone, il tempo di attesa potrebbe essere lungo: vuoi proseguire?", question!, yesNo!, 2)= 2 then return 1
//end if
//
//// OK, modifica la stringa di ricerca...
//	
//sqlsyntax += ls_syntax
//
//SetSqlPreview ( sqlsyntax)
//
//
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_ok" then
		
		long ll_idx
		
		this.setRedraw(false)
		
		if ib_oktoggle= false then
			
			// tutti NOK
			
			this.setFilter("flag_ok= '1'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "flag_ok", '0')
				
			next
			
			this.object.b_ok.text= 'Tutti'
			
		else
			
			// tutti OK
			
			this.setFilter("flag_ok= '0'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "flag_ok", '1')
				
			next		
			
			this.object.b_ok.text= 'Nessuno'
			
		end if
		
		this.setFilter("")
		this.filter()
		
		ib_oktoggle= NOT ib_oktoggle
		
		this.setRedraw(true)
		
	end if
		
end event

type st_1 from statictext within tabpage_inserimento
integer x = 3520
integer y = 8
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Seleziona struttura"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_struttura from picturebutton within tabpage_inserimento
integer x = 3634
integer y = 64
integer width = 183
integer height = 144
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
boolean originalsize = true
string picturename = "where.bmp"
end type

event clicked;uint lu_livello_old

s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s.ab_abilitaincolla= true
s_assegnastruttura_s.ai_maxlivello= gi_maxlivello		
s_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello - 1
s_assegnastruttura_s.as_ambito= gs_ambito

lu_livello_old= is_struttura_s.livello

openWithParm(w_assegna_struttura, s_assegnastruttura_s )

is_struttura_s= message.powerObjectParm

if is_struttura_s.livello= -1 then return -1

//if ib_query_mode false then
	
	//tab_esami.tabpage_inserimento.uodw_import.uof_ricerca()
	
	//tab_esami.tabpage_inserimento.uodw_import.Object.DataWindow.QueryMode="yes"
	
//end if

//if lu_livello_old > 0 and lu_livello_old <  is_struttura_s.livello then  is_struttura_s.livello= lu_livello_old
//
//tab_esami.tabpage_inserimento.uodw_import.setColumn(1)
//
//tab_esami.tabpage_inserimento.uodw_import.setText(is_struttura_s.vc_nodo) 

tab_esami.tabpage_inserimento.cb_estrazione.enabled= true
end event

type cb_importa from commandbutton within tabpage_inserimento
integer x = 3538
integer y = 360
integer width = 343
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Genera lista"
end type

event clicked;w_esami_tab.event importa()
end event

type cb_estrazione from commandbutton within tabpage_inserimento
integer x = 3931
integer y = 80
integer width = 343
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Estrazione"
end type

event clicked;uodw_import.setTransObject(sqlca)

if is_struttura_s.vc_nodo= "" then
	
	messageBox(parent.text, "Selezionare la struttura utilizzando il bottone 'Seleziona struttura'")
	return -1
	
end if

open(w_wait_snoopy_writing)

uodw_import.setRedraw(false)

if uodw_import.retrieve(is_liv, idt_data_cerimonia_soglia, idt_data_ultimo_esame, ii_livello_resp_soglia, is_a_g, is_evento_s.tipo_evento,  is_struttura_s.vc_nodo, 1) >0 then
	cb_importa.enabled= true
	cb_reset.enabled= true
else
	cb_importa.enabled= false
	cb_reset.enabled= false
end if

//if 	uodw_import.ib_queryMode= true then
//	this.text= "Estrazione"
//	pb_struttura.enabled= true
//else
//	this.text= "Ricerca"
//	pb_struttura.enabled= false
//end if

uodw_import.setRedraw(true)

close(w_wait_snoopy_writing)

uodw_import.setFocus()

end event

type gb_criteri from groupbox within tabpage_inserimento
integer y = 8
integer width = 3506
integer height = 456
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 81324524
end type

type tabpage_lista from userobject within tab_esami
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5202
integer height = 2244
boolean enabled = false
long backcolor = 81324524
string text = "Lista esami"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
uodw_lista uodw_lista
end type

on tabpage_lista.create
this.uodw_lista=create uodw_lista
this.Control[]={this.uodw_lista}
end on

on tabpage_lista.destroy
destroy(this.uodw_lista)
end on

type uodw_lista from uodw_generica within tabpage_lista
integer width = 5189
integer height = 1116
integer taborder = 90
string dataobject = "dw_lista"
boolean ib_isgrid = true
boolean ib_stampatoda = true
end type

event buttonclicked;call super::buttonclicked;decimal ld_id
long ll_totale

integer li_livello, li_num
long ll_idx, ll_rowCount
string ls_nodo


choose case dwo.name
		
	case "b_messaggi"
		
		s_lista s_lista_s
		s_reportpath ls_reportpath_s
		
		if uodw_lista.rowCount() = 0 then
			messageBox(this.title, "Nessun record estratto: la lista non può essere generata.", information!)
			return 0
		end if
		
		ls_reportpath_s.as_reportname= uodw_lista.dataObject
//		ls_reportpath_s.as_path= is_assegnastruttura_s.as_reportpath
		//ls_reportpath_s.aw_parentwindow= parentWindow()
		
		openWithParm(w_liste_auto_tipo, uodw_lista.dataObject)
		
		s_lista_s= message.powerObjectParm
		
		if s_lista_s.idx= 0 then return -1
		
		openWithParm(w_liste_auto_tab, s_lista_s)
		
		return 0//close(this)		
		
	case "b_sposta" 
	
	if this.modifiedCount() > 0 then
		
		if messageBox(parent.text, "Sono state eseguite delle modifiche, bisogna salvare i dati. Vuoi proseguire?", information!, yesNo!)= 2 then return -1
	
		if this.uof_aggiorna() < 0 then
			
			open(w_message_negative)
			
			return -1
			
		else
			
			open(w_message)
			
		end if
	
	end if
	
		openWithParm(w_sposta_sede_esame, is_evento_s)
		
		ld_id= message.doubleParm
		
		if isNull(ld_id) OR ld_id<= 0 then return -1
			
		string ls_codice
		
		ls_codice= this.getItemString(row, "codice")
		
		update esami set id= :ld_id where codice= :ls_codice;
		if trap_sql(sqlca, "SPOSTASESS01") < 0 then goto errore
	
		commit;
		if trap_sql(sqlca, "SPOSTASESS02") < 0 then goto errore
		
		open(w_message)
		
		this.retrieve(is_evento_s.id)
		
		return 0
	
	errore:
	
		rollback;
		
		open(w_message_negative)
		
		return -1

	case "b_raggruppa"
		
		ld_id= dw_header.getItemDecimal(dw_header.getRow(), "id")		
		
		select livello_master
		into :li_livello
		from esami_raggruppamento
		where id= :ld_id;
		if trap_sql(sqlca, "RAGGRUPPA01") < 0 then goto errore	
		
		if li_livello= 0 or isNull(li_livello) then li_livello= is_struttura_s.livello
		
		openWithParm(w_selezione_livello, li_livello -1)
		
		 li_livello= message.doubleParm
		
		if  li_livello= 0 then return -1
		
		this.setRedraw(false)
		
		ll_rowCount= this.rowCount()
		
		setPointer(hourGlass!)
		
			for ll_idx= 1 to ll_rowCount
				
				ls_nodo= this.getItemString(ll_idx, "vc_parent")
				
				ls_nodo= f_parse_struttura_left(ls_nodo, li_livello)
				
				this.setItem(ll_idx, "raggruppamento", ls_nodo)
				this.setItem(ll_idx, "livello", li_livello)	
				
			next
			
		setPointer(arrow!)			
		
		update esami_raggruppamento
		set livello= :li_livello, vc_nodo= :ls_nodo
		where id= :ld_id;
		if trap_sql(sqlca, "RAGGRUPPA02") < 0 then goto errore		
		
		commit;
		
		this.sort()
		
		this.groupCalc()
		
		wf_rinumera(this)
		
		this.ResetUpdate()		
		
		this.setRedraw(true)
		
	case "b_annullaraggruppa"
		
		ld_id= dw_header.getItemDecimal(dw_header.getRow(), "id")		
		
		li_livello= 0
		
		this.setRedraw(false)
		
		ll_rowCount= this.rowCount()
		
		setPointer(hourGlass!)
		
			for ll_idx= 1 to ll_rowCount
				
				this.setItem(ll_idx, "raggruppamento", "")
				this.setItem(ll_idx, "livello", li_livello)	
				
			next
			
		setPointer(arrow!)		
		
		update esami_raggruppamento
		set livello= :li_livello, vc_nodo= :ls_nodo
		where id= :ld_id;
		if trap_sql(sqlca, "RAGGRUPPA02") < 0 then goto errore		
		
		commit;
		
		this.sort()
		
		this.groupCalc()
		
		wf_rinumera(this)
		
		this.ResetUpdate()		
		
		this.setRedraw(true)		
		
	case "b_cancella" 
		
		if messageBox(parent.text,"Hai richiesto la cancellazione della lista. Confermi?", question!, yesNo!, 2)= 2 then return 0
		
		select count(*)
		into :ll_totale
		from esami
		where id= 	:is_evento_s.id and
						voto > 0;
				
		if trap_sql(sqlca, "COUNTESAMI01") < 0 then return -1
		
		if ll_totale > 0 then
			
			messageBox(parent.text, "Sono già state attribuite delle votazioni. Per cancellare la lista occorre azzerare i voti.", exclamation!)
			
			return 0
			
		end if
	
		delete from esami where id= :is_evento_s.id;
		
		if trap_sql(sqlca, "DELETE_ESAMI01") < 0 then
			rollback;
		else
			commit;
				if trap_sql(sqlca, "DELETE_ESAMI02") < 0 then
					messageBox(tab_esami.tabpage_lista.text, "Salvataggio fallito", exclamation!)
					return -1
				end if
			uodw_lista.reset()
			tab_esami.tabpage_inserimento.uodw_import.reset()
			tab_esami.tabpage_lista.enabled= false
			tab_esami.tabpage_esito.enabled= false
			tab_esami.selectTab(tab_esami.tabpage_inserimento)
			tab_esami.tabpage_inserimento.enabled= true
			
			 is_struttura_s.livello= 0
			
			tab_esami.tabpage_inserimento.cb_estrazione.enabled= true
			tab_esami.tabpage_inserimento.pb_struttura.enabled= true
			tab_esami.tabpage_inserimento.cb_estrazione.event clicked()
			
		end if
	
end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_lista

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_ordina.visible= false
im_preview.m_inserisci.visible= false
im_preview.m_esporta.visible= false


im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event itemchanged;call super::itemchanged;//if dwo.name= "csort" then
//	
//	if data= '1' then
//		
//		this.setSort("cognome, nome")
//		
//	else
//		
//		this.setSort("vc_parent")	
//		
//	end if
//	
//	this.sort()
//	
//	this.groupCalc()
//
//end if
end event

event retrieveend;call super::retrieveend;//this.sort()
//
//this.groupCalc()
//
//wf_rinumera(this)
end event

type tabpage_esito from userobject within tab_esami
integer x = 18
integer y = 100
integer width = 5202
integer height = 2244
boolean enabled = false
long backcolor = 81324524
string text = "Esito"
long tabtextcolor = 8388736
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
cbx_nascondi cbx_nascondi
pb_ricerca pb_ricerca
st_3 st_3
st_min st_min
uodw_esito uodw_esito
cb_soglia cb_soglia
cb_aggiorna cb_aggiorna
cbx_aggiorna cbx_aggiorna
em_da em_da
em_a em_a
cb_filtra cb_filtra
cb_annulla cb_annulla
rb_presenti rb_presenti
rb_tutti rb_tutti
rb_respinti rb_respinti
rb_promossi rb_promossi
rb_assenti rb_assenti
gb_filtra gb_filtra
gb_1 gb_1
gb_2 gb_2
end type

on tabpage_esito.create
this.cbx_nascondi=create cbx_nascondi
this.pb_ricerca=create pb_ricerca
this.st_3=create st_3
this.st_min=create st_min
this.uodw_esito=create uodw_esito
this.cb_soglia=create cb_soglia
this.cb_aggiorna=create cb_aggiorna
this.cbx_aggiorna=create cbx_aggiorna
this.em_da=create em_da
this.em_a=create em_a
this.cb_filtra=create cb_filtra
this.cb_annulla=create cb_annulla
this.rb_presenti=create rb_presenti
this.rb_tutti=create rb_tutti
this.rb_respinti=create rb_respinti
this.rb_promossi=create rb_promossi
this.rb_assenti=create rb_assenti
this.gb_filtra=create gb_filtra
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cbx_nascondi,&
this.pb_ricerca,&
this.st_3,&
this.st_min,&
this.uodw_esito,&
this.cb_soglia,&
this.cb_aggiorna,&
this.cbx_aggiorna,&
this.em_da,&
this.em_a,&
this.cb_filtra,&
this.cb_annulla,&
this.rb_presenti,&
this.rb_tutti,&
this.rb_respinti,&
this.rb_promossi,&
this.rb_assenti,&
this.gb_filtra,&
this.gb_1,&
this.gb_2}
end on

on tabpage_esito.destroy
destroy(this.cbx_nascondi)
destroy(this.pb_ricerca)
destroy(this.st_3)
destroy(this.st_min)
destroy(this.uodw_esito)
destroy(this.cb_soglia)
destroy(this.cb_aggiorna)
destroy(this.cbx_aggiorna)
destroy(this.em_da)
destroy(this.em_a)
destroy(this.cb_filtra)
destroy(this.cb_annulla)
destroy(this.rb_presenti)
destroy(this.rb_tutti)
destroy(this.rb_respinti)
destroy(this.rb_promossi)
destroy(this.rb_assenti)
destroy(this.gb_filtra)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type cbx_nascondi from checkbox within tabpage_esito
integer x = 4302
integer y = 1112
integer width = 567
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Nascondi colonna voti"
boolean lefttext = true
end type

event clicked;if this.checked= true then 
	uodw_esito.Modify("voto_t.Visible=0")
	uodw_esito.Modify("voto.Visible=0")
else
	uodw_esito.Modify("voto_t.Visible=1")
	uodw_esito.Modify("voto.Visible=1")
end if
end event

type pb_ricerca from picturebutton within tabpage_esito
integer x = 4288
integer y = 1240
integer width = 581
integer height = 172
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricerca una persona tra tutte le sedi di esame"
vtextalign vtextalign = multiline!
string powertiptext = "Esegue una ricerca tra tutte le sedi di esame di una persona allo scopo di individuare la sede in cui è in lista ed eventualmente trasferirla"
long textcolor = 16777215
long backcolor = 8388608
end type

event clicked;if dw_header.rowCount() > 0  then
	
	uodw_esito.acceptText()
	
	if uodw_esito.modifiedCount() > 0 then
		messageBox(parent.text, "Prima di eseguire la ricerca occorre aggiornare i dati.", information!)
		return 0
	end if
	
	if messageBox(parent.text, "Per eseguire una ricerca occorre prima chiudere la visualizzazione relativa alla sede corrente. Vuoi proseguire?", Question!, yesNo!, 1)= 2 then return 0
	
end if

dw_header.reset()

uodw_esito.reset()

//cb_soglia.enabled= false

s_ricerca s_ricercanominativa_s

openWithParm(w_ricercanominativasmall, is_evento_s)

s_ricercanominativa_s= message.powerObjectParm

if s_ricercanominativa_s.i_retcode= -1 then return -1

 is_evento_s.id= s_ricercanominativa_s.id

dw_header.retrieve( is_evento_s.id)

	tab_esami.tabpage_inserimento.enabled= false
	tab_esami.tabpage_lista.enabled= true
	tab_esami.tabpage_esito.enabled= true
	tab_esami.selectTab(tab_esami.tabpage_esito)
	
	long ll_found
	string ls_find
	
	ls_find= "codice='"+string(s_ricercanominativa_s.codice)+"'"
	
	ll_found = uodw_esito.Find(ls_find,  1, uodw_esito.RowCount() )
	
	uodw_esito.scrollToRow(ll_found)
	uodw_esito.setColumn("voto")
	uodw_esito.setFocus()

uodw_esito.selectText(1, len(uodw_esito.getText()) )













end event

type st_3 from statictext within tabpage_esito
integer x = 4567
integer y = 692
integer width = 265
integer height = 132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "a (max=100)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_min from statictext within tabpage_esito
integer x = 4343
integer y = 692
integer width = 178
integer height = 132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 81324524
string text = "da (min=1)"
alignment alignment = center!
boolean focusrectangle = false
end type

type uodw_esito from uodw_generica within tabpage_esito
integer width = 4256
integer taborder = 20
string dataobject = "d_esiti"
boolean ib_allowrowselection = true
end type

event rowfocuschanged;// non esegue la script ancestor

end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_esito

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_ordina.visible= true
im_preview.m_ordina.enabled= true
im_preview.m_inserisci.visible= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event retrieveend;call super::retrieveend;em_da.text= "0"
em_a.text= "0"
end event

event itemchanged;// non esegue la script ancestor

if dwo.name= "voto" then
	if integer(data) > 250 or integer(data) < 0 then return 1
	this.object.b_aggiorna.visible= '1'
end if

if dwo.name= "note" then this.object.b_aggiorna.visible= '1'
end event

event buttonclicked;call super::buttonclicked;decimal ld_id
string ls_codice

if dwo.name=  "b_sposta" then
	
	if this.modifiedCount() > 0 then
		
		if messageBox(parent.text, "Sono state eseguite delle modifiche, prima di proseguire verranno aggiornati i dati.", information!, okCancel!)= 2 then return -1
	
		if this.uof_aggiorna() < 0 then
			
			open(w_message_negative)
			
			return -1
			
		else
			
			open(w_message)
			
		end if
	
	end if
	
	//messageBox("test", string(is_evento_s.id)+"-"+string(is_evento_s.tipo_evento), information!)
	
		openWithParm(w_sposta_sede_esame, is_evento_s)
		
		ld_id= message.doubleParm
		
		if isNull(ld_id) OR ld_id<= 0 then return -1
				
		ls_codice= this.getItemString(row, "codice")
		
		update esami set id= :ld_id where codice= :ls_codice;
		if trap_sql(sqlca, "SPOSTASEDE01") < 0 then goto errore
	
		commit;
		if trap_sql(sqlca, "SPOSTASEDE02") < 0 then goto errore
		
		open(w_message)
		
		this.retrieve(is_evento_s.id)
		
		//tab_esami.event selectionchanging(2, 3)
		
		tab_esami.tabpage_esito.uodw_esito.sort()
		
		tab_esami.tabpage_esito.uodw_esito.groupCalc()
		
		return 0
	
	errore:
	
		rollback;
		
		open(w_message_negative)
		
		return -1
		
	end if

end event

type cb_soglia from commandbutton within tabpage_esito
integer x = 4306
integer y = 1552
integer width = 539
integer height = 220
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Applica voto minimo"
end type

event clicked;s_soglia s_soglia_s
integer li_soglia

uodw_esito.Modify("voto_t.Visible=1")
uodw_esito.Modify("voto.Visible=1")

//openWithParm(w_limite_tab, is_evento_s.id)
//
//li_soglia= message.doubleParm
//
//if  li_soglia= 0 then return 0
// 
//if messageBox(parent.text, "Confermi "+string(li_soglia) +" come valore del voto minimo inserito?", question!, yesNo!, 2)= 2 then return 0

select voto_minimo
into :li_soglia
from esami_sessioni, eventi
where eventi.id= :is_evento_s.id and
		esami_sessioni.id= eventi.id_esami_sessioni;
			
if trap_sql(sqlca, "VOTOMINIMO00") < 0 then return -1		

if li_soglia= 0 or isNull(li_soglia) then
	messageBox(parent.text, "Il voto minimo non è stato ancora definito.")
	return 0
end if

update esami set soglia= :li_soglia
where id=  :is_evento_s.id;
if trap_sql(sqlca, "VOTOMINIMO01") < 0 then return -1

commit;
if trap_sql(sqlca, "VOTOMINIMO02") < 0 then
	rollback;
	return -1
end if

tab_esami.selectTab(3)		

return 0
		


end event

type cb_aggiorna from commandbutton within tabpage_esito
integer x = 4306
integer y = 1904
integer width = 539
integer height = 220
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Aggiorna lo storico"
end type

event clicked;integer li_voto, li_soglia, li_ret, li_count
long ll_idx
string ls_codice, ls_esito, ls_livello, ls_nome
datetime ldt_data

open(w_check_pw)
	
li_ret= message.doubleParm

if li_ret <> 1 then return 0


this.enabled= false
cbx_aggiorna.checked= false

// rende di nuovo visibile la colonna voti...
uodw_esito.Modify("voto_t.Visible=1")
uodw_esito.Modify("voto.Visible=1")

// toglie i filtri...
uodw_esito.setFilter("")
uodw_esito.filter()

uodw_esito.acceptText()

// se manca un voto avverte e ferma la procedura...
for ll_idx= 1 to uodw_esito.rowCount()
	
	ls_esito= uodw_esito.getItemString(ll_idx, "esito")
	
	if ls_esito= "" or isNull(ls_esito) then
		messageBox(parent.text, "Occorre inserire l'esito dell'esame per questo candidato.", information!)
		uodw_esito.scrollToRow(ll_idx)
		return -1
	end if
	
next

// se non sono stati salvati i voti effettua in aggiornamento...

if uodw_esito.ModifiedCount() > 0 then
	
	messageBox("Aggiornamento", "Sono stati modificati dei voti, verrà effettuato un salvataggio", information!, Ok!)
		
	if uodw_esito.uof_aggiorna() < 0 then goto sqlerror
	
end if

ls_livello= "0"+string(is_evento_s.tipo_evento)

is_evento_s.descrizione= "Sede: "+is_evento_s.descrizione

li_ret= messageBox("Aggiornamento", "Verranno aggiornati i dati in anagrafica e nello storico esami e verranno cancellati i dati relativi a questo evento: vuoi proseguire?", question!, OkCancel!, 1)

if li_ret = 2 then return -1 // annulla l'aggiornamento dello storico...

open(w_wait_meter)


// cicla sui partecipanti all'esame...
for ll_idx= 1 to uodw_esito.rowCount()
	
	ls_codice= uodw_esito.getItemString(ll_idx, "codice")
//	ldt_data= uodw_esito.getItemDateTime(ll_idx, "data_evento")
	li_voto= uodw_esito.getItemNumber(ll_idx, "voto")
	li_soglia= uodw_esito.getItemNumber(ll_idx, "soglia")
	
	if li_voto= 0 then
		
		ls_esito= 'A'
		
	else
	
		choose case li_voto - li_soglia
				
			case is >= 0
				
				ls_esito= 'P'
				
			case is < 0
				
				ls_esito= 'R'
				
		end choose
		
	end if
	
	// se promosso effettua l'aggiornamento del dato in tabella membri...
	if ls_esito = "P" then
	
		update membri_gerarchica
		set cod_studio= :ls_livello
		where codice= :ls_codice;
		if trap_sql(sqlca, "UPDATESTUDIO01") < 0 then goto sqlerror
		
	end if
	
	/* se esiste già un record in esami_curr esegue un'update altrimenti esegue una insert */
	
		 select count(*)
		 into :li_ret
		 from esami_curr
		 where
		 codice= :ls_codice and
		 cod_studio= :ls_livello and
		data_esame=  :idt_data_diploma;
		//and esito= 'I';
		 if trap_sql(sqlca, "UPDATESTUDIO02") < 0 then goto sqlerror
		 
		 if isNull(li_ret) then li_ret= 0
		 
		 if li_ret > 0 then
			
				update esami_curr
			 	set 	esito= :ls_esito,
				 		voto= :li_voto,
						soglia= :li_soglia,
						note= :is_evento_s.descrizione
				where
					 codice= :ls_codice and
					 cod_studio= :ls_livello and
					 data_esame=  :idt_data_diploma;
					 
					 //and esito= 'I';		  
					 
				if trap_sql(sqlca, "UPDATESTUDIO03") < 0 then
				
						select cognome+" "+nome
						into :ls_nome
						from membri_gerarchica
						where codice= :ls_codice;
						
						messageBox(parent.text, "Errore in aggiornamento dello storico esami dei dati di: "+ls_nome, exclamation!)
						goto sqlerror
					
					end if
		else
			
				 insert into esami_curr  
					( codice,   
					  cod_studio,   
					  data_esame,   
					  esito,
					  voto,
					  soglia,
					  note)  
				values ( :ls_codice,   
							:ls_livello,   
							:idt_data_diploma,   
							:ls_esito,
							:li_voto,
							:li_soglia,
							:is_evento_s.descrizione) ;
						  
					if trap_sql(sqlca, "UPDATESTUDIO04") < 0 then
				
						select cognome+" "+nome
						into :ls_nome
						from membri_gerarchica
						where codice= :ls_codice;
						
						messageBox(parent.text, "Errore in inserimento nello storico esami dei dati di: "+ls_nome, exclamation!)
						goto sqlerror
					
					end if
			
		end if
		
		// progress bar che scorre a scatti di 100 (ad evitare di appesantire con aggiornamento troppo frequente) o in modo continuo...
		if uodw_esito.rowCount() > 1000 then
		
			li_count++
			
			if li_count = 100 then
				
				w_wait_meter.hpb_meter.position= (ll_idx/uodw_esito.rowCount() ) * 100
				
				li_count= 0
				
			end if
			
		else
			
				w_wait_meter.hpb_meter.position= (ll_idx/uodw_esito.rowCount() ) * 100
			
		end if
	
next

//delete from esami where id= :is_evento_s.id;
//if trap_sql(sqlca, "UPDATESTUDIO03") < 0 then goto sqlerror

delete from eventi where id= :is_evento_s.id; // cancella in cascata la tabella esami ed esami_raggruppamento...
if trap_sql(sqlca, "UPDATESTUDIO05") < 0 then goto sqlerror

commit;
if trap_sql(sqlca, "UPDATESTUDIO06") < 0 then goto sqlerror

uodw_esito.reset()
tab_esami.tabpage_lista.uodw_lista.reset()

close(w_wait_meter)

open(w_message)

if isValid(w_eventi) then w_eventi.event ue_oggi()

return 0

sqlerror:

close(w_wait_meter)

rollback;
trap_sql(sqlca, "UPDATESTUDIO07")

return -1
end event

type cbx_aggiorna from checkbox within tabpage_esito
integer x = 4283
integer y = 1804
integer width = 567
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 81324524
string text = "Abilita l~'aggiornamento"
boolean lefttext = true
end type

event clicked;if this.checked= true then
	
	decimal ld_id_esami_sessioni
	integer li_soglia, li_voto_minimo
	
	uodw_esito.acceptText()
	
		// controllo sulle votazioni, se tutto è a 0 tutti i partecipanti risulteranno assenti...

		if uodw_esito.getItemNumber(uodw_esito.getRow(), "ctotvoto")= 0 then
			
			if messageBox(parent.text, "Tutti i voti sono uguali a 0. I candidati risulteranno tutti assenti.~nVuoi proseguire?", question!, yesNo!, 2) = 2 then
				this.checked= false
				return 0
			else // ...proseguo...
				this.enabled= false
				this.checked= true
			end if
			
		end if
		
	// controlla che il voto minimo nel frattempo non sia stato cambiato a livello di sessione di esame, nel caso l'operatore dovrà rieseguire l'assegnazione del voto minimo...	
		
	li_soglia= uodw_esito.getItemNumber(1, "soglia")

	if li_soglia > 0 then // se il voto minimo è stato inserito...
		
		ld_id_esami_sessioni= uodw_esito.getItemDecimal(1, "id_esami_sessioni")
		
		select voto_minimo
		into :li_voto_minimo
		from esami_sessioni
		where id= :ld_id_esami_sessioni;
		
		if trap_sql(sqlca, "ABILITAAGGIORNAMENTO01") < 0 then return 0
		
		if li_voto_minimo <> li_soglia then // se i due voti sono diversi...
			
			messageBox(parent.text, "Il voto minimo è stato modificato. ~nRieseguire la procedura di applicazione del voto minimo cliccando sul tasto 'APPLICA voto minimo'") 
			
			this.checked= false
	
			return 0
			
		end if		
		
		cb_aggiorna.enabled= true
		
	else // Il voto minimo non è stato inserito...
		
			messageBox(parent.text, "Non è stato inserito il voto minimo.", information!)
			
			this.checked= false	
			
			return 0
		
	end if
	
else
	
		cb_aggiorna.enabled= false	
		
end if

return 0
end event

type em_da from editmask within tabpage_esito
integer x = 4343
integer y = 596
integer width = 178
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
string minmax = "1~~100"
end type

event getfocus;this.selectText(1, 3 )
end event

type em_a from editmask within tabpage_esito
integer x = 4603
integer y = 596
integer width = 178
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
string minmax = "0~~100"
end type

event getfocus;this.selectText(1, 3 )
end event

type cb_filtra from commandbutton within tabpage_esito
integer x = 4407
integer y = 848
integer width = 343
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Filtra"
end type

event clicked;string ls_filtra

cb_annulla.triggerEvent(clicked!)

if uodw_esito.rowCount() <= 0 then
	messageBox(parent.text, "Selezionare una sessione di esame", information!)
	return
end if

if (integer(em_da.text) > integer(em_a.text)) OR  (integer(em_a.text) < integer(em_da.text)) then
	messageBox(parent.text, "Inserire i valori nell'ordine corretto (es. da 50 a 60", exclamation!)
	return
end if

if em_da.text= "0" and em_a.text= "0" then
	
	ls_filtra= ""
	
else

	ls_filtra= "voto >= "+em_da.text+" and voto <= "+em_a.text
	
end if

uodw_esito.setFilter(ls_filtra)

uodw_esito.filter()
end event

type cb_annulla from commandbutton within tabpage_esito
integer x = 4407
integer y = 964
integer width = 343
integer height = 112
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla filtro"
end type

event clicked;//if uodw_esito.rowCount() <= 0 then
//	messageBox(parent.text, "Selezionare una sessione di esame", information!)
//	return
//end if

uodw_esito.setFilter("")

uodw_esito.filter()
end event

type rb_presenti from radiobutton within tabpage_esito
integer x = 4366
integer y = 76
integer width = 398
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Solo presenti"
end type

event clicked;uodw_esito.setFilter("cvoto = 1")
uodw_esito.filter()
end event

type rb_tutti from radiobutton within tabpage_esito
integer x = 4366
integer y = 428
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Tutti"
boolean checked = true
end type

event clicked;uodw_esito.setFilter("")
uodw_esito.filter()
end event

type rb_respinti from radiobutton within tabpage_esito
integer x = 4366
integer y = 340
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Solo respinti"
end type

event clicked;uodw_esito.setFilter("voto < soglia and voto > 0")
uodw_esito.filter()
end event

type rb_promossi from radiobutton within tabpage_esito
integer x = 4366
integer y = 252
integer width = 453
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Solo promossi"
end type

event clicked;uodw_esito.setFilter("voto >= soglia")
uodw_esito.filter()
end event

type rb_assenti from radiobutton within tabpage_esito
integer x = 4366
integer y = 164
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Solo assenti"
end type

event clicked;uodw_esito.setFilter("voto= 0 or isNull(voto)")
uodw_esito.filter()
end event

type gb_filtra from groupbox within tabpage_esito
integer x = 4274
integer y = 524
integer width = 613
integer height = 680
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Filtra voti"
end type

type gb_1 from groupbox within tabpage_esito
integer x = 4279
integer y = 1496
integer width = 613
integer height = 676
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Fase conclusiva"
end type

type gb_2 from groupbox within tabpage_esito
integer x = 4279
integer y = 16
integer width = 613
integer height = 492
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Visualizza"
end type

type dw_header from uodw_header within w_esami_tab
integer x = 18
integer width = 5202
integer height = 368
integer taborder = 10
end type

