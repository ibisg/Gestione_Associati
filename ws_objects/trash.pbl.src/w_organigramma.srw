$PBExportHeader$w_organigramma.srw
forward
global type w_organigramma from w_centered
end type
type uodw_current from uodw_organigramma within w_organigramma
end type
end forward

global type w_organigramma from w_centered
integer width = 2848
integer height = 2188
uodw_current uodw_current
end type
global w_organigramma w_organigramma

event open;call super::open;uodw_current.uof_populate(5, "IT.LA.S4.S2.R4")

end event

on w_organigramma.create
int iCurrent
call super::create
this.uodw_current=create uodw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_current
end on

on w_organigramma.destroy
call super::destroy
destroy(this.uodw_current)
end on

type uodw_current from uodw_organigramma within w_organigramma
integer x = 41
integer y = 40
integer height = 1960
integer taborder = 10
end type

