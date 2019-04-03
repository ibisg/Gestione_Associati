$PBExportHeader$w_prova_anagrafica.srw
forward
global type w_prova_anagrafica from window
end type
type dw_current from datawindow within w_prova_anagrafica
end type
end forward

global type w_prova_anagrafica from window
integer width = 4206
integer height = 2800
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
dw_current dw_current
end type
global w_prova_anagrafica w_prova_anagrafica

type variables
dataWindowChild dwc_struttura
end variables

event open;dw_current.setTransObject(sqlca)

dw_current.retrieve('168306RM')

end event

on w_prova_anagrafica.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_prova_anagrafica.destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_prova_anagrafica
integer x = 32
integer y = 32
integer width = 4123
integer height = 2032
integer taborder = 10
string title = "none"
string dataobject = "dw_anagrafica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//dwc_struttura.setItem(dwc_struttura.insertRow(0), "descrizione", "area")
//dwc_struttura.setItem(dwc_struttura.insertRow(0), "descrizione", "territorio")
//dwc_struttura.setItem(dwc_struttura.insertRow(0), "descrizione", "centro")
openWithParm(w_mostra_struttura, this.getItemString(row, "vc_parent") )

string ls_struttura
ls_struttura= message.stringParm

this.setItem(row, "vc_parent", ls_struttura )

ls_struttura= f_descrizione_struttura(ls_struttura)

//ls_struttura= f_global_replace(ls_struttura, ":", ": ~t~t")

ls_struttura= f_global_replace(ls_struttura, ".", "~r")

dw_current.Object.t_struttura.Text= ls_struttura
end event

event retrieveend;string ls_struttura

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura(ls_struttura)

dw_current.Object.t_footer.Text= ls_struttura


ls_struttura= f_global_replace(ls_struttura, ".", "~r")

dw_current.Object.t_struttura.Text= ls_struttura
end event

