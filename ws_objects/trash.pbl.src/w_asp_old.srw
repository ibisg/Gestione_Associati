$PBExportHeader$w_asp_old.srw
forward
global type w_asp_old from window
end type
type sle_cognome from uo_sle_gen within w_asp_old
end type
type sle_nome from uo_sle_gen within w_asp_old
end type
type st_cognome from statictext within w_asp_old
end type
type st_nome from statictext within w_asp_old
end type
type cb_cerca from commandbutton within w_asp_old
end type
type dw_cer from datawindow within w_asp_old
end type
type st_modify from statictext within w_asp_old
end type
type dw_asp from datawindow within w_asp_old
end type
type gb_cerca from groupbox within w_asp_old
end type
type gb_cer from groupbox within w_asp_old
end type
end forward

global type w_asp_old from window
integer x = 9
integer y = 12
integer width = 3566
integer height = 2268
boolean titlebar = true
string title = "Aspiranti membri"
string menuname = "m_asp"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event type integer save ( )
event cerca ( )
event type integer cerca_cer ( )
event type integer mod_state ( )
event clear ( string status )
event erase ( )
event uscita ( )
event undo ( )
event crea_cer ( )
sle_cognome sle_cognome
sle_nome sle_nome
st_cognome st_cognome
st_nome st_nome
cb_cerca cb_cerca
dw_cer dw_cer
st_modify st_modify
dw_asp dw_asp
gb_cerca gb_cerca
gb_cer gb_cer
end type
global w_asp_old w_asp_old

type variables
boolean ib_closing = false
boolean modify = false
boolean searching = false
boolean clearing = false

s_asp str_asp
s_parm str_parm
s_nom str_nom

s_strade is_strade_s

long il_code

string is_dip
string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string c_area_d, c_terr_d, c_cen_d, c_cap_d, c_sett_d, c_gru_d
string is_cod_com, is_com, is_prov
string is_cognome, is_nome

DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru
DataWindowChild idwc_area_d, idwc_terr_d, idwc_cen_d
DataWindowChild idwc_cap_d, idwc_sett_d, idwc_gru_d

datastore ds_com
uo_ds_gen ds_doppi

end variables
forward prototypes
public function integer f_search (ref string v_cognome, ref string v_nome)
public function integer f_mod_nome ()
public function integer f_exists (string v_cognome, string v_nome)
end prototypes

event ue_open;/*
* Nella finestra w_login vengono letti i parametri di connessione dal file .ini
* A questo punto eseguo una estrazione dalla tabella contatore per verificare 
* che esista un contatore relativo alla dip. operativa; nel caso non esista eseguo una insert 
* in tabella contatore assegnando cod_dip= _dip.operativa e max_count= 0.
*/

integer i_count

// Da scommentare nel momento in cui verrà implementat il filtro per dip operativa GdS 06072001
//select count(*)
//into :i_count
//from contatore
//where cod_dip= :str_ini.v_dip;
//if trap_sql(sqlca, "UEOPENASP01") < 0 then return
//
//if i_count= 0 then
//	
//	insert contatore
//	values(:str_ini.v_dip, 0);
//	
//	if trap_sql(sqlca, "UEOPENASP02") < 0 then return
//	
//end if

ds_com = create u_ds_com
ds_doppi = create uo_ds_gen

ds_doppi.DataObject = "d_doppi"

dw_asp.GetChild ( 'cod_area',idwc_area_d )
dw_asp.GetChild ( 'cod_terr',idwc_terr_d )
dw_asp.GetChild ( 'cod_cen',idwc_cen_d )
dw_asp.GetChild ( 'cod_cap',idwc_cap_d )
dw_asp.GetChild ( 'cod_sett',idwc_sett_d )
dw_asp.GetChild ( 'cod_gru',idwc_gru_d )

dw_asp.SetTransObject ( sqlca )
idwc_area_d.SetTransObject ( sqlca )
idwc_terr_d.SetTransObject ( sqlca )
idwc_cen_d.SetTransObject ( sqlca )
idwc_cap_d.SetTransObject ( sqlca )
idwc_sett_d.SetTransObject ( sqlca )
idwc_gru_d.SetTransObject ( sqlca )

ds_com.SetTransObject ( sqlca )
ds_doppi.SetTransObject ( sqlca )

dw_asp.SetRedraw ( false )
dw_asp.Retrieve ( 0, "" )
//dw_asp.InsertRow ( 0 )
commit;

dw_asp.SetRedraw ( true )

end event

event save;long ll_code, ll_ret
string ls_dip
DwItemStatus l_status

if modify then dw_cer.AcceptText ( )

dw_asp.AcceptText ( )

if dw_asp.ModifiedCount ( ) = 0 and dw_asp.DeletedCount ( ) = 0 then return 0

//????????????????????????????????????' GdS 14092001
if dw_asp.getItemString(1, "comune")= "" or isNull(dw_asp.getItemString(1, "comune")) then
	
	MessageBox("Campo obbligatorio mancante",  &
		"Inserire un valore in: 'Comune'", exclamation! )
		dw_asp.setColumn("comune")
		return -1
end if
//?????????????????????????????????????????

if checknull ( dw_asp ) < 1 then return -1

if not modify or ( modify and f_mod_nome ( ) = 1 ) then

	ll_ret =  f_exists ( "%" + dw_asp.GetItemString ( 1, "cognome" ) + "%", "%" + dw_asp.GetItemString ( 1, "nome" ) + "%" )
	
	choose case ll_ret
	
		case -1
	
			return -1
	
		case 0
	
		case is > 0
	
			open ( w_doppi )
	
			if message.DoubleParm = -1 then return -1
	
	end choose
	
end if

if not modify then

	ll_code = gencod ( )

	if ll_code = -1 then goto errore

	ls_dip = str_ini.v_dip // il codice viene assgenato in relazione alla dipendenza operativa.
	
	dw_asp.SetItem ( 1, "codice_membro", ll_code )
	dw_asp.SetItem ( 1, "cod_dip", ls_dip )
	
	is_cognome = dw_asp.GetItemString ( 1, "cognome" )
	is_nome = dw_asp.GetItemString ( 1, "nome" )

end if

dw_asp.SetItem ( 1, "data_cer", str_asp.v_data )
dw_asp.SetItem ( 1, "luogo_cer", str_asp.v_citta )
dw_asp.SetItem ( 1, "turno", str_asp.v_turno )
dw_asp.SetItem ( 1, "status", "AAA" )
dw_asp.SetItem ( 1, "membro", "S" )
dw_asp.SetItem ( 1, "u_insert", sqlca.LogId )
dw_asp.SetItem ( 1, "d_insert", DateTime ( today ( ), now ( ) ) )

if dw_asp.Update ( ) = -1 then goto errore

commit;
if trap_sql(sqlca, "COMMITASP01") < 0 then return -1

if not modify then
	
	f_log ( gs_context, is_cognome + " " + is_nome + " inserito in lista" )
	MessageBox ( "Nuovi membri", string ( ll_code ) + " - " + ls_dip + "~n" + &
					 is_cognome + " " + is_nome + "~nInserimento dati effettuato." )
	
else
	
	OpenWithParm ( w_msgauto, "Modifiche effettuate." )
	
end if

if not ib_closing then
		
	this.event clear ( "salva" )
	
end if

return 0

errore:
	rollback;
	return -1
end event

event cerca;int li_ret

if len ( trim ( sle_cognome.text ) ) = 0 and len ( trim ( sle_nome.text ) ) = 0 then
	
	MessageBox ( "Ricerca", "Digitare cognome e/o nome.", exclamation! )
	sle_cognome.SetFocus ( )
	return
	
end if

if IsNull ( sle_cognome.text ) then sle_cognome.text = ""
if IsNull ( sle_nome.text ) then sle_nome.text = ""

str_nom.v_cognome = "%" + sle_cognome.text + "%"
str_nom.v_nome = "%" + sle_nome.text + "%"

li_ret = f_search ( str_nom.v_cognome, str_nom.v_nome )

choose case li_ret
		
	case -1
		
		return
		
	case 0
		
		MessageBox ( "Aspiranti", "Ricerca senza esito..." )
		sle_cognome.SetFocus ( )
		return
		
	case 1
		
		select codice_membro,
				 cod_dip
		  into :il_code,
		  		 :is_dip
		  from aspiranti
		 where cognome like :str_nom.v_cognome
		   and nome like :str_nom.v_nome ;
			
		
		if trap_sql ( sqlca, "estrazione nominativo" ) = -1 then
			f_log_err ( gs_context, sqlca.SqlErrText )
			return
		end if
		
		dw_asp.SetRedraw ( false )
		dw_asp.Reset ( )
		
		if dw_asp.Retrieve ( il_code, is_dip ) < 1 then
			this.event clear ( "error" )
			dw_asp.SetRedraw ( true )
			return
		end if
		
		dw_asp.SetRedraw ( true )
		
		goto modifica
		
	case is > 1

		OpenWithParm ( w_s_asp, str_nom )
		
		if message.DoubleParm = -1 then
			sle_cognome.SetFocus ( )
			return
		end if
		
		goto modifica
		
end choose

modifica:

dw_cer.InsertRow ( 0 )

str_asp.v_data = dw_asp.GetItemDateTime ( 1, "data_cer" )
dw_cer.SetItem ( 1, "data_cer", str_asp.v_data )

str_asp.v_citta = dw_asp.GetItemString ( 1, "luogo_cer" )
dw_cer.SetItem ( 1, "luogo_cer", str_asp.v_citta )

str_asp.v_turno = dw_asp.GetItemString ( 1, "turno" )
dw_cer.SetItem ( 1, "turno", str_asp.v_turno )

modify = true
st_modify.visible = true

m_asp.m_main.m_r_cerimonia.enabled = true
m_asp.m_main.m_salva.enabled = true
m_asp.m_main.m_cancella.enabled = true
m_asp.m_finestra.m_svuota.enabled = true

st_cognome.visible = false
sle_cognome.visible = false
st_nome.visible = false
sle_nome.visible = false
cb_cerca.visible = false

dw_cer.enabled = true

dw_asp.enabled = true
dw_asp.SetFocus ( )

end event

event cerca_cer;long ll_rows

select count ( * )
into :ll_rows
from aspiranti;

if trap_sql ( sqlca, "controllo liste" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	close ( this )
	return -1
end if

if ll_rows = 0 then 
	MessageBox ( "Aspiranti", "Nessuna lista impostata..." )
	return -1
end if

Open ( w_h_cer )

if message.DoubleParm = -1 then
	
	if not modify then
		
		event clear ( "menu" )
		return 1
		
	end if
	
	return 1
	
else
	
	if modify then dw_asp.SetItemStatus ( 1, 0, Primary!, DataModified! )
	
end if

dw_cer.InsertRow ( 0 )

str_asp = message.PowerObjectParm

dw_cer.SetItem ( 1, "data_cer", str_asp.v_data )
dw_cer.SetItem ( 1, "luogo_cer", str_asp.v_citta )
dw_cer.SetItem ( 1, "turno", str_asp.v_turno )

if not modify then dw_cer.enabled = false

dw_asp.enabled = true
dw_asp.SetFocus ( )

if not modify then dw_asp.InsertRow ( 0 )

dw_asp.SetColumn ( "cognome" )

m_asp.m_finestra.m_svuota.enabled = true
m_asp.m_main.m_salva.enabled = true

return 0

end event

event mod_state;long ll_rows

select count ( * )
into :ll_rows
from aspiranti;

if trap_sql ( sqlca, "controllo liste" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	close ( this )
	return -1
end if

if ll_rows = 0 then 
	MessageBox ( "Aspiranti", "Nessuna lista impostata..." )
	return -1
end if

dw_cer.enabled = false

st_cognome.visible = true
sle_cognome.visible = true
st_nome.visible = true
sle_nome.visible = true
cb_cerca.visible = true

searching = true

sle_cognome.SetFocus ( )

return 0

end event

event clear;/* --- ROUTINE DI REINIZIALIZZAZIONE MASCHERA --- */

int field_tot, i, b1, b2, li_ret
field_tot = UpperBound ( control[] )

SingleLineEdit curr_sle
DataWindow curr_dw
Picture curr_pict

dw_asp.AcceptText ( )

if dw_asp.ModifiedCount ( ) > 0 or dw_asp.DeletedCount ( ) > 0 then

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

/* Individua tutti gli oggetti modificabili e li inizializza... */

for i = 1 to field_tot
	
	choose case TypeOf ( control[i] )

		case SingleLineEdit!
			
			curr_sle = control[i]
			curr_sle.text = ""
			
		case DataWindow!
			
			curr_dw = control[i]
			if status = "salva" and not modify then
				if curr_dw.tag <> "cerimonie" then
					curr_dw.SetRedraw ( false )
					curr_dw.Reset ( )
					curr_dw.InsertRow ( 0 )
					curr_dw.SetRedraw ( true )
				end if
			else
				curr_dw.SetRedraw ( false )
				curr_dw.Reset ( )
				curr_dw.SetRedraw ( true )
			end if
				
		case Picture!
			
			curr_pict = control[i]
			curr_pict.Visible = false
			
		case else

	end choose

next

m_asp.m_main.m_annulla.enabled = false
m_asp.m_main.m_salva.enabled = false

choose case status

	case "insert"
	
		m_asp.m_finestra.m_svuota.enabled = true
		dw_asp.enabled = true
		dw_asp.SetFocus ( )

	case "salva"
		
		m_asp.m_finestra.m_svuota.enabled = true
		m_asp.m_main.m_ricerca_nome.enabled = true
		m_asp.m_main.m_n_cerimonia.enabled = true
		m_asp.m_main.m_r_cerimonia.enabled = true
		dw_asp.enabled = true
		dw_asp.SetFocus ( )
		
	case "menu"

		m_asp.m_main.m_ricerca_nome.enabled = true
		m_asp.m_main.m_n_cerimonia.enabled = true
		m_asp.m_main.m_r_cerimonia.enabled = true
		dw_asp.enabled = false
		dw_cer.enabled = true

end choose

st_modify.visible = false
modify = false
searching = false

m_asp.m_main.m_cancella.enabled = false

st_cognome.visible = false
sle_cognome.visible = false
st_nome.visible = false
sle_nome.visible = false
cb_cerca.visible = false

SetNull ( il_code )
SetNull ( is_dip )
SetNull ( is_cognome )
SetNull ( is_nome )

end event

event erase;int li_ret

li_ret = MessageBox ( "CANCELLAZIONE", "Procedere?", question!, YesNo!, 2 )

if li_ret = 2 then return

dw_asp.DeleteRow ( 1 )

if dw_asp.Update ( ) = -1 then goto errore

commit;

m_asp.m_main.m_ricerca_nome.checked = false

OpenWithParm ( w_msgauto, "Cancellazione effettuata." )

this.PostEvent ( "ins_state" )

return

errore:

rollback;

OpenWithParm ( w_msgauto, "Cancellazione fallita." )

end event

event uscita;ib_closing = true

close ( this )

end event

event undo;int li_ret

li_ret = MessageBox ( "Aspiranti", "Annullare le modifiche?", question!, YesNo!, 2 )

if li_ret = 2 then return

dw_asp.SetRedraw ( false )
dw_asp.Reset ( )

if dw_asp.Retrieve ( il_code, is_dip ) < 1 then
	this.event clear ( "menu" )
	dw_asp.SetRedraw ( true )
	return
end if

dw_asp.SetRedraw ( true )

str_asp.v_data = dw_asp.GetItemDateTime ( 1, "data_cer" )
w_asp.dw_cer.SetItem ( 1, "data_cer", w_asp.str_asp.v_data )

str_asp.v_citta = dw_asp.GetItemString ( 1, "luogo_cer" )
w_asp.dw_cer.SetItem ( 1, "luogo_cer", w_asp.str_asp.v_citta )

str_asp.v_turno = dw_asp.GetItemString ( 1, "turno" )
w_asp.dw_cer.SetItem ( 1, "turno", w_asp.str_asp.v_turno )

m_asp.m_main.m_annulla.enabled = false

end event

event crea_cer;dw_cer.InsertRow ( 0 )
dw_cer.SetFocus ( )

end event

public function integer f_search (ref string v_cognome, ref string v_nome);long ll_rows

select count ( * )
into :ll_rows
from aspiranti
where cognome like :v_cognome
and nome like :v_nome;


if trap_sql ( sqlca, "ricerca nomi" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	return -1
end if

choose case ll_rows
		
	case 0

		return 0
		
	case is >= 1
		
		return ll_rows
		
	case else 
		
		return -2
		
end choose

end function

public function integer f_mod_nome ();if dw_asp.GetItemStatus ( 1, "cognome", primary! ) = DataModified! or &
	dw_asp.GetItemStatus ( 1, "nome", primary! ) = DataModified! then return 1
	
return 0

end function

public function integer f_exists (string v_cognome, string v_nome);long ll_rows


ll_rows = ds_doppi.Retrieve ( v_cognome, v_nome )


return ll_rows

end function

on w_asp_old.create
if this.MenuName = "m_asp" then this.MenuID = create m_asp
this.sle_cognome=create sle_cognome
this.sle_nome=create sle_nome
this.st_cognome=create st_cognome
this.st_nome=create st_nome
this.cb_cerca=create cb_cerca
this.dw_cer=create dw_cer
this.st_modify=create st_modify
this.dw_asp=create dw_asp
this.gb_cerca=create gb_cerca
this.gb_cer=create gb_cer
this.Control[]={this.sle_cognome,&
this.sle_nome,&
this.st_cognome,&
this.st_nome,&
this.cb_cerca,&
this.dw_cer,&
this.st_modify,&
this.dw_asp,&
this.gb_cerca,&
this.gb_cer}
end on

on w_asp_old.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_cognome)
destroy(this.sle_nome)
destroy(this.st_cognome)
destroy(this.st_nome)
destroy(this.cb_cerca)
destroy(this.dw_cer)
destroy(this.st_modify)
destroy(this.dw_asp)
destroy(this.gb_cerca)
destroy(this.gb_cer)
end on

event open;PostEvent ( "ue_open" )


end event

event closequery;int li_ret

dw_asp.AcceptText ( )

if dw_asp.GetItemStatus ( 1, 0, primary! ) = DataModified! or &
	dw_asp.GetItemStatus ( 1, 0, primary! ) = NewModified! then
	
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

end event

event activate;gs_context = "Nuovi membri"

end event

type sle_cognome from uo_sle_gen within w_asp_old
string tag = "Cognome"
boolean visible = false
integer x = 498
integer y = 348
integer width = 658
integer height = 80
integer taborder = 10
integer limit = 30
end type

event getfocus;call super::getfocus;cb_cerca.enabled = true

end event

type sle_nome from uo_sle_gen within w_asp_old
string tag = "Nome"
boolean visible = false
integer x = 1445
integer y = 352
integer width = 658
integer height = 80
integer taborder = 20
integer limit = 25
end type

event getfocus;call super::getfocus;cb_cerca.enabled = true

end event

type st_cognome from statictext within w_asp_old
boolean visible = false
integer x = 233
integer y = 356
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Cognome:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nome from statictext within w_asp_old
boolean visible = false
integer x = 1248
integer y = 360
integer width = 178
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Nome:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_cerca from commandbutton within w_asp_old
event clicked pbm_bnclicked
boolean visible = false
integer x = 2226
integer y = 352
integer width = 233
integer height = 88
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cerca"
boolean default = true
end type

event clicked;int li_ret

dw_asp.AcceptText ( )

if dw_asp.GetItemStatus ( 1, 0, primary! ) = DataModified! then
	
	li_ret = MessageBox ( "DATI MODIFICATI", "Salvare?", question!, YesNoCancel!, 1 )
																				
	choose case li_ret
			
		case 1
			
			if event save ( ) = -1 then return
			goto ok
			
		case 2
			
			goto ok
			
		case 3
			
			return
			
	end choose
	
end if

Ok:

dw_asp.SetRedraw ( false )
dw_asp.Reset ( )
dw_asp.SetRedraw ( true )

cb_cerca.enabled = false

parent.PostEvent ( "cerca" )

end event

type dw_cer from datawindow within w_asp_old
string tag = "cerimonie"
integer x = 101
integer y = 104
integer width = 3031
integer height = 116
string dataobject = "d_ext_cer"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_rows

if modify then dw_asp.SetItemStatus ( 1, 0, Primary!, DataModified! )

choose case dwo.name
		
	case "data_cer"
		
		if date ( mid ( data, 1, 10 ) ) < today ( ) then
			
			if MessageBox ( "Attenzione", "Data anteriore a quella odierna...~n~nContinuare?", &
								 exclamation!, YesNo!, 2 ) = 2 then return 1
								 
   	end if
		
		if modify then str_asp.v_data = datetime ( date ( data ) )
		
		SetColumn ( "luogo_cer" )
		
	case "luogo_cer"
		
		if modify then str_asp.v_citta = data
		
	case "turno"
		
		if not IsNull ( data ) then
			
			if not modify then
			
				str_asp.v_data = GetItemDateTime ( row, 1 )
				str_asp.v_citta = GetItemString ( row, 2 )
				str_asp.v_turno = data
		
				select count ( * )
				into :ll_rows
				from aspiranti
				where data_cer = :str_asp.v_data
				and luogo_cer = :str_asp.v_citta
				and turno = :data;
				
				if ll_rows > 0 then
					MessageBox ( "Attenzione", "Questa cerimonia è già stata impostata.", exclamation! )
					SetColumn ( 1 )
					return 1
				end if
		
				dw_asp.enabled = true
				dw_asp.SetFocus ( )
				dw_asp.InsertRow ( 0 )
				dw_asp.SetColumn ( "cognome" )
				
				dw_cer.enabled = false
				
			else
				
				str_asp.v_turno = data
				dw_asp.SetFocus ( )
				dw_asp.SetColumn ( "cognome" )
				
				dw_cer.enabled = false
				
			end if
			
			m_asp.m_finestra.m_svuota.enabled = true
			m_asp.m_main.m_salva.enabled = true
			
		else
			
			return 1

		end if
		
	case else
		
end choose

end event

event itemerror;return 1

end event

event editchanged;if dwo.name = "data_cer" then f_checkdate ( dw_cer )

end event

type st_modify from statictext within w_asp_old
boolean visible = false
integer x = 2555
integer y = 360
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
boolean enabled = false
string text = "MODIFICA"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_asp from datawindow within w_asp_old
string tag = "Dettaglio"
integer x = 50
integer y = 544
integer width = 3351
integer height = 1480
boolean enabled = false
string dataobject = "d_asp"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_rows
boolean first_time = true
string ls_data

if row > 0 then

	m_asp.m_main.m_salva.enabled = true
	
	if modify then m_asp.m_main.m_annulla.enabled = true

	CHOOSE CASE dwo.name
			
		CASE "cognome"
			
			if len ( trim ( data ) ) = 0 then
				this.SetItem ( 1, "cognome", this.GetItemString ( 1, "cognome" ) )
				return 1
			end if

			data= trim(data)
			
		CASE "nome"
			
			if len ( trim ( data ) ) = 0 then
				this.SetItem ( 1, "nome", this.GetItemString ( 1, "nome" ) )
				return 1
			end if

			data= trim(data)
			
		CASE "comune"
			
			cerca:
			
			data = trim ( data )

			ll_rows = ds_com.Retrieve ( data )
			
//			scelta:
			
			choose case ll_rows
					
				case is < 1
					
					if first_time then
						data = data + "%"
						first_time = false
						goto cerca
					else
						first_time = true
						goto not_found
					end if
					
					not_found:
					
					MessageBox ( "LOCALITA' NON TROVATA...", data )
					this.SetItem ( 1, "comune", this.GetItemString ( 1, "comune" ) )
					return 1
					
				case 1
					
					is_com = ds_com.GetItemString ( 1, 2 )
					is_prov = ds_com.GetItemString ( 1, 3 )
					is_cod_com = ds_com.GetItemstring ( 1, 1 )
					
					dw_asp.SetItem ( row, "provincia", is_prov )
					dw_asp.SetItem ( row, "cod_com", is_cod_com )
					dw_asp.SetItem ( row, "comune", is_com )
					dw_asp.SetText ( is_com )
					return 2
								
				case is > 1
					
					str_parm.w_name = "w_asp"
					str_parm.v_com = data
					
					OpenWithParm ( w_search_com, str_parm )
					
					if message.DoubleParm = -1 then
						this.SetItem ( 1, "comune", this.GetItemString ( 1, "comune" ) )
						return 1
					end if
					
					dw_asp.SetItem ( row, "provincia", is_prov )
					dw_asp.SetItem ( row, "cod_com", is_cod_com )
					dw_asp.SetItem ( row, "comune", is_com )
					dw_asp.SetText ( is_com )
					return 2
		
			end choose
			
		CASE "cod_area"
 
			c_area = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_terr_d.Reset ( )
			SetItem ( row, "cod_terr", v_null )
			SetItem ( row, "cod_cen", v_null )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )

		CASE "cod_terr"
 
			c_terr = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_cen_d.Reset ( )
			SetItem ( row, "cod_cen", v_null )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			
			
		CASE "cod_cen"

			c_cen = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_cap_d.Reset ( )
			SetItem ( row, "cod_cap", v_null )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )

		CASE "cod_cap"

			c_cap = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_sett_d.Reset ( )
			SetItem ( row, "cod_sett", v_null )
			SetItem ( row, "cod_gru", v_null )
			
		CASE "cod_sett"

			c_sett = f_replace_chars ( this.getText ( ), "'", "" )
			idwc_gru_d.Reset ( )
			SetItem ( row, "cod_gru", v_null )
			
		CASE "data_nas"
			
			if f_min ( data ) = 1 then
				if MessageBox ( parent.title, "E' consentito inserire minorenni solo con il consenso dei genitori."+&
														"~nAbbiamo il modulo di consenso firmato da ambedue i genitori?" , question!, yesNo!, 2)= 2 then
					return 1
				else
					return 0
				end if
			end if

//			SetColumn ( "citta_nas" )

	CASE else

	END CHOOSE

end if

return 0

end event

event itemerror;if dwo.name = "cod_area" or dwo.name = "cod_terr" or dwo.name = "cod_cen" or &
	dwo.name = "cod_cap" or dwo.name = "cod_sett" or dwo.name = "cod_gru" then

	return 3
	
else
	
	return 1

end if

end event

event itemfocuschanged;long l_rows

string where_clause

if row < 1 then return

c_area_d = GetItemString ( 1, "cod_area" )
c_terr_d = GetItemString ( 1, "cod_terr" )
c_cen_d = GetItemString ( 1, "cod_cen" )
c_cap_d = GetItemString ( 1, "cod_cap" )
c_sett_d = GetItemString ( 1, "cod_sett" )
c_gru_d = GetItemString ( 1, "cod_gru" )

choose case dwo.name
		
	case "cod_area"
		
		where_clause= " where aree.cod_area<>~~'"+"A"+"~~'" 
		l_rows= f_mod_select(where_clause, idwc_area_d)
		
		
	case "cod_terr"
		
		where_clause= " or territori.cod_area=~~'"+c_area_d+"~~'" 
		l_rows= f_mod_select(where_clause, idwc_terr_d)
		
	case "cod_cen"

		where_clause= " or (centri.cod_area=~~'"+c_area_d+"~~' and centri.cod_terr=~~'"+c_terr_d+"~~')" 
		l_rows= f_mod_select(where_clause, idwc_cen_d)
		
	case "cod_cap"

		where_clause= 	" or (capitoli.cod_area=~~'"+c_area_d+ &
							"~~' and capitoli.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
							" capitoli.cod_cen= ~~'"+c_cen_d+"~~')"
		l_rows= f_mod_select(where_clause, idwc_cap_d)
		
	case "cod_sett"

		where_clause= " or (settori.cod_area= ~~'"+c_area_d+"~~' and "+ &
						  " settori.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
						  " settori.cod_cen= ~~'"+c_cen_d+"~~' and "+&
						  " settori.cod_cap= ~~'"+c_cap_d+"~~')"
		l_rows= f_mod_select(where_clause, idwc_sett_d)
		
	case "cod_gru"

		where_clause= " or (gruppi.cod_area= ~~'"+c_area_d+"~~' and "+ &
						  " gruppi.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
						  " gruppi.cod_cen= ~~'"+c_cen_d+"~~' and "+&
						  " gruppi.cod_cap= ~~'"+c_cap_d+"~~' and "+&
						  " gruppi.cod_sett= ~~'"+c_sett_d+"~~')"
		l_rows= f_mod_select(where_clause, idwc_gru_d)

end choose

end event

event retrieveend;long l_rows, err_code

string where_clause

if rowcount < 1 then return

c_area_d = GetItemString ( 1, "cod_area" )
c_terr_d = GetItemString ( 1, "cod_terr" )
c_cen_d = GetItemString ( 1, "cod_cen" )
c_cap_d = GetItemString ( 1, "cod_cap" )
c_sett_d = GetItemString ( 1, "cod_sett" )
c_gru_d = GetItemString ( 1, "cod_gru" )

where_clause= " where aree.cod_area<>~~'"+"A"+"~~'" 
err_code = this.GetChild ( 'cod_area',idwc_area_d )
l_rows= f_mod_select(where_clause, idwc_area_d)

where_clause= " or territori.cod_area=~~'"+c_area_d+"~~'" 
this.GetChild ( 'cod_terr',idwc_terr_d )
l_rows= f_mod_select(where_clause, idwc_terr_d)
this.AcceptText ( )

where_clause= " or (centri.cod_area=~~'"+c_area_d+"~~' and centri.cod_terr=~~'"+c_terr_d+"~~')" 
this.GetChild ( 'cod_cen',idwc_cen_d )
l_rows= f_mod_select(where_clause, idwc_cen_d)

where_clause= 	" or (capitoli.cod_area=~~'"+c_area_d+ &
					"~~' and capitoli.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
					" capitoli.cod_cen= ~~'"+c_cen_d+"~~')"
this.GetChild ( 'cod_cap',idwc_cap_d )
l_rows= f_mod_select(where_clause, idwc_cap_d)

where_clause= " or (settori.cod_area= ~~'"+c_area_d+"~~' and "+ &
				  " settori.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
				  " settori.cod_cen= ~~'"+c_cen_d+"~~' and "+&
				  " settori.cod_cap= ~~'"+c_cap_d+"~~')"
this.GetChild ( 'cod_sett',idwc_sett_d )
l_rows= f_mod_select(where_clause, idwc_sett_d)

where_clause= " or (gruppi.cod_area= ~~'"+c_area_d+"~~' and "+ &
				  " gruppi.cod_terr= ~~'"+c_terr_d+"~~' and "+ &
				  " gruppi.cod_cen= ~~'"+c_cen_d+"~~' and "+&
				  " gruppi.cod_cap= ~~'"+c_cap_d+"~~' and "+&
				  " gruppi.cod_sett= ~~'"+c_sett_d+"~~')"
this.GetChild ( 'cod_gru',idwc_gru_d )

l_rows= f_mod_select(where_clause, idwc_gru_d)

is_cognome = this.GetItemString ( 1, "cognome" )
is_nome = this.GetItemString ( 1, "nome" )

end event

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event editchanged;//if dwo.name = "data_nas" then f_checkdate ( dw_asp )

end event

event buttonclicked;integer i_err, li_exists
string ls_cap, ls_loc, ls_vercap

ls_cap= this.getItemString(row, "cap_dom")
ls_loc= this.getItemString(row, "comune")

select cap into :ls_vercap from tab_comuni where comune= :ls_loc;

select count(*)  into :li_exists from cap_generici where cap= :ls_vercap;

if isNull(li_exists) or li_exists= 0 then // se non è un cap generico...
//	select cap into :ls_vercap from tab_comuni where comune= :ls_loc;
	if ls_vercap <> ls_cap then
		i_err= messageBox(parent.title, "Il C.A.P. corretto relativo alla località "+ls_loc+" è: "+ls_vercap+"~nVuoi eseguire la correzione?", question!, yesNo!, 1)
		if i_err= 2 then return
		i_err= dw_asp.SetItem ( row, "cap_dom", ls_vercap )
	else
		messageBox(parent.title, "Il C.A.P. "+ls_vercap+ " relativo alla località "+ls_loc+" è corretto.")
	end if
else // se è un cap generico...
	i_err= messageBox(parent.title, "Il C.A.P. relativo alla località "+ls_loc +" è un C.A.P. generico.~nVuoi cercare nell'archivio strade?", question!, yesNo!, 1)
	if i_err= 2 then return 
		// apre la finestra di ricerca strade...
		openWithParm(w_cerca_strade, this.getItemString(row, "cod_com"))
		is_strade_s= message.powerObjectParm
			
			if NOT isNull(is_strade_s.cap) then
				
				if is_strade_s.strada <> "" then dw_asp.SetItem ( row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")
				
				i_err= dw_asp.SetItem ( row, "cap_dom", is_strade_s.cap)
		
			end if
		
end if
end event
type gb_cerca from groupbox within w_asp_old
boolean visible = false
integer x = 50
integer y = 288
integer width = 3351
integer height = 188
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32768
long backcolor = 12632256
string text = " Ricerca "
borderstyle borderstyle = stylelowered!
end type

type gb_cer from groupbox within w_asp_old
integer x = 50
integer y = 4
integer width = 3351
integer height = 264
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = " Dati cerimonia "
borderstyle borderstyle = stylelowered!
end type

