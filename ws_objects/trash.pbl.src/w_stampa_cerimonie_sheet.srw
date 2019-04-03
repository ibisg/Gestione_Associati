$PBExportHeader$w_stampa_cerimonie_sheet.srw
forward
global type w_stampa_cerimonie_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_stampa_cerimonie_sheet from w_gestione_archivio_sheet
string menuname = "m_search_archivio_sheet"
windowstate windowstate = maximized!
string icon = "Query5!"
end type
global w_stampa_cerimonie_sheet w_stampa_cerimonie_sheet

type variables
s_cerimonia is_cerimonia_s
end variables

on w_stampa_cerimonie_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_search_archivio_sheet" then this.MenuID = create m_search_archivio_sheet
end on

on w_stampa_cerimonie_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long ll_row
string ls_tipo

ls_tipo= message.stringParm

openWithParm(w_gestione_cerimonie, ls_tipo)

is_cerimonia_s= message.powerObjectParm

if isNull(is_cerimonia_s.id) then close(this)

if ls_tipo= "I" then
	
	dw_current.dataObject= "dw_stampa_cerimonie"
	
else
	
	dw_current.dataObject= "dw_stampa_sostituzioni"	
	
end if

dw_current.setTransObject(sqlca)

return dw_current.retrieve(is_cerimonia_s.id)
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_stampa_cerimonie_sheet
string dataobject = "dw_stampa_cerimonie"
end type

