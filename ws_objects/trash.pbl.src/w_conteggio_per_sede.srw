$PBExportHeader$w_conteggio_per_sede.srw
forward
global type w_conteggio_per_sede from window
end type
type dw_elenco from uo_dwselect within w_conteggio_per_sede
end type
type gb_dett from groupbox within w_conteggio_per_sede
end type
type s_cons from structure within w_conteggio_per_sede
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

global type w_conteggio_per_sede from window
integer x = 5
integer y = 4
integer width = 4992
integer height = 2356
boolean titlebar = true
string title = "Esami di studio"
string menuname = "m_conteggio"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event uscita ( )
event clear ( string ls_from )
event type integer save ( )
event query_on ( )
event query_off ( )
event query_start ( )
event ordina ( )
event stampa ( )
event type integer ue_salva_come ( )
dw_elenco dw_elenco
gb_dett gb_dett
end type
global w_conteggio_per_sede w_conteggio_per_sede

type variables
boolean ib_closing = false
boolean calling = false

s_esami str_es
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status

DataWindowChild idwc_liv
DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru

end variables

forward prototypes
public function integer f_canc_lista ()
public function string dw_status ()
public function integer query_mode ()
public function integer dw_retrieve ()
end prototypes

event ue_open;dw_elenco.SetTransObject ( sqlca )


//this.TriggerEvent ( "query_start" )
this.TriggerEvent ( "query_off" )

end event
event uscita;ib_closing = true

close ( this )

end event

event clear;if dw_elenco.DataObject = "d_lista" then

	int li_ret
	
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
	
end if

dw_elenco.SetRedraw ( false )
dw_elenco.DataObject = "d_lista"
dw_elenco.SetTransObject ( sqlca )
SetRedraw ( dw_elenco, true )

dw_elenco.visible = false

SetNull ( status )

gb_dett.text = ""

end event

event save;dw_elenco.SetRedraw ( false )

if dw_elenco.Update ( ) = -1 then
	
	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
		halt close
	end if
	
	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	
	OpenWithParm ( w_msgauto, "Modifiche annullate" )
	
	dw_elenco.SetRedraw ( true )
	
	return -1
	
else
	
	commit;
	
	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
		halt close
	end if

	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
	
	dw_elenco.SetRedraw ( true )
	
end if

return 0

end event

event query_on;int li_colnum
string ls_colname, ls_null

dw_elenco.SetRedraw ( false )

//for li_colnum = 3 to 10
//	
//	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
//	dw_elenco.Modify(ls_colname+".Protect=0")
//
//next

dw_elenco.modify ( "flag_ok.visible=0" )
dw_elenco.modify ( "conf_t.visible=0" )
//dw_elenco.Modify ( "DataWindow.Footer.Height='1'" )

query_mode ( )

dw_elenco.SetRedraw ( true )

dw_elenco.SetFocus ( )

m_conteggio.m_opzioni.m_stampa.enabled = false
m_conteggio.m_opzioni.m_salvacome.enabled = false

end event

event query_off;int li_colnum
string ls_colname

if dw_retrieve ( ) = 0 then
	
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	
	return
	
end if

dw_elenco.SetRedraw ( false )

if dw_elenco.RowCount ( ) > 0 then
	
	for li_colnum = 3 to 10
		
		ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
		dw_elenco.Modify(ls_colname+".Protect=1")
		
	next
	
	dw_elenco.modify ( "flag_ok.visible=1" )
	dw_elenco.modify ( "conf_t.visible=1" )
//	dw_elenco.Modify ( "DataWindow.Footer.Height='92'" )
	
end if

dw_elenco.SetRedraw ( true )
dw_elenco.setFocus ( )

m_conteggio.m_opzioni.m_stampa.enabled = true
m_conteggio.m_opzioni.m_salvacome.enabled = true

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

event stampa;dw_elenco.SetRedraw ( false )
//dw_elenco.Object.n_pag.visible = 1
//dw_elenco.Object.DataWindow.Footer.Height = 165

OpenWithParm ( w_dw_print_options, this.dw_elenco )

//dw_elenco.Object.n_pag.visible = 0
//dw_elenco.Object.DataWindow.Footer.Height = 85
dw_elenco.SetRedraw ( true )

end event

event ue_salva_come;int li_colnum
string ls_colname, ls_msg

open ( w_aut_print )

if Message.DoubleParm = -1 then return -1

ls_msg = "Salvato su file per " + Message.StringParm

if dw_elenco.SaveAs()= -1 then return -1

f_log ( gs_context, ls_msg )

return 0
end event

public function integer f_canc_lista ();open ( w_wait )

delete from esami
 where data_esame = :str_es.v_data
	and sede = :str_es.v_sede
	and cod_studio = :str_es.v_liv;

close ( w_wait )
	
if trap_sql ( sqlca, "cancellazione lista candidati" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	return -1
else
	commit;
	return 0
end if

return 0

end function

public function string dw_status ();string stato

stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public function integer query_mode ();dw_elenco.dataObject= dw_elenco.dataObject

dw_elenco.setTransObject ( sqlca )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=YES" )

//dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.setRedraw ( true )

w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public function integer dw_retrieve ();long ll_rows
/*
 * estrazione dati in base a definiti criteri...
 */
dw_elenco.acceptText()

w_prelude.SetMicroHelp ( "Estrazione dati..." )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=no" )

//dw_elenco.setTransObject ( sqlca )

ll_rows= dw_elenco.retrieve ( )

// GdS
commit using sqlca;

if ll_rows = 0 then return 0

dw_elenco.setRedraw ( true )

dw_elenco.TriggerEvent ( GetFocus! )

w_prelude.SetMicroHelp ( "" )

return 1
end function

event dw_retrieve;int li_colnum
string ls_colname, ls_msg

open ( w_aut_print )

//if Message.DoubleParm = -1 then return -1

ls_msg = "Salvato su file per " + Message.StringParm

//if dw_elenco.SaveAs()= -1 then return -1

f_log ( gs_context, ls_msg )

//return 0
end event

on w_conteggio_per_sede.create
if this.MenuName = "m_conteggio" then this.MenuID = create m_conteggio
this.dw_elenco=create dw_elenco
this.gb_dett=create gb_dett
this.Control[]={this.dw_elenco,&
this.gb_dett}
end on

on w_conteggio_per_sede.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_elenco)
destroy(this.gb_dett)
end on

event open;PostEvent ( "ue_open" )

end event

event closequery;if dw_elenco.DataObject = "d_lista" then

	int li_ret
	
	dw_elenco.AcceptText ( )
	
	if dw_elenco.ModifiedCount ( ) > 0 then
		
		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
									 question!, YesNoCancel!, 1 )
																					
		choose case li_ret
				
			case 1
				
				if event save ( ) = -1 then
					ib_closing = false
					return 1
				else
					return 0
				end if
				
			case 2
				
				return 0
				
			case 3
				
				ib_closing = false
				return 1
				
		end choose
		
	end if
	
end if

end event

event activate;gs_context = "Esami di studio"

end event

event resize;gb_dett.width= this.width - 90
dw_elenco.width= gb_dett.width - 60


gb_dett.height= this.height - 200 - gb_dett.y

dw_elenco.height= gb_dett.height -60

end event
type dw_elenco from uo_dwselect within w_conteggio_per_sede
integer x = 50
integer y = 60
integer width = 4777
integer height = 1536
integer taborder = 0
string dataobject = "dw_conteggio_per_sedi"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event sqlpreview;call super::sqlpreview;if this.DataObject = "d_import" then

	string ls_stat
	
	if SqlType = PreviewSelect! then
		
		if pos ( SqlSyntax, "WHERE" ) = 0 then
			
			if is_liv <> "00" then
			
				ls_stat = " WHERE membri.cod_dis NOT IN ('DEC', 'TFE', 'DIM', 'TAI') AND" + &
							 " membri.cod_studio = '" + is_liv + "' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "

			else
				
				ls_stat = " WHERE membri.cod_dis NOT IN ('DEC', 'TFE', 'DIM', 'TAI') AND" + &
							 " membri.cod_studio = '00' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "
							 
			end if
				
		else
			
			if not IsNull ( is_liv ) then
			
				ls_stat = " and membri.cod_dis NOT IN ('DEC', 'TFE', 'DIM', 'TAI') AND" + &
							 " membri.cod_studio = '" + is_liv + "' AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "

			else
				
				ls_stat =" and membri.cod_dis NOT IN ('DEC', 'TFE', 'DIM', 'TAI') AND" + &
							 " membri.cod_studio = null AND " + &
							 " convert ( varchar ( 20 ), membri.codice_membro ) +" + &
							 " membri.cod_dip not in " + &
							 " ( SELECT convert ( varchar ( 20 ), esami.codice_membro ) +" + &
							 " esami.cod_dip FROM esami ) "
							 
			end if
			
		end if	
				
		SetSqlPreview ( SqlSyntax + ls_stat )
		
	end if

end if

end event

event getfocus;if dw_status ( ) = "NO" then
	
	SelectRow(0, false)
	SelectRow(1, true)
	
	il_rows = RowCount()
	
end if

end event

event itemfocuschanged;call super::itemfocuschanged;long l_rows, err_code

string resp_code, ls_col

string where_clause, ls_area, ls_terr, ls_cen, ls_cap, ls_sett, ls_gru

if this.DataObject = "d_import" then

	resp_code= dw_elenco.describe("dataWindow.queryMode")
	
	ls_col = dwo.name
	
	if row < 1 then return
	
	if resp_code = "yes" then
		
		CHOOSE CASE dwo.name
				
			CASE "cod_area"
	 
				where_clause= " where aree.cod_area<>~~'"+"A"+"~~'" 
				
				err_code = this.GetChild ( 'cod_area',idwc_area )
				
				l_rows= f_mod_select(where_clause, idwc_area)
	
			CASE "cod_terr"
	 
				where_clause= " or territori.cod_area=~~'"+c_area+"~~'" 
				

				this.GetChild ( 'cod_terr',idwc_terr )
				
				l_rows= f_mod_select(where_clause, idwc_terr)
	
			CASE "cod_cen"
	 
				where_clause= " or (centri.cod_area=~~'"+c_area+"~~' and centri.cod_terr=~~'"+c_terr+"~~')" 
				
				this.GetChild ( 'cod_cen',idwc_cen )
				
				l_rows= f_mod_select(where_clause, idwc_cen)
	
			CASE "cod_cap"
	
				where_clause= 	" or (capitoli.cod_area=~~'"+c_area+ &
									"~~' and capitoli.cod_terr= ~~'"+c_terr+"~~' and "+ &
									" capitoli.cod_cen= ~~'"+c_cen+"~~')"
									
				this.GetChild ( 'cod_cap',idwc_cap )
				
				l_rows= f_mod_select(where_clause, idwc_cap)
	
			CASE "cod_sett"
	
				where_clause= " or (settori.cod_area= ~~'"+c_area+"~~' and "+ &
								  " settori.cod_terr= ~~'"+c_terr+"~~' and "+ &
								  " settori.cod_cen= ~~'"+c_cen+"~~' and "+&
								  " settori.cod_cap= ~~'"+c_cap+"~~')"
								  
				this.GetChild ( 'cod_sett',idwc_sett )
				
				l_rows= f_mod_select(where_clause, idwc_sett)
	
	
			CASE "cod_gru"
	
				where_clause= " or (gruppi.cod_area= ~~'"+c_area+"~~' and "+ &
								  " gruppi.cod_terr= ~~'"+c_terr+"~~' and "+ &
								  " gruppi.cod_cen= ~~'"+c_cen+"~~' and "+&
								  " gruppi.cod_cap= ~~'"+c_cap+"~~' and "+&
								  " gruppi.cod_sett= ~~'"+c_sett+"~~')"
									 
				this.GetChild ( 'cod_gru',idwc_gru )
				
				l_rows= f_mod_select(where_clause, idwc_gru)
				
	
		END CHOOSE
	
	else
		
	end if
	
end if

end event

event dberror;call super::dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event retrievestart;call super::retrievestart;open ( w_wait )



end event

event retrieveend;close ( w_wait )

dw_elenco.Object.DataWindow.Print.Preview= "Yes"

end event

event updatestart;call super::updatestart;open ( w_wait )

end event

event updateend;call super::updateend;close ( w_wait )

end event

event editchanged;call super::editchanged;if dwo.name= "data_cer" then 
	f_checkdate(dw_elenco)
end if
end event

type gb_dett from groupbox within w_conteggio_per_sede
integer x = 23
integer y = 8
integer width = 4855
integer height = 1620
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

