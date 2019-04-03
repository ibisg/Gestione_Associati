$PBExportHeader$w_stampa_diplomi.srw
forward
global type w_stampa_diplomi from w_ricerca_small
end type
type pb_1 from picturebutton within w_stampa_diplomi
end type
end forward

global type w_stampa_diplomi from w_ricerca_small
integer width = 4571
string menuname = "m_search_archivio_sheet"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
windowstate windowstate = maximized!
boolean ib_centered = false
pb_1 pb_1
end type
global w_stampa_diplomi w_stampa_diplomi

on w_stampa_diplomi.create
int iCurrent
call super::create
if this.MenuName = "m_search_archivio_sheet" then this.MenuID = create m_search_archivio_sheet
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on w_stampa_diplomi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
end on

type dw_current from w_ricerca_small`dw_current within w_stampa_diplomi
end type

type cb_importa from w_ricerca_small`cb_importa within w_stampa_diplomi
integer x = 2642
integer y = 1640
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_stampa_diplomi
integer x = 2057
integer y = 1640
end type

type cb_query from w_ricerca_small`cb_query within w_stampa_diplomi
integer x = 869
integer y = 1632
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_stampa_diplomi
integer x = 1435
integer y = 1640
end type

type pb_1 from picturebutton within w_stampa_diplomi
integer x = 3273
integer y = 1652
integer width = 174
integer height = 136
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "D:\svil\Svil7\Risorse\where.bmp"
alignment htextalign = left!
end type

