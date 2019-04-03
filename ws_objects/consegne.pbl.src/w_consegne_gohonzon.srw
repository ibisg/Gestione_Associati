$PBExportHeader$w_consegne_gohonzon.srw
forward
global type w_consegne_gohonzon from window
end type
type dw_header from uodw_header within w_consegne_gohonzon
end type
type tab_gohonzon from tab within w_consegne_gohonzon
end type
type tabpage_inserimento from userobject within tab_gohonzon
end type
type rb_oka from radiobutton within tabpage_inserimento
end type
type rb_tok from radiobutton within tabpage_inserimento
end type
type rb_oma from radiobutton within tabpage_inserimento
end type
type dp_filtra_datacerimonia from datepicker within tabpage_inserimento
end type
type uodw_import from uodw_generica within tabpage_inserimento
end type
type cbx_filtra_datacerimonia from checkbox within tabpage_inserimento
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
type tabpage_inserimento from userobject within tab_gohonzon
rb_oka rb_oka
rb_tok rb_tok
rb_oma rb_oma
dp_filtra_datacerimonia dp_filtra_datacerimonia
uodw_import uodw_import
cbx_filtra_datacerimonia cbx_filtra_datacerimonia
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltrodata cb_annullafiltrodata
cb_estrazione cb_estrazione
gb_criteri gb_criteri
cb_filtradata cb_filtradata
end type
type tabpage_lista from userobject within tab_gohonzon
end type
type uodw_lista from uodw_generica within tabpage_lista
end type
type tabpage_lista from userobject within tab_gohonzon
uodw_lista uodw_lista
end type
type tabpage_conferma from userobject within tab_gohonzon
end type
type uodw_esito from uodw_generica within tabpage_conferma
end type
type tabpage_conferma from userobject within tab_gohonzon
uodw_esito uodw_esito
end type
type tab_gohonzon from tab within w_consegne_gohonzon
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_conferma tabpage_conferma
end type
type s_cons from structure within w_consegne_gohonzon
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

global type w_consegne_gohonzon from window
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
event type integer ue_enable ( )
dw_header dw_header
tab_gohonzon tab_gohonzon
end type
global w_consegne_gohonzon w_consegne_gohonzon

type variables
//boolean ib_closing = false
//boolean calling = false
//
//s_esami str_es
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status, is_tipo_goh

DataWindowChild idwc_liv, idwc_luoghi

m_preview im_preview

s_evento is_evento_s

end variables

event type integer ue_open();long ll_row

im_preview= create m_preview

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

tab_gohonzon.enabled= false

open(w_wait_snoopy_writing)

this.setRedraw(false)

tab_gohonzon.tabpage_inserimento.uodw_import.setTransObject(sqlca)

dw_header.setTransObject(sqlca)
dw_header.GetChild('cod_luogo', idwc_luoghi)

idwc_luoghi.setTransObject(sqlca)

idwc_luoghi.retrieve(s_session_s.cod_dip)

ll_row= dw_header.retrieve(is_evento_s.id)

is_liv = "0"+string(is_evento_s.tipo_evento - 1)

tab_gohonzon.tabpage_lista.uodw_lista.setTransObject(sqlca)

if tab_gohonzon.tabpage_lista.uodw_lista.retrieve(is_evento_s.id)= 0 then
	
	close(w_wait_snoopy_writing)
	messageBox(this.title, "Nessuna lista è stata ancora generata per questo evento.", information!)
	
	tab_gohonzon.enabled= true
//	
//	//tab_gohonzon.tabpage_inserimento.cb_estrazione.event clicked()
//	
//	tab_gohonzon.tabpage_inserimento.cb_estrazione.enabled= true
//	tab_gohonzon.tabpage_inserimento.pb_struttura.enabled= true
	
else
	
	tab_gohonzon.enabled= true
	tab_gohonzon.tabpage_inserimento.enabled= false
	tab_gohonzon.tabpage_lista.enabled= true
	tab_gohonzon.tabpage_conferma.enabled= true
	tab_gohonzon.selectTab(tab_gohonzon.tabpage_lista)
	
	close(w_wait_snoopy_writing)
	
end if

this.setRedraw(true)

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

event importa();long ll_rows, ll_count, ll_row

ds_lista = create uo_ds_gen
ds_lista.DataObject = "dw_lista_consegna_gohonzon" //"ds_lista"
ds_lista.SetTransObject ( sqlca )

for ll_count = 1 to tab_gohonzon.tabpage_inserimento.uodw_import.RowCount ()
	
	if tab_gohonzon.tabpage_inserimento.uodw_import.GetItemString ( ll_count, "flag_ok" ) = "1" then
	
		ll_row= ds_lista.InsertRow ( 0 )
		
		ds_lista.SetItem ( ll_row, "eventi_id", is_evento_s.id )
		ds_lista.SetItem ( ll_row, "codice", tab_gohonzon.tabpage_inserimento.uodw_import.GetItemString ( ll_count, "codice" ) )
		ds_lista.SetItem ( ll_row, "tipo_goh", is_tipo_goh )
		ds_lista.SetItem ( ll_row, "flag_part", "1" )
		
//		messageBox("test", tab_esami.tabpage_inserimento.dw_import.GetItemString ( ll_count, "codice" ) )
		
	end if
	
next

if ds_lista.Update ( ) = -1 then
	
	rollback;
	destroy ds_lista
	OpenWithParm ( w_msg, "Importazione annullata" )
	
	return
	
end if

commit;

//ds_lista.reset ( )
destroy ds_lista

OpenWithParm ( w_msg, "Importazione effettuata" )

tab_gohonzon.tabpage_lista.uodw_lista.SetRedraw ( false )
//tab_gohonzon.tabpage_lista.uodw_lista.Retrieve ( is_evento_s.id )
//tab_esami.tabpage_lista.dw_lista.Object.DataWindow.Print.Preview= 'yes'

//cb_estrai.text = "Aggiorna lista"
//cb_save.enabled = false
//cb_annulla.text = "Cancella lista"
//cb_annulla.enabled = true
//

tab_gohonzon.selectTab(tab_gohonzon.tabpage_lista)
tab_gohonzon.tabpage_lista.enabled= true
tab_gohonzon.tabpage_inserimento.enabled= false
tab_gohonzon.tabpage_conferma.enabled= true

tab_gohonzon.tabpage_lista.uodw_lista.SetRedraw ( true )

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

event type integer ue_enable();//tab_gohonzon.enabled= true

tab_gohonzon.tabpage_inserimento.uodw_import.Object.DataWindow.queryMode= 'No'

tab_gohonzon.tabpage_inserimento.cb_estrazione.event clicked()

tab_gohonzon.tabpage_inserimento.cb_estrazione.enabled= true
tab_gohonzon.tabpage_inserimento.pb_struttura.enabled= true

return 0
end event

on w_consegne_gohonzon.create
this.dw_header=create dw_header
this.tab_gohonzon=create tab_gohonzon
this.Control[]={this.dw_header,&
this.tab_gohonzon}
end on

on w_consegne_gohonzon.destroy
destroy(this.dw_header)
destroy(this.tab_gohonzon)
end on

event open;is_evento_s= message.powerObjectParm

PostEvent ( "ue_open" )

end event

event closequery;//if dw_elenco.DataObject = "d_lista" then
//
//	int li_ret
//	
//	dw_elenco.AcceptText ( )
//	
//	if dw_elenco.ModifiedCount ( ) > 0 then
//		
//		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
//									 question!, YesNoCancel!, 1 )
//																					
//		choose case li_ret
//				
//			case 1
//				
//				if event save ( ) = -1 then
//					ib_closing = false
//					return 1
//				else
//					return 0
//				end if
//				
//			case 2
//				
//				return 0
//				
//			case 3
//				
//				ib_closing = false
//				return 1
//				
//		end choose
//		
//	end if
//	
//end if
//
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

tab_gohonzon.height= this.height - 180 - tab_gohonzon.y
tab_gohonzon.width= this.width - 120
tab_gohonzon.tabpage_inserimento.uodw_import.height= tab_gohonzon.height - 120 - tab_gohonzon.tabpage_inserimento.uodw_import.y

tab_gohonzon.tabpage_lista.uodw_lista.height= tab_gohonzon.height - 120 - tab_gohonzon.tabpage_lista.uodw_lista.y
tab_gohonzon.tabpage_lista.uodw_lista.width= tab_gohonzon.tabpage_lista.width - 30
tab_gohonzon.tabpage_conferma.uodw_esito.height= tab_gohonzon.height - 120 - tab_gohonzon.tabpage_conferma.uodw_esito.y
end event

type dw_header from uodw_header within w_consegne_gohonzon
integer x = 18
integer width = 4434
integer height = 368
integer taborder = 20
end type

type tab_gohonzon from tab within w_consegne_gohonzon
event create ( )
event destroy ( )
integer x = 23
integer y = 384
integer width = 4453
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
tabpage_conferma tabpage_conferma
end type

on tab_gohonzon.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_lista=create tabpage_lista
this.tabpage_conferma=create tabpage_conferma
this.Control[]={this.tabpage_inserimento,&
this.tabpage_lista,&
this.tabpage_conferma}
end on

on tab_gohonzon.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_lista)
destroy(this.tabpage_conferma)
end on

event selectionchanging;if oldindex= 2 then

	choose case tab_gohonzon.tabpage_lista.uodw_lista.uof_modificheincorso()
			
		case 1
			
				tab_gohonzon.tabpage_lista.uodw_lista.uof_aggiorna()
				
		case 2
			
			// non salva
			
		case 3
			
			return 1 // annulla il cambio di selezione...
			
	end choose

end if

setPointer(hourGlass!)

choose case newindex
		
	case 2
		
		tab_gohonzon.tabpage_lista.uodw_lista.setTransObject(sqlca)
		tab_gohonzon.tabpage_lista.uodw_lista.SetRedraw ( false )
		tab_gohonzon.tabpage_lista.uodw_lista.Retrieve ( is_evento_s.id )
//		tab_gohonzon.tabpage_lista.uodw_lista.Object.DataWindow.Print.Preview= 'yes'
//		tab_gohonzon.tabpage_lista.uodw_lista.Object.DataWindow.Print.Buttons = 'yes'
		tab_gohonzon.tabpage_lista.uodw_lista.SetRedraw ( true )	
		
	case 3
		
		tab_gohonzon.tabpage_conferma.uodw_esito.setTransObject(sqlca)
		tab_gohonzon.tabpage_conferma.uodw_esito.SetRedraw ( false )
		tab_gohonzon.tabpage_conferma.uodw_esito.Retrieve ( is_evento_s.id )
		tab_gohonzon.tabpage_conferma.uodw_esito.SetRedraw ( true )	
		
		
end choose
end event

type tabpage_inserimento from userobject within tab_gohonzon
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4416
integer height = 2244
long backcolor = 81324524
string text = "Inserimento partecipanti"
long tabtextcolor = 16711680
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
rb_oka rb_oka
rb_tok rb_tok
rb_oma rb_oma
dp_filtra_datacerimonia dp_filtra_datacerimonia
uodw_import uodw_import
cbx_filtra_datacerimonia cbx_filtra_datacerimonia
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltrodata cb_annullafiltrodata
cb_estrazione cb_estrazione
gb_criteri gb_criteri
cb_filtradata cb_filtradata
end type

on tabpage_inserimento.create
this.rb_oka=create rb_oka
this.rb_tok=create rb_tok
this.rb_oma=create rb_oma
this.dp_filtra_datacerimonia=create dp_filtra_datacerimonia
this.uodw_import=create uodw_import
this.cbx_filtra_datacerimonia=create cbx_filtra_datacerimonia
this.st_1=create st_1
this.pb_struttura=create pb_struttura
this.cb_importa=create cb_importa
this.cb_annullafiltrodata=create cb_annullafiltrodata
this.cb_estrazione=create cb_estrazione
this.gb_criteri=create gb_criteri
this.cb_filtradata=create cb_filtradata
this.Control[]={this.rb_oka,&
this.rb_tok,&
this.rb_oma,&
this.dp_filtra_datacerimonia,&
this.uodw_import,&
this.cbx_filtra_datacerimonia,&
this.st_1,&
this.pb_struttura,&
this.cb_importa,&
this.cb_annullafiltrodata,&
this.cb_estrazione,&
this.gb_criteri,&
this.cb_filtradata}
end on

on tabpage_inserimento.destroy
destroy(this.rb_oka)
destroy(this.rb_tok)
destroy(this.rb_oma)
destroy(this.dp_filtra_datacerimonia)
destroy(this.uodw_import)
destroy(this.cbx_filtra_datacerimonia)
destroy(this.st_1)
destroy(this.pb_struttura)
destroy(this.cb_importa)
destroy(this.cb_annullafiltrodata)
destroy(this.cb_estrazione)
destroy(this.gb_criteri)
destroy(this.cb_filtradata)
end on

type rb_oka from radiobutton within tabpage_inserimento
integer x = 114
integer y = 120
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
string text = "Okatagi"
end type

event clicked;is_tipo_goh= 'OKA'

return event ue_enable()
end event

type rb_tok from radiobutton within tabpage_inserimento
integer x = 937
integer y = 120
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
string text = "Tokuso"
end type

event clicked;is_tipo_goh= 'TOK'

return event ue_enable()
end event

type rb_oma from radiobutton within tabpage_inserimento
integer x = 526
integer y = 120
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
string text = "Omamori"
end type

event clicked;is_tipo_goh= 'OMA'

return event ue_enable()
end event

type dp_filtra_datacerimonia from datepicker within tabpage_inserimento
integer x = 1728
integer y = 252
integer width = 434
integer height = 100
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
boolean enabled = false
boolean allowedit = true
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-21"), Time("10:36:32.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type uodw_import from uodw_generica within tabpage_inserimento
integer y = 488
integer width = 4398
integer height = 720
integer taborder = 30
string dataobject = "dw_consegne_gohonzon"
boolean ib_isgrid = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_import

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event retrieveend;call super::retrieveend;cbx_filtra_datacerimonia.enabled= true
end event

event retrievestart;call super::retrievestart;cbx_filtra_datacerimonia.enabled= false
dp_filtra_datacerimonia.enabled= false
cb_filtradata.enabled= false
cb_annullafiltrodata.enabled= false
end event

event rowfocuschanged;call super::rowfocuschanged;f_select_current_row (this)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

event sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, uodw_import, false)

choose case is_tipo_goh
		
	case 'OKA'

		if(pos(lower(sqlsyntax), "where")) >0 then
			sqlsyntax+= " and membri_gerarchica.flag_goh <>  'S' "
		else
			sqlsyntax+= " where membri_gerarchica.flag_goh <>  'S' "	
		end if		
		
	case 'OMA'

		if(pos(lower(sqlsyntax), "where")) >0 then
			sqlsyntax+= " and membri_gerarchica.flag_oma <>  'S' "
		else
			sqlsyntax+= " where membri_gerarchica.flag_oma <>  'S' "	
		end if
	
	case 'TOK'

		if(pos(lower(sqlsyntax), "where")) >0 then
			sqlsyntax+= " and membri_gerarchica.flag_tok <>  'S' "
		else
			sqlsyntax+= " where membri_gerarchica.flag_tok <>  'S' "
		end if
	
end choose

SetSqlPreview ( sqlsyntax)
end event

event itemchanged;/* non esegue la script dell'ancestor */
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
string text = "Escludi le persone che hanno la data cerimonia uguale o superiore al:"
end type

event clicked;dp_filtra_datacerimonia.enabled= this.checked

cb_filtradata.enabled= this.enabled
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

event clicked;s_struttura s_struttura_s
s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s.ab_abilitaincolla= true
s_assegnastruttura_s.ai_maxlivello= gi_maxlivello		
s_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello - 1
s_assegnastruttura_s.as_ambito= gs_ambito

openWithParm(w_assegna_struttura, s_assegnastruttura_s )

s_struttura_s= message.powerObjectParm

if s_struttura_s.livello= -1 then return -1

tab_gohonzon.tabpage_inserimento.uodw_import.setColumn(1)

tab_gohonzon.tabpage_inserimento.uodw_import.setText(s_struttura_s.vc_nodo) 
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

event clicked;w_consegne_gohonzon.event importa()
end event

type cb_annullafiltrodata from commandbutton within tabpage_inserimento
integer x = 2546
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

dp_filtra_datacerimonia.enabled= false

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

event clicked;open(w_wait_snoopy_writing)

parent.setRedraw(false)
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

parent.setRedraw(true)

close(w_wait_snoopy_writing)

uodw_import.setFocus()

end event

type gb_criteri from groupbox within tabpage_inserimento
integer y = 16
integer width = 3401
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
integer x = 2194
integer y = 244
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

event clicked;string ls_filtra

if cbx_filtra_datacerimonia.checked= true then
	
	ls_filtra= " (data_cer <= date('"+string(dp_filtra_datacerimonia.value, "dd.mm.yy")+"'))"
	
end if

uodw_import.setFilter(ls_filtra)

uodw_import.filter()

cb_annullafiltrodata.enabled= true


end event

type tabpage_lista from userobject within tab_gohonzon
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4416
integer height = 2244
boolean enabled = false
long backcolor = 81324524
string text = "Lista consegna"
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
integer y = 12
integer width = 4411
integer height = 1116
integer taborder = 90
string dataobject = "dw_lista_consegna_gohonzon"
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;long ll_totale


choose case dwo.name
		
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
					messageBox(tab_gohonzon.tabpage_lista.text, "Salvataggio fallito", exclamation!)
					return -1
				end if
			uodw_lista.reset()
			tab_gohonzon.tabpage_lista.enabled= false
			tab_gohonzon.tabpage_conferma.enabled= false
			tab_gohonzon.selectTab(tab_gohonzon.tabpage_inserimento)
			tab_gohonzon.tabpage_inserimento.enabled= true
			
			tab_gohonzon.tabpage_inserimento.cb_estrazione.enabled= true
			tab_gohonzon.tabpage_inserimento.pb_struttura.enabled= true
			tab_gohonzon.tabpage_inserimento.cb_estrazione.event clicked()
			
		end if
	
end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_lista

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

type tabpage_conferma from userobject within tab_gohonzon
integer x = 18
integer y = 100
integer width = 4416
integer height = 2244
boolean enabled = false
long backcolor = 81324524
string text = "Conferma partecipazione"
long tabtextcolor = 8388736
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
uodw_esito uodw_esito
end type

on tabpage_conferma.create
this.uodw_esito=create uodw_esito
this.Control[]={this.uodw_esito}
end on

on tabpage_conferma.destroy
destroy(this.uodw_esito)
end on

type uodw_esito from uodw_generica within tabpage_conferma
integer width = 3575
integer taborder = 20
string dataobject = "dw_conferma_aspiranti"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
end type

event rowfocuschanged;call super::rowfocuschanged;if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_esito

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_esami_tab.PointerX(), w_esami_tab.PointerY() )
end event

event itemchanged;call super::itemchanged;if dwo.name= "voto" then
	if integer(data) > 250 or integer(data) < 0 then return 1
end if
end event

