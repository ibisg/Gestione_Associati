$PBExportHeader$w_mod_eventi.srw
forward
global type w_mod_eventi from w_ins_eventi
end type
end forward

global type w_mod_eventi from w_ins_eventi
end type
global w_mod_eventi w_mod_eventi

event open;call super::open;uodw_ins_eventi.object.b_m.visible= false
end event

on w_mod_eventi.create
call super::create
end on

on w_mod_eventi.destroy
call super::destroy
end on

type cb_chiudi from w_ins_eventi`cb_chiudi within w_mod_eventi
end type

type uodw_ins_eventi from w_ins_eventi`uodw_ins_eventi within w_mod_eventi
end type

