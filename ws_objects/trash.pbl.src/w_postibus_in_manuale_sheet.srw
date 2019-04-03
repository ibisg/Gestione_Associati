$PBExportHeader$w_postibus_in_manuale_sheet.srw
forward
global type w_postibus_in_manuale_sheet from w_gestione_archivio_sheet
end type
type dw_partecipanti from datawindow within w_postibus_in_manuale_sheet
end type
end forward

global type w_postibus_in_manuale_sheet from w_gestione_archivio_sheet
integer width = 3712
string menuname = "m_postibus_in_manuale"
windowstate windowstate = maximized!
long backcolor = 12632256
event type integer ue_annulla_assegnazioni ( )
event type integer ue_seleziona_mezzi ( )
dw_partecipanti dw_partecipanti
end type
global w_postibus_in_manuale_sheet w_postibus_in_manuale_sheet

type variables
long il_null
string is_corso, is_turno, is_mezzo, is_where, is_a_r
boolean ib_ricerca_iniziale= false
dataWindowChild dwc_partecipanti
end variables

event ue_annulla_assegnazioni;// annulla le assegnazioni manuali
update posti_bus
set codice_part= null, flag_man= null
where codice_part <> null and
			cod_corso= :is_corso and
				cod_turno= :is_turno and
					cod_mezzo= :is_mezzo and
						flag_man= 'M';
					
if trap_sql(sqlca, "ANNULLA01") < 0 then
	rollback;
	trap_sql(sqlca, "ANNULLA02")
	return -1
end if

dw_current.retrieve(is_corso, is_turno, is_mezzo)

m_postibus_in_manuale.m_gestionearchivio.m_salva.enabled= false
m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= false

commit;
if trap_sql(sqlca, "ANNULLA03") < 0 then return -1

return 0
end event

event ue_seleziona_mezzi;long ll_rows
string ls_where

if wf_modwarning(dw_current) > 0 then return 0

openWithParm(w_seleziona_mezzo, is_a_r)

is_mezzo= message.stringParm

if is_mezzo= "" then return 0

if is_a_r= 'A' then
	dw_current.dataObject= 'dw_postibus_a'
	is_where= " and mezzi_a.cod_corso= ~~'"+is_corso+ "~~' and mezzi_a.cod_turno= ~~'"+is_turno+"~~' and mezzi_a.cod_mezzo= ~~'"+is_mezzo+"~~'"
	/*+"' and mezzi_a.a_r='"+is_a_r+"'"*/
else
	dw_current.dataObject= 'dw_postibus_r'
	is_where= " and mezzi_r.cod_corso= ~~'"+is_corso+"~~' and mezzi_r.cod_turno= ~~'"+is_turno+"~~' and mezzi_r.cod_mezzo= ~~'"+is_mezzo+"~~'"
	/*+"' and mezzi_r.a_r='"+is_a_r+"'"	*/
end if

dw_current.getChild("codice_part", dwc_partecipanti)

dwc_partecipanti.setTransObject(sqlca)
ls_where=  " where cod_corso= ~~'"+is_corso+"~~' and cod_turno= ~~'"+is_turno+"~~'"
ll_rows= f_mod_select(ls_where, dwc_partecipanti)

dw_current.reset()

dw_current.setTransObject(sqlca)

ib_ricerca_iniziale= true

ll_rows= f_dw_mod_select(false, is_where, dw_current)

/////////// provisorio
	if ll_rows > 0 then
		m_postibus_in_manuale.m_gestionearchivio.m_ricerca.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_stampa.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_anteprima.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_ordina.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_reset.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= true
		m_postibus_in_manuale.m_gestionearchivio.m_salva.enabled= true
	else
		m_postibus_in_manuale.m_gestionearchivio.m_ricerca.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_stampa.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_anteprima.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_ordina.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_reset.enabled= false
		m_postibus_in_manuale.m_gestionearchivio.m_salva.enabled= false
//		if ib_only_once= false then
//			m_reset.triggerEvent(clicked!)
//			// return
//		end if
	end if

/////////////////////////////

ib_ricerca_iniziale= false

//

//ll_rows= dw_current.retrieve(is_corso, is_turno, is_mezzo)



//if ll_rows > 0 then m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= true

commit;
if trap_sql(sqlca, "POSTIBUS04") < 0 then return -1
return 0
end event

event open;long ll_rows, ll_idx
integer li_nposti

setNull(il_null)

is_a_r= message.stringParm

if is_a_r= 'A' then
	this.title= "Assegnazione manuale posti bus andata per "+gs_descrizionecorsocorrente
else
	this.title= "Assegnazione manuale posti bus ritorno per "+gs_descrizionecorsocorrente
end if

is_corso= mid(gs_corsocorrente, 1, 6)
is_turno= mid(gs_corsocorrente, 7, 10)

post event ue_seleziona_mezzi()

return 0





end event

on w_postibus_in_manuale_sheet.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_postibus_in_manuale" then this.MenuID = create m_postibus_in_manuale
this.dw_partecipanti=create dw_partecipanti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_partecipanti
end on

on w_postibus_in_manuale_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_partecipanti)
end on

type dw_current from w_gestione_archivio_sheet`dw_current within w_postibus_in_manuale_sheet
integer x = 1769
integer y = 8
integer width = 1856
string dataobject = "dw_postibus_a"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::itemchanged;call super::itemchanged;choose case dwo.name
	case "codice_part" 
		
		long ll_row
		
		ll_row= this.find("codice_part="+data, 1, this.rowCount() )
		if ll_row > 0 then
			
				if is_a_r= 'A' then
					messageBox(parent.title, "Il partecipante, per il tragitto di andata,  è già stato inserito nel mezzo con codice: "+is_mezzo+" al posto "+string(ll_row)+".", information!)
				else
					messageBox(parent.title, "Il partecipante, per il tragitto di ritorno,  è già stato inserito nel mezzo con codice: "+is_mezzo+" al posto "+string(ll_row)+".", information!)					
				end if
				
				this.ReselectRow ( row ) 

				return 1
			
		else // ora cerca nella base dati per verificare che non sia già stato inserito in un altro mezzo...
			
			if is_a_r= 'A' then
				select count(*)
				into :ll_row
				from posti_bus_a
				where cod_corso= :is_corso and
							cod_turno= :is_turno /*and
								cod_mezzo= :is_mezzo */and
									codice_part= convert(integer, :data) ;
				if trap_sql(sqlca, "ITEMCH01") < 0 then return 1
			else
				select count(*)
				into :ll_row
				from posti_bus_r
				where cod_corso= :is_corso and
							cod_turno= :is_turno /*and
								cod_mezzo= :is_mezzo*/ and
									codice_part= convert(integer, :data) ;
				if trap_sql(sqlca, "ITEMCH01.0") < 0 then return 1				
			end if
			
			if ll_row > 0 then
				
				if is_a_r= 'A' then
					messageBox(parent.title, "Il partecipante, per il tragitto di andata,  è già stato inserito nel mezzo con codice: "+is_mezzo+".", information!)
				else
					messageBox(parent.title, "Il partecipante, per il tragitto di ritorno,  è già stato inserito nel mezzo con codice: "+is_mezzo+".", information!)					
				end if

				this.ReselectRow ( row ) 

				return 1
			
			end if
			
		end if
		
//		this.setItem(row, "flag_man", 'M')
//		m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= true
//		if this.update() < 0 then messageBox(parent.title, "Salvataggio non riuscito.", exclamation!)

end choose
		
this.setItem(row, "flag_man", 'M')
m_postibus_in_manuale.m_gestionearchivio.m_salva.enabled= true
m_postibus_in_manuale.m_gestionearchivio.m_cancella.enabled= true
//if this.update() < 0 then messageBox(parent.title, "Salvataggio non riuscito.", exclamation!)

return 0
	
end event

event dw_current::buttonclicked;call super::buttonclicked;this.setItem(row, "codice_part", il_null)
this.setItem(row, "flag_man", '')

m_postibus_in_manuale.m_gestionearchivio.m_salva.enabled= true

//if this.update() < 0 then messageBox(parent.title, "Salvataggio non riuscito.", exclamation!)
end event

event dw_current::sqlpreview;//if ib_ricerca_iniziale= true	then
//	sqlsyntax += is_where
//	SetSqlPreview ( sqlsyntax)
//end if
end event

type dw_partecipanti from datawindow within w_postibus_in_manuale_sheet
integer x = 87
integer y = 8
integer width = 1669
integer height = 1128
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_partecipanti_da_sistemare_in_bus_a"
boolean border = false
boolean livescroll = true
end type

