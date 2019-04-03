$PBExportHeader$w_updliste.srw
forward
global type w_updliste from window
end type
type cb_3 from commandbutton within w_updliste
end type
type cb_2 from commandbutton within w_updliste
end type
type dw_current from datawindow within w_updliste
end type
type cb_1 from commandbutton within w_updliste
end type
end forward

global type w_updliste from window
integer width = 2944
integer height = 1648
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
dw_current dw_current
cb_1 cb_1
end type
global w_updliste w_updliste

event open;dw_current.setTransObject(sqlca)



end event

on w_updliste.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_current=create dw_current
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.dw_current,&
this.cb_1}
end on

on w_updliste.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_current)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_updliste
integer x = 1774
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "aggiorna"
end type

event clicked;integer ll_idx
string ls_capitolo_nuovo

for ll_idx= 1 to dw_current.rowCount()
	
	
	ls_capitolo_nuovo= dw_current.getItemString(ll_idx, "vc_nodonew")
	
	dw_current.setItem(ll_idx, "vc_nodo", ls_capitolo_nuovo)
	
next

dw_current.update()

if trap_sql(sqlca, "UPD01") < 0 then
	rollback;
else
	commit;
end if
end event

type cb_2 from commandbutton within w_updliste
integer x = 1426
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "assegna"
end type

event clicked;long ll_idx
integer li_livello
string ls_codice, ls_nodo, ls_parent, ls_relazione, ls_descrizione
decimal ld_id, ld_id_parent


for ll_idx= 1 to dw_current.rowCount()

	ls_parent= dw_current.getItemString(ll_idx, "vc_parent")
	li_livello= dw_current.getItemNumber(ll_idx, "livello")
	
		select id into :ld_id from struttura_id where vc_nodo= :ls_parent;
	
		dw_current.setItem(ll_idx, "id_parent", ld_id)
	
next
end event

type dw_current from datawindow within w_updliste
integer x = 59
integer y = 24
integer width = 2775
integer height = 1296
integer taborder = 10
string title = "none"
string dataobject = "dw_updliste"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_updliste
integer x = 1079
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "estrai"
end type

event clicked;

dw_current.retrieve()


end event

