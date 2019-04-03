$PBExportHeader$w_gestione_deceduti.srw
forward
global type w_gestione_deceduti from w_generica_sheet
end type
end forward

global type w_gestione_deceduti from w_generica_sheet
integer width = 4818
end type
global w_gestione_deceduti w_gestione_deceduti

type variables
m_preview_deceduti im_preview_deceduti
end variables

on w_gestione_deceduti.create
call super::create
end on

on w_gestione_deceduti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;im_preview_deceduti= create m_preview_deceduti
end event

type uodw_current from w_generica_sheet`uodw_current within w_gestione_deceduti
integer y = 60
string dataobject = "dw_gestione_deceduti"
boolean ib_allowrowselection = true
end type

event uodw_current::rbuttondown;if this.ib_queryMode= true then
	messageBox(parent.title, "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview_deceduti.iuodw_generica= this

im_preview_deceduti.m_aggiungi.visible= false
im_preview_deceduti.m_rimuovi.visible= false
im_preview_deceduti.m_salva.visible= false

im_preview_deceduti.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

