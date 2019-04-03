$PBExportHeader$wq_conf_pass.srw
forward
global type wq_conf_pass from window
end type
type hpb_asp from hprogressbar within wq_conf_pass
end type
type dw_elenco from datawindow within wq_conf_pass
end type
end forward

global type wq_conf_pass from window
integer width = 3666
integer height = 2400
boolean titlebar = true
string title = "Conferma partecipazione/Passaggio nuovi membri in anagrafica"
string menuname = "mq_conf_pass"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event query_on ( )
event query_off ( )
event ue_open ( )
event query_start ( )
event ordina ( )
event stop ( )
event type integer save ( )
event aggiorna ( )
hpb_asp hpb_asp
dw_elenco dw_elenco
end type
global wq_conf_pass wq_conf_pass

type variables
boolean stop_retrieval = false
boolean modify = false
boolean saving = false

long retrieved_rows, t_row, il_start, il_len, il_code
long n = 0

int sort_order = 1

string is_dis
string is_where, is_dip

datetime id_data_goj

uo_ds_gen ds_mem, ds_asp, ds_storico

end variables

forward prototypes
public subroutine storico_goh (long v_code, string v_dip, datetime v_data)
public function integer query_mode ()
public function string dw_status ()
public subroutine menu_on ()
public subroutine menu_off ()
public function integer wf_agg_studio ()
public function integer dw_retrieve ()
end prototypes

event query_on;mq_conf_pass.m_principale.m_salva.disable ( )
mq_conf_pass.m_principale.m_ordina.disable ( )
mq_conf_pass.m_principale.m_aggiorna.disable ( )

mq_conf_pass.m_principale.m_ricerca.ToolBarItemName = "Retrieve!"

modify = false
saving = false

dw_elenco.SetRedraw ( false )

query_mode ( )

dw_elenco.modify ( "data_cer.protect = '0'" )
dw_elenco.modify ( "luogo_cer.protect = '0'" )
dw_elenco.modify ( "turno.protect = '0'" )
dw_elenco.modify ( "tipo_goh.protect = '0'" )
dw_elenco.modify ( "membro.protect = '1'" )
dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.SetRedraw ( true )

dw_elenco.SetFocus ( )

end event

event query_off;if dw_retrieve ( ) = 0 then
	
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	return
	
end if

dw_elenco.SetRedraw ( false )

mq_conf_pass.m_principale.m_ricerca.ToolBarItemName = "Search!"

if dw_elenco.RowCount ( ) > 0 then
	
	mq_conf_pass.m_principale.m_ordina.enable ( )
	mq_conf_pass.m_principale.m_aggiorna.enable ( )
	
	dw_elenco.modify ( "data_cer.protect = '1'" )
	dw_elenco.modify ( "luogo_cer.protect = '1'" )
	dw_elenco.modify ( "turno.protect = '1'" )
	dw_elenco.modify ( "tipo_goh.protect = '1'" )
	dw_elenco.modify ( "membro.protect = '0'" )
	dw_elenco.Object.DataWindow.Footer.Height = 85
	
end if

dw_elenco.SetRedraw ( true )

dw_elenco.setFocus ( )

end event

event ue_open;query_mode ( )

end event

event query_start;if dw_status ( ) = 'no' then
	TriggerEvent ( "query_on" )
else
	TriggerEvent ( "query_off" )
end if

end event

event ordina;OpenWithParm ( w_ordina, dw_elenco )
dw_elenco.SetSort ( message.StringParm )
dw_elenco.Sort ( )

end event

event stop;stop_retrieval = true

end event

event save;if not modify then return 0

saving = true

if dw_elenco.Update ( ) = 1 then
	commit;
	modify = false
	saving = false
	return 0
else
	rollback;
	dw_elenco.Retrieve ( )
	return -1
end if

end event

event aggiorna;int li_ret
long ll_rows, ll_count, ll_code, ll_row_stor
string ls_dip, ls_goh, sql_stat, ls_debug, ls_cognome, ls_nome
datetime ld_data

dw_elenco.AcceptText ( )

if modify then
	
	if event save ( ) = -1 then return
	
end if

if MessageBox ( "Aggiornamento anagrafica", "Confermi operazione?", Question!, YesNo!, 2 ) = 2 then return

ds_asp = create uo_ds_gen
ds_asp.DataObject = "ds_asp_out"
ds_asp.SetTransObject ( sqlca )

ds_mem = create uo_ds_gen
ds_mem.DataObject = "ds_mem_in"
ds_mem.SetTransObject ( sqlca )

ds_storico = create uo_ds_gen
ds_storico.DataObject = "ds_storico"
ds_storico.SetTransObject ( sqlca )

ll_rows = dw_elenco.RowCount ( )

for ll_count = 1 to ll_rows
	
	if dw_elenco.GetItemString ( ll_count, "membro" ) = "S" then
	
		ls_cognome = dw_elenco.GetItemString ( ll_count, "cognome" )
		ls_nome = dw_elenco.GetItemString ( ll_count, "nome" )
		ll_code = dw_elenco.GetItemNumber ( ll_count, "codice_membro" )
		ls_dip = dw_elenco.GetItemString ( ll_count, "cod_dip" )
		ls_goh = dw_elenco.GetItemString ( ll_count, "tipo_goh" )
		ld_data = dw_elenco.GetItemDateTime ( ll_count, "data_cer" )
		
		f_log ( gs_context, "Dati di " + trim ( ls_nome ) + " " + ls_cognome + " trasferiti in anagrafica (" + ls_goh + ")" )
		
		if ds_asp.Retrieve ( ll_code, ls_dip ) < 1 then goto errore
		
		if ls_goh = "OKATAGI" then ds_asp.SetItem ( 1, "flag_goh", "S" )
		
		if ds_asp.RowsCopy( 1, 1, Primary!, ds_mem, 10000, Primary!) = -1 then goto errore
		
		if ls_goh = "OKATAGI" then
			
			ds_storico.InsertRow ( 0 )
			ll_row_stor = ds_storico.RowCount ( )
			ds_storico.SetRow ( ll_row_stor )
			ds_storico.SetItem ( ll_row_stor, "codice_membro", ll_code )
			ds_storico.SetItem ( ll_row_stor, "cod_dip", ls_dip )
			ds_storico.SetItem ( ll_row_stor, "tipo_goh", ls_goh )
			ds_storico.SetItem ( ll_row_stor, "data", ld_data )
			ds_storico.SetItem ( ll_row_stor, "cod_causale", "ACQ" )

		end if

	end if

	hpb_asp.position= (ll_count*100)/ll_rows
	
	ds_asp.Reset ( )
	
next

if ds_mem.update ( true, false ) = -1 then goto errore
if ds_storico.update ( ) = -1 then goto errore

//sql_stat = "delete from aspiranti" + is_where
//execute immediate :sql_stat;
dw_elenco.RowsMove(1, dw_elenco.rowCount(), Primary!, dw_elenco, 1, Delete!)

if dw_elenco.update()= -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	goto errore
end if

dw_elenco.reset()

goto fine

errore:

	rollback;
	rollback using tracking;
	
	dw_elenco.reset()
	
	destroy ds_asp
	destroy ds_mem
	destroy ds_storico
	
	OpenWithParm ( w_msgauto, "Aggiornamento non eseguito" )
	f_log_err ( gs_context, "Non eseguito il passaggio membri in anagrafica." )
	return

fine:

	if messageBox(this.title, "Il passaggio in anagrafica è stato eseguito.~n"+&
											"Confermi in modo definitivo l'operazione?", question!, yesNo!, 1)= 2 then goto errore

	commit;
	
	destroy ds_asp
	destroy ds_mem
	destroy ds_storico
	
	OpenWithParm ( w_msgauto, "Aggiornamento effettuato" )
	TriggerEvent ( "query_on" )

end event
public subroutine storico_goh (long v_code, string v_dip, datetime v_data);int nr

ds_storico.InsertRow ( 0 )
nr = ds_storico.RowCount ( )
ds_storico.SetRow ( nr )

ds_storico.SetItem ( nr, "codice_membro", v_code )
ds_storico.SetItem ( nr, "cod_dip", v_dip )
ds_storico.SetItem ( nr, "tipo_goh", "OKATAGI" )
ds_storico.SetItem ( nr, "data", v_data )
ds_storico.SetItem ( nr, "cod_causale", "ACQ" )

end subroutine

public function integer query_mode ();dw_elenco.dataObject= dw_elenco.dataObject

dw_elenco.setTransObject ( sqlca )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=YES" )

dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.setRedraw ( true )

w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public function string dw_status ();string stato

stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public subroutine menu_on ();mq_conf_pass.m_principale.m_stop.disable ( )
mq_conf_pass.m_principale.m_ricerca.enable ( )
mq_conf_pass.m_finestra.m_chiudi.enable ( )
return

end subroutine

public subroutine menu_off ();mq_conf_pass.m_principale.m_stop.enable ( )
mq_conf_pass.m_principale.m_ricerca.disable ( )
mq_conf_pass.m_finestra.m_chiudi.disable ( )

return

end subroutine

public function integer wf_agg_studio ();return 0

end function

public function integer dw_retrieve ();/*
 * estrazione dati in base a definiti criteri...
 */

w_prelude.SetMicroHelp ("Estrazione dati...")

dw_elenco.setRedraw(false)

dw_elenco.modify("dataWindow.queryMode=no")

dw_elenco.setTransObject(sqlca)

retrieved_rows= dw_elenco.retrieve ( )

if retrieved_rows = 0 then return 0

dw_elenco.setRedraw(true)

w_prelude.SetMicroHelp ("")

return 1

end function

on wq_conf_pass.create
if this.MenuName = "mq_conf_pass" then this.MenuID = create mq_conf_pass
this.hpb_asp=create hpb_asp
this.dw_elenco=create dw_elenco
this.Control[]={this.hpb_asp,&
this.dw_elenco}
end on

on wq_conf_pass.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.hpb_asp)
destroy(this.dw_elenco)
end on

event open;PostEvent ( "ue_open" )

end event

event closequery;int li_ret

dw_elenco.AcceptText ( )

if modify then
	
	li_ret = MessageBox ( "Attenzione", "Dati partecipazione modificati... Salvare?", question!, YesNoCancel!, 1 )
																				
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

event resize;dw_elenco.height = this.height -130 -100
hpb_asp.y= dw_elenco.height + 10

end event

event activate;gs_context = "Aspiranti membri"

end event

type hpb_asp from hprogressbar within wq_conf_pass
integer x = 9
integer y = 1624
integer width = 3461
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type dw_elenco from datawindow within wq_conf_pass
event key_down pbm_dwnkey
event select_item pbm_custom01
integer x = 9
integer y = 4
integer width = 3461
integer height = 1596
integer taborder = 10
string dataobject = "dq_conf_pass"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemerror;query_mode ( )
return 1

end event

event retrieverow;if stop_retrieval = true then
	stop_retrieval = false
	return 1
end if

end event

event retrieveend;menu_on ( )

end event

event retrievestart;menu_off ( )

end event

event dberror;MessageBox ( "Errore DB " + string ( SqlDbCode ), SqlErrText, exclamation! )
f_log_err ( gs_context, SqlErrText )
rollback;
rollback using tracking;

return 1

end event

event sqlpreview;//if not saving then
//	
//	if request = PreviewFunctionRetrieve! then
//		
//		il_start = pos ( SqlSyntax, 'WHERE' )
//		il_len = len ( SqlSyntax ) - il_start
//		
//		if il_start = 0 then is_where = "" else is_where = " " + mid ( SqlSyntax, il_start, il_len )
//		
//	end if
//	
//else
//	
//	SetSqlPreview ( SqlSyntax + is_where )
//	
//end if

end event

event itemchanged;if dw_status ( ) = "no" then
	modify = true
	mq_conf_pass.m_principale.m_salva.enable ( )
end if

end event

