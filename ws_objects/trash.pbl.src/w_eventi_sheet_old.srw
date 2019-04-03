$PBExportHeader$w_eventi_sheet_old.srw
forward
global type w_eventi_sheet_old from window
end type
type tab_entrata from tab within w_eventi_sheet_old
end type
type tabpage_inserimento from userobject within tab_entrata
end type
type uodw_inserimento from uodw_generica within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_entrata
uodw_inserimento uodw_inserimento
end type
type tabpage_stampe from userobject within tab_entrata
end type
type uodw_stampa_cerimonie from uodw_generica within tabpage_stampe
end type
type tabpage_stampe from userobject within tab_entrata
uodw_stampa_cerimonie uodw_stampa_cerimonie
end type
type tabpage_conferma from userobject within tab_entrata
end type
type uodw_conferma from uodw_generica within tabpage_conferma
end type
type tabpage_conferma from userobject within tab_entrata
uodw_conferma uodw_conferma
end type
type tab_entrata from tab within w_eventi_sheet_old
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
tabpage_conferma tabpage_conferma
end type
type dw_header from datawindow within w_eventi_sheet_old
end type
end forward

global type w_eventi_sheet_old from window
integer width = 5093
integer height = 3304
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event type integer ue_open ( )
event type integer ue_cercacerimonie ( )
tab_entrata tab_entrata
dw_header dw_header
end type
global w_eventi_sheet_old w_eventi_sheet_old

type variables
string is_codice, is_cod_com, is_com, is_prov, is_cap
s_strade is_strade_s
s_parm s_parm_s
u_ds_com ids_com
boolean ib_dbcancel
s_cerimonia is_cerimonia_s
s_evento is_evento_s

m_preview im_preview
end variables

event type integer ue_open();long ll_row

//openWithParm(w_gestione_cerimonie, 6)
//
//is_evento_s= message.powerObjectParm
//
//if isNull(is_evento_s.id) then
//	close(this)
//	return -1
//end if

tab_entrata.tabpage_inserimento.uodw_inserimento.setTransObject(sqlca)
tab_entrata.tabpage_stampe.uodw_stampa_cerimonie.setTransObject(sqlca)
tab_entrata.tabpage_conferma.uodw_conferma.setTransObject(sqlca)

dw_header.setTransObject(sqlca)

//ll_row= dw_header.retrieve(is_evento_s.id)

event ue_cercacerimonie()

return 0
end event

event type integer ue_cercacerimonie();long ll_row

//if tab_entrata.tabpage_inserimento.uodw_inserimento.uof_modificheincorso() < 0 then return -1

openWithParm(w_gestione_cerimonie, ENTRATA)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

ll_row= dw_header.retrieve(is_evento_s.id)

if is_evento_s.totale_partecipanti= 0 then
	
	tab_entrata.tabpage_inserimento.uodw_inserimento.uof_inserimento()
	
	tab_entrata.tabpage_inserimento.uodw_inserimento.setFocus()
	
else
	
//	tab_entrata.tabpage_inserimento.uodw_inserimento.object.b_ricerca.event clicked()
	
//	tab_entrata.tabpage_inserimento.uodw_inserimento.uof_esegui(RICERCA)
	
end if

return 0
end event

on w_eventi_sheet_old.create
this.tab_entrata=create tab_entrata
this.dw_header=create dw_header
this.Control[]={this.tab_entrata,&
this.dw_header}
end on

on w_eventi_sheet_old.destroy
destroy(this.tab_entrata)
destroy(this.dw_header)
end on

event open;im_preview= create m_preview

event post ue_open()
end event

type tab_entrata from tab within w_eventi_sheet_old
integer x = 9
integer y = 388
integer width = 4882
integer height = 2604
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
tabpage_conferma tabpage_conferma
end type

on tab_entrata.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_stampe=create tabpage_stampe
this.tabpage_conferma=create tabpage_conferma
this.Control[]={this.tabpage_inserimento,&
this.tabpage_stampe,&
this.tabpage_conferma}
end on

on tab_entrata.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_stampe)
destroy(this.tabpage_conferma)
end on

event selectionchanged;long ll_row

choose case newindex
		
	case 2
		
		ll_row= tab_entrata.tabpage_stampe.uodw_stampa_cerimonie.retrieve(is_evento_s.id)
		
	case 3
		
		ll_row= tab_entrata.tabpage_conferma.uodw_conferma.retrieve(is_evento_s.id)
		
end choose
end event

type tabpage_inserimento from userobject within tab_entrata
integer x = 18
integer y = 112
integer width = 4846
integer height = 2476
long backcolor = 67108864
string text = "Inserimento"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_inserimento uodw_inserimento
end type

on tabpage_inserimento.create
this.uodw_inserimento=create uodw_inserimento
this.Control[]={this.uodw_inserimento}
end on

on tabpage_inserimento.destroy
destroy(this.uodw_inserimento)
end on

type uodw_inserimento from uodw_generica within tabpage_inserimento
integer width = 4247
integer height = 2416
integer taborder = 50
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;integer li_ret

choose case dwo.name
		
	case "b_cerca"
		
		string ls_er
		
		this.object.b_m.visible= false
		this.object.b_p.visible= false
		this.object.b_aggiorna.visible= false
		
		open(w_seleziona_aspiranti)
		is_codice= message.stringParm
		
		if tab_entrata.tabpage_inserimento.uodw_inserimento.retrieve(is_codice)= 0 then this.object.b_p.visible= true	
		
	case "b_forzailcap"
		
		messageBox("Attenzione", "Il C.A.P. inserito manualmente potrebbe essere scorretto.", information!)
		
		this.Object.cap_dom.Protect=0
		this.setColumn("cap_dom")
			
	case "b_struttura"
		
//		if this.uof_struttura(row) < 0 then return -1
		this.object.b_salva.visible= '1'
		this.object.gb_struttura.text= "Struttura: "+this.getItemString(1, "vc_parent")

	case "b_cap"
		
		integer i_err
		string ls_cap, ls_loc
		
		s_strade s_strade_s
		
		s_strade_s.cap= this.getItemString(row, "cap_dom")
		s_strade_s.comune= this.getItemString(row, "comune")
		s_strade_s.cod_com= this.getItemString(row, "cod_com")
		s_strade_s.provincia= this.getItemString(row, "provincia")
		
		s_strade_s= f_vercap(s_strade_s)
		
		choose case s_strade_s.return_code
				
			case 0
				
				messageBox(this.title, "Operazione annullata.", information!)
				
			case -1
				
				return -1
				
			case 1
				
				i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
							
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
			case 2
				
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
		end choose
		
		
		
		
end choose
end event

event itemchanged;call super::itemchanged;this.object.b_aggiorna.visible= true
end event

type tabpage_stampe from userobject within tab_entrata
integer x = 18
integer y = 112
integer width = 4846
integer height = 2476
long backcolor = 67108864
string text = "Stampe"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_stampa_cerimonie uodw_stampa_cerimonie
end type

on tabpage_stampe.create
this.uodw_stampa_cerimonie=create uodw_stampa_cerimonie
this.Control[]={this.uodw_stampa_cerimonie}
end on

on tabpage_stampe.destroy
destroy(this.uodw_stampa_cerimonie)
end on

type uodw_stampa_cerimonie from uodw_generica within tabpage_stampe
integer width = 3488
integer taborder = 20
string dataobject = "dw_stampa_cerimonie"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stampa_cerimonie

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_entrata.PointerX(), w_entrata.PointerY() )
end event

type tabpage_conferma from userobject within tab_entrata
integer x = 18
integer y = 112
integer width = 4846
integer height = 2476
long backcolor = 67108864
string text = "Conferma partecipazione"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_conferma uodw_conferma
end type

on tabpage_conferma.create
this.uodw_conferma=create uodw_conferma
this.Control[]={this.uodw_conferma}
end on

on tabpage_conferma.destroy
destroy(this.uodw_conferma)
end on

type uodw_conferma from uodw_generica within tabpage_conferma
integer width = 3643
integer height = 2104
integer taborder = 20
string dataobject = "dw_conferma_cerimonie"
borderstyle borderstyle = stylebox!
end type

type dw_header from datawindow within w_eventi_sheet_old
integer x = 18
integer width = 4219
integer height = 368
integer taborder = 10
string title = "none"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type

