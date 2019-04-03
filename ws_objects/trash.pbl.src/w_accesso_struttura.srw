$PBExportHeader$w_accesso_struttura.srw
forward
global type w_accesso_struttura from w_mostra_struttura
end type
type dw_dip from datawindow within w_accesso_struttura
end type
end forward

global type w_accesso_struttura from w_mostra_struttura
string title = ""
boolean minbox = true
windowtype windowtype = popup!
dw_dip dw_dip
end type
global w_accesso_struttura w_accesso_struttura

on w_accesso_struttura.create
int iCurrent
call super::create
this.dw_dip=create dw_dip
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dip
end on

on w_accesso_struttura.destroy
call super::destroy
destroy(this.dw_dip)
end on

event open;call super::open;dw_dip.setTransObject(sqlca)
dw_dip.retrieve()
end event

type cb_annulla from w_mostra_struttura`cb_annulla within w_accesso_struttura
string facename = "Tahoma"
end type

type cb_seleziona from w_mostra_struttura`cb_seleziona within w_accesso_struttura
integer x = 1303
integer taborder = 30
string facename = "Tahoma"
end type

type tv_struttura from w_mostra_struttura`tv_struttura within w_accesso_struttura
integer taborder = 10
end type

type dw_dip from datawindow within w_accesso_struttura
integer y = 1256
integer width = 1015
integer height = 116
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_dipendenze"
boolean border = false
boolean livescroll = true
end type

