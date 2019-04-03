$PBExportHeader$w_rga_messaggi.srw
forward
global type w_rga_messaggi from window
end type
type uodw_leggi_messaggi from uodw_generica within w_rga_messaggi
end type
type dw_rga_messaggi_in from datawindow within w_rga_messaggi
end type
end forward

global type w_rga_messaggi from window
integer width = 3035
integer height = 2884
boolean titlebar = true
string title = "Messaggi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "DataPipeline!"
boolean center = true
uodw_leggi_messaggi uodw_leggi_messaggi
dw_rga_messaggi_in dw_rga_messaggi_in
end type
global w_rga_messaggi w_rga_messaggi

type variables
string is_nodo
s_messaggi is_messaggi_s
m_preview im_preview
end variables

on w_rga_messaggi.create
this.uodw_leggi_messaggi=create uodw_leggi_messaggi
this.dw_rga_messaggi_in=create dw_rga_messaggi_in
this.Control[]={this.uodw_leggi_messaggi,&
this.dw_rga_messaggi_in}
end on

on w_rga_messaggi.destroy
destroy(this.uodw_leggi_messaggi)
destroy(this.dw_rga_messaggi_in)
end on

event open;long ll_rows

im_preview= create m_preview

is_messaggi_s= message.powerObjectParm

dw_rga_messaggi_in.setTransObject(sqlca)

uodw_leggi_messaggi.setTransObject(sqlca)

dw_rga_messaggi_in.setRowFocusIndicator(hand!)

ll_rows= dw_rga_messaggi_in.retrieve(is_messaggi_s.vc_nodo)

if ll_rows > 0 then beep(2)


end event

type uodw_leggi_messaggi from uodw_generica within w_rga_messaggi
integer x = 23
integer y = 1012
integer width = 2976
integer height = 1752
integer taborder = 20
string dataobject = "dw_leggi_messaggi"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_leggi_messaggi

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false
	im_preview.m_ordina.visible= false
	im_preview.m_esporta.visible= false

im_preview.PopMenu ( w_rga_messaggi.PointerX(), w_rga_messaggi.PointerY() )
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case  'b_stampa'
		
		this.uof_print()
		
	case 'b_rispondi'
		
		s_messaggi ls_messaggi_s
		
		ls_messaggi_s.oggetto= is_messaggi_s.oggetto
		
		ls_messaggi_s.vc_nodo= is_messaggi_s.vc_nodo
		
		openWithParm(w_rga_messaggi_nuovi, ls_messaggi_s)
		
		dw_rga_messaggi_in.retrieve(is_messaggi_s.vc_nodo)
		
end choose
end event

type dw_rga_messaggi_in from datawindow within w_rga_messaggi
integer x = 23
integer y = 32
integer width = 2976
integer height = 964
integer taborder = 20
string title = "none"
string dataobject = "dw_rga_messaggi_in"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;decimal ld_id
long ll_rows

choose case dwo.name
		
	case "b_scarica"
		
		ll_rows= this.retrieve(is_messaggi_s.vc_nodo)

		if ll_rows > 0 then beep(2)

	case "b_nuovo"
	
		openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
		
		this.retrieve(is_messaggi_s.vc_nodo)
	
	case "b_elimina"
	
		if messageBox("Elimina messaggio", "Confermi l'eliminazione di questo messaggio?", question!, yesNo!, 2)= 2 then return 0
		
		this.deleteRow(getRow() )
		if this.update()= 1 then
			commit;
			open(w_message)
		else
			open(w_message_negative)
			rollback;
		end if
	
end choose

if this.rowCount() > 0 then

	this.setRow(1)
	this.ScrollToRow(1)
	
	ld_id= this.getItemDecimal(1, "id")
	
	if NOT isNull(ld_id) then uodw_leggi_messaggi.retrieve(ld_id)
	
else
	
	uodw_leggi_messaggi.reset()

end if
end event

event rowfocuschanged;string ls_mittente

ls_mittente= this.getItemString(getRow(), "mittente")

if this.getRow() > 0 then uodw_leggi_messaggi.retrieve(this.getItemDecimal(getRow(), "id") )

if ls_mittente= 'I' then
	
	is_messaggi_s.oggetto=  this.getItemString(getRow(), "oggetto")	
	is_messaggi_s.vc_nodo=  this.getItemString(getRow(), "vc_nodo")
	is_messaggi_s.mittente=  this.getItemString(getRow(), "mittente")	
	
	this.setItem(this.getRow(), "flag_letto", 1)
	
	this.update()
	
	commit;
	
end if


end event

event retrieveend;//decimal ld_id
//long ll_row
//
//if rowcount= 0 then return 0
//
//ld_id= this.getItemDecimal(1, "id")
//
//this.setRow(1)
//this.scrollToRow(1)
//
//ll_row= dw_leggi_messaggi.retrieve(ld_id)
//
//dw_leggi_messaggi.setFilter("mittente='I'")
//dw_leggi_messaggi.filter()
//
//return 0
end event

event itemchanged;if dwo.name= "flag_letto" then

	if data= '0' then
		
		this.setItem(this.getRow(), "flag_letto", 0)
		
	end if
	
	this.update()
	
	commit;
	
end if
end event

