$PBExportHeader$w_search_dbl.srw
$PBExportComments$Finestra gestione doppi inserimenti
forward
global type w_search_dbl from window
end type
type st_wait from statictext within w_search_dbl
end type
type cb_2 from commandbutton within w_search_dbl
end type
type cb_1 from commandbutton within w_search_dbl
end type
type dw_mem_1 from datawindow within w_search_dbl
end type
type dw_mem_2 from datawindow within w_search_dbl
end type
type p_goh_1 from picture within w_search_dbl
end type
type st_3 from statictext within w_search_dbl
end type
type p_studio_1 from picture within w_search_dbl
end type
type st_7 from statictext within w_search_dbl
end type
type p_zaimu_1 from picture within w_search_dbl
end type
type st_8 from statictext within w_search_dbl
end type
type p_offerte_1 from picture within w_search_dbl
end type
type st_9 from statictext within w_search_dbl
end type
type st_10 from statictext within w_search_dbl
end type
type p_offerte_2 from picture within w_search_dbl
end type
type st_11 from statictext within w_search_dbl
end type
type p_zaimu_2 from picture within w_search_dbl
end type
type st_12 from statictext within w_search_dbl
end type
type p_studio_2 from picture within w_search_dbl
end type
type st_16 from statictext within w_search_dbl
end type
type p_goh_2 from picture within w_search_dbl
end type
type dw_elenco from uo_dwselect within w_search_dbl
end type
type st_2 from statictext within w_search_dbl
end type
type st_ret from statictext within w_search_dbl
end type
end forward

global type w_search_dbl from window
integer width = 3666
integer height = 2400
boolean titlebar = true
string title = "Gestione doppi inserimenti"
string menuname = "m_search_dbl"
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
event stop ( )
event ue_select ( )
event clear ( )
event wait ( )
st_wait st_wait
cb_2 cb_2
cb_1 cb_1
dw_mem_1 dw_mem_1
dw_mem_2 dw_mem_2
p_goh_1 p_goh_1
st_3 st_3
p_studio_1 p_studio_1
st_7 st_7
p_zaimu_1 p_zaimu_1
st_8 st_8
p_offerte_1 p_offerte_1
st_9 st_9
st_10 st_10
p_offerte_2 p_offerte_2
st_11 st_11
p_zaimu_2 p_zaimu_2
st_12 st_12
p_studio_2 p_studio_2
st_16 st_16
p_goh_2 p_goh_2
dw_elenco dw_elenco
st_2 st_2
st_ret st_ret
end type
global w_search_dbl w_search_dbl

type variables
boolean stop_retrieval = false
long retrieved_rows, t_row
long n = 0
int sort_order = 1
int il_count = 0
DataWindowChild dwc_alb, dwc_mezzo
string is_dis, is_cognome
string vi_turno = '0002'
string is_tabs[4]={"storico_goh", "curr_studio", "zaimu","offerte"}
picture paint[2,4]

end variables

forward prototypes
public function integer query_mode ()
public function integer dw_retrieve ()
public function string dw_status ()
public subroutine menu_on ()
public subroutine menu_off ()
public function integer wf_tb_dip (long ll_code, string ls_dip, integer li_num)
public function integer wf_cancella (long ll_code_a, string ls_dip_a, long ll_code_c, string ls_dip_c)
public function integer dw_select_item (long row)
end prototypes

event query_on;int li_colnum
string ls_colname

m_search_dbl.m_opzioni.m_cerca.ToolBarItemName = "Retrieve!"

il_count = 0

TriggerEvent ( "clear" )

dw_elenco.SetRedraw ( false )

for li_colnum = 1 to 4
	
	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
	dw_elenco.Modify(ls_colname+".Protect=0")
	
next

dw_elenco.Modify ( "DataWindow.Print.Preview = no" )
dw_elenco.Object.DataWindow.Footer.Height = 0
dw_elenco.Object.DataWindow.Summary.Height = 0

query_mode ( )

dw_elenco.enabled = true

dw_elenco.SetRedraw ( true )
dw_elenco.SetFocus ( )

end event

event query_off;int li_colnum
string ls_colname

dw_elenco.acceptText()

if dw_retrieve ( ) = 0 then
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	return
end if
dw_elenco.SetRedraw ( false )

for li_colnum = 1 to 4
	
	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
	dw_elenco.Modify(ls_colname+".Protect=1")
	
next

m_search_dbl.m_opzioni.m_cerca.ToolBarItemName = "Search!"

dw_elenco.SetRedraw ( true )
dw_elenco.setFocus ( )

end event

event ue_open;dw_elenco.SetTransObject ( sqlca )
dw_mem_1.SetTransObject ( sqlca )
dw_mem_2.SetTransObject ( sqlca )

query_mode ( )

dw_elenco.SetFocus ( )

paint[1,1] = p_goh_1
paint[1,2] = p_studio_1
paint[1,3] = p_zaimu_1
paint[1,4] = p_offerte_1
paint[2,1] = p_goh_2
paint[2,2] = p_studio_2
paint[2,3] = p_zaimu_2
paint[2,4] = p_offerte_2

end event

event query_start;if dw_status ( ) = 'no' then
	TriggerEvent ( "query_on" )
else
	TriggerEvent ( "query_off" )
end if

end event

event stop;stop_retrieval = true

end event

event ue_select;long ll_code_1, ll_code_2, ll_rows, n_row
string ls_dip_1, ls_dip_2, ls_cognome_1, ls_nome_1, ls_cognome_2, ls_nome_2, ls_sel_1, ls_sel_2
int li_ret

if il_count < 2 then
	MessageBox ( "Attenzione", "Selezionare 2 nominativi", Exclamation! )
	return
end if

dw_elenco.enabled = false

il_count = 0

ll_rows = dw_elenco.RowCount( )

if ll_rows < 1 then return

st_wait.visible = true

m_search_dbl.m_opzioni.m_seleziona.disable ( )

for n_row = 1 to ll_rows
	
	if dw_elenco.IsSelected ( n_row ) then
		
		il_count = il_count + 1
		
		li_ret = dw_select_item ( n_row )
		
		choose case li_ret
				
			case -1
			
				TriggerEvent ( "query_on" )
				return
				
			case -2
				
				close ( this )
				return
				
			case else
			
		end choose
		
	end if
	
next

ll_code_1 = dw_mem_1.GetItemNumber ( 1, 1 )
ls_dip_1 = dw_mem_1.GetItemString ( 1, 2 )
ls_cognome_1 = dw_mem_1.GetItemString ( 1, 3 )
ls_nome_1 = dw_mem_1.GetItemString ( 1, 4 )
ll_code_2 = dw_mem_2.GetItemNumber ( 1, 1 )
ls_dip_2 = dw_mem_2.GetItemString ( 1, 2 )
ls_cognome_2 = dw_mem_2.GetItemString ( 1, 3 )
ls_nome_2 = dw_mem_2.GetItemString ( 1, 4 )

ls_sel_1 = string ( ll_code_1 ) + " " + ls_dip_1 + " - " + trim ( ls_cognome_1 ) + " " + ls_nome_1
ls_sel_2 = string ( ll_code_2 ) + " " + ls_dip_2 + " - " + trim ( ls_cognome_2 ) + " " + ls_nome_2

PostEvent ( "wait" )


end event

event clear;int li_p1, li_p2

m_search_dbl.m_opzioni.m_seleziona.disable ( )

dw_mem_1.Reset ( )
dw_mem_2.Reset ( )

cb_1.enabled = false
cb_2.enabled = false

for li_p1 = 1 to 2
	
	for li_p2 = 1 to 4
		
		paint[li_p1, li_p2].PictureName = "d_gray.bmp"
		
	next
	
next

end event

event wait;st_wait.visible = false

cb_1.enabled = true
cb_2.enabled = true

end event

public function integer query_mode ();dw_elenco.dataObject= dw_elenco.dataObject

dw_elenco.setTransObject(sqlca)

dw_elenco.setRedraw(false)

dw_elenco.modify("dataWindow.queryMode=YES")

dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.setRedraw(true)

w_prelude.SetMicroHelp ("Modalita' Ricerca: impostare i criteri di estrazione...")

st_ret.text = "0"

return 0

end function

public function integer dw_retrieve ();/*
 * estrazione dati in base a definiti criteri...
 */

w_prelude.SetMicroHelp ("Estrazione dati...")

dw_elenco.setRedraw(false)

dw_elenco.modify("dataWindow.queryMode=no")

dw_elenco.setTransObject(sqlca)

retrieved_rows= dw_elenco.retrieve ( )

st_ret.text = string ( retrieved_rows )

if retrieved_rows = 0 then return 0

dw_elenco.setRedraw(true)

w_prelude.SetMicroHelp ("")

return 1

end function

public function string dw_status ();string stato

stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public subroutine menu_on ();m_search_dbl.m_opzioni.m_stop.disable ( )
m_search_dbl.m_opzioni.m_cerca.enable ( )
m_search_dbl.m_opzioni.m_seleziona.enable ( )
m_search_dbl.m_finestra.m_chiudi.enable ( )
return

end subroutine

public subroutine menu_off ();m_search_dbl.m_opzioni.m_stop.enable ( )
m_search_dbl.m_opzioni.m_cerca.disable ( )
m_search_dbl.m_finestra.m_chiudi.disable ( )
return

end subroutine

public function integer wf_tb_dip (long ll_code, string ls_dip, integer li_num);string ls_stat
int li_tab, li_ret

for li_tab = 1 to 4
	
	declare crs_count dynamic cursor for sqlsa;
	
	ls_stat = "select count(*) from " + is_tabs[li_tab] + " where codice_membro = ? and cod_dip = ?"
	prepare sqlsa from :ls_stat;
	open dynamic crs_count using :ll_code, :ls_dip;
	fetch crs_count into :li_ret;
	
	if sqlca.Sqlcode = -1 then 
		f_log_err ( gs_context, sqlca.SqlErrText )
		MessageBox ( "Errore Db " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText, StopSign! )
		return -1
	end if
	
	if li_ret > 0 then paint[li_num, li_tab].PictureName = "d_yellow.bmp"
	
	close crs_count;
	
next

return 0

end function

public function integer wf_cancella (long ll_code_a, string ls_dip_a, long ll_code_c, string ls_dip_c);string ls_stat
int li_tab

for li_tab = 1 to 4

	ls_stat = "update " + is_tabs[li_tab] + " set codice_membro = ?, cod_dip = ? where " + &
				 "codice_membro = ? and cod_dip = ?"
				 
	prepare sqlsa from :ls_stat;
	
	execute sqlsa using :ll_code_a, :ls_dip_a, :ll_code_c, :ls_dip_c;
	
	if sqlca.SqlCode = -1 then
		
		if sqlca.SqlDbCode <> 2601 then
			
			f_log_err ( gs_context, sqlca.SqlErrText )
			MessageBox ( "Errore Db " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText, StopSign! )
			
			return -1
			
		end if
		
	end if
	
next

delete from membri
where codice_membro = :ll_code_c
and cod_dip = :ls_dip_c;

if sqlca.SqlCode = -1 then
	
	f_log_err ( gs_context, sqlca.SqlErrText )
	MessageBox ( "Errore Db " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText, StopSign! )
		
	return -1
		
end if

return 0

end function

public function integer dw_select_item (long row);long ll_code
string ls_dip

ll_code = dw_elenco.GetItemNumber ( row, 1 )
ls_dip = dw_elenco.GetItemString ( row, 2 )

choose case il_count
		
	case 1
		
		if dw_mem_1.Retrieve ( ll_code, ls_dip ) < 1 then return -1
		if wf_tb_dip ( ll_code, ls_dip, il_count ) = -1 then return -1
		
	case 2
		
		if dw_mem_2.Retrieve ( ll_code, ls_dip ) < 1 then return -1
		if wf_tb_dip ( ll_code, ls_dip, il_count ) = -1 then return -1
		
	case else
		
//		f_log ( "Errore", "Finestra w_search,  oggetto dw_elenco, evento/funzione <dw_select_item>" )
		MessageBox ( "Errore grave", "Contattare il CED.", StopSign! )
		return -2
		
end choose

return 0

end function

on w_search_dbl.create
if this.MenuName = "m_search_dbl" then this.MenuID = create m_search_dbl
this.st_wait=create st_wait
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_mem_1=create dw_mem_1
this.dw_mem_2=create dw_mem_2
this.p_goh_1=create p_goh_1
this.st_3=create st_3
this.p_studio_1=create p_studio_1
this.st_7=create st_7
this.p_zaimu_1=create p_zaimu_1
this.st_8=create st_8
this.p_offerte_1=create p_offerte_1
this.st_9=create st_9
this.st_10=create st_10
this.p_offerte_2=create p_offerte_2
this.st_11=create st_11
this.p_zaimu_2=create p_zaimu_2
this.st_12=create st_12
this.p_studio_2=create p_studio_2
this.st_16=create st_16
this.p_goh_2=create p_goh_2
this.dw_elenco=create dw_elenco
this.st_2=create st_2
this.st_ret=create st_ret
this.Control[]={this.st_wait,&
this.cb_2,&
this.cb_1,&
this.dw_mem_1,&
this.dw_mem_2,&
this.p_goh_1,&
this.st_3,&
this.p_studio_1,&
this.st_7,&
this.p_zaimu_1,&
this.st_8,&
this.p_offerte_1,&
this.st_9,&
this.st_10,&
this.p_offerte_2,&
this.st_11,&
this.p_zaimu_2,&
this.st_12,&
this.p_studio_2,&
this.st_16,&
this.p_goh_2,&
this.dw_elenco,&
this.st_2,&
this.st_ret}
end on

on w_search_dbl.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_wait)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_mem_1)
destroy(this.dw_mem_2)
destroy(this.p_goh_1)
destroy(this.st_3)
destroy(this.p_studio_1)
destroy(this.st_7)
destroy(this.p_zaimu_1)
destroy(this.st_8)
destroy(this.p_offerte_1)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.p_offerte_2)
destroy(this.st_11)
destroy(this.p_zaimu_2)
destroy(this.st_12)
destroy(this.p_studio_2)
destroy(this.st_16)
destroy(this.p_goh_2)
destroy(this.dw_elenco)
destroy(this.st_2)
destroy(this.st_ret)
end on

event open;PostEvent ( "ue_open" )

end event

event activate;gs_context = "Doppi inserimenti"

end event

type st_wait from statictext within w_search_dbl
boolean visible = false
integer x = 1193
integer y = 1084
integer width = 814
integer height = 76
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 25680629
boolean enabled = false
string text = "ATTENDERE..."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_search_dbl
integer x = 2793
integer y = 1088
integer width = 398
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cancella"
end type

event clicked;long ll_code_a, ll_code_c
string ls_dip_a, ls_dip_c, ls_cognome, ls_nome, ls_cognome_a, ls_nome_a, ls_to_canc, ls_to_merge
int li_ret

ll_code_a = dw_mem_1.GetItemNumber ( 1, 1 )
ls_dip_a = dw_mem_1.GetItemString ( 1, 2 )
ls_cognome_a = dw_mem_1.GetItemString ( 1, 3 )
ls_nome_a = dw_mem_1.GetItemString ( 1, 4 )
ll_code_c = dw_mem_2.GetItemNumber ( 1, 1 )
ls_dip_c = dw_mem_2.GetItemString ( 1, 2 )
ls_cognome = dw_mem_2.GetItemString ( 1, 3 )
ls_nome = dw_mem_2.GetItemString ( 1, 4 )
ls_to_canc = string ( ll_code_c ) + " " + ls_dip_c + " - " + trim ( ls_cognome ) + " " + ls_nome
ls_to_merge = string ( ll_code_a ) + " " + ls_dip_a + " - " + trim ( ls_cognome_a ) + " " + ls_nome_a

li_ret = MessageBox ( "Attenzione", "Confermi la cancellazione di~n" + ls_to_canc + &
							 "?~n~nI dati verranno accorpati a quelli di~n" + ls_to_merge + ".", &
							 Question!, YesNo!, 2 )

if li_ret = 2 then return

st_wait.visible = true

this.enabled = false
cb_1.enabled = false
m_search_dbl.m_opzioni.m_seleziona.disable ( )

if wf_cancella ( ll_code_a, ls_dip_a, ll_code_c, ls_dip_c ) = -1 then
	
	f_log_err ( gs_context, sqlca.SqlErrText )
	ROLLBACK;
	st_wait.visible = false
	MessageBox ( "Cancellazione", "Operazione annullata", StopSign! )
	return
	
else
	
	COMMIT;
	st_wait.visible = false
	f_log ( "Cancellazione record per accorpamento dati", ls_to_canc )
	MessageBox ( "Cancellazione", "Operazione effettuata" )
	parent.TriggerEvent ( "query_on" )
	return
	
end if

end event

type cb_1 from commandbutton within w_search_dbl
integer x = 9
integer y = 1088
integer width = 398
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cancella"
end type

event clicked;long ll_code_a, ll_code_c
string ls_dip_a, ls_dip_c, ls_cognome, ls_nome, ls_cognome_a, ls_nome_a, ls_to_canc, ls_to_merge
int li_ret

ll_code_a = dw_mem_2.GetItemNumber ( 1, 1 )
ls_dip_a = dw_mem_2.GetItemString ( 1, 2 )
ls_cognome_a = dw_mem_2.GetItemString ( 1, 3 )
ls_nome_a = dw_mem_2.GetItemString ( 1, 4 )
ll_code_c = dw_mem_1.GetItemNumber ( 1, 1 )
ls_dip_c = dw_mem_1.GetItemString ( 1, 2 )
ls_cognome = dw_mem_1.GetItemString ( 1, 3 )
ls_nome = dw_mem_1.GetItemString ( 1, 4 )
ls_to_canc = string ( ll_code_c ) + " " + ls_dip_c + " - " + trim ( ls_cognome ) + " " + ls_nome
ls_to_merge = string ( ll_code_a ) + " " + ls_dip_a + " - " + trim ( ls_cognome_a ) + " " + ls_nome_a

li_ret = MessageBox ( "Attenzione", "Confermi la cancellazione di~n" + ls_to_canc + &
							 "?~n~nI dati verranno accorpati a quelli di~n" + ls_to_merge + ".", &
							 Question!, YesNo!, 2 )

if li_ret = 2 then return

this.enabled = false
cb_2.enabled = false
m_search_dbl.m_opzioni.m_seleziona.disable ( )

st_wait.visible = true

if wf_cancella ( ll_code_a, ls_dip_a, ll_code_c, ls_dip_c ) = -1 then
	
	f_log_err ( gs_context, sqlca.SqlErrText )
	ROLLBACK;
	st_wait.visible = false
	MessageBox ( "Cancellazione", "Operazione annullata", StopSign! )
	return
	
else
	
	COMMIT;
	st_wait.visible = false
	f_log ( "Cancellazione record", ls_to_canc )
	MessageBox ( "Cancellazione", "Operazione effettuata" )
	parent.TriggerEvent ( "query_on" )
	return
	
end if


end event

type dw_mem_1 from datawindow within w_search_dbl
integer x = 9
integer y = 536
integer width = 1559
integer height = 524
integer taborder = 10
string dataobject = "d_mem_dbl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore Db " + string ( SqlDbCode ), SqlErrText, StopSign! )

return 1

end event

type dw_mem_2 from datawindow within w_search_dbl
integer x = 1627
integer y = 536
integer width = 1559
integer height = 524
integer taborder = 50
string dataobject = "d_mem_dbl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore Db " + string ( SqlDbCode ), SqlErrText, StopSign! )

return 1

end event

type p_goh_1 from picture within w_search_dbl
integer x = 14
integer y = 1264
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_search_dbl
integer x = 101
integer y = 1268
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Storico Gohonzon"
boolean focusrectangle = false
end type

type p_studio_1 from picture within w_search_dbl
integer x = 14
integer y = 1400
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_7 from statictext within w_search_dbl
integer x = 101
integer y = 1404
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Studio"
boolean focusrectangle = false
end type

type p_zaimu_1 from picture within w_search_dbl
integer x = 14
integer y = 1536
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_8 from statictext within w_search_dbl
integer x = 101
integer y = 1540
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Zaimu"
boolean focusrectangle = false
end type

type p_offerte_1 from picture within w_search_dbl
integer x = 14
integer y = 1672
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_9 from statictext within w_search_dbl
integer x = 101
integer y = 1676
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Offerte E.R."
boolean focusrectangle = false
end type

type st_10 from statictext within w_search_dbl
integer x = 2615
integer y = 1676
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Offerte E.R."
alignment alignment = right!
boolean focusrectangle = false
end type

type p_offerte_2 from picture within w_search_dbl
integer x = 3127
integer y = 1672
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_11 from statictext within w_search_dbl
integer x = 2615
integer y = 1540
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Zaimu"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_zaimu_2 from picture within w_search_dbl
integer x = 3127
integer y = 1536
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_12 from statictext within w_search_dbl
integer x = 2615
integer y = 1404
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Studio"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_studio_2 from picture within w_search_dbl
integer x = 3127
integer y = 1400
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_16 from statictext within w_search_dbl
integer x = 2615
integer y = 1268
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Storico Gohonzon"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_goh_2 from picture within w_search_dbl
integer x = 3127
integer y = 1264
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type dw_elenco from uo_dwselect within w_search_dbl
integer x = 9
integer y = 8
integer width = 2565
integer height = 472
integer taborder = 40
string dataobject = "d_sel_mem_dbl"
end type

event clicked;if dw_status ( ) = "no" then

	If row = 0 then Return
	
	if IsSelected ( row ) then
		selectrow ( row, false )
		il_count = il_count -1
		return
	end if
	
	if il_count = 2 then
		MessageBox ( "Attenzione", "Max 2 nominativi selezionabili.", Exclamation! )
		return
	end if
	
	selectrow ( row, TRUE )
	il_count = il_count+1
	
	SetRow ( row )
	
end if

end event

event getfocus;/**/
end event

event retrieverow;call super::retrieverow;if stop_retrieval = true then
	stop_retrieval = false
	return 1
end if

end event

event retrievestart;call super::retrievestart;menu_off ( )

end event

event retrieveend;call super::retrieveend;menu_on ( )

end event

event doubleclicked;/**/

end event

event keydown;/**/

end event

event itemchanged;call super::itemchanged;if dwo.name= "cognome" then
	
	is_cognome=  f_replace_chars(this.getText(), "'", "''")
	
end if
end event

event sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlSyntax, dw_elenco)

setSqlPreview(sqlsyntax)
end event
type st_2 from statictext within w_search_dbl
integer x = 2418
integer y = 1812
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Nominativi estratti:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ret from statictext within w_search_dbl
integer x = 2880
integer y = 1800
integer width = 302
integer height = 88
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

