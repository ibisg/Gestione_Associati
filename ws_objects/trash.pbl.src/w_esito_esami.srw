$PBExportHeader$w_esito_esami.srw
forward
global type w_esito_esami from window
end type
type dw_header from datawindow within w_esito_esami
end type
type dw_current from datawindow within w_esito_esami
end type
end forward

global type w_esito_esami from window
integer width = 4599
integer height = 2588
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
dw_header dw_header
dw_current dw_current
end type
global w_esito_esami w_esito_esami

on w_esito_esami.create
this.dw_header=create dw_header
this.dw_current=create dw_current
this.Control[]={this.dw_header,&
this.dw_current}
end on

on w_esito_esami.destroy
destroy(this.dw_header)
destroy(this.dw_current)
end on

type dw_header from datawindow within w_esito_esami
integer x = 55
integer y = 24
integer width = 4201
integer height = 376
integer taborder = 10
string title = "none"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type

type dw_current from datawindow within w_esito_esami
integer x = 55
integer y = 420
integer width = 3506
integer height = 1848
integer taborder = 10
string title = "none"
string dataobject = "dw_esito_esami"
boolean border = false
boolean livescroll = true
end type

