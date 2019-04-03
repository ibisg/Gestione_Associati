$PBExportHeader$w_storico_goh.srw
$PBExportComments$Finestra gestione storico Gohonzon
forward
global type w_storico_goh from window
end type
type cb_save from commandbutton within w_storico_goh
end type
type cb_end from commandbutton within w_storico_goh
end type
type cb_canc from commandbutton within w_storico_goh
end type
type cb_ann from commandbutton within w_storico_goh
end type
type cb_new from commandbutton within w_storico_goh
end type
type dw_elenco from datawindow within w_storico_goh
end type
end forward

global type w_storico_goh from window
integer x = 873
integer y = 688
integer width = 2976
integer height = 1288
boolean titlebar = true
string title = "Storico Gohonzon"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_save cb_save
cb_end cb_end
cb_canc cb_canc
cb_ann cb_ann
cb_new cb_new
dw_elenco dw_elenco
end type
global w_storico_goh w_storico_goh

type variables
s_parm str_parm

boolean modify = false


end variables

event open;long ll_rows

f_centra ( w_storico_goh )

gs_context = "Storico Gohonzon"

str_parm = message.PowerObjectParm

dw_elenco.setRowFocusIndicator(focusRect!)

dw_elenco.SetTransObject ( sqlca )

ll_rows = dw_elenco.Retrieve ( str_parm.v_code, str_parm.v_dip )

cb_new.enabled= NOT is_cg

choose case ll_rows
		
	case -1

		CloseWithReturn ( this, -1 )
		return
		
	case is > 0
		
		cb_canc.enabled= NOT is_cg
		
	case else
		
end choose

this.title += " di "+trim ( str_parm.v_nome ) + " " + str_parm.v_cognome

dw_elenco.SetFocus ( )

end event
on w_storico_goh.create
this.cb_save=create cb_save
this.cb_end=create cb_end
this.cb_canc=create cb_canc
this.cb_ann=create cb_ann
this.cb_new=create cb_new
this.dw_elenco=create dw_elenco
this.Control[]={this.cb_save,&
this.cb_end,&
this.cb_canc,&
this.cb_ann,&
this.cb_new,&
this.dw_elenco}
end on

on w_storico_goh.destroy
destroy(this.cb_save)
destroy(this.cb_end)
destroy(this.cb_canc)
destroy(this.cb_ann)
destroy(this.cb_new)
destroy(this.dw_elenco)
end on

event closequery;int li_ret

if modify then
	
	li_ret = MessageBox ( "Modifiche in corso", "Salvare?", question!, YesNoCancel!, 3 )

	choose case li_ret
			
		case 1
			
			if dw_elenco.Update ( ) = -1 then
				
				rollback;
				return 1
				
			else
				
				commit;
				return 0
				
			end if
			
		case 2
			
			return 0
			
		case 3

			return 1
	
	end choose
	
end if

end event

event activate;gs_context = "Storico Gohonzon"

end event

type cb_save from commandbutton within w_storico_goh
integer x = 2592
integer y = 244
integer width = 320
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Salva"
end type

event clicked;long ll_rows
string ls_nome

if checknull ( dw_elenco ) < 0 then return

if dw_elenco.Update ( ) = -1 then
	
	rollback;
	OpenWithParm ( w_msgauto, "Modifiche annullate" )
	goto fine
	
else
	
	f_log ( gs_context, "Modifica manuale storico Gohonzon per " + trim ( str_parm.v_nome ) + " " + str_parm.v_cognome )
	commit;
	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
	goto fine
	
end if

fine:

modify = false

ll_rows = dw_elenco.Retrieve ( str_parm.v_code, str_parm.v_dip )

choose case ll_rows
		
	case -1

		CloseWithReturn ( parent, -1 )
		return
		
	case is > 0
		
		cb_ann.enabled = false
		cb_canc.enabled = true
		cb_save.enabled = false
		dw_elenco.SetFocus ( )
		
	case else

		cb_ann.enabled = false
		cb_canc.enabled = false
		cb_save.enabled = false
		
end choose

return

end event

type cb_end from commandbutton within w_storico_goh
integer x = 2592
integer y = 1056
integer width = 320
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Esci"
boolean cancel = true
end type

event clicked;close ( parent )

end event

type cb_canc from commandbutton within w_storico_goh
integer x = 2592
integer y = 132
integer width = 320
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Cancella"
end type

event clicked;long row

row = dw_elenco.GetRow ( )

if row > 0 then
	
	dw_elenco.DeleteRow ( row )
	if dw_elenco.RowCount ( ) = 0 then this.enabled = false
	modify = true
	cb_ann.enabled = true
	cb_save.enabled = true
	dw_elenco.SetFocus ( )
	
end if

end event

type cb_ann from commandbutton within w_storico_goh
integer x = 2592
integer y = 360
integer width = 320
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Annulla"
end type

event clicked;int li_ret
long ll_rows

if modify then
	
	li_ret = MessageBox ( "Annulla modifiche", "Sei sicuro?", question!, YesNo!, 2 )

	if li_ret = 2 then return
	
		ll_rows = dw_elenco.Retrieve ( str_parm.v_code, str_parm.v_dip )
		
		choose case ll_rows
				
			case -1
		
				CloseWithReturn ( parent, -1 )
				return
				
			case is > 0
				
				cb_canc.enabled = true
				dw_elenco.SetFocus ( )
				
			case else
				
				cb_canc.enabled = false
				
		end choose
	
	modify = false
	
	cb_ann.enabled = false
	cb_save.enabled = false

end if

end event

type cb_new from commandbutton within w_storico_goh
integer x = 2592
integer y = 20
integer width = 320
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nuovo"
end type

event clicked;dw_elenco.InsertRow ( 0 )
dw_elenco.SetFocus ( )
dw_elenco.SetRow ( dw_elenco.RowCount ( ) )
dw_elenco.ScrollToRow ( dw_elenco.RowCount ( ) )
dw_elenco.SetItem ( dw_elenco.RowCount ( ), "codice_membro", str_parm.v_code )
dw_elenco.SetItem ( dw_elenco.RowCount ( ), "cod_dip", str_parm.v_dip )
dw_elenco.SetColumn ( 1 )

cb_canc.enabled = true

end event

type dw_elenco from datawindow within w_storico_goh
integer x = 46
integer y = 20
integer width = 2482
integer height = 1132
string dataobject = "d_storico_goh"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event dberror;f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event itemchanged;modify = true

//if dwo.name = "data" then SetColumn ( "cod_causale" )

cb_ann.enabled = true
cb_canc.enabled = true
cb_save.enabled = true

end event

event editchanged;if dwo.name = "data" then f_checkdate ( dw_elenco )


end event

event itemerror;return 3

end event

event buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

ls_note=  this.getItemString(row, "note")

if dwo.name= 'b_note' then
	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
		this.triggerEvent("itemChanged")
	end if
	
end if
end event

