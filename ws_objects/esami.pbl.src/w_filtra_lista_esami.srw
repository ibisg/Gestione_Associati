$PBExportHeader$w_filtra_lista_esami.srw
forward
global type w_filtra_lista_esami from w_centered
end type
type cb_annulla from commandbutton within w_filtra_lista_esami
end type
type cb_filtra from commandbutton within w_filtra_lista_esami
end type
type dw_filtra from datawindow within w_filtra_lista_esami
end type
end forward

global type w_filtra_lista_esami from w_centered
integer width = 1243
integer height = 980
string title = "Filtra i risultati"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_annulla cb_annulla
cb_filtra cb_filtra
dw_filtra dw_filtra
end type
global w_filtra_lista_esami w_filtra_lista_esami

type variables
dataWindowChild idwc_resp
end variables

on w_filtra_lista_esami.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_filtra=create cb_filtra
this.dw_filtra=create dw_filtra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_filtra
this.Control[iCurrent+3]=this.dw_filtra
end on

on w_filtra_lista_esami.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_filtra)
destroy(this.dw_filtra)
end on

event open;call super::open;dw_filtra.GetChild('livello_resp_soglia', idwc_resp)

idwc_resp.setTransObject(sqlca)

idwc_resp.retrieve()

dw_filtra.insertRow(0)


end event

type cb_annulla from commandbutton within w_filtra_lista_esami
integer x = 869
integer y = 756
integer width = 343
integer height = 124
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type cb_filtra from commandbutton within w_filtra_lista_esami
integer x = 393
integer y = 756
integer width = 430
integer height = 124
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Applica il filtro"
boolean default = true
end type

event clicked;integer li_resp
string ls_a_g, ls_filtro

li_resp= dw_filtra.getItemNumber(1, "livello_resp_soglia")

ls_a_g= dw_filtra.getItemString(1, "a_g")

choose case ls_a_g
			
	case 'G'
		
		ls_filtro= "(cod_div= '3' OR cod_div= '4') "
		
	case 'A'
		
		ls_filtro= "(cod_div= '1' OR cod_div= '2') "
			
end choose

if ls_filtro= "" then

	if li_resp > 0 then
		
		ls_filtro+= " (livello_resp_max <= "+string(li_resp)+")"
		
	end if

else
	
	if li_resp > 0 then
		
		ls_filtro+= " and (livello_resp_max <= "+string(li_resp)+")"
		
	end if	
	
end if

closeWithReturn(parent, ls_filtro)
end event

type dw_filtra from datawindow within w_filtra_lista_esami
integer width = 1216
integer height = 720
integer taborder = 10
string title = "none"
string dataobject = "edw_filtra_lista_esami"
boolean border = false
boolean livescroll = true
end type

