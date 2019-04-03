$PBExportHeader$w_utenti_web_conliste.srw
forward
global type w_utenti_web_conliste from w_reportrunner
end type
end forward

global type w_utenti_web_conliste from w_reportrunner
integer width = 7854
end type
global w_utenti_web_conliste w_utenti_web_conliste

on w_utenti_web_conliste.create
call super::create
end on

on w_utenti_web_conliste.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_reportrunner`uodw_current within w_utenti_web_conliste
integer width = 6981
string dataobject = "dw_utenti_web"
boolean ib_readonly = true
end type

event uodw_current::doubleclicked;call super::doubleclicked;if row = 0 then return

string ls_codice

ls_codice= this.getItemString(row, "codice")


openWithParm(w_gestioneaccessoremoto, ls_codice)

this.retrieve()
this.sort()
end event

