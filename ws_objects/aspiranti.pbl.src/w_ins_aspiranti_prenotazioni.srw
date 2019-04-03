$PBExportHeader$w_ins_aspiranti_prenotazioni.srw
forward
global type w_ins_aspiranti_prenotazioni from w_centered
end type
type cb_chiudi from commandbutton within w_ins_aspiranti_prenotazioni
end type
type uodw_ins_aspiranti_prenotazioni from uodw_generica within w_ins_aspiranti_prenotazioni
end type
end forward

global type w_ins_aspiranti_prenotazioni from w_centered
integer width = 1925
integer height = 1956
string title = "Inserimento prenotazioni cerimonie"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
event ue_open ( )
cb_chiudi cb_chiudi
uodw_ins_aspiranti_prenotazioni uodw_ins_aspiranti_prenotazioni
end type
global w_ins_aspiranti_prenotazioni w_ins_aspiranti_prenotazioni

type variables
long il_row
s_prenotazioni s_prenotazioni_s

end variables

event ue_open();if isNull(s_prenotazioni_s.id) then s_prenotazioni_s.id= 0

if s_prenotazioni_s.id > 0 then
	uodw_ins_aspiranti_prenotazioni.retrieve(s_prenotazioni_s.id)
else
	il_row= uodw_ins_aspiranti_prenotazioni.insertRow(0)
	uodw_ins_aspiranti_prenotazioni.setItem(il_row, "id_evento", s_prenotazioni_s.id_evento)
	uodw_ins_aspiranti_prenotazioni.setItem(il_row, "vc_nodo", s_prenotazioni_s.vc_nodo)
	uodw_ins_aspiranti_prenotazioni.setFocus()
end if

uodw_ins_aspiranti_prenotazioni.setRedraw(true)

return
end event

on w_ins_aspiranti_prenotazioni.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.uodw_ins_aspiranti_prenotazioni=create uodw_ins_aspiranti_prenotazioni
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.uodw_ins_aspiranti_prenotazioni
end on

on w_ins_aspiranti_prenotazioni.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.uodw_ins_aspiranti_prenotazioni)
end on

event open;integer li_rif

s_session_s.context= "Inserimento prenotazioni cerimonie"

s_prenotazioni_s= message.powerObjectParm

uodw_ins_aspiranti_prenotazioni.setTransObject(sqlca)

uodw_ins_aspiranti_prenotazioni.setRedraw(false)

event post ue_open()
end event

event closequery;call super::closequery;if uodw_ins_aspiranti_prenotazioni.uof_modificheincorso()= 3 then return 1
return  0
end event

type cb_chiudi from commandbutton within w_ins_aspiranti_prenotazioni
integer x = 1371
integer y = 1720
integer width = 439
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closeWithReturn(parent, - 1)
end event

type uodw_ins_aspiranti_prenotazioni from uodw_generica within w_ins_aspiranti_prenotazioni
integer width = 1874
integer height = 1668
integer taborder = 10
string dataobject = "dw_ins_aspiranti_prenotazioni"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
boolean ib_p = false
end type

event buttonclicked;call super::buttonclicked;long ll_ret

choose case dwo.name
		
	case "b_struttura"
		
		s_assegnastruttura s_assegnastruttura_s
		
		s_struttura s_strutturatgt_s
		
		s_assegnastruttura_s.as_struttura_s.vc_nodo= this.getItemString(row, "vc_nodo")
		s_assegnastruttura_s.as_struttura_s.livello= 5 //= is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ab_abilitaincolla= false
		s_assegnastruttura_s.ai_maxlivello= 5 //is_assegnastruttura_s.ai_maxlivello
		s_assegnastruttura_s.ai_ultimolivelloparent= 5 //is_assegnastruttura_s.ai_ultimolivelloparent
		s_assegnastruttura_s.as_ambito=gs_ambito
		
		s_strutturatgt_s=  this.uof_struttura(s_assegnastruttura_s)
		
		if s_strutturatgt_s.livello= -1 then return -1
		
		this.setItem(row, "vc_nodo", s_strutturatgt_s.vc_nodo)
			
		
	case "b_aggiorna"

		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)
	
	case "b_m"
			
		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)

end choose
end event

