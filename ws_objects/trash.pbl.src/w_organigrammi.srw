$PBExportHeader$w_organigrammi.srw
$PBExportComments$Stampa organigrammi
forward
global type w_organigrammi from window
end type
type dw_elenco from datawindow within w_organigrammi
end type
type st_2 from statictext within w_organigrammi
end type
type ddlb_a from dropdownlistbox within w_organigrammi
end type
type gb_level from groupbox within w_organigrammi
end type
type gb_organigramma from groupbox within w_organigrammi
end type
type dw_h_org from datawindow within w_organigrammi
end type
type gb_h_org from groupbox within w_organigrammi
end type
end forward

global type w_organigrammi from window
integer x = 37
integer y = 48
integer width = 3543
integer height = 2152
boolean titlebar = true
string title = "Organigrammi"
string menuname = "m_organigrammi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event clear ( )
event ue_open ( )
event genera ( )
event stampa ( )
dw_elenco dw_elenco
st_2 st_2
ddlb_a ddlb_a
gb_level gb_level
gb_organigramma gb_organigramma
dw_h_org dw_h_org
gb_h_org gb_h_org
end type
global w_organigrammi w_organigrammi

type variables
DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru, c_resp

int level = 5, to_level = 0

uo_ds_gen ds_resp_prim, ds_resp_sec

end variables

forward prototypes
public subroutine f_clear_h_org ()
public function string wf_filter (integer v_level)
public subroutine wf_exec_filter ()
public subroutine wf_header ()
public function string descrizione (string livello, string area, string terr, string cen, string cap, string sett, string gru)
end prototypes

event clear();int n

level = 6
to_level = 1

ddlb_a.text = "Gruppo"

c_area = ""
c_terr = ""
c_cen = ""
c_cap = ""
c_sett = ""
c_gru = ""

idwc_area.Reset ( )
idwc_terr.Reset ( )
idwc_cen.Reset ( )
idwc_cap.Reset ( )
idwc_sett.Reset ( )
idwc_gru.Reset ( )

f_clear_h_org ( )

for n = 2 to 6
	dw_h_org.Modify("#"+string(n)+".Protect='0'")
next

dw_elenco.SetRedraw ( false )

dw_elenco.Object.area_t.Font.Italic = '0'
dw_elenco.Object.c_area.Font.Italic = '0'
dw_elenco.Object.area_t.Font.Weight='700'
dw_elenco.Object.c_area.Font.Weight='700'
dw_elenco.Object.terr_t.Font.Italic = '0'
dw_elenco.Object.c_terr.Font.Italic = '0'
dw_elenco.Object.terr_t.Font.Weight='700'
dw_elenco.Object.c_terr.Font.Weight='700'
dw_elenco.Object.cen_t.Font.Italic = '0'
dw_elenco.Object.c_cen.Font.Italic = '0'
dw_elenco.Object.cen_t.Font.Weight='700'
dw_elenco.Object.c_cen.Font.Weight='700'
dw_elenco.Object.cap_t.Font.Italic = '0'
dw_elenco.Object.c_cap.Font.Italic = '0'
dw_elenco.Object.cap_t.Font.Weight='700'
dw_elenco.Object.c_cap.Font.Weight='700'
dw_elenco.Object.sett_t.Font.Italic = '0'
dw_elenco.Object.c_sett.Font.Italic = '0'
dw_elenco.Object.sett_t.Font.Weight='700'
dw_elenco.Object.c_sett.Font.Weight='700'

dw_elenco.Object.terr_t.Visible='1'
dw_elenco.Object.cen_t.Visible='1'
dw_elenco.Object.cap_t.Visible='1'
dw_elenco.Object.sett_t.Visible='1'
dw_elenco.Object.gru_t.Visible='1'

dw_elenco.SetFilter ( "" )
dw_elenco.Filter ( )

dw_elenco.Reset ( )

dw_elenco.SetRedraw ( true )

m_organigrammi.m_1opzioni.m_start.enabled = true
m_organigrammi.m_1opzioni.m_stampa.enabled = false
dw_h_org.enabled = true
ddlb_a.enabled = true

end event

event ue_open;idwc_area.SetTransObject ( sqlca )
idwc_terr.SetTransObject ( sqlca )
idwc_cen.SetTransObject ( sqlca )
idwc_cap.SetTransObject ( sqlca )
idwc_sett.SetTransObject ( sqlca )
idwc_gru.SetTransObject ( sqlca )

idwc_area.Retrieve ( )
idwc_terr.Retrieve ( )
idwc_cen.Retrieve ( )
idwc_cap.Retrieve ( )
idwc_sett.Retrieve ( )
idwc_gru.Retrieve ( )

dw_h_org.InsertRow ( 0 )

end event

event genera();long ll_rows, ll_count, ll_parz
string ls_lev, ls_descr, ls_cod_area, ls_cod_terr, ls_cod_cen, ls_cod_cap, ls_cod_sett, ls_cod_gru, ls_data
string ls_area, ls_terr, ls_cen, ls_cap, ls_sett, ls_gru, ls_null

if IsNull ( c_area ) or c_area = "A" or c_area = "" then
	MessageBox ( "Organigramma", "Selezionare almeno l'area...", exclamation! )
	return
end if

m_organigrammi.m_1opzioni.m_start.enabled = false

dw_elenco.SetRedraw ( false )

open ( w_wait )

ls_null = ""

ds_resp_prim = create uo_ds_gen
ds_resp_sec = create uo_ds_gen

ds_resp_prim.DataObject = "d_resp_prim"
ds_resp_sec.DataObject = "d_resp_sec"

ds_resp_prim.SetTransObject ( sqlca )
ds_resp_sec.SetTransObject ( sqlca )

goto fase_1

fase_1:

ll_rows = ds_resp_prim.Retrieve (c_area, c_terr, c_cen, c_cap, c_sett, c_gru, c_resp )

if ll_rows < 1 then goto errore

ll_parz = ll_rows

for ll_count = 1 to ll_rows
	
	dw_elenco.InsertRow ( 0 )
	
	ls_lev = mid ( ds_resp_prim.GetItemString ( ll_count, "cod_att_ist_1" ), 1, 1 )
	
	choose case ls_lev
			
		case "6"
			
			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			
			select distinct descrizione
			into :ls_area
			from vw_org
			where cod_area = :ls_cod_area;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "livello", "Area" )
			
		case "5"
			
			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_prim.GetItemString ( ll_count, "cod_terr" )
			
			select distinct descrizione,
					 descrizione_a
			into :ls_area,
				  :ls_terr
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count, "livello", "Territorio" )
			
		case "4"
			
			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_prim.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_prim.GetItemString ( ll_count, "cod_cen" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b
			into :ls_area,
				  :ls_terr,
				  :ls_cen
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen;
			
			if sqlca.SqlCode = -1 then goto errore

			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count, "livello", "Centro" )
			
		case "3"

			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_prim.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_prim.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_prim.GetItemString ( ll_count, "cod_cap" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count, "livello", "Capitolo" )
			
		case "2"
			
			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_prim.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_prim.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_prim.GetItemString ( ll_count, "cod_cap" )
			ls_cod_sett = ds_resp_prim.GetItemString ( ll_count, "cod_sett" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c,
					 descrizione_d
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap,
				  :ls_sett
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap
			and cod_sett = :ls_cod_sett;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_cod_sett )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count, "sett", ls_sett )
			dw_elenco.SetItem ( ll_count, "livello", "Settore" )
			
		case "1"

			ls_cod_area = ds_resp_prim.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_prim.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_prim.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_prim.GetItemString ( ll_count, "cod_cap" )
			ls_cod_sett = ds_resp_prim.GetItemString ( ll_count, "cod_sett" )
			ls_cod_gru = ds_resp_prim.GetItemString ( ll_count, "cod_gru" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c,
					 descrizione_d,
					 descrizione_e
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap,
				  :ls_sett,
				  :ls_gru
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap
			and cod_sett = :ls_cod_sett
			and cod_gru = :ls_cod_gru;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count, "cod_sett", ls_cod_sett )
			dw_elenco.SetItem ( ll_count, "cod_gru", ls_cod_gru )
			dw_elenco.SetItem ( ll_count, "area", ls_area )
			dw_elenco.SetItem ( ll_count, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count, "sett", ls_sett )
			dw_elenco.SetItem ( ll_count, "gru", ls_gru )
			dw_elenco.SetItem ( ll_count, "livello", "Gruppo" )
			
		case else
			
	end choose
	
	dw_elenco.SetItem ( ll_count, "nome", ds_resp_prim.GetItemString ( ll_count, "c_nome" ) )
	dw_elenco.SetItem ( ll_count, "cod_att_ist", ds_resp_prim.GetItemString ( ll_count, "cod_att_ist_1" ) )
	dw_elenco.SetItem ( ll_count, "resp", ds_resp_prim.GetItemString ( ll_count, "resp" ) )
	dw_elenco.SetItem ( ll_count, "tel_1", ds_resp_prim.GetItemString ( ll_count, "num_tel" ) )
	dw_elenco.SetItem ( ll_count, "tel_2", ds_resp_prim.GetItemString ( ll_count, "num_tel_2" ) )
	
next

goto fase_2

fase_2:

ll_rows = ds_resp_sec.Retrieve (c_area, c_terr, c_cen, c_cap, c_sett, c_gru, c_resp )

if ll_rows = 0 then goto show

if ll_rows = -1 then goto errore

for ll_count = 1 to ll_rows
	
	dw_elenco.InsertRow ( 0 )
	
	ls_lev = mid ( ds_resp_sec.GetItemString ( ll_count, "cod_att_ist_2" ), 1, 1 )
	
	choose case ls_lev
			
		case "6"
			
			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			
			select distinct descrizione
			into :ls_area
			from vw_org
			where cod_area = :ls_cod_area;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Area" )
			
		case "5"
			
			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_sec.GetItemString ( ll_count, "cod_terr" )
			
			select distinct descrizione,
					 descrizione_a
			into :ls_area,
				  :ls_terr
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Territorio" )
			
		case "4"
			
			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_sec.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_sec.GetItemString ( ll_count, "cod_cen" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b
			into :ls_area,
				  :ls_terr,
				  :ls_cen
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen;
			
			if sqlca.SqlCode = -1 then goto errore

			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Centro" )
			
		case "3"

			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_sec.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_sec.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_sec.GetItemString ( ll_count, "cod_cap" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Capitolo" )
			
		case "2"
			
			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_sec.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_sec.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_sec.GetItemString ( ll_count, "cod_cap" )
			ls_cod_sett = ds_resp_sec.GetItemString ( ll_count, "cod_sett" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c,
					 descrizione_d
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap,
				  :ls_sett
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap
			and cod_sett = :ls_cod_sett;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_cod_sett )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_null )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "sett", ls_sett )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Settore" )
			
		case "1"

			ls_cod_area = ds_resp_sec.GetItemString ( ll_count, "cod_area" )
			ls_cod_terr = ds_resp_sec.GetItemString ( ll_count, "cod_terr" )
			ls_cod_cen = ds_resp_sec.GetItemString ( ll_count, "cod_cen" )
			ls_cod_cap = ds_resp_sec.GetItemString ( ll_count, "cod_cap" )
			ls_cod_sett = ds_resp_sec.GetItemString ( ll_count, "cod_sett" )
			ls_cod_gru = ds_resp_sec.GetItemString ( ll_count, "cod_gru" )
			
			select distinct descrizione,
					 descrizione_a,
					 descrizione_b,
					 descrizione_c,
					 descrizione_d,
					 descrizione_e
			into :ls_area,
				  :ls_terr,
				  :ls_cen,
				  :ls_cap,
				  :ls_sett,
				  :ls_gru
			from vw_org
			where cod_area = :ls_cod_area
			and cod_terr = :ls_cod_terr
			and cod_cen = :ls_cod_cen
			and cod_cap = :ls_cod_cap
			and cod_sett = :ls_cod_sett
			and cod_gru = :ls_cod_gru;
			
			if sqlca.SqlCode = -1 then goto errore
			
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_area", ls_cod_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_terr", ls_cod_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cen", ls_cod_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_cap", ls_cod_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_sett", ls_cod_sett )
			dw_elenco.SetItem ( ll_count+ll_parz, "cod_gru", ls_cod_gru )
			dw_elenco.SetItem ( ll_count+ll_parz, "area", ls_area )
			dw_elenco.SetItem ( ll_count+ll_parz, "terr", ls_terr )
			dw_elenco.SetItem ( ll_count+ll_parz, "cen", ls_cen )
			dw_elenco.SetItem ( ll_count+ll_parz, "cap", ls_cap )
			dw_elenco.SetItem ( ll_count+ll_parz, "sett", ls_sett )
			dw_elenco.SetItem ( ll_count+ll_parz, "gru", ls_gru )
			dw_elenco.SetItem ( ll_count+ll_parz, "livello", "Gruppo" )
			
		case else
			
	end choose
	
	dw_elenco.SetItem ( ll_count+ll_parz, "nome", ds_resp_sec.GetItemString ( ll_count, "c_nome" ) )
	dw_elenco.SetItem ( ll_count+ll_parz, "cod_att_ist", ds_resp_sec.GetItemString ( ll_count, "cod_att_ist_2" ) )
	dw_elenco.SetItem ( ll_count+ll_parz, "resp", ds_resp_sec.GetItemString ( ll_count, "resp" ) )
	dw_elenco.SetItem ( ll_count+ll_parz, "tel_1", ds_resp_sec.GetItemString ( ll_count, "num_tel" ) )
	dw_elenco.SetItem ( ll_count+ll_parz, "tel_2", ds_resp_sec.GetItemString ( ll_count, "num_tel_2" ) )
	
next

show:

dw_elenco.SetSort ( "#8 A, #9 A, #10 A, #11 A, #12 A, #13 A, #15 D, #14 A" )
dw_elenco.Sort ( )
dw_elenco.Object.DataWindow.Sparse = "c_area~tc_terr~tc_cen~tc_cap~tc_sett~tc_gru~tlivello~tc_resp"

close ( w_wait )

//dw_h_org.visible = true
//dw_h_org.enabled = true
ddlb_a.enabled = true

if u_lev < 4 or u_lev > 6 then m_organigrammi.m_1opzioni.m_stampa.enabled = true

m_organigrammi.m_2finestra.m_annulla.enabled = true

goto fine

errore:

close ( w_wait )
dw_elenco.Reset ( )
MessageBox ( "Errore Db " + string ( sqlca.SqlDbCode ), "Generazione organigramma fallita.~n~n" + &
				 sqlca.SqlErrText, StopSign! )
m_organigrammi.m_1opzioni.m_start.enabled = true

fine:

// GdS
commit using sqlca;

dw_elenco.SetRedraw ( true )

dw_elenco.setFocus()

destroy ds_resp_prim
destroy ds_resp_sec

end event

event stampa;string ls_msg

open ( w_aut_print )

if Message.DoubleParm = -1 then return

dw_elenco.SetRedraw ( false )
dw_elenco.Object.DataWindow.Print.Orientation = '1'
dw_elenco.Object.DataWindow.Footer.Height='121'

ls_msg = "Stampato da " + gs_LogId + " per " + Message.StringParm

OpenWithParm ( w_dw_print_options, dw_elenco )

if Message.DoubleParm = -1 then return

f_log ( gs_context, ls_msg )

dw_elenco.Object.DataWindow.Footer.Height='1'
dw_elenco.SetRedraw ( true )

f_log ( gs_context, ls_msg )
end event

public subroutine f_clear_h_org ();SetNull ( c_area )
SetNull ( c_terr )
SetNull ( c_cen )
SetNull ( c_cap )
SetNull ( c_sett )
SetNull ( c_gru )

dw_h_org.SetRedraw ( false )
dw_h_org.Reset ( )
dw_h_org.InsertRow ( 0 )
dw_h_org.SetRedraw ( true )
dw_h_org.enabled = true

end subroutine

public function string wf_filter (integer v_level);string ls_filter

choose case v_level
		
	case 6
		
		ls_filter = "cod_area = '"+c_area+"' "
		
	case 5
		
		ls_filter = "cod_area = '"+c_area+"' and cod_terr = '"+c_terr+"' "
		
	case 4
		
		ls_filter = "cod_area = '"+c_area+"' and cod_terr = '"+c_terr+"' and cod_cen = '"+c_cen+"' "
		
	case 3
		
		ls_filter = "cod_area = '"+c_area+"' and cod_terr = '"+c_terr+"' and cod_cen = '"+c_cen+"' and " + &
						"cod_cap = '"+c_cap+"' "
		
	case 2
		
		ls_filter = "cod_area = '"+c_area+"' and cod_terr = '"+c_terr+"' and cod_cen = '"+c_cen+"' and " + &
						"cod_cap = '"+c_cap+"' and cod_sett = '"+c_sett+"' "
	
	case 1
		
		ls_filter = "cod_area = '"+c_area+"' and cod_terr = '"+c_terr+"' and cod_cen = '"+c_cen+"' and " + &
						"cod_cap = '"+c_cap+"' and cod_sett = '"+c_sett+"' and cod_gru = '"+c_gru+"'"

end choose

return ls_filter

end function

public subroutine wf_exec_filter ();string ls_filter, ls_filter_2

dw_elenco.SetFilter ( "" )
dw_elenco.Filter ( )

ls_filter_2 = wf_filter ( level )

choose case to_level
		
	case 6
		
		c_terr = ""
		c_cen = ""
		c_cap = ""
		c_sett = ""
		c_gru = ""
		
		ls_filter = "and cod_terr = '"+c_terr+"' "+&
  					   "and cod_cen = '"+c_cen+"' and cod_cap = '"+c_cap+"' "+&
						"and cod_sett = '"+c_sett+"' and cod_gru = '"+c_gru+"'"
		
	case 5
		
		c_cen = ""
		c_cap = ""
		c_sett = ""
		c_gru = ""
		
		ls_filter = "and cod_cen = '"+c_cen+"' and cod_cap = '"+c_cap+"' "+&
						"and cod_sett = '"+c_sett+"' and cod_gru = '"+c_gru+"'"
		
	case 4
		
		c_cap = ""
		c_sett = ""
		c_gru = ""
		
		ls_filter = "and cod_cap = '"+c_cap+"' "+&
						"and cod_sett = '"+c_sett+"' and cod_gru = '"+c_gru+"'"
									 
	case 3
		
		c_sett = ""
		c_gru = ""
		
		ls_filter = "and cod_sett = '"+c_sett+"' and cod_gru = '"+c_gru+"'"
		
	case 2
		
		c_gru = ""
		
		ls_filter = "and cod_gru = '"+c_gru+"'"
									 
	case else
		
		ls_filter = ""
		
end choose

dw_elenco.setRedraw ( false )

wf_header ( )

dw_elenco.SetFilter ( ls_filter_2+ls_filter )
dw_elenco.Filter ( )

dw_elenco.setRedraw ( true )

//dw_h_org.enabled = false
//ddlb_a.enabled = false
//this.enabled = false

end subroutine

public subroutine wf_header ();choose case level
		
	case 6
		
	case 5
		
		dw_elenco.Object.area_t.Font.Italic = '1'
		dw_elenco.Object.c_area.Font.Italic = '1'
		dw_elenco.Object.area_t.Font.Weight='400'
		dw_elenco.Object.c_area.Font.Weight='400'
		
	case 4
		
		dw_elenco.Object.area_t.Font.Italic = '1'
		dw_elenco.Object.c_area.Font.Italic = '1'
		dw_elenco.Object.area_t.Font.Weight='400'
		dw_elenco.Object.c_area.Font.Weight='400'
		dw_elenco.Object.terr_t.Font.Italic = '1'
		dw_elenco.Object.c_terr.Font.Italic = '1'
		dw_elenco.Object.terr_t.Font.Weight='400'
		dw_elenco.Object.c_terr.Font.Weight='400'

	case 3
		
		dw_elenco.Object.area_t.Font.Italic = '1'
		dw_elenco.Object.c_area.Font.Italic = '1'
		dw_elenco.Object.area_t.Font.Weight='400'
		dw_elenco.Object.c_area.Font.Weight='400'
		dw_elenco.Object.terr_t.Font.Italic = '1'
		dw_elenco.Object.c_terr.Font.Italic = '1'
		dw_elenco.Object.terr_t.Font.Weight='400'
		dw_elenco.Object.c_terr.Font.Weight='400'
		dw_elenco.Object.cen_t.Font.Italic = '1'
		dw_elenco.Object.c_cen.Font.Italic = '1'
		dw_elenco.Object.cen_t.Font.Weight='400'
		dw_elenco.Object.c_cen.Font.Weight='400'
		
	case 2
		
		dw_elenco.Object.area_t.Font.Italic = '1'
		dw_elenco.Object.c_area.Font.Italic = '1'
		dw_elenco.Object.area_t.Font.Weight='400'
		dw_elenco.Object.c_area.Font.Weight='400'
		dw_elenco.Object.terr_t.Font.Italic = '1'
		dw_elenco.Object.c_terr.Font.Italic = '1'
		dw_elenco.Object.terr_t.Font.Weight='400'
		dw_elenco.Object.c_terr.Font.Weight='400'
		dw_elenco.Object.cen_t.Font.Italic = '1'
		dw_elenco.Object.c_cen.Font.Italic = '1'
		dw_elenco.Object.cen_t.Font.Weight='400'
		dw_elenco.Object.c_cen.Font.Weight='400'
		dw_elenco.Object.cap_t.Font.Italic = '1'
		dw_elenco.Object.c_cap.Font.Italic = '1'
		dw_elenco.Object.cap_t.Font.Weight='400'
		dw_elenco.Object.c_cap.Font.Weight='400'
		
	case 1
		
		dw_elenco.Object.area_t.Font.Italic = '1'
		dw_elenco.Object.c_area.Font.Italic = '1'
		dw_elenco.Object.area_t.Font.Weight='400'
		dw_elenco.Object.c_area.Font.Weight='400'
		dw_elenco.Object.terr_t.Font.Italic = '1'
		dw_elenco.Object.c_terr.Font.Italic = '1'
		dw_elenco.Object.terr_t.Font.Weight='400'
		dw_elenco.Object.c_terr.Font.Weight='400'
		dw_elenco.Object.cen_t.Font.Italic = '1'
		dw_elenco.Object.c_cen.Font.Italic = '1'
		dw_elenco.Object.cen_t.Font.Weight='400'
		dw_elenco.Object.c_cen.Font.Weight='400'
		dw_elenco.Object.cap_t.Font.Italic = '1'
		dw_elenco.Object.c_cap.Font.Italic = '1'
		dw_elenco.Object.cap_t.Font.Weight='400'
		dw_elenco.Object.c_cap.Font.Weight='400'
		dw_elenco.Object.sett_t.Font.Italic = '1'
		dw_elenco.Object.c_sett.Font.Italic = '1'
		dw_elenco.Object.sett_t.Font.Weight='400'
		dw_elenco.Object.c_sett.Font.Weight='400'
		
end choose

choose case to_level
		
	case 6
		
		dw_elenco.Object.terr_t.Visible='0'
		dw_elenco.Object.cen_t.Visible='0'
		dw_elenco.Object.cap_t.Visible='0'
		dw_elenco.Object.sett_t.Visible='0'
		dw_elenco.Object.gru_t.Visible='0'
		
	case 5
		
		dw_elenco.Object.cen_t.Visible='0'
		dw_elenco.Object.cap_t.Visible='0'
		dw_elenco.Object.sett_t.Visible='0'
		dw_elenco.Object.gru_t.Visible='0'
		
	case 4
		
		dw_elenco.Object.cap_t.Visible='0'
		dw_elenco.Object.sett_t.Visible='0'
		dw_elenco.Object.gru_t.Visible='0'

	case 3
		
		dw_elenco.Object.sett_t.Visible='0'
		dw_elenco.Object.gru_t.Visible='0'
		
	case 2
		
		dw_elenco.Object.gru_t.Visible='0'
		
	case 1
		
end choose

end subroutine

public function string descrizione (string livello, string area, string terr, string cen, string cap, string sett, string gru);return ""

end function

on w_organigrammi.create
if this.MenuName = "m_organigrammi" then this.MenuID = create m_organigrammi
this.dw_elenco=create dw_elenco
this.st_2=create st_2
this.ddlb_a=create ddlb_a
this.gb_level=create gb_level
this.gb_organigramma=create gb_organigramma
this.dw_h_org=create dw_h_org
this.gb_h_org=create gb_h_org
this.Control[]={this.dw_elenco,&
this.st_2,&
this.ddlb_a,&
this.gb_level,&
this.gb_organigramma,&
this.dw_h_org,&
this.gb_h_org}
end on

on w_organigrammi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_elenco)
destroy(this.st_2)
destroy(this.ddlb_a)
destroy(this.gb_level)
destroy(this.gb_organigramma)
destroy(this.dw_h_org)
destroy(this.gb_h_org)
end on

event open;PostEvent ( "ue_open" )

end event

event resize;dw_elenco.height= this.height - 357 - 120 - 20
gb_organigramma.height= this.height - 301 - 120

dw_elenco.width= this.width - dw_elenco.x - 120

gb_organigramma.width= this.width - gb_organigramma.x - 80
end event

event activate;gs_context = "Stampa organigrammi"
end event

type dw_elenco from datawindow within w_organigrammi
integer x = 64
integer y = 356
integer width = 3323
integer height = 1344
string dataobject = "d_organigramma"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_2 from statictext within w_organigrammi
integer x = 2784
integer y = 112
integer width = 160
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Fino a:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_a from dropdownlistbox within w_organigrammi
integer x = 2949
integer y = 96
integer width = 453
integer height = 480
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Gruppo"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Area","Territorio","Centro","Capitolo","Settore","Gruppo"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;int n

choose case this.text
		
	case "Area"
		
		to_level = 6
		
		for n = 2 to 6
			dw_h_org.Modify("#"+string(n)+".Protect='1'")
		next
		
	case "Territorio"
		
		to_level = 5
		
		dw_h_org.Modify("#2.Protect='0'")

		for n = 3 to 6
			dw_h_org.Modify("#"+string(n)+".Protect='1'")
		next
		
	case "Centro"
		
		to_level = 4
		
		for n = 2 to 3
			dw_h_org.Modify("#"+string(n)+".Protect='0'")
		next

		for n = 4 to 6
			dw_h_org.Modify("#"+string(n)+".Protect='1'")
		next
		
	case "Capitolo"
		
		to_level = 3
		
		for n = 2 to 4
			dw_h_org.Modify("#"+string(n)+".Protect='0'")
		next

		for n = 5 to 6
			dw_h_org.Modify("#"+string(n)+".Protect='1'")
		next
		
	case "Settore"

		to_level = 2
		
		for n = 2 to 5
			dw_h_org.Modify("#"+string(n)+".Protect='0'")
		next

		dw_h_org.Modify("#6.Protect='1'")
		
	case "Gruppo"

		to_level = 1
		
		for n = 2 to 6
			dw_h_org.Modify("#"+string(n)+".Protect='0'")
		next
		
end choose

if level < to_level then
//	MessageBox ( "Attenzione", "Scelta non valida...", exclamation! )
	return -1
//	parent.TriggerEvent ( "clear" )
end if

wf_exec_filter()

end event

type gb_level from groupbox within w_organigrammi
integer x = 2775
integer y = 40
integer width = 645
integer height = 260
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = " Visualizzazione"
end type

type gb_organigramma from groupbox within w_organigrammi
integer x = 27
integer y = 300
integer width = 3397
integer height = 1432
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 12632256
string text = " Organigramma "
borderstyle borderstyle = stylelowered!
end type

type dw_h_org from datawindow within w_organigrammi
integer x = 50
integer y = 84
integer width = 2688
integer height = 200
integer taborder = 10
string dataobject = "d_ext_org_1"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if row > 0 then
	
	CHOOSE CASE dwo.name
			
		CASE "cod_area"
			 
			level = 6
			
			c_area = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_terr.Reset ( )
			SetItem ( row, "cod_terr", v_null )
			SetItem ( row, "cod_cen", v_null )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			c_terr = "%"
			c_cen = "%"
			c_cap = "%"
			c_sett = "%"
			c_gru = "%"
			
		CASE "cod_terr"
 
			level = 5
			
			c_terr = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_cen.Reset ( )
			SetItem ( row, "cod_cen", v_null )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			c_cen = "%"
			c_cap = "%"
			c_sett = "%"
			c_gru = "%"
			
		CASE "cod_cen"
			
			level = 4
			
			c_cen = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_cap.Reset ( )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			c_cap = "%"
			c_sett = "%"
			c_gru = "%"

		CASE "cod_cap"

			level = 3

			c_cap = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_sett.Reset ( )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			c_sett = "%"
			c_gru = "%"
			
		CASE "cod_sett"

			level = 2

			c_sett = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_gru.Reset ( )
			SetItem ( row, "cod_gru", v_null )
			c_gru = "%"
			
		CASE "cod_gru"
			
			level = 1

			c_gru = f_replace_chars ( this.getText ( ), "'", "" )

	END CHOOSE
	
	c_resp=string(level)

end if

end event

event itemfocuschanged;long l_rows

string ls_col

string where_clause, ls_area, ls_terr, ls_cen, ls_cap, ls_sett, ls_gru

ls_col = dwo.name

if row < 1 then return

	CHOOSE CASE dwo.name
			
		CASE "cod_area"
 
			where_clause= " where aree.cod_area<>~~'"+"A"+"~~'" 
			
			this.GetChild ( 'cod_area',idwc_area )
			
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

end event

type gb_h_org from groupbox within w_organigrammi
integer x = 27
integer y = 40
integer width = 2738
integer height = 260
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
string text = " Selezione "
borderstyle borderstyle = stylelowered!
end type

