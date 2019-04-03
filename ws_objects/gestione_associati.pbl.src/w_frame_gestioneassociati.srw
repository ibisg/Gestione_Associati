$PBExportHeader$w_frame_gestioneassociati.srw
forward
global type w_frame_gestioneassociati from w_frame_template
end type
end forward

global type w_frame_gestioneassociati from w_frame_template
integer width = 3575
integer height = 1592
string title = "Gestione associati"
string menuname = "m_frame_gestione_associati"
boolean controlmenu = true
windowtype windowtype = mdi!
string icon = "typewr_red.ico"
boolean clientedge = true
boolean center = true
end type
global w_frame_gestioneassociati w_frame_gestioneassociati

on w_frame_gestioneassociati.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_frame_gestione_associati" then this.MenuID = create m_frame_gestione_associati
end on

on w_frame_gestioneassociati.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;this.title += gs_title
end event

