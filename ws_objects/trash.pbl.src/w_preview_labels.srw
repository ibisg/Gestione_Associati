$PBExportHeader$w_preview_labels.srw
forward
global type w_preview_labels from w_preview
end type
end forward

global type w_preview_labels from w_preview
end type
global w_preview_labels w_preview_labels

on w_preview_labels.create
call super::create
end on

on w_preview_labels.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_labels
string dataobject = "edw_labels"
boolean ib_readonly = true
end type

