$PBExportHeader$w_ins_riferimenti_mail.srw
forward
global type w_ins_riferimenti_mail from w_ins_riferimenti
end type
end forward

global type w_ins_riferimenti_mail from w_ins_riferimenti
end type
global w_ins_riferimenti_mail w_ins_riferimenti_mail

event open;call super::open;uodw_ins_riferimenti.setItem(il_row, "cod_rif", is_riferimenti_s.cod_rif)
uodw_ins_riferimenti.Object.cod_rif.Protect=1
uodw_ins_riferimenti.setColumn("riferimento_descr")
end event

on w_ins_riferimenti_mail.create
call super::create
end on

on w_ins_riferimenti_mail.destroy
call super::destroy
end on

type cb_chiudi from w_ins_riferimenti`cb_chiudi within w_ins_riferimenti_mail
end type

type uodw_ins_riferimenti from w_ins_riferimenti`uodw_ins_riferimenti within w_ins_riferimenti_mail
end type

