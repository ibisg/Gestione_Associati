$PBExportHeader$w_gestione_corsi_sheet.srw
forward
global type w_gestione_corsi_sheet from window
end type
type uodw_corsi from uodw_generica within w_gestione_corsi_sheet
end type
end forward

global type w_gestione_corsi_sheet from window
integer width = 2071
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
uodw_corsi uodw_corsi
end type
global w_gestione_corsi_sheet w_gestione_corsi_sheet

on w_gestione_corsi_sheet.create
this.uodw_corsi=create uodw_corsi
this.Control[]={this.uodw_corsi}
end on

on w_gestione_corsi_sheet.destroy
destroy(this.uodw_corsi)
end on

type uodw_corsi from uodw_generica within w_gestione_corsi_sheet
integer width = 2034
integer taborder = 10
string dataobject = "dw_corsi"
end type

