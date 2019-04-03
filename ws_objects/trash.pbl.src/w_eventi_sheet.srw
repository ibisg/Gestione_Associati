$PBExportHeader$w_eventi_sheet.srw
forward
global type w_eventi_sheet from window
end type
type uodw_eventi from uodw_generica within w_eventi_sheet
end type
end forward

global type w_eventi_sheet from window
integer width = 4142
integer height = 2100
boolean titlebar = true
string title = "Gestione eventi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "LibraryOpen!"
boolean clientedge = true
event ue_open ( )
uodw_eventi uodw_eventi
end type
global w_eventi_sheet w_eventi_sheet

type variables
dataWindowChild idwc_dipendenze, idwc_tipo_eventi, idwc_luoghi, idwc_sale
m_preview im_preview
end variables

event ue_open();this.setRedraw(false)

if message.stringParm= 'P' then
	
	uodw_eventi.dataObject= 'dw_eventi'
	
else
	
	uodw_eventi.dataObject= 'dw_monitor_eventi'
	
	uodw_eventi.Object.DataWindow.ReadOnly="Yes"
	
end if

uodw_eventi.GetChild('cod_dip', idwc_dipendenze)
uodw_eventi.GetChild('tipo_evento', idwc_tipo_eventi)
uodw_eventi.GetChild('cod_luogo', idwc_luoghi)
uodw_eventi.GetChild('cod_sala', idwc_sale)

uodw_eventi.setTransObject(sqlca)

idwc_dipendenze.setTransObject(sqlca)
idwc_tipo_eventi.setTransObject(sqlca)
idwc_luoghi.setTransObject(sqlca)
idwc_sale.setTransObject(sqlca)

idwc_sale.retrieve(gs_dip_operativa)
idwc_luoghi.retrieve(gs_dip_operativa)

uodw_eventi.retrieve()

this.setRedraw(true)


end event

event open;im_preview= create m_preview

event post ue_open()
end event

event resize;//uodw_eventi.height= this.height - 120
//uodw_eventi.width= this.width - 120


end event

on w_eventi_sheet.create
this.uodw_eventi=create uodw_eventi
this.Control[]={this.uodw_eventi}
end on

on w_eventi_sheet.destroy
destroy(this.uodw_eventi)
end on

type uodw_eventi from uodw_generica within w_eventi_sheet
event type integer ue_delete ( long row )
integer width = 4073
integer height = 1856
integer taborder = 10
string title = "Gestione eventi"
string dataobject = "dw_eventi"
string icon = "Library5!"
boolean ib_isgrid = true
end type

event type integer ue_delete(long row);	
	long ll_tipo, id, ll_count
	
	id= this.getItemNumber(row, "id")
	
	ll_tipo= this.getItemNumber(row, "tipo_evento")
	
	choose case ll_tipo
			
		case is < 6 // esami
			
			select count(*)
			into :ll_count
			from esami
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI01") < 0 then return -1			
			
			
		case 6 // Entrata nuovi fedeli
			
			select count(*)
			into :ll_count
			from membri_eventi
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI02") < 0 then return -1
			
			
		case 7 // Consegna o sostituzione G
			
			select count(*)
			into :ll_count
			from sostituzioni
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI03") < 0 then return -1			
			
			
		case else // recitazioni etc.
			
			return 0
			
	end choose
	
	if messageBox(parent.title, "Confermi la cancellazione?", question!, yesNo!, 2)= 2 then return 0
	
	if ll_count > 0 then
		
		// da riscrivere: deve essere chiaro che la cancellazione va gestita direttamente nelle procedure.
		messageBox(parent.title, "Per questo evento sono già stati inseriti "+string(ll_count)+ " partecipanti: la cancellazione non è possibile.", information!)
		return -1
		
	end if
	
	if this.deleteRow(0)= 1 then this.uof_aggiorna()
	
end event

event buttonclicked;call super::buttonclicked;integer li_ret
choose case dwo.name
	case "b_nuovo"
		open(w_ins_eventi)
		li_ret= message.doubleParm
		if li_ret= -1 then return
		this.retrieve()
end choose
end event

event doubleclicked;call super::doubleclicked;integer li_ret

if row= 0 then return

if gi_classediutenza >= gc_op then return 

openWithParm(w_ins_eventi, this.getItemDecimal(row, "id") )
li_ret= message.doubleParm
if li_ret= -1 then return
this.retrieve()
end event

event rbuttondown;call super::rbuttondown;if gi_classediutenza >= gc_op then return 

im_preview.iuodw_generica= uodw_eventi

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_eventi_sheet.PointerX(), w_eventi_sheet.PointerY() )
end event

event rowfocuschanged;call super::rowfocuschanged;setRowFocusIndicator(hand!)
end event

