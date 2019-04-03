$PBExportHeader$w_sel_cerimonie.srw
forward
global type w_sel_cerimonie from window
end type
type dw_current from datawindow within w_sel_cerimonie
end type
type st_1 from statictext within w_sel_cerimonie
end type
type cb_chiudi from commandbutton within w_sel_cerimonie
end type
end forward

global type w_sel_cerimonie from window
integer width = 2373
integer height = 1520
boolean titlebar = true
string title = "Inserimento eventi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
dw_current dw_current
st_1 st_1
cb_chiudi cb_chiudi
end type
global w_sel_cerimonie w_sel_cerimonie

type variables
boolean ib_nuovo
dataWindowChild idwc_tipo, idwc_dip, idwc_sale, idwc_luoghi
dataStore ids_eventi_id
decimal id_id
string is_currentluogo, is_currentdip

s_evento is_evento_s
end variables

event open;//ids_eventi_id= create datastore
//
//ids_eventi_id.dataObject= 'ds_eventi_id'
//
//ids_eventi_id.setTransObject(sqlca)

s_session_s.context= "Selezione cerimoniai"

//uodw_ins_eventi.GetChild('cod_dip', idwc_dip)
//uodw_ins_eventi.GetChild('tipo_evento', idwc_tipo)
//uodw_ins_eventi.GetChild('cod_sala', idwc_sale)
//uodw_ins_eventi.GetChild('cod_luogo', idwc_luoghi)

dw_current.setTransObject(sqlca)
//idwc_dip.setTransObject(sqlca)
//idwc_tipo.setTransObject(sqlca)
//idwc_sale.setTransObject(sqlca)
//idwc_luoghi.setTransObject(sqlca)

//idwc_dip.retrieve()
//idwc_tipo.retrieve()
//
//idwc_luoghi.retrieve(is_evento_s.cod_dip)
//idwc_sale.retrieve(is_evento_s.cod_dip, is_evento_s.cod_luogo)

dw_current.retrieve(  s_session_s.cod_dip )

//is_currentdip= is_evento_s.cod_dip
//is_currentluogo= is_evento_s.cod_luogo
//
//if is_evento_s.id= 0 then
//		this.title= "Inserimento eventi"
//		ib_nuovo= true
//		uodw_ins_eventi.insertRow(0)
//		uodw_ins_eventi.setItem(1, "cod_dip", is_evento_s.cod_dip)		
//		uodw_ins_eventi.setItem(1, "operatore", s_utente_s.s_nome_esteso)	
//			
//		if s_utente_s.s_ambito <> "T" then // se l'ambito operativo non comprende tutta la struttura... 
//			uodw_ins_eventi.Object.cod_dip.Protect=1
//			uodw_ins_eventi.setColumn("tipo_evento")
//			
//		end if
//		
//	else
//		this.title= "Modifica eventi"
//		uodw_ins_eventi.retrieve( is_evento_s.id )
//		
//		uodw_ins_eventi.Object.cod_dip.Protect=1
//		uodw_ins_eventi.Object.tipo_evento.Protect=1
		
//end if
end event

on w_sel_cerimonie.create
this.dw_current=create dw_current
this.st_1=create st_1
this.cb_chiudi=create cb_chiudi
this.Control[]={this.dw_current,&
this.st_1,&
this.cb_chiudi}
end on

on w_sel_cerimonie.destroy
destroy(this.dw_current)
destroy(this.st_1)
destroy(this.cb_chiudi)
end on

type dw_current from datawindow within w_sel_cerimonie
integer x = 9
integer width = 2331
integer height = 1220
integer taborder = 10
string title = "none"
string dataobject = "dw_sel_cerimonia"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;decimal ld_id

ld_id= this.getItemDecimal(row, "id")

OpenSheetWithParm (w_aspiranti_prenotazioni, ld_id, w_frame_gestioneassociati, 2,  original!)

close(parent)

end event

type st_1 from statictext within w_sel_cerimonie
integer x = 562
integer y = 1276
integer width = 873
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "( N.B. i campi in rosso sono obbligatori )"
boolean focusrectangle = false
end type

type cb_chiudi from commandbutton within w_sel_cerimonie
integer x = 1522
integer y = 1244
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

event clicked;closeWithReturn(parent, -1)
end event

