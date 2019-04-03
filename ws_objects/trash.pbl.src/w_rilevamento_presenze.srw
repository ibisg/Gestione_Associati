$PBExportHeader$w_rilevamento_presenze.srw
forward
global type w_rilevamento_presenze from window
end type
type dw_current from datawindow within w_rilevamento_presenze
end type
end forward

global type w_rilevamento_presenze from window
integer width = 2144
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_current dw_current
end type
global w_rilevamento_presenze w_rilevamento_presenze

type variables
string is_codice= '168306RM', is_entrata
end variables

on w_rilevamento_presenze.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_rilevamento_presenze.destroy
destroy(this.dw_current)
end on

event open;long ll_count

is_entrata= string(today(), "dd/mm/yyyy")

dw_current.setTransObject(sqlca)

ll_count= dw_current.retrieve(is_codice, is_entrata)

if ll_count= 0 then
	
  dw_current.insertRow(0)
  dw_current.setItem(1, "codice", is_codice)
	
end if
			
			
			
			
			

end event

type dw_current from datawindow within w_rilevamento_presenze
integer width = 2094
integer height = 1756
integer taborder = 10
string title = "none"
string dataobject = "dw_rilevamento_presenze"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;choose case dwo.name
		
	case "b_entrata"
		
		this.setItem(row, "dt_entrata", today() )
		this.update()
		
		commit;
		
	case "b_uscita"
		
		this.setItem(row, "dt_uscita", today() )
		this.update()
		
		commit;
		
		
	case "b_aggiorna"
		
		this.retrieve(is_codice, is_entrata)
		
end choose
end event

