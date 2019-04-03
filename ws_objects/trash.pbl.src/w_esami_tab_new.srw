$PBExportHeader$w_esami_tab_new.srw
forward
global type w_esami_tab_new from window
end type
type dw_header from uodw_header within w_esami_tab_new
end type
type tab_esami from tab within w_esami_tab_new
end type
type tabpage_inserimento from userobject within tab_esami
end type
type st_2 from statictext within tabpage_inserimento
end type
type em_filtra_datacerimonia from editmask within tabpage_inserimento
end type
type em_filtra_dataesame from editmask within tabpage_inserimento
end type
type uodw_import from uodw_generica within tabpage_inserimento
end type
type cbx_filtra_datacerimonia from checkbox within tabpage_inserimento
end type
type cbx_filtra_dataesame from checkbox within tabpage_inserimento
end type
type st_1 from statictext within tabpage_inserimento
end type
type pb_struttura from picturebutton within tabpage_inserimento
end type
type cb_importa from commandbutton within tabpage_inserimento
end type
type cb_annullafiltrodata from commandbutton within tabpage_inserimento
end type
type cb_estrazione from commandbutton within tabpage_inserimento
end type
type gb_criteri from groupbox within tabpage_inserimento
end type
type cb_filtradata from commandbutton within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_esami
st_2 st_2
em_filtra_datacerimonia em_filtra_datacerimonia
em_filtra_dataesame em_filtra_dataesame
uodw_import uodw_import
cbx_filtra_datacerimonia cbx_filtra_datacerimonia
cbx_filtra_dataesame cbx_filtra_dataesame
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltrodata cb_annullafiltrodata
cb_estrazione cb_estrazione
gb_criteri gb_criteri
cb_filtradata cb_filtradata
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
type st_3 from statictext within tabpage_esito
end type
type st_min from statictext within tabpage_esito
end type
type uodw_esito from uodw_generica within tabpage_esito
end type
type cb_ricerca from commandbutton within tabpage_esito
end type
type cb_soglia from commandbutton within tabpage_esito
end type
type cb_aggiorna from commandbutton within tabpage_esito
end type
type cbx_aggiorna from checkbox within tabpage_esito
end type
type cb_media from commandbutton within tabpage_esito
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
st_3 st_3
st_min st_min
uodw_esito uodw_esito
cb_ricerca cb_ricerca
cb_soglia cb_soglia
cb_aggiorna cb_aggiorna
cbx_aggiorna cbx_aggiorna
cb_media cb_media
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
type tab_esami from tab within w_esami_tab_new
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_esito tabpage_esito
end type
type s_cons from structure within w_esami_tab_new
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

global type w_esami_tab_new from window
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
dw_header dw_header
tab_esami tab_esami
end type
global w_esami_tab_new w_esami_tab_new

type variables
 boolean ib_oktoggle
 
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status

DataWindowChild idwc_liv, idwc_luoghi

m_preview im_preview

s_evento is_evento_s
s_struttura is_struttura_s

end variables

forward prototypes
public subroutine wf_rinumera (datawindow adw_arg)
end prototypes

event type integer ue_open();long ll_row

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

idwc_luoghi.retrieve(gs_dip_operativa)

ll_row= dw_header.retrieve(is_evento_s.id)

is_liv = "0"+string(is_evento_s.tipo_evento - 1)

if is_liv= '00' then
	
	tab_esami.tabpage_inserimento.cbx_filtra_dataesame.visible= false
	tab_esami.tabpage_inserimento.em_filtra_dataesame.visible= false
	
end if

//tab_esami.tabpage_lista.uodw_lista.setTransObject(sqlca)
//
//ll_row= tab_esami.tabpage_lista.uodw_lista.retrieve(is_evento_s.id)
//	
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

event importa();integer li_adesione, li_sqlcode, li_ret
long ll_rows, ll_count, ll_row

ds_lista = create uo_ds_gen
ds_lista.DataObject = "ds_lista"
ds_lista.SetTransObject ( sqlca )

open(w_wait_snoopy)

for ll_count = 1 to tab_esami.tabpage_inserimento.uodw_import.RowCount ()
	
		li_adesione= tab_esami.tabpage_inserimento.uodw_import.GetItemNumber ( ll_count, "flag_adesione" )
		
		if li_adesione <> 1 then li_adesione= 0
	
		ll_row= ds_lista.InsertRow ( 0 )
		
		ds_lista.SetItem ( ll_row, "id", is_evento_s.id )
		ds_lista.SetItem ( ll_row, "codice", tab_esami.tabpage_inserimento.uodw_import.GetItemString ( ll_count, "codice" ) )
		ds_lista.SetItem ( ll_row, "cod_studio", is_liv )
		ds_lista.SetItem ( ll_row, "esito", "A" )
		ds_lista.SetItem ( ll_row, "flag_ok", string(li_adesione) )
		ds_lista.SetItem(ll_row, "raggruppamento", is_struttura_s.vc_nodo)
		ds_lista.SetItem(ll_row, "livello", is_struttura_s.livello)		
	
next

delete 
from  esami_raggruppamento
where id= :is_evento_s.id;

if trap_sql(sqlca, "INSLISTA00") < 0 then return

insert into esami_raggruppamento
(id, livello_master, vc_nodo_master, livello, vc_nodo)
values ( :is_evento_s.id, :is_struttura_s.livello, : is_struttura_s.vc_nodo, :is_struttura_s.livello, :is_struttura_s.vc_nodo);

if trap_sql(sqlca, "INSLISTA01") < 0 then return

li_sqlcode= sqlca.sqlcode

li_ret= ds_lista.Update()

close(w_wait_snoopy)

if li_ret = -1 OR li_sqlcode < 0 then
	
	rollback;
	destroy ds_lista
	OpenWithParm ( w_msg, "Importazione annullata: SQLCODE= "+string(li_sqlcode ) )
	
	return
	
end if

commit;
destroy ds_lista
OpenWithParm ( w_msg, "Importazione effettuata" )	


tab_esami.tabpage_lista.uodw_lista.SetRedraw ( false )
tab_esami.tabpage_lista.uodw_lista.setTransObject(sqlca)
tab_esami.tabpage_lista.uodw_lista.Retrieve ( is_evento_s.id )
//tab_esami.tabpage_lista.dw_lista.Object.DataWindow.Print.Preview= 'yes'
tab_esami.tabpage_lista.uodw_lista.SetRedraw ( true )

//cb_estrai.text = "Aggiorna lista"
//cb_save.enabled = false
//cb_annulla.text = "Cancella lista"
//cb_annulla.enabled = true
//

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

on w_esami_tab_new.create
this.dw_header=create dw_header
this.tab_esami=create tab_esami
this.Control[]={this.dw_header,&
this.tab_esami}
end on

on w_esami_tab_new.destroy
destroy(this.dw_header)
destroy(this.tab_esami)
end on

event open;is_evento_s= message.powerObjectParm

PostEvent ( "ue_open" )

end event

event closequery;tab_esami.tabpage_lista.uodw_lista.acceptText()

if tab_esami.tabpage_lista.uodw_lista.modifiedCount() > 0 then
	if messageBox(this.title, "Liste esami: sono stati aggiornati dei dati. Vuoi salvare le modifiche?", question!, yesNo!, 1)= 1 then
		if tab_esami.tabpage_lista.uodw_lista.update()> 0 then
			commit;
			if trap_sql(sqlca, "COMMITLISTAESAMI") < 0 then goto errore
		else
			goto errore
		end if
	end if
end if

if tab_esami.tabpage_lista.uodw_lista.modifiedCount() > 0 then
	if messageBox(this.title, "Esiti esami: sono stati aggiornati dei dati. Vuoi salvare le modifiche?", question!, yesNo!, 1)= 1 then
		if tab_esami.tabpage_esito.uodw_esito.update()> 0 then
			commit;
			if trap_sql(sqlca, "COMMITESITIESAMI") < 0 then goto errore
		else
			goto errore
		end if
	end if
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

type dw_header from uodw_header within w_esami_tab_new
integer x = 18
integer width = 4434
integer height = 368
integer taborder = 10
end type

type tab_esami from tab within w_esami_tab_new
event create ( )
event destroy ( )
integer x = 23
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
long ll_idx
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
		tab_esami.tabpage_lista.uodw_lista.Retrieve ( is_evento_s.id )
//		tab_esami.tabpage_lista.uodw_lista.Object.DataWindow.Print.Preview= 'yes'
//		tab_esami.tabpage_lista.uodw_lista.Object.DataWindow.Print.Buttons = 'yes'

		select livello, vc_nodo
		into :li_livello, :ls_nodo
		from esami_raggruppamento
		where
		id=  :is_evento_s.id;
		
//		select livello_master
//		into :li_livello
//		from esami_raggruppamento
//		where id= :is_evento_s.id;
//		if trap_sql(sqlca, "SELCHANGING01") < 0 then return -1
		
		if li_livello= 0 then li_livello= is_struttura_s.livello
		
		tab_esami.tabpage_lista.uodw_lista.setRedraw(false)
		
		for ll_idx= 1 to tab_esami.tabpage_lista.uodw_lista.rowCount()
			
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
		tab_esami.tabpage_esito.uodw_esito.Retrieve ( is_evento_s.id )
		
		select livello, vc_nodo
		into :li_livello, :ls_nodo
		from esami_raggruppamento
		where
		id=  :is_evento_s.id;
		
		if li_livello= 0 then li_livello= is_struttura_s.livello
		
		tab_esami.tabpage_esito.uodw_esito.setRedraw(false)
		
		for ll_idx= 1 to tab_esami.tabpage_esito.uodw_esito.rowCount()
			
			ls_nodo= tab_esami.tabpage_esito.uodw_esito.getItemString(ll_idx, "vc_parent")
			
			ls_nodo= f_parse_struttura_left(ls_nodo, li_livello)
			
			tab_esami.tabpage_esito.uodw_esito.setItem(ll_idx, "raggruppamento", ls_nodo)
			
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
st_2 st_2
em_filtra_datacerimonia em_filtra_datacerimonia
em_filtra_dataesame em_filtra_dataesame
uodw_import uodw_import
cbx_filtra_datacerimonia cbx_filtra_datacerimonia
cbx_filtra_dataesame cbx_filtra_dataesame
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltrodata cb_annullafiltrodata
cb_estrazione cb_estrazione
gb_criteri gb_criteri
cb_filtradata cb_filtradata
end type

on tabpage_inserimento.create
this.st_2=create st_2
this.em_filtra_datacerimonia=create em_filtra_datacerimonia
this.em_filtra_dataesame=create em_filtra_dataesame
this.uodw_import=create uodw_import
this.cbx_filtra_datacerimonia=create cbx_filtra_datacerimonia
this.cbx_filtra_dataesame=create cbx_filtra_dataesame
this.st_1=create st_1
this.pb_struttura=create pb_struttura
this.cb_importa=create cb_importa
this.cb_annullafiltrodata=create cb_annullafiltrodata
this.cb_estrazione=create cb_estrazione
this.gb_criteri=create gb_criteri
this.cb_filtradata=create cb_filtradata
this.Control[]={this.st_2,&
this.em_filtra_datacerimonia,&
this.em_filtra_dataesame,&
this.uodw_import,&
this.cbx_filtra_datacerimonia,&
this.cbx_filtra_dataesame,&
this.st_1,&
this.pb_struttura,&
this.cb_importa,&
this.cb_annullafiltrodata,&
this.cb_estrazione,&
this.gb_criteri,&
this.cb_filtradata}
end on

on tabpage_inserimento.destroy
destroy(this.st_2)
destroy(this.em_filtra_datacerimonia)
destroy(this.em_filtra_dataesame)
destroy(this.uodw_import)
destroy(this.cbx_filtra_datacerimonia)
destroy(this.cbx_filtra_dataesame)
destroy(this.st_1)
destroy(this.pb_struttura)
destroy(this.cb_importa)
destroy(this.cb_annullafiltrodata)
destroy(this.cb_estrazione)
destroy(this.gb_criteri)
destroy(this.cb_filtradata)
end on

type st_2 from statictext within tabpage_inserimento
integer x = 370
integer y = 396
integer width = 2802
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 81324524
string text = "( Sono compresi nella lista i membri residenti in Italia i membri trasferiti all~'estero e i non appartenenti all~'E.R.)"
boolean disabledlook = true
end type

type em_filtra_datacerimonia from editmask within tabpage_inserimento
integer x = 2103
integer y = 244
integer width = 544
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean autoskip = true
boolean dropdowncalendar = true
end type

type em_filtra_dataesame from editmask within tabpage_inserimento
integer x = 2103
integer y = 116
integer width = 544
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean autoskip = true
boolean dropdowncalendar = true
end type

type uodw_import from uodw_generica within tabpage_inserimento
integer y = 488
integer width = 3950
integer height = 720
integer taborder = 30
string dataobject = "dw_import"
boolean ib_isgrid = true
boolean ib_stampatoda = true
boolean ib_aggiorna = false
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_import

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event retrieveend;call super::retrieveend;cbx_filtra_dataesame.enabled= true
cbx_filtra_datacerimonia.enabled= true

cb_annullafiltrodata.triggerEvent(clicked!)
end event

event retrievestart;call super::retrievestart;cbx_filtra_dataesame.enabled= false
cbx_filtra_datacerimonia.enabled= false
em_filtra_dataesame.enabled= false
em_filtra_datacerimonia.enabled= false
cb_filtradata.enabled= false
cb_annullafiltrodata.enabled= false
end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row (this)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

event sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, uodw_import, false)

if is_liv= '00' then // Nessun esame...

	if(pos(lower(sqlsyntax), "where")) >0 then
		sqlsyntax+= " and membri_gerarchica.cod_dis in ('MEM', 'TFE')  and membri_gerarchica.cod_studio= '"+is_liv+"'"
	else
			sqlsyntax+= " where membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"	
	end if
	
else

	if(pos(lower(sqlsyntax), "where")) >0 then
		sqlsyntax+= " and membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"
	else
			sqlsyntax+= " where membri_gerarchica.cod_dis in ('MEM', 'TFE') and membri_gerarchica.cod_studio= '"+is_liv+"'"
	end if
	
end if

sqlsyntax += " and membri_gerarchica.codice NOT IN  (select codice from esami, eventi where esami.id= eventi.id and eventi.tipo_evento= "+string(is_evento_s.tipo_evento)+" )"
 
SetSqlPreview ( sqlsyntax)


end event

event itemchanged;/* non esegue la script dell'ancestor */

string ls_codice

ls_codice= this.getItemString(row, "codice")

if data= '1' then
	
	this.setItem(row, "data_adesione", today() )
	
	insert into esami_adesione
	(codice, cod_studio, flag_adesione, data_adesione)
	values( :ls_codice, :is_liv, 1, getDate() );
	
	trap_sql(sqlca, "INSERTADESIONE01")
	
else
	
	delete esami_adesione where codice= :ls_codice and cod_studio= :is_liv;
	
	trap_sql(sqlca, "DELETEADESIONE02")	
	
	this.setItem(row, "data_adesione", "" )
	
end if

commit;
if trap_sql(sqlca, "COMMITADESIONE03") < 0 then
	rollback;
end if





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

type cbx_filtra_datacerimonia from checkbox within tabpage_inserimento
integer x = 123
integer y = 268
integer width = 1938
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Escludi le persone che hanno la data cerimonia uguale o superiore al"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;em_filtra_datacerimonia.enabled= this.checked

cb_filtradata.enabled= this.enabled OR cbx_filtra_dataesame.enabled
end event

type cbx_filtra_dataesame from checkbox within tabpage_inserimento
integer x = 123
integer y = 140
integer width = 1938
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "Escludi le persone che hanno sostenuto l~'ultimo esame in data uguale o superiore al"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;em_filtra_dataesame.enabled= this.checked

cb_filtradata.enabled= this.enabled OR cbx_filtra_datacerimonia.enabled
end event

type st_1 from statictext within tabpage_inserimento
integer x = 3561
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
integer x = 3675
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

event clicked;s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s.ab_abilitaincolla= true
s_assegnastruttura_s.ai_maxlivello= gi_maxlivello		
s_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello - 1
s_assegnastruttura_s.as_ambito= gs_ambito

openWithParm(w_assegna_struttura, s_assegnastruttura_s )

is_struttura_s= message.powerObjectParm

if is_struttura_s.livello= -1 then return -1

tab_esami.tabpage_inserimento.uodw_import.setColumn(1)

tab_esami.tabpage_inserimento.uodw_import.setText(is_struttura_s.vc_nodo) 
end event

type cb_importa from commandbutton within tabpage_inserimento
integer x = 3593
integer y = 344
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

type cb_annullafiltrodata from commandbutton within tabpage_inserimento
integer x = 2670
integer y = 244
integer width = 343
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Annulla il filtro"
end type

event clicked;string ls_filtra

ls_filtra= ""

em_filtra_dataesame.enabled= false
em_filtra_datacerimonia.enabled= false

cbx_filtra_dataesame.checked= false
cbx_filtra_datacerimonia.checked= false



uodw_import.setFilter(ls_filtra)

uodw_import.filter()

end event

type cb_estrazione from commandbutton within tabpage_inserimento
integer x = 3593
integer y = 224
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
boolean enabled = false
string text = "Estrazione"
end type

event clicked;cbx_filtra_dataesame.enabled= false
cbx_filtra_datacerimonia.enabled= false

cbx_filtra_dataesame.checked= false

open(w_wait_snoopy_writing)

uodw_import.setRedraw(false)
if uodw_import.uof_esegui(uodw_import.ic_ricerca) > 0 then
	cb_importa.enabled= true 
else
	cb_importa.enabled= false
end if

if 	uodw_import.ib_queryMode= true then
	this.text= "Estrazione"
	pb_struttura.enabled= true
else
	this.text= "Ricerca"
	pb_struttura.enabled= false
end if

uodw_import.setRedraw(true)

close(w_wait_snoopy_writing)

uodw_import.setFocus()

end event

type gb_criteri from groupbox within tabpage_inserimento
integer y = 16
integer width = 3506
integer height = 464
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 81324524
end type

type cb_filtradata from commandbutton within tabpage_inserimento
integer x = 2670
integer y = 116
integer width = 343
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Filtra"
end type

event clicked;string ls_filtra, ls_filtra1, ls_filtra2

if cbx_filtra_dataesame.checked= true then
	
	ls_filtra1= " (data_esame < date('"+em_filtra_dataesame.text+"') or isNull(data_esame))"
	
	ls_filtra= ls_filtra1
	
end if

if cbx_filtra_datacerimonia.checked= true then
	
	ls_filtra2= " (data_cer < date('"+em_filtra_datacerimonia.text+"'))"
	
	ls_filtra= ls_filtra2
	
end if

if cbx_filtra_dataesame.checked= true and cbx_filtra_datacerimonia.checked= true then
	
	ls_filtra= ls_filtra1+" and " + ls_filtra2
	
end if

uodw_import.setFilter(ls_filtra)

uodw_import.filter()

cb_annullafiltrodata.enabled= true


end event

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


choose case dwo.name
		
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
	
		openWithParm(w_sposta_sessione, is_evento_s)
		
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
		
		integer li_livello, li_num
		long ll_idx
		string ls_nodo
		
		ld_id= dw_header.getItemDecimal(dw_header.getRow(), "id")		
		
		select livello_master
		into :li_livello
		from esami_raggruppamento
		where id= :ld_id;
		if trap_sql(sqlca, "RAGGRUPPA01") < 0 then goto errore	
		
		if li_livello= 0 then li_livello= is_struttura_s.livello
		
		openWithParm(w_selezione_livello, li_livello)
		
		 li_livello= message.doubleParm
		
		if  li_livello= 0 then return -1
		
		this.setRedraw(false)
		
		for ll_idx= 1 to this.rowCount()
			
			ls_nodo= this.getItemString(ll_idx, "vc_parent")
			
			ls_nodo= f_parse_struttura_left(ls_nodo, li_livello)
			
			this.setItem(ll_idx, "raggruppamento", ls_nodo)
			this.setItem(ll_idx, "livello", li_livello)			
			
		next
		
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
st_3 st_3
st_min st_min
uodw_esito uodw_esito
cb_ricerca cb_ricerca
cb_soglia cb_soglia
cb_aggiorna cb_aggiorna
cbx_aggiorna cbx_aggiorna
cb_media cb_media
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
this.st_3=create st_3
this.st_min=create st_min
this.uodw_esito=create uodw_esito
this.cb_ricerca=create cb_ricerca
this.cb_soglia=create cb_soglia
this.cb_aggiorna=create cb_aggiorna
this.cbx_aggiorna=create cbx_aggiorna
this.cb_media=create cb_media
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
this.Control[]={this.st_3,&
this.st_min,&
this.uodw_esito,&
this.cb_ricerca,&
this.cb_soglia,&
this.cb_aggiorna,&
this.cbx_aggiorna,&
this.cb_media,&
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
destroy(this.st_3)
destroy(this.st_min)
destroy(this.uodw_esito)
destroy(this.cb_ricerca)
destroy(this.cb_soglia)
destroy(this.cb_aggiorna)
destroy(this.cbx_aggiorna)
destroy(this.cb_media)
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

type st_3 from statictext within tabpage_esito
integer x = 3835
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
integer x = 3611
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
integer width = 3520
integer taborder = 20
string dataobject = "d_esiti"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
end type

event rowfocuschanged;call super::rowfocuschanged;if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
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

event itemchanged;call super::itemchanged;if dwo.name= "voto" then
	if integer(data) > 250 or integer(data) < 0 then return 1
end if
end event

event buttonclicked;call super::buttonclicked;decimal ld_id

if dwo.name=  "b_sposta" then
	
	if this.modifiedCount() > 0 then
		
		if messageBox(parent.text, "Sono state eseguite delle modifiche, bisogna salvare i dati. Vuoi proseguire?", information!, yesNo!)= 2 then return -1
	
		if this.uof_aggiorna() < 0 then
			
			open(w_message_negative)
			
			return -1
			
		else
			
			open(w_message)
			
		end if
	
	end if
	
		openWithParm(w_sposta_sessione, is_evento_s)
		
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
		
	end if

end event

type cb_ricerca from commandbutton within tabpage_esito
integer x = 3575
integer y = 1120
integer width = 539
integer height = 220
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricerca nominativa"
end type

event clicked;if dw_header.rowCount() > 0  then
	
	uodw_esito.acceptText()
	
	if uodw_esito.modifiedCount() > 0 then
		messageBox(parent.text, "Prima di eseguire la ricerca occorre aggiornare i dati.", information!)
		return 0
	end if
	
	if messageBox(parent.text, "Per eseguire una ricerca nominativa occorre prima chiudere la sessione d'esame attiva. Vuoi proseguire?", Question!, yesNo!, 1)= 2 then return 0
	
end if

dw_header.reset()

uodw_esito.reset()

//cb_soglia.enabled= false

s_ricerca s_ricercanominativa_s

open(w_ricercanominativasmall)

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

type cb_soglia from commandbutton within tabpage_esito
integer x = 3575
integer y = 1624
integer width = 539
integer height = 220
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserisci voto minimo"
end type

event clicked;s_soglia s_soglia_s
integer li_soglia

openWithParm(w_limite_tab, is_evento_s.id)

li_soglia= message.doubleParm

if  li_soglia= 0 then return 0
 
if messageBox(parent.text, "Confermi "+string(li_soglia) +" come valore del voto minimo inserito?", question!, yesNo!, 2)= 2 then return 0

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
integer x = 3575
integer y = 1924
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

event clicked;integer li_voto, li_soglia, li_ret
long ll_idx
string ls_codice, ls_esito, ls_livello, ls_nome
datetime ldt_data

openWithParm(w_check_pw, s_utente_s)
	
li_ret= message.doubleParm

if li_ret <> 1 then return 0

ls_livello= "0"+string(is_evento_s.tipo_evento)

is_evento_s.descrizione= "Sede: "+is_evento_s.descrizione

uodw_esito.setFilter("")

uodw_esito.filter()

for ll_idx= 1 to uodw_esito.rowCount()
	
	ls_esito= uodw_esito.getItemString(ll_idx, "esito")
	
	if ls_esito= "" or isNull(ls_esito) then
		messageBox(parent.text, "Occorre inserire l'esito dell'esame per questo candidato.", information!)
		uodw_esito.scrollToRow(ll_idx)
		return -1
	end if
	
next

this.enabled= false
cbx_aggiorna.checked= false

open(w_wait_meter)

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
	
	if ls_esito = "P" then
	
		update membri_gerarchica
		set cod_studio= :ls_livello
		where codice= :ls_codice;
		if trap_sql(sqlca, "UPDATESTUDIO01") < 0 then goto sqlerror
		
	end if
	
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
					   :is_evento_s.data_evento,   
					   :ls_esito,
					   :li_voto,
					   :li_soglia,
					   :is_evento_s.descrizione) ;
					  
			if trap_sql(sqlca, "UPDATESTUDIO02") < 0 then
				
				select cognome+" "+nome
				into :ls_nome
				from membri_gerarchica
				where codice= :ls_codice;
				
				messageBox(parent.text, "Errore in inserimento nello storico esami dei dati di: "+ls_nome, exclamation!)
				goto sqlerror
				
			end if
			
				delete from esami_adesione
				where codice= :ls_codice;
				if trap_sql(sqlca, "UPDATESTUDIO03") < 0 then goto sqlerror
			
			w_wait_meter.hpb_meter.position= (ll_idx/uodw_esito.rowCount() ) * 100
	
next

//delete from esami where id= :is_evento_s.id;
//if trap_sql(sqlca, "UPDATESTUDIO03") < 0 then goto sqlerror

delete from eventi where id= :is_evento_s.id; // cancella in cascata la tabella esami
if trap_sql(sqlca, "UPDATESTUDIO04") < 0 then goto sqlerror

commit;
if trap_sql(sqlca, "UPDATESTUDIO05") < 0 then goto sqlerror

uodw_esito.reset()
tab_esami.tabpage_lista.uodw_lista.reset()

close(w_wait_meter)

open(w_message)

return 0

sqlerror:

close(w_wait_meter)

rollback;
trap_sql(sqlca, "UPDATESTUDIO06")

return -1
end event

type cbx_aggiorna from checkbox within tabpage_esito
integer x = 3552
integer y = 1852
integer width = 567
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
string text = "Abilita l~'aggiornamento"
boolean lefttext = true
end type

event clicked;if this.checked= true then
	
	uodw_esito.acceptText()

	if uodw_esito.getItemNumber(uodw_esito.getRow(), "ctotvoto")= 0 then
		messageBox(parent.text, "Nessuno voto è stato assegnato.", information!)
		this.enabled= false
		this.checked= false
	else
		
		if uodw_esito.getItemNumber(1, "soglia") > 0 then
			cb_aggiorna.enabled= true
		else
			messageBox(parent.text, "Non è stato inserito il voto minimo.", information!)
		end if
		
	end if
	
else
		cb_aggiorna.enabled= false	
end if

return 0
end event

type cb_media from commandbutton within tabpage_esito
integer x = 3575
integer y = 1344
integer width = 539
integer height = 220
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "La media in dettaglio"
end type

event clicked;integer li_tot

select count(*)
into : li_tot
from esami
where voto > 0 and id= :is_evento_s.id;

if li_tot= 0 or uodw_esito.modifiedCount() > 0  then
	messageBox(parent.text, "Occorre prima aggiornare le votazioni di esame.", information!)
	return 0
end if

openWithParm(w_media_tab, is_evento_s.id)
end event

type em_da from editmask within tabpage_esito
integer x = 3611
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
integer x = 3872
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
integer x = 3675
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
integer x = 3675
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
integer x = 3634
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
integer x = 3634
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
integer x = 3634
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
integer x = 3634
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
integer x = 3634
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
integer x = 3543
integer y = 524
integer width = 613
integer height = 572
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Filtra voti"
end type

type gb_1 from groupbox within tabpage_esito
integer x = 3538
integer y = 1568
integer width = 613
integer height = 604
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Fase conclusiva"
end type

type gb_2 from groupbox within tabpage_esito
integer x = 3547
integer y = 16
integer width = 613
integer height = 492
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "Visualizza"
end type

