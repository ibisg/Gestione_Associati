$PBExportHeader$w_preview_ricercapercomuni.srw
forward
global type w_preview_ricercapercomuni from w_preview
end type
end forward

global type w_preview_ricercapercomuni from w_preview
end type
global w_preview_ricercapercomuni w_preview_ricercapercomuni

on w_preview_ricercapercomuni.create
call super::create
end on

on w_preview_ricercapercomuni.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_ricercapercomuni
string dataobject = "dgraph_localita_anno"
boolean ib_allowstop = false
end type

event uodw_current::sqlpreview;call super::sqlpreview;sqlSyntax+= is_preview_s.criterio

if this.setSqlPreview(sqlSyntax)= 0 then messageBox(parent.title, "Errore in sqlPreview")
end event

