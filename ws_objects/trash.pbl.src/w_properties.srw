$PBExportHeader$w_properties.srw
forward
global type w_properties from w_centered
end type
type pb_stampa from picturebutton within w_properties
end type
type pb_chiudi from picturebutton within w_properties
end type
type dw_dettagli from datawindow within w_properties
end type
end forward

global type w_properties from w_centered
integer width = 4288
integer height = 3352
string title = "Dettagli"
windowtype windowtype = child!
long backcolor = 81324524
string icon = "Query5!"
boolean clientedge = true
boolean ib_centered = false
event ue_open ( )
pb_stampa pb_stampa
pb_chiudi pb_chiudi
dw_dettagli dw_dettagli
end type
global w_properties w_properties

type variables
integer ii_anno

s_struttura is_struttura_s

end variables

event ue_open();dw_dettagli.retrieve(is_struttura_s.vc_nodo+"%", is_struttura_s.livello, ii_anno)
end event

event open;call super::open;is_struttura_s= message.powerObjectParm

this.title= is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura

dw_dettagli.setTransObject(sqlca)

ii_anno= year(today())

setPointer(hourGlass!)

event post ue_open()

//dw_dettagli.Object.gb_graph.y= dw_dettagli.object.dw_3.y - 60


end event

on w_properties.create
int iCurrent
call super::create
this.pb_stampa=create pb_stampa
this.pb_chiudi=create pb_chiudi
this.dw_dettagli=create dw_dettagli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_stampa
this.Control[iCurrent+2]=this.pb_chiudi
this.Control[iCurrent+3]=this.dw_dettagli
end on

on w_properties.destroy
call super::destroy
destroy(this.pb_stampa)
destroy(this.pb_chiudi)
destroy(this.dw_dettagli)
end on

event resize;call super::resize;dw_dettagli.height= this.height - 120
dw_dettagli.width= this.width - 334 -120

pb_stampa.x= this.width - 334 - 120
pb_chiudi.x= this.width - 334 - 120
end event

type pb_stampa from picturebutton within w_properties
integer x = 3813
integer y = 92
integer width = 334
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;openWithParm(w_dw_print_options, dw_dettagli)

end event

type pb_chiudi from picturebutton within w_properties
integer x = 3813
integer y = 320
integer width = 334
integer height = 184
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type dw_dettagli from datawindow within w_properties
integer width = 3735
integer height = 3144
integer taborder = 10
string title = "none"
string dataobject = "dw_dettagli"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

