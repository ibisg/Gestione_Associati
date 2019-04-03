$PBExportHeader$w_gestione_cerimonie.srw
forward
global type w_gestione_cerimonie from w_centered
end type
type dw_current from datawindow within w_gestione_cerimonie
end type
end forward

global type w_gestione_cerimonie from w_centered
integer width = 2322
integer height = 1440
string title = "Gestione eventi"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
dw_current dw_current
end type
global w_gestione_cerimonie w_gestione_cerimonie

type variables
boolean ib_nuova= false
s_evento is_evento_s
end variables

event open;call super::open;integer li_tipo_cerimonia

li_tipo_cerimonia= message.doubleParm

choose case li_tipo_cerimonia
		
	case is <= ESAMI
		
		dw_current.DataObject = "dw_esami"
		
	case ENTRATA
	
		dw_current.DataObject = "dw_cerimonie"
	
	case CONSEGNA_SOSTITUZIONE
	
		dw_current.DataObject = "dw_consegnesostituzioni"

end choose

dw_current.setRowFocusIndicator(focusRect!)

dw_current.setTransObject(sqlca)

if li_tipo_cerimonia <= ESAMI then	
	dw_current.retrieve(ESAMI)
else
	dw_current.retrieve(li_tipo_cerimonia)
end if



end event

on w_gestione_cerimonie.create
int iCurrent
call super::create
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
end on

on w_gestione_cerimonie.destroy
call super::destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_gestione_cerimonie
event type s_evento ue_daticerimonia ( long al_row )
integer width = 2272
integer height = 1288
integer taborder = 10
string title = "Gestione cerimonie"
string dataobject = "dw_consegnesostituzioni"
boolean vscrollbar = true
string icon = "Question!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type s_evento ue_daticerimonia(long al_row);s_evento s_evento_s

s_evento_s.id= this.getItemDecimal(al_row, "id")

s_evento_s.data_evento= this.getItemDatetime(al_row, "data_evento")
s_evento_s.cod_luogo= this.getItemString(al_row, "cod_luogo")
s_evento_s.descrizione= this.getItemString(al_row, "descrizione_evento")
s_evento_s.turno= this.getItemString(al_row, "turno")
s_evento_s.tipo_evento= this.getItemNumber(al_row, "tipo_evento")
s_evento_s.totale_partecipanti= this.getItemNumber(al_row, "cpartecipanti")

return s_evento_s

end event

event buttonclicked;choose case dwo.name
		
//	case "b_nuova"
//		
//		long ll_row
//		
//		ll_row= dw_current.insertRow(0)
//		
//		dw_current.setItem(ll_row, "tipo_evento", 1)
//		
//		dw_current.scrollToRow(ll_row)
//		
//		ib_nuova= true
		
//	case "b_salva"
//		
//		if checknull(dw_current) < 0 then return -1
//		
//		if dw_current.update() = 1 then
//			
//			commit;
//			if trap_sql(sqlca, "COMMITCER") < 0 then return -1
//			
//		else
//			
//			rollback;
//			if trap_sql(sqlca, "ROLLBACKCER") < 0 then return -1
//			
//		end if
//		
//		if ib_nuova then
//			
//			if messageBox(parent.title, "E' stata creata una nuova cerimonia.~nVuoi inserire i partecipanti?", question!, yesNo!, 1)= 1 then
//				
//				// va sulla maschera di inserimento partecipanti senza bisogno del doppio click
//				is_evento_s= event ue_daticerimonia(row)
//				closeWithReturn(parent, is_evento_s)
//				return 0
//	
//			end if
//		
//		end if
//			
//		ib_nuova= false
		
	case "b_annulla"
		
		setNull(is_evento_s.id)
		closeWithReturn(parent, is_evento_s)
		
end choose

end event

event doubleclicked;if row<= 0 then return
is_evento_s= event ue_daticerimonia(row)
closeWithReturn(parent, is_evento_s)


end event

