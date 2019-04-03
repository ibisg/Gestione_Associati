$PBExportHeader$w_ins_storico_gohonzon.srw
forward
global type w_ins_storico_gohonzon from w_centered
end type
type cb_chiudi from commandbutton within w_ins_storico_gohonzon
end type
type uodw_ins_storico from uodw_generica within w_ins_storico_gohonzon
end type
end forward

global type w_ins_storico_gohonzon from w_centered
integer width = 1650
integer height = 1404
string title = "Aggiornamento storico Gohonzon"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
event ue_open ( )
cb_chiudi cb_chiudi
uodw_ins_storico uodw_ins_storico
end type
global w_ins_storico_gohonzon w_ins_storico_gohonzon

type variables
dataWindowChild idwc_cod_causale
long il_row
s_riferimenti is_riferimenti_s
end variables

event ue_open();string ls_causale, ls_filter
integer li_ret



if isNull(is_riferimenti_s.idx) then is_riferimenti_s.idx= 0

if is_riferimenti_s.idx > 0 then
	li_ret= uodw_ins_storico.retrieve(is_riferimenti_s.idx)
	
	uodw_ins_storico.Object.tipo_goh.Protect=1

	ls_causale= mid(uodw_ins_storico.getItemString(1, "cod_causale"), 1, 1)
	
	li_ret= uodw_ins_storico.getChild("cod_causale", idwc_cod_causale)
	
	ls_filter= "mid(cod_causale, 1, 1)= "+"'"+ls_causale+"'"
	
	li_ret= idwc_cod_causale.setFilter(ls_filter)
	li_ret= idwc_cod_causale.filter()
	
else
	il_row= uodw_ins_storico.insertRow(0)
	uodw_ins_storico.Object.tipo_goh.Protect=0
	uodw_ins_storico.setItem(il_row, "codice", is_riferimenti_s.codice)
	
	// inseriamo anche la dipendenza operativa ? uodw_ins_storico.setItem(il_row, "cod_dip", s_session_s.cod_dip)
	
	uodw_ins_storico.setItem(il_row, "u_ult_mod", s_session_s.s_utente_s.s_nome_esteso)
	uodw_ins_storico.setItem(il_row, "d_ult_mod", now() )
	
	uodw_ins_storico.setFocus()
end if

uodw_ins_storico.setRedraw(true)

return
end event

on w_ins_storico_gohonzon.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.uodw_ins_storico=create uodw_ins_storico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.uodw_ins_storico
end on

on w_ins_storico_gohonzon.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.uodw_ins_storico)
end on

event open;integer li_rif

s_session_s.context= "Inserimento storico Gohonzon"

is_riferimenti_s= message.powerObjectParm

if 	is_riferimenti_s.status= 'DEC' OR is_riferimenti_s.status= 'ISG' then
	
	uodw_ins_storico.dataObject= 'dw_insert_gohonzon_storico_fs'
	
elseif is_riferimenti_s.status= 'DIM' OR  is_riferimenti_s.status= 'NOP' then
	
		uodw_ins_storico.dataObject= 'dw_insert_gohonzon_storico_dim'
		
else
		
		uodw_ins_storico.dataObject= 'dw_insert_gohonzon_storico'
		
end if

uodw_ins_storico.setTransObject(sqlca)

uodw_ins_storico.setRedraw(false)

event post ue_open()
end event

event closequery;call super::closequery;if uodw_ins_storico.uof_modificheincorso()= 3 then return 1
return  0
end event

type cb_chiudi from commandbutton within w_ins_storico_gohonzon
integer x = 1125
integer y = 1152
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

type uodw_ins_storico from uodw_generica within w_ins_storico_gohonzon
integer width = 1586
integer height = 1140
integer taborder = 10
string dataobject = "dw_insert_gohonzon_storico"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;long ll_ret
string ls_descrizione

s_session ls_session_s

ls_session_s= s_session_s

choose case dwo.name
		
	case "b_aggiorna"

		ll_ret= ancestorReturnValue
		
//					ls_session_s.gm= 'M'
//			  		if ls_goh= 'S'  then ls_session_s.gm= 'G'
//					
					ls_session_s.codice= uodw_ins_storico.getItemString(row, "codice")
					ls_session_s.causale= uodw_ins_storico.getItemString(row, "cod_causale")
//					ls_session_s.status_src= 'ASP'
//					ls_session_s.status_tgt= 'MEM'
//					ls_session_s.struttura_src= ls_struttura
					ls_session_s.s_utente_s= s_session_s.s_utente_s
					ls_session_s.context= "Storico Gohonzon"
//					ls_session_s.tipo_variazione_src= "DA-ASP"
//					ls_session_s.tipo_variazione_tgt= "A-MEM"
//					

					select descr
					into :ls_descrizione
					from gohonzon_causali
					where cod_causale= :ls_session_s.causale;
					
					if trap_sql(sqlca, "INSSTORICO.01") < 0 then return -1

					if f_log(ls_session_s, "Tipo Gohonzon: "+this.getItemString(this.getRow(), "tipo_goh")+": "+ls_descrizione, false) < 0 then return -1
		
		if ll_ret >= 0 then close(parent)
	
	case "b_m"
			
		ll_ret= ancestorReturnValue
		
					ls_session_s.codice= uodw_ins_storico.getItemString(row, "codice")
					ls_session_s.causale= uodw_ins_storico.getItemString(row, "cod_causale")
					ls_session_s.s_utente_s= s_session_s.s_utente_s
					ls_session_s.context= "Cancellazione da storico Gohonzon"
					
					select descr
					into :ls_descrizione
					from gohonzon_causali
					where cod_causale= :ls_session_s.causale;
					
					if trap_sql(sqlca, "INSSTORICO.02") < 0 then return -1

					if f_log(ls_session_s, "Tipo Gohonzon: "+this.getItemString(this.getRow(), "tipo_goh")+": "+ls_descrizione, false) < 0 then return -1					
		
		if ll_ret >= 0 then close(parent)

end choose
end event

event updatestart;call super::updatestart;uodw_ins_storico.setItem(uodw_ins_storico.getRow(), "u_ult_mod", s_session_s.s_utente_s.s_nome_esteso)
uodw_ins_storico.setItem(uodw_ins_storico.getRow(), "d_ult_mod", now() )
end event

