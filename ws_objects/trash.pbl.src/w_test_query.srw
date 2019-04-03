$PBExportHeader$w_test_query.srw
forward
global type w_test_query from window
end type
type dw_current from datawindow within w_test_query
end type
end forward

global type w_test_query from window
integer width = 4965
integer height = 1584
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_current dw_current
end type
global w_test_query w_test_query

event open;select ambito
into :gs_ambito
from utenti
where id_utente= 1;

dw_current.setTransObject(sqlca)
dw_current.retrieve()

end event

on w_test_query.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_test_query.destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_test_query
integer x = 37
integer y = 28
integer width = 4818
integer height = 1516
integer taborder = 10
string title = "none"
string dataobject = "d_test_query"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;if SqlType = PreviewSelect! then
		
string ls_stat
	
	if pos ( SqlSyntax, "WHERE" ) = 0 then
		
		ls_stat = " WHERE struttura like '"+gs_ambito+"%'"

		else
			
			ls_stat = " and struttura like '"+gs_ambito+"%'"
			
	end if
			
	SetSqlPreview ( SqlSyntax + ls_stat )

end if

end event

