$PBExportHeader$w_stampa_resp.srw
forward
global type w_stampa_resp from window
end type
type dw_lev_resp from datawindow within w_stampa_resp
end type
type dw_elenco from datawindow within w_stampa_resp
end type
type gb_resp from groupbox within w_stampa_resp
end type
end forward

global type w_stampa_resp from window
integer width = 4183
integer height = 2400
boolean titlebar = true
string title = "Report responsabili"
string menuname = "m_stampe_gen"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event query_on pbm_custom01
event query_off pbm_custom02
event ue_open pbm_custom03
event query_start pbm_custom04
event ordina pbm_custom05
event stampa pbm_custom06
event stop pbm_custom07
event f_page pbm_custom08
event p_page pbm_custom09
event n_page pbm_custom10
event l_page pbm_custom11
event type integer ue_salva_come ( )
dw_lev_resp dw_lev_resp
dw_elenco dw_elenco
gb_resp gb_resp
end type
global w_stampa_resp w_stampa_resp

type variables
boolean stop_retrieval = false
long retrieved_rows, t_row, il_start, il_len

int ii_col, sort_order = 1, ii_min=100, ii_max=899

string is_dis, is_d_obj, is_where, is_filter, is_cognome
string c_area, c_terr, c_cen, c_cap, c_sett, c_gru

DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru

end variables

forward prototypes
public function integer query_mode ()
public function string dw_status ()
public subroutine menu_on ()
public subroutine menu_off ()
public function integer dw_retrieve ()
end prototypes

event query_on;int li_colnum
string ls_colname

m_stampe_gen.m_pagine.m_prima.disable ( )
m_stampe_gen.m_pagine.m_prec.disable ( )
m_stampe_gen.m_pagine.m_succ.disable ( )
m_stampe_gen.m_pagine.m_ultima.disable ( )
m_stampe_gen.m_principale.m_ordina.disable ( )
m_stampe_gen.m_principale.m_salvacome.disable ( )
m_stampe_gen.m_principale.m_stampa.disable ( )

m_stampe_gen.m_principale.m_ricerca.ToolBarItemName = "Retrieve!"

dw_elenco.SetRedraw ( false )

for li_colnum = 1 to ii_col
	
	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
	dw_elenco.Modify(ls_colname+".Protect=0")

next

gb_resp.visible = false
dw_lev_resp.visible = false

dw_lev_resp.SetItem ( 1,1,100 )
dw_lev_resp.SetItem ( 1,2,899 )

ii_min = 100
ii_max = 899

is_filter = "liv_resp >= " + string ( ii_min ) + " and liv_resp <= " + string ( ii_max )

dw_elenco.SetFilter ( is_filter )
dw_elenco.Filter ( )

//dw_elenco.Modify ( "DataWindow.Print.Preview = no" )

dw_elenco.Modify ( "DataWindow.Print.Orientation = 0" )

query_mode ( )

dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.SetRedraw ( true )
dw_elenco.SetFocus ( )

end event

event query_off;int li_colnum
string ls_colname

if dw_retrieve ( ) = 0 then
	
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	return
	
end if

// GdS
commit using sqlca;

dw_elenco.SetRedraw ( false )

gb_resp.visible = true
dw_lev_resp.visible = true

m_stampe_gen.m_principale.m_ricerca.ToolBarItemName = "Search!"

if dw_elenco.RowCount ( ) > 0 then
	
	for li_colnum = 1 to ii_col
		
		ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
		dw_elenco.Modify(ls_colname+".Protect=1")
		
	next

//	dw_elenco.Modify ( "DataWindow.Print.Preview = yes" )
	dw_elenco.Modify ( "DataWindow.Print.Orientation = 1" )
	
	if is_d_obj <> "r_simple" then dw_elenco.Object.DataWindow.Footer.Height = 85
	
	if u_lev < 4 or u_lev > 6 then m_stampe_gen.m_principale.m_salvacome.enable ( )
	if u_lev < 4 or u_lev > 6 then m_stampe_gen.m_principale.m_stampa.enable ( )
	m_stampe_gen.m_principale.m_ordina.enable ( )
	m_stampe_gen.m_pagine.m_prima.enable ( )
	m_stampe_gen.m_pagine.m_prec.enable ( )
	m_stampe_gen.m_pagine.m_succ.enable ( )
	m_stampe_gen.m_pagine.m_ultima.enable ( )
	
end if

dw_elenco.SetRedraw ( true )
dw_elenco.setFocus ( )

end event

event ue_open;dw_lev_resp.SetFocus ( )

dw_lev_resp.InsertRow ( 0 )

dw_lev_resp.SetItem ( 1,1,100 )
dw_lev_resp.SetItem ( 1,2,899 )

dw_elenco.SetRedraw ( false )

ii_col = integer ( dw_elenco.Object.DataWindow.Column.Count )

query_mode ( )

dw_elenco.SetRedraw ( true )

dw_elenco.SetFocus ( )

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
if dw_elenco.DataObject = "r_simple" then dw_elenco.GroupCalc ( )

end event

event stampa;int li_colnum
string ls_colname, ls_msg

open ( w_aut_print )

if Message.DoubleParm = -1 then return

ls_msg = "Stampato per " + Message.StringParm

dw_elenco.SetRedraw ( false )

if dw_elenco.RowCount ( ) > 0 then
	
	for li_colnum = 1 to ii_col
		
		ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
		dw_elenco.Modify(ls_colname+".Font.Face='Arial Narrow'")
		
	next

	
end if

OpenWithParm ( w_dw_print_options, this.dw_elenco )

for li_colnum = 1 to ii_col
	
	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
	dw_elenco.Modify(ls_colname+".Font.Face='Arial'")
	
next

dw_elenco.SetRedraw ( true )
	
if Message.DoubleParm = -1 then return

f_log ( gs_context, ls_msg )

end event

event stop;stop_retrieval = true

end event

event f_page;dw_elenco.ScrollToRow ( 1 )

end event

event p_page;dw_elenco.ScrollPriorPage ( )

end event

event n_page;dw_elenco.ScrollNextPage ( )

end event

event l_page;dw_elenco.ScrollToRow ( dw_elenco.RowCount ( ) )

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

public subroutine menu_on ();m_stampe_gen.m_principale.m_stop.disable ( )
m_stampe_gen.m_principale.m_ricerca.enable ( )
m_stampe_gen.m_finestra.m_chiudi.enable ( )
return

end subroutine

public subroutine menu_off ();m_stampe_gen.m_principale.m_stop.enable ( )
m_stampe_gen.m_principale.m_ricerca.disable ( )
m_stampe_gen.m_finestra.m_chiudi.disable ( )
return

end subroutine

public function integer dw_retrieve ();/*
 * estrazione dati in base a definiti criteri...
 */

w_prelude.SetMicroHelp ("Estrazione dati...")

dw_elenco.acceptText()

dw_elenco.setRedraw(false)

dw_elenco.modify("dataWindow.queryMode=no")

dw_elenco.setTransObject(sqlca)

retrieved_rows= dw_elenco.retrieve ( )

if retrieved_rows = 0 then return 0

dw_elenco.setRedraw(true)

w_prelude.SetMicroHelp ("")

return 1

end function

on w_stampa_resp.create
if this.MenuName = "m_stampe_gen" then this.MenuID = create m_stampe_gen
this.dw_lev_resp=create dw_lev_resp
this.dw_elenco=create dw_elenco
this.gb_resp=create gb_resp
this.Control[]={this.dw_lev_resp,&
this.dw_elenco,&
this.gb_resp}
end on

on w_stampa_resp.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_lev_resp)
destroy(this.dw_elenco)
destroy(this.gb_resp)
end on

event open;PostEvent ( "ue_open" )

end event

event resize;dw_elenco.height = this.height -430

dw_elenco.width= this.width -120

end event

event activate;gs_context = "Report responsabili"

end event

type dw_lev_resp from datawindow within w_stampa_resp
boolean visible = false
integer x = 55
integer y = 72
integer width = 2491
integer height = 100
integer taborder = 20
string dataobject = "d_lev_resp"
boolean border = false
boolean livescroll = true
end type

event itemchanged;choose case dwo.name
		
	case "minimo"
		
		ii_min = integer ( data )
		
	case "massimo"
		
		ii_max = integer ( data )
		
	case "cbx_dis"
		
		if this.getItemString(row, "cbx_dis")= 'S' then
			is_dis =" and  flag_dis=~'N~'"
		else
			is_dis =""
		end if
		
end choose

if ii_max < ii_min then
	MessageBox ( "Errore", "Incongruenza dati", Exclamation! )
	return
end if

is_filter = "liv_resp >= " + string ( ii_min ) + " and liv_resp <= " + string ( ii_max )+is_dis

dw_elenco.SetFilter ( is_filter )
dw_elenco.Filter ( )

end event

type dw_elenco from datawindow within w_stampa_resp
event key_down pbm_dwnkey
event select_item pbm_custom01
integer x = 27
integer y = 220
integer width = 4046
integer height = 1544
integer taborder = 30
string dataobject = "r_simple_resp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
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

event retrieveend;close ( w_wait )

menu_on ( )

end event

event retrievestart;open ( w_wait )

menu_off ( )

end event

event itemchanged;if row > 0 AND this.Object.DataWindow.QueryMode='yes' then

	CHOOSE CASE dwo.name
			
		CASE "cod_area"
 
			c_area = f_replace_chars ( this.getText(), "'", "" )

		CASE "cod_terr"
 
			c_terr = f_replace_chars(this.getText(), "'", "")
			
		CASE "cod_cen"

			c_cen = f_replace_chars(this.getText(), "'", "")

		CASE "cod_cap"

			c_cap = f_replace_chars(this.getText(), "'", "")
			
		CASE "cod_sett"

			c_sett = f_replace_chars(this.getText(), "'", "")
			
		case "membri_cognome"
			
			is_cognome=  f_replace_chars(this.getText(), "'", "''")

	END CHOOSE

end if

end event

event itemfocuschanged;long l_rows, err_code

string resp_code, ls_col

string where_clause, ls_area, ls_terr, ls_cen, ls_cap, ls_sett, ls_gru

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

end event

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event editchanged;if dwo.name = "membri_data_cer" OR dwo.name = "membri_data_nas" then f_checkdate ( dw_elenco )
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_elenco)

setSqlPreview(sqlsyntax)
end event

type gb_resp from groupbox within w_stampa_resp
boolean visible = false
integer x = 23
integer y = 12
integer width = 2546
integer height = 188
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Responsabilità"
end type

