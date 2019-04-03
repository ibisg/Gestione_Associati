$PBExportHeader$w_esiti.srw
forward
global type w_esiti from window
end type
type cb_annulla from commandbutton within w_esiti
end type
type cb_filtra from commandbutton within w_esiti
end type
type st_a from statictext within w_esiti
end type
type st_da from statictext within w_esiti
end type
type em_a from editmask within w_esiti
end type
type em_da from editmask within w_esiti
end type
type cb_media from commandbutton within w_esiti
end type
type cbx_aggiorna from checkbox within w_esiti
end type
type rb_voti from radiobutton within w_esiti
end type
type cb_aggiorna from commandbutton within w_esiti
end type
type cb_soglia from commandbutton within w_esiti
end type
type cb_ricerca from commandbutton within w_esiti
end type
type rb_tutti from radiobutton within w_esiti
end type
type rb_respinti from radiobutton within w_esiti
end type
type rb_promossi from radiobutton within w_esiti
end type
type rb_assenti from radiobutton within w_esiti
end type
type st_1 from statictext within w_esiti
end type
type dw_liv from datawindow within w_esiti
end type
type st_30 from statictext within w_esiti
end type
type st_31 from statictext within w_esiti
end type
type st_26 from statictext within w_esiti
end type
type sle_loc from uo_sle_gen within w_esiti
end type
type em_data from editmask within w_esiti
end type
type gb_dett from groupbox within w_esiti
end type
type gb_cer from groupbox within w_esiti
end type
type dw_elenco from uo_dwselect within w_esiti
end type
type gb_filtra from groupbox within w_esiti
end type
type s_cons from structure within w_esiti
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

global type w_esiti from window
integer x = 5
integer y = 4
integer width = 4567
integer height = 2884
boolean titlebar = true
string title = "Esami di studio - Esiti e liste"
string menuname = "m_esiti"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "Form!"
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event uscita ( )
event clear ( string ls_from )
event type integer save ( )
event search_ses ( )
event ordina ( )
event aggiorna ( )
event stampa ( )
cb_annulla cb_annulla
cb_filtra cb_filtra
st_a st_a
st_da st_da
em_a em_a
em_da em_da
cb_media cb_media
cbx_aggiorna cbx_aggiorna
rb_voti rb_voti
cb_aggiorna cb_aggiorna
cb_soglia cb_soglia
cb_ricerca cb_ricerca
rb_tutti rb_tutti
rb_respinti rb_respinti
rb_promossi rb_promossi
rb_assenti rb_assenti
st_1 st_1
dw_liv dw_liv
st_30 st_30
st_31 st_31
st_26 st_26
sle_loc sle_loc
em_data em_data
gb_dett gb_dett
gb_cer gb_cer
dw_elenco dw_elenco
gb_filtra gb_filtra
end type
global w_esiti w_esiti

type variables
boolean ib_closing = false
s_esami str_es
uo_ds_gen ds_lista, ds_curr

DataWindowChild idwc_liv

end variables

forward prototypes
public subroutine f_header ()
end prototypes

event ue_open;dw_liv.InsertRow ( 0 )
dw_liv.GetChild ( "esame", idwc_liv )
idwc_liv.SetTransObject ( sqlca )
idwc_liv.Retrieve ( )

SetNull ( str_es.v_data )
SetNull ( str_es.v_sede )
SetNull ( str_es.v_liv )

dw_elenco.SetTransObject ( sqlca )

end event

event uscita;ib_closing = true

close ( this )

end event

event clear(string ls_from);int li_ret

dw_elenco.AcceptText ( )

if dw_elenco.ModifiedCount ( ) > 0 then
	
	li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
								 question!, YesNoCancel!, 1 )
																				
	choose case li_ret
			
		case 1
			
			if event save ( ) = -1 then return
			
		case 2
			
		case 3
			
			return
			
	end choose
	
end if

dw_elenco.visible = false
dw_elenco.Reset ( )

em_data.text = ""
sle_loc.text = ""

dw_liv.SetRedraw ( false )
dw_liv.Reset ( )
dw_liv.InsertRow ( 0 )
dw_liv.SetRedraw ( true )

SetNull ( str_es.v_data )
SetNull ( str_es.v_sede )
SetNull ( str_es.v_liv )

gb_dett.text = ""

m_esiti.m_opzioni.m_sessione.enabled = true
m_esiti.m_opzioni.m_salva.enabled = false
m_esiti.m_opzioni.m_aggiorna.enabled = false
m_esiti.m_opzioni.m_stampe.enabled = false

cb_ricerca.enabled= true
cb_media.enabled= true
cb_soglia.enabled= true
cb_aggiorna.enabled= false
cbx_aggiorna.enabled= false


end event

event type integer save();dw_elenco.acceptText()

if dw_elenco.Update ( ) = -1 then
	
	MessageBox ( this.title, "Salvataggio non riuscito", StopSign! )
	
	rollback;
	
	return -1
	
else
	
	commit;
	
	if sqlca.sqlcode < 0 then 
		MessageBox ( this.title, "Commit non riuscita", StopSign! )
		return -1
	end if

	OpenWithParm ( w_msgauto, "Salvataggio riuscito" )
	
end if

return 0

end event

event search_ses();long ll_rows

select count ( * )
into :ll_rows
from esami;

if trap_sql ( sqlca, "controllo liste" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	close ( this )
	return

end if

commit;

if ll_rows = 0 then 
	MessageBox ( "Esami", "Nessuna lista impostata..." )
	return
end if

OpenWithParm ( w_sel_sessione, "esiti" )

if message.DoubleParm = -1 then return

f_header ( )

cb_ricerca.enabled= false
cb_media.enabled= false
cb_soglia.enabled= false

if dw_elenco.rowCount() > 0 then
	if dw_elenco.getItemNumber(1, "soglia") > 0 then cbx_aggiorna.enabled= true
end if

end event

event ordina;OpenWithParm ( w_ordina, dw_elenco )
dw_elenco.SetSort ( message.StringParm )
dw_elenco.Sort ( )

end event

event aggiorna();long ll_rows, ll_count, ll_code, ll_curr
string ls_dip, ls_esito, ls_percorso
datetime ld_data
int li_ret, li_differenza, li_voto, flag_membri

if MessageBox ( "Aggiornamento archivi", &
					 "Questa operazione cancellerà la lista corrente...~n" + &
					 "Se non è stata fatta una stampa per l'archivio~n" + &
					 "premere <Annulla> per interrompere la procedura.", information!, OkCancel!, 2 ) = 2 then goto errore

dw_elenco.AcceptText ( )

if dw_elenco.ModifiedCount ( ) > 0 then
	
	li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati... Vuoi proseguire?", &
								 question!, YesNo!, 1 )
																				
	choose case li_ret
			
		case 1
			
			if event save ( ) = -1 then return
			
		case 2
			
			return
			
	end choose
	
end if

ds_curr = create uo_ds_gen
ds_curr.DataObject = "ds_curr_studio"
ds_curr.SetTransObject ( sqlca )

ll_rows = dw_elenco.RowCount ( )

for ll_count = 1 to ll_rows

	li_voto= dw_elenco.GetItemNumber(ll_count, "voto") 
	
		if li_voto = 0 or isNull(li_voto) then
			
			dw_elenco.setItem(ll_count, "esito", 'A')
			
		else
			
			li_differenza= dw_elenco.GetItemNumber(ll_count, "voto") - dw_elenco.GetItemNumber(ll_count, "soglia") 
			
			choose case li_differenza
				
				case is >= 0 
					
					dw_elenco.setItem(ll_count, "esito", 'P' )
					
				case is < 0 
					
					dw_elenco.setItem(ll_count, "esito", 'R' )	
				
			end choose
			
		end if
		
next

if dw_elenco.update()= -1 then goto errore

//ls_percorso= gs_percorso_liste+"\"+str_es.v_sede+"_"+string(str_es.v_data, "dd.mm.yyyy")+"_"+str_es.v_liv+".xls"

//if MessageBox ( "Aggiornamento archivi", &
//					 "Questa operazione cancellerà la lista corrente...~n" + &
//					 "Se non è stata fatta una stampa per l'archivio~n" + &
//					 "premere <Annulla> per interrompere la procedura.", information!, OkCancel!, 2 ) = 2 then
//													  
//	goto errore
//	
//end if

for ll_count = 1 to ll_rows
	
	ll_code = dw_elenco.GetItemNumber ( ll_count, "codice_membro" )
	ls_dip = dw_elenco.GetItemString ( ll_count, "cod_dip" )
	ls_esito= dw_elenco.GetItemString ( ll_count, "esito" ) 
	
	select count(*)
	into :flag_membri
	from membri
	where codice_membro= :ll_code and cod_dip= :ls_dip;
	
	if trap_sql ( sqlca, "VERIFICA_MEMBRI01" ) = -1 then goto errore
	
	if flag_membri= 0 or isNull(flag_membri) then continue
	
	ll_curr= ds_curr.InsertRow ( 0 )
	
	ds_curr.SetItem ( ll_curr, "codice_membro", ll_code )
	ds_curr.SetItem ( ll_curr, "cod_dip", ls_dip )
	ds_curr.SetItem ( ll_curr, "cod_studio", str_es.v_liv )
	ds_curr.SetItem ( ll_curr, "data_esame", str_es.v_data )
	ds_curr.SetItem ( ll_curr, "esito", ls_esito ) // GdS - 200902 - Si memorizza in curr_studio l'esito dell'esame
	
	if ls_esito <> 'P' then continue
	
	ld_data = datetime ( today ( ), now ( ) )
	
	update membri
	set cod_studio = :str_es.v_liv,
		 u_ult_mod = :gs_logname,
		 d_ult_mod = :ld_data
	where codice_membro = :ll_code
	and cod_dip = :ls_dip;

	if trap_sql ( sqlca, "aggiornamento anagrafica" ) = -1 then goto errore
	
next

if ds_curr.Update ( ) = -1 then goto errore

DELETE FROM esami  
WHERE ( esami.data_esame = :str_es.v_data ) AND  
		( esami.sede = :str_es.v_sede ) AND  
		( esami.cod_studio = :str_es.v_liv )   ;

if trap_sql ( sqlca, "cancellazione tabella esami" ) = -1 then goto errore

commit;

if trap_sql(sqlca, "COMMIT-ESAMI") < 0 then goto errore

//// GdS
////if dw_elenco.saveAs(ls_percorso, Excel!, true)= -1 then
//if dw_elenco.saveAs("", Excel!, true)= -1 then
//	messageBox(this.title, "Non è stato possibile creare il file Excel.", exclamation!)
//end if
//// GdS
//
////f_log ( gs_context, "Effettuato aggiornamento posizioni studio" )

OpenWithParm ( w_msgauto, "Aggiornamento effettuato" )

TriggerEvent ( "clear" )

destroy ds_curr
return

errore:

//	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	OpenWithParm ( w_msgauto, "Aggiornamento annullato" )
	
	destroy ds_curr
	return

end event

event stampa;dw_elenco.SetRedraw ( false )
dw_elenco.Object.DataWindow.Footer.Height = 165

OpenWithParm ( w_dw_print_options, this.dw_elenco )

dw_elenco.Object.DataWindow.Footer.Height = 1
dw_elenco.SetRedraw ( true )

end event

public subroutine f_header ();long ll_found

if not IsNull ( str_es.v_data ) and not IsNull ( str_es.v_sede ) &
and not IsNull ( str_es.v_liv ) then

	dw_elenco.SetRedraw ( false )
	ll_found = dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv )
	dw_elenco.SetRedraw ( true )
	
	if ll_found = -1 then
		
		OpenWithParm ( w_msgauto, "Operazione annullata" )
		TriggerEvent ( "clear" )
		return
		
	end if
	
	dw_elenco.visible = true

	gb_dett.Text = " Esiti esami "
		
	m_esiti.m_opzioni.m_sessione.enabled = false
	m_esiti.m_opzioni.m_aggiorna.enabled = false
	m_esiti.m_opzioni.m_stampe.enabled = true
	
end if

end subroutine

on w_esiti.create
if this.MenuName = "m_esiti" then this.MenuID = create m_esiti
this.cb_annulla=create cb_annulla
this.cb_filtra=create cb_filtra
this.st_a=create st_a
this.st_da=create st_da
this.em_a=create em_a
this.em_da=create em_da
this.cb_media=create cb_media
this.cbx_aggiorna=create cbx_aggiorna
this.rb_voti=create rb_voti
this.cb_aggiorna=create cb_aggiorna
this.cb_soglia=create cb_soglia
this.cb_ricerca=create cb_ricerca
this.rb_tutti=create rb_tutti
this.rb_respinti=create rb_respinti
this.rb_promossi=create rb_promossi
this.rb_assenti=create rb_assenti
this.st_1=create st_1
this.dw_liv=create dw_liv
this.st_30=create st_30
this.st_31=create st_31
this.st_26=create st_26
this.sle_loc=create sle_loc
this.em_data=create em_data
this.gb_dett=create gb_dett
this.gb_cer=create gb_cer
this.dw_elenco=create dw_elenco
this.gb_filtra=create gb_filtra
this.Control[]={this.cb_annulla,&
this.cb_filtra,&
this.st_a,&
this.st_da,&
this.em_a,&
this.em_da,&
this.cb_media,&
this.cbx_aggiorna,&
this.rb_voti,&
this.cb_aggiorna,&
this.cb_soglia,&
this.cb_ricerca,&
this.rb_tutti,&
this.rb_respinti,&
this.rb_promossi,&
this.rb_assenti,&
this.st_1,&
this.dw_liv,&
this.st_30,&
this.st_31,&
this.st_26,&
this.sle_loc,&
this.em_data,&
this.gb_dett,&
this.gb_cer,&
this.dw_elenco,&
this.gb_filtra}
end on

on w_esiti.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_annulla)
destroy(this.cb_filtra)
destroy(this.st_a)
destroy(this.st_da)
destroy(this.em_a)
destroy(this.em_da)
destroy(this.cb_media)
destroy(this.cbx_aggiorna)
destroy(this.rb_voti)
destroy(this.cb_aggiorna)
destroy(this.cb_soglia)
destroy(this.cb_ricerca)
destroy(this.rb_tutti)
destroy(this.rb_respinti)
destroy(this.rb_promossi)
destroy(this.rb_assenti)
destroy(this.st_1)
destroy(this.dw_liv)
destroy(this.st_30)
destroy(this.st_31)
destroy(this.st_26)
destroy(this.sle_loc)
destroy(this.em_data)
destroy(this.gb_dett)
destroy(this.gb_cer)
destroy(this.dw_elenco)
destroy(this.gb_filtra)
end on

event open;PostEvent ( "ue_open" )

end event

event closequery;int li_ret

dw_elenco.AcceptText ( )

if dw_elenco.ModifiedCount ( ) > 0 then
	
	li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
								 question!, YesNoCancel!, 1 )
																				
	choose case li_ret
			
		case 1
			
			if event save ( ) = -1 then
				return 1
			else
				return 0
			end if
			
		case 2
			
			return 0
			
		case 3
			
			return 1
			
	end choose
	
end if

end event

event activate;gs_context = "Aggiornamento curr. studio"

end event

event resize;gb_dett.height= newheight - 60 - gb_cer.height

dw_elenco.height= gb_dett.height - 120

end event

type cb_annulla from commandbutton within w_esiti
integer x = 3685
integer y = 1088
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annulla filtro"
end type

event clicked;//if dw_elenco.rowCount() <= 0 then
//	messageBox(parent.title, "Selezionare una sessione di esame", information!)
//	return
//end if

dw_elenco.setFilter("")

dw_elenco.filter()
end event

type cb_filtra from commandbutton within w_esiti
integer x = 3685
integer y = 984
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filtra"
end type

event clicked;
string ls_filtra

if dw_elenco.rowCount() <= 0 then
	messageBox(parent.title, "Selezionare una sessione di esame", information!)
	return
end if

if (integer(em_da.text) > integer(em_a.text)) OR  (integer(em_a.text) < integer(em_da.text)) then
	messageBox(parent.title, "Inserire i valori nell'ordine corretto (es. da 50 a 60", exclamation!)
	return
end if

if em_da.text= "0" and em_a.text= "0" then
	
	ls_filtra= ""
	
else

	ls_filtra= "voto >= "+em_da.text+" and voto <= "+em_a.text
	
end if

dw_elenco.setFilter(ls_filtra)

dw_elenco.filter()
end event

type st_a from statictext within w_esiti
integer x = 3863
integer y = 876
integer width = 64
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "a:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_da from statictext within w_esiti
integer x = 3593
integer y = 876
integer width = 78
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "da:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_a from editmask within w_esiti
integer x = 3931
integer y = 856
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
string minmax = "0~~100"
end type

event getfocus;this.selectText(1, 3 )
end event

type em_da from editmask within w_esiti
integer x = 3675
integer y = 856
integer width = 178
integer height = 92
integer taborder = 40
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

type cb_media from commandbutton within w_esiti
integer x = 3575
integer y = 1468
integer width = 558
integer height = 220
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Media di un esame"
end type

event clicked;open(w_media)
end event

type cbx_aggiorna from checkbox within w_esiti
integer x = 3557
integer y = 1976
integer width = 567
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Abilita l~'aggiornamento"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked= true then
	
	dw_elenco.acceptText()

	if dw_elenco.getItemNumber(dw_elenco.getRow(), "ctotvoto")= 0 then
		messageBox(parent.title, "Nessuno voto è stato assegnato.", information!)
		this.enabled= false
		this.checked= false
	else
		
		if dw_elenco.getItemNumber(1, "soglia") > 0 then
			cb_aggiorna.enabled= true
		else
			messageBox(parent.title, "Non è stato inserito il voto minimo.", information!)
		end if
		
	end if
	
else
		cb_aggiorna.enabled= false	
end if

return 0
end event

type rb_voti from radiobutton within w_esiti
integer x = 3561
integer y = 336
integer width = 475
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Solo presenti"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_elenco.setFilter("cvoto=1")
dw_elenco.filter()
end event

type cb_aggiorna from commandbutton within w_esiti
integer x = 3575
integer y = 2048
integer width = 558
integer height = 220
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Aggiorna lo storico"
end type

event clicked;dw_elenco.setFilter("")

dw_elenco.filter()

parent.event aggiorna()
this.enabled= false
cbx_aggiorna.checked= false
end event
type cb_soglia from commandbutton within w_esiti
integer x = 3575
integer y = 1692
integer width = 558
integer height = 220
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inserisci voto minimo"
end type

event clicked;s_soglia s_soglia_s

open(w_limite)

s_soglia_s= message.powerObjectParm

if  s_soglia_s.soglia= 0 then return 0
 
if messageBox(parent.title, "Confermi "+string(s_soglia_s.soglia) +" come valore del voto minimo inserito?", question!, yesNo!, 2)= 2 then return 0

update esami set soglia= :s_soglia_s.soglia
where data_esame= :s_soglia_s.data and
		cod_studio= :s_soglia_s.livello;
		if trap_sql(sqlca, "VOTOMINIMO01") < 0 then return -1
		
		
		


end event

type cb_ricerca from commandbutton within w_esiti
integer x = 3575
integer y = 1244
integer width = 558
integer height = 220
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ricerca nominativa"
end type

event clicked;if sle_loc.text <> "" then
	
	messageBox(parent.title, "Per eseguire una ricerca nominativa occorre prima chiudere la sessione d'esame attiva", information!)
	
	return 0
	
end if

cb_soglia.enabled= false

s_ricercanominativa s_ricercanominativa_s

open(w_ricercanominativa)

s_ricercanominativa_s= message.powerObjectParm

if s_ricercanominativa_s.sede= "" or isNull(s_ricercanominativa_s.sede) then
	
	this.enabled= true
	return 0
	
else
	
	this.enabled= false

	str_es.v_data= s_ricercanominativa_s.data_esame
	
	str_es.v_sede= s_ricercanominativa_s.sede
	
	str_es.v_liv= s_ricercanominativa_s.cod_studio
	
	f_header()
	
	em_data.text= string(str_es.v_data)
	sle_loc.text= str_es.v_sede
	dw_liv.setItem(1, "esame", str_es.v_liv)
	
	long ll_found
	string ls_find
	
	ls_find= "codice_membro="+string(s_ricercanominativa_s.codice_membro)+" and cod_dip= '"+s_ricercanominativa_s.cod_dip+"'"
	
	ll_found = dw_elenco.Find(ls_find,  1, dw_elenco.RowCount() )
	
	dw_elenco.scrollToRow(ll_found)
	dw_elenco.setColumn("voto")
	dw_elenco.setFocus()
	
end if

dw_elenco.selectText(1, len(dw_elenco.getText()) )













end event

type rb_tutti from radiobutton within w_esiti
integer x = 3561
integer y = 684
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Tutti"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_elenco.setFilter("")
dw_elenco.filter()
end event

type rb_respinti from radiobutton within w_esiti
integer x = 3561
integer y = 596
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Solo respinti"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_elenco.setFilter("voto < soglia ")
dw_elenco.filter()
end event

type rb_promossi from radiobutton within w_esiti
integer x = 3561
integer y = 508
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Solo promossi"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_elenco.setFilter("voto >= soglia ")
dw_elenco.filter()
end event

type rb_assenti from radiobutton within w_esiti
integer x = 3561
integer y = 420
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Solo assenti"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_elenco.setFilter("voto=0 or isNull(voto) ")
dw_elenco.filter()
end event

type st_1 from statictext within w_esiti
integer x = 3250
integer y = 112
integer width = 151
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "livello"
boolean focusrectangle = false
end type

type dw_liv from datawindow within w_esiti
integer x = 2711
integer y = 104
integer width = 526
integer height = 104
integer taborder = 30
boolean enabled = false
string dataobject = "d_read_liv"
boolean border = false
boolean livescroll = true
end type

event itemchanged;str_es.v_liv = data

f_header ( )

end event

type st_30 from statictext within w_esiti
integer x = 101
integer y = 104
integer width = 151
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Data:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_31 from statictext within w_esiti
integer x = 699
integer y = 112
integer width = 146
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Sede:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_26 from statictext within w_esiti
integer x = 2400
integer y = 112
integer width = 311
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Per diventare:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_loc from uo_sle_gen within w_esiti
event modified pbm_enmodified
string tag = "Citta"
integer x = 859
integer y = 104
integer width = 1527
integer height = 92
integer taborder = 20
long backcolor = 16777215
boolean enabled = false
integer limit = 60
end type

event modified;call super::modified;str_es.v_sede = trim ( this.text )

if len ( str_es.v_sede ) = 0 then SetNull ( str_es.v_sede )

f_header ( )

end event

type em_data from editmask within w_esiti
event modified pbm_enmodified
string tag = "Data"
integer x = 265
integer y = 104
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
string displaydata = "~b"
end type

event modified;if this.text = "" then return

if integer ( mid ( this.text, 7, 4 ) ) < 1960 and not ib_closing and &
this.text <> "" and this.text <> "00/00/0000" then
	
	MessageBox ( "Data non valida", "Immettere una data corretta...", Exclamation! )
	this.text = ""
	this.SetFocus ( )
	SetNull ( str_es.v_data )
	return
	
end if

str_es.v_data = datetime ( date ( this.text ) )

f_header ( )

return

end event

type gb_dett from groupbox within w_esiti
integer y = 272
integer width = 3502
integer height = 1428
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Inserimento votazioni ( per i candidati assenti lasciare a 0 il voto )"
borderstyle borderstyle = stylelowered!
end type

type gb_cer from groupbox within w_esiti
integer y = 12
integer width = 3502
integer height = 248
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = " Sessione "
borderstyle borderstyle = stylelowered!
end type

type dw_elenco from uo_dwselect within w_esiti
boolean visible = false
integer x = 18
integer y = 336
integer width = 3451
integer height = 1320
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_esiti"
end type

event clicked;/**/
end event

event getfocus;/**/
end event

event itemchanged;call super::itemchanged;if m_esiti.m_opzioni.m_salva.enabled = false then m_esiti.m_opzioni.m_salva.enabled = true

if integer(data) < 0 or integer(data) > 100 then
	messageBox(parent.title, "Votazione al di fuori dei limiti ( 0 - 100 )", information!)
	return 1
else
	if cbx_aggiorna.enabled= false then
		cbx_aggiorna.enabled= true
		cbx_aggiorna.checked= false
	end if
	return 0
end if

end event

event itemerror;call super::itemerror;return 1
end event

event itemfocuschanged;call super::itemfocuschanged;if dwo.name= "voto"  then this.selectText(1, len(getText()) )
end event

type gb_filtra from groupbox within w_esiti
integer x = 3575
integer y = 792
integer width = 558
integer height = 408
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Filtra voti"
borderstyle borderstyle = stylelowered!
end type

