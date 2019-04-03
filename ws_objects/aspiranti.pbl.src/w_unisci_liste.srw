$PBExportHeader$w_unisci_liste.srw
forward
global type w_unisci_liste from w_preview
end type
end forward

global type w_unisci_liste from w_preview
end type
global w_unisci_liste w_unisci_liste

event open;call super::open;open(w_unisci_cerimonie)
end event

on w_unisci_liste.create
call super::create
end on

on w_unisci_liste.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_unisci_liste
integer width = 3909
string dataobject = "dw_unisci_liste"
end type

event uodw_current::retrievestart;call super::retrievestart;return 2
end event

event uodw_current::buttonclicked;call super::buttonclicked;if dwo.name= "b_seleziona" then
	
	s_preview s_preview_s

	s_preview_s.dataObject= 'dw_unisci_liste'

	openWithParm(w_unisci_liste, s_preview_s)
	
end if
end event

