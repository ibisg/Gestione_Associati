$PBExportHeader$w_ambito_operativo.srw
forward
global type w_ambito_operativo from window
end type
type cb_chiudi from commandbutton within w_ambito_operativo
end type
type uodw_current from uodw_generica within w_ambito_operativo
end type
end forward

global type w_ambito_operativo from window
integer width = 2007
integer height = 1756
boolean titlebar = true
string title = "Assegnazione ambito operativo"
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
uodw_current uodw_current
end type
global w_ambito_operativo w_ambito_operativo

on w_ambito_operativo.create
this.cb_chiudi=create cb_chiudi
this.uodw_current=create uodw_current
this.Control[]={this.cb_chiudi,&
this.uodw_current}
end on

on w_ambito_operativo.destroy
destroy(this.cb_chiudi)
destroy(this.uodw_current)
end on

event closequery;if uodw_current.uof_modificheincorso()= 3 then return 1
end event

event open;uodw_current.setTransObject(sqlca)
uodw_current.retrieve()
end event

type cb_chiudi from commandbutton within w_ambito_operativo
integer x = 809
integer y = 1492
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type uodw_current from uodw_generica within w_ambito_operativo
integer width = 1961
integer height = 1468
integer taborder = 10
string dataobject = "dw_ambito_operativo"
boolean controlmenu = true
boolean maxbox = false
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case "b_struttura"
		
		s_assegnastruttura s_assegnastruttura_s
		s_struttura s_struttura_s
		string ls_nodo
		
		ls_nodo= this.getItemString(this.getRow(), "vc_nodo")
		
		s_assegnastruttura_s.ai_maxlivello= gi_maxlivello
		s_assegnastruttura_s.as_ambito= gs_ambito
		s_assegnastruttura_s.ab_abilitaincolla= true
		s_assegnastruttura_s.as_struttura_s.vc_nodo= ls_nodo
		s_assegnastruttura_s.as_struttura_s.livello= gi_maxlivello
		
		//
		s_assegnastruttura_s.ai_maxlivello= gi_maxlivello
		//
		
		s_struttura_s=  this.uof_struttura(s_assegnastruttura_s)
		
		if s_struttura_s.livello= -1 then return -1
		
		this.object.b_aggiorna.visible= '1'
		
		this.setcolumn("vc_nodo")
		
		this.setText(s_struttura_s.vc_nodo) 
		
end choose
end event

