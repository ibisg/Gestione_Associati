$PBExportHeader$w_storico_esami.srw
forward
global type w_storico_esami from window
end type
type cb_annulla from commandbutton within w_storico_esami
end type
type cb_salva from commandbutton within w_storico_esami
end type
type cb_cancella from commandbutton within w_storico_esami
end type
type cb_nuovo from commandbutton within w_storico_esami
end type
type cb_esci from commandbutton within w_storico_esami
end type
type dw_current from datawindow within w_storico_esami
end type
end forward

global type w_storico_esami from window
integer width = 1897
integer height = 1088
boolean titlebar = true
string title = "Storico esami"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_annulla cb_annulla
cb_salva cb_salva
cb_cancella cb_cancella
cb_nuovo cb_nuovo
cb_esci cb_esci
dw_current dw_current
end type
global w_storico_esami w_storico_esami

type variables
s_parm str_parm

boolean modify = false
end variables

event open;long ll_rows

f_centra ( w_storico_esami )

gs_context = "Storico esami"

str_parm = message.PowerObjectParm

dw_current.setRowFocusIndicator(focusRect!)

dw_current.SetTransObject ( sqlca )

ll_rows = dw_current.Retrieve ( str_parm.v_code, str_parm.v_dip )

cb_nuovo.enabled= NOT is_cg

choose case ll_rows
		
	case -1

		CloseWithReturn ( this, -1 )
		return
		
	case is > 0
		
		cb_cancella.enabled= NOT is_cg
		
	case else
		
end choose

this.title += " di "+trim ( str_parm.v_nome ) + " " + str_parm.v_cognome

dw_current.SetFocus ( )




end event

on w_storico_esami.create
this.cb_annulla=create cb_annulla
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_nuovo=create cb_nuovo
this.cb_esci=create cb_esci
this.dw_current=create dw_current
this.Control[]={this.cb_annulla,&
this.cb_salva,&
this.cb_cancella,&
this.cb_nuovo,&
this.cb_esci,&
this.dw_current}
end on

on w_storico_esami.destroy
destroy(this.cb_annulla)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_nuovo)
destroy(this.cb_esci)
destroy(this.dw_current)
end on

type cb_annulla from commandbutton within w_storico_esami
integer x = 1499
integer y = 380
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Annulla"
boolean cancel = true
end type

event clicked;int li_ret
long ll_rows

if modify then
	
	li_ret = MessageBox ( "Annulla modifiche", "Sei sicuro?", question!, YesNo!, 2 )

	if li_ret = 2 then return
	
		ll_rows = dw_current.Retrieve ( str_parm.v_code, str_parm.v_dip )
		
		choose case ll_rows
				
			case -1
		
				CloseWithReturn ( parent, -1 )
				return
				
			case is > 0
				
				cb_cancella.enabled = true
				dw_current.SetFocus ( )
				
			case else
				
				cb_cancella.enabled = false
				
		end choose
	
	modify = false
	
	cb_annulla.enabled = false
	cb_salva.enabled = false

end if

end event

type cb_salva from commandbutton within w_storico_esami
integer x = 1499
integer y = 264
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Salva"
boolean cancel = true
end type

event clicked;long ll_rows
string ls_nome

if checknull ( dw_current ) < 0 then return

if dw_current.Update ( ) = -1 then
	
	rollback;
	OpenWithParm ( w_msgauto, "Modifiche annullate" )
	goto fine
	
else
	
	f_log ( gs_context, "Modifica manuale storico esami per " + trim ( str_parm.v_nome ) + " " + str_parm.v_cognome )
	commit;
	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
	goto fine
	
end if

fine:

modify = false

ll_rows = dw_current.Retrieve ( str_parm.v_code, str_parm.v_dip )

choose case ll_rows
		
	case -1

		CloseWithReturn ( parent, -1 )
		return
		
	case is > 0
		
		cb_annulla.enabled = false
		cb_cancella.enabled = true
		cb_salva.enabled = false
		dw_current.SetFocus ( )
		
	case else

		cb_annulla.enabled = false
		cb_cancella.enabled = false
		cb_salva.enabled = false
		
end choose

return

end event

type cb_cancella from commandbutton within w_storico_esami
integer x = 1499
integer y = 148
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cancella"
boolean cancel = true
end type

event clicked;long row

row = dw_current.GetRow ( )

if row > 0 then
	
	dw_current.DeleteRow ( row )
	if dw_current.RowCount ( ) = 0 then this.enabled = false
	modify = true
	cb_annulla.enabled = true
	cb_salva.enabled = true
	dw_current.SetFocus ( )
	
end if
end event

type cb_nuovo from commandbutton within w_storico_esami
integer x = 1499
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Nuovo"
boolean cancel = true
end type

event clicked;dw_current.InsertRow ( 0 )
dw_current.SetFocus ( )
dw_current.SetRow ( dw_current.RowCount ( ) )
dw_current.ScrollToRow ( dw_current.RowCount ( ) )
dw_current.SetItem ( dw_current.RowCount ( ), "codice_membro", str_parm.v_code )
dw_current.SetItem ( dw_current.RowCount ( ), "cod_dip", str_parm.v_dip )
dw_current.SetColumn ( 1 )

cb_cancella.enabled = true
end event

type cb_esci from commandbutton within w_storico_esami
integer x = 1499
integer y = 856
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Esci"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_storico_esami
integer x = 41
integer y = 32
integer width = 1435
integer height = 916
integer taborder = 10
string title = "none"
string dataobject = "ds_curr_studio"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;modify = true

cb_annulla.enabled = true
cb_cancella.enabled = true
cb_salva.enabled = true

end event

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1
end event

event itemerror;return 3
end event

