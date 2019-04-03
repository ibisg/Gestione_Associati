$PBExportHeader$w_frame_gestione_associat.srw
forward
global type w_frame_gestione_associat from w_frame_template
end type
end forward

global type w_frame_gestione_associat from w_frame_template
end type
global w_frame_gestione_associat w_frame_gestione_associat

on w_frame_gestione_associat.create
call super::create
end on

on w_frame_gestione_associat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

