$PBExportHeader$w_preview_bollettini.srw
forward
global type w_preview_bollettini from window
end type
type uodw_current from uodw_generica within w_preview_bollettini
end type
end forward

global type w_preview_bollettini from window
integer width = 3982
integer height = 2404
boolean titlebar = true
string title = "Anteprima"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "Form!"
boolean clientedge = true
boolean center = true
event ue_postopen ( )
uodw_current uodw_current
end type
global w_preview_bollettini w_preview_bollettini

type variables
boolean ib_esportadw
s_preview is_preview_s
m_preview im_preview
end variables

event ue_postopen();long ll_row

this.setRedraw(false)

if is_preview_s.doretrieve= true then
	ll_row= uodw_current.retrieve(is_preview_s.criterio)
end if

//uodw_current.groupCalc()
//
//if is_preview_s.ib_anteprima= true then uodw_current.Object.DataWindow.Print.Preview = 'Yes'

this.setRedraw(true)

end event

event open;w_frame_template w_parent

w_parent= this.parentWindow()

im_preview= create m_preview

s_session_s.context= "Anteprima"

is_preview_s= message.PowerObjectParm

this.height= w_parent.WorkSpaceHeight() - 240

transaction sqlca_loc
sqlca_loc= create transaction

uodw_current.ib_append= is_preview_s.ib_append

if is_preview_s.ib_dwcreate= true then

	string ls_syntax, ls_errors
	
	// questa era commentata ???????????
	ls_syntax= libraryExport(gs_docdir+"\"+gs_reportpath, is_preview_s.dataObject, exportDataWindow!)
	
	if ls_syntax= "" then
		messageBox(this.title, "Errore in generazione datawindow", exclamation!)
		return
	end if
	
	uodw_current.create(ls_syntax, ls_errors) // idw_dettaglio.create(ls_syntax, ls_errors)
	
		if len(ls_errors) > 0 then
			messageBox(this.title, ls_errors, exclamation!)
			return
		end if

else // ib_dwcreate= false 

	uodw_current.dataObject= is_preview_s.dataObject

end if

sqlca_loc= is_preview_s.transObject

if isValid(sqlca_loc) then 

	uodw_current.setTransObject(sqlca_loc)
	
else
		
	uodw_current.setTransObject(sqlca)
	
end if

post event ue_postopen()

end event

event resize;//w_frame_template w_parent
//
//w_parent= this.parentWindow()

this.setRedraw(false)

//this.height= w_parent.WorkSpaceHeight() - 240
uodw_current.height= this.height - 180
uodw_current.width= this.width - 60

//if ib_centered then wf_center()

this.setRedraw(true)

end event

on w_preview_bollettini.create
this.uodw_current=create uodw_current
this.Control[]={this.uodw_current}
end on

on w_preview_bollettini.destroy
destroy(this.uodw_current)
end on

type uodw_current from uodw_generica within w_preview_bollettini
integer taborder = 10
boolean ib_append = true
end type

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case "b_dis"
		
		if this.filteredCount() > 0 then
		
			this.setFilter("")
			
			this.Object.t_lista.text= "( tutti )"
			
		else
			
			this.setFilter("flag_dis='N'")
			
			this.Object.t_lista.text= "( esclusi non attivi )"	
			
		end if
		
		this.filter()
		this.sort()
		this.groupCalc()
		
	case "b_showreservedfields"
		
		gb_showreservedfields= NOT gb_showreservedfields
		
	case "b_livelli"
	
		s_selezionalivelli s_selezionalivelli_s
		
		open(w_filtra_livelli)
		
		s_selezionalivelli_s= message.powerObjectParm
		
		if isNull(s_selezionalivelli_s.as_da) /*= ""*/  then
			
			uodw_current.setFilter("")
			
		else
		
			uodw_current.setFilter("att_ist_livello >= "+s_selezionalivelli_s.as_da+" and att_ist_livello <= "+s_selezionalivelli_s.as_a)
			
		end if
		
		uodw_current.filter()
	
	case "b_div"
	
		string ls_div
		
		open(w_seleziona_div)		
		
		ls_div= message.stringParm
		
		this.setFilter(ls_div)
		this.filter()
	
end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

//if ib_esportadw= false then
//	im_preview.m_esporta.visible= false
//else
	im_preview.m_esporta.visible= true
//end if

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )

end event

event retrieveend;call super::retrieveend;uodw_current.groupCalc()

if is_preview_s.ib_anteprima= true then uodw_current.Object.DataWindow.Print.Preview = 'Yes'
end event

