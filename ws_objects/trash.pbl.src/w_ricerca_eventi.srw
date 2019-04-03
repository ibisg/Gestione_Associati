$PBExportHeader$w_ricerca_eventi.srw
forward
global type w_ricerca_eventi from w_centered
end type
type cb_1 from commandbutton within w_ricerca_eventi
end type
type cb_chiudi from commandbutton within w_ricerca_eventi
end type
type cb_esegui from commandbutton within w_ricerca_eventi
end type
type cb_annulla from commandbutton within w_ricerca_eventi
end type
type uodw_ricerca from uodw_generica within w_ricerca_eventi
end type
end forward

global type w_ricerca_eventi from w_centered
integer width = 4745
integer height = 2500
string title = "Gestione eventi"
long backcolor = 81324524
string icon = "Query5!"
boolean clientedge = true
cb_1 cb_1
cb_chiudi cb_chiudi
cb_esegui cb_esegui
cb_annulla cb_annulla
uodw_ricerca uodw_ricerca
end type
global w_ricerca_eventi w_ricerca_eventi

type variables
boolean b_ricercaestesa= false
dataWindowChild idwc_dip
end variables

on w_ricerca_eventi.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_chiudi=create cb_chiudi
this.cb_esegui=create cb_esegui
this.cb_annulla=create cb_annulla
this.uodw_ricerca=create uodw_ricerca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.cb_esegui
this.Control[iCurrent+4]=this.cb_annulla
this.Control[iCurrent+5]=this.uodw_ricerca
end on

on w_ricerca_eventi.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_chiudi)
destroy(this.cb_esegui)
destroy(this.cb_annulla)
destroy(this.uodw_ricerca)
end on

event open;call super::open;uodw_ricerca.GetChild('cod_dip', idwc_dip)


uodw_ricerca.setTransObject(sqlca)
idwc_dip.setTransObject(sqlca)

uodw_ricerca.uof_esegui(1)	
end event

event closequery;call super::closequery;if uodw_ricerca.uof_modificheincorso()= 3 then return 1
end event

type cb_1 from commandbutton within w_ricerca_eventi
integer x = 818
integer y = 2172
integer width = 603
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Estrazione mese in corso"
boolean default = true
end type

event clicked;b_ricercaestesa= false
end event

type cb_chiudi from commandbutton within w_ricerca_eventi
integer x = 3721
integer y = 2164
integer width = 567
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_esegui from commandbutton within w_ricerca_eventi
integer x = 3141
integer y = 2164
integer width = 567
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricerca estesa"
boolean default = true
end type

event clicked;integer li_ret

b_ricercaestesa= true

parent.setRedraw(false)
if uodw_ricerca.ib_queryMode= false then
	li_ret= uodw_ricerca.uof_esegui(3)	
else
	cb_annulla.enabled= true
	li_ret= uodw_ricerca.uof_esegui(1)
	cb_annulla.enabled= false
end if
parent.setRedraw(true)

return li_ret
end event

type cb_annulla from commandbutton within w_ricerca_eventi
integer x = 2560
integer y = 2164
integer width = 567
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Annulla l~'estrazione"
end type

event clicked;return uodw_ricerca.uof_esegui(2)	
end event

type uodw_ricerca from uodw_generica within w_ricerca_eventi
integer x = 9
integer y = 8
integer width = 4658
integer height = 2104
integer taborder = 10
string dataobject = "dw_eventi"
boolean controlmenu = true
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event itemchanged;call super::itemchanged;if dwo.name= "data_evento" then data= mid(data, 1, 10) + "00.00.00"
end event

event sqlpreview;call super::sqlpreview;//if pos(lower(sqlsyntax), "where", 1) > 0 then
//	
//	sqlsyntax += " and data_evento datediff
//	
//	
//	
//end if
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case "b_m_eventi" 
	
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
	
case "b_p"
	
	this.setItem(this.getRow(), "data_evento", datetime(date(string(today(), "dd.mm.yyyy") ) ) ) 
		
end choose
	
end event

