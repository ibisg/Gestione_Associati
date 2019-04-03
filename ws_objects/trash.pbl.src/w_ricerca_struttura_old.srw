$PBExportHeader$w_ricerca_struttura_old.srw
forward
global type w_ricerca_struttura_old from w_ricerca_small
end type
type sle_struttura from singlelineedit within w_ricerca_struttura_old
end type
end forward

global type w_ricerca_struttura_old from w_ricerca_small
integer width = 2363
integer height = 1724
string title = "Ricerca elementi di struttura"
string icon = "Query5!"
boolean clientedge = true
sle_struttura sle_struttura
end type
global w_ricerca_struttura_old w_ricerca_struttura_old

type variables
integer il_fino_a_quale_livello
end variables

on w_ricerca_struttura_old.create
int iCurrent
call super::create
this.sle_struttura=create sle_struttura
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_struttura
end on

on w_ricerca_struttura_old.destroy
call super::destroy
destroy(this.sle_struttura)
end on

event open;call super::open;string ls_struttura

ls_struttura= message.stringParm

dw_current.retrieve(ls_struttura)
end event

type dw_current from w_ricerca_small`dw_current within w_ricerca_struttura_old
event type integer ue_ricerca ( string as_struttura )
integer x = 0
integer y = 0
integer width = 2277
integer height = 1236
string dataobject = "dw_ricerca_struttura"
boolean border = false
string icon = "Query5!"
borderstyle borderstyle = stylebox!
end type

event type integer dw_current::ue_ricerca(string as_struttura);w_struttura_tv.tv_struttura.setRedraw(false)

if w_struttura_tv.tv_struttura.uf_cerca_nodo(as_struttura) = -1 then
	messageBox(this.title, "Errore in ricerca nodo.", exclamation!)
end if

w_struttura_tv.tv_struttura.setRedraw(true)

return 0

end event

event dw_current::rowfocuschanged;call super::rowfocuschanged;f_select_current_row (dw_current)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(this.getRow(), "vc_nodo") )
end if
end event

event dw_current::doubleclicked;call super::doubleclicked;long ll_tvi
string ls_struttura

ls_struttura= this.getItemString(row, "vc_parent")+"."+this.getItemString(row, "codice")

//w_struttura_tv.tv_struttura.setRedraw(false)
//
////ll_tvi = w_struttura_tv.tv_struttura.FindItem(roottreeitem!, 0)
////
////w_struttura_tv.tv_struttura.CollapseItem(ll_tvi)
//
//if w_struttura_tv.tv_struttura.uf_cerca_nodo(ls_struttura) = -1 then
//	messageBox(parent.title, "Errore in ricerca nodo.", exclamation!)
//end if
//
//w_struttura_tv.tv_struttura.setRedraw(true)
//
//close(parent)

closeWithReturn(parent, ls_struttura)
end event

event dw_current::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)

if il_fino_a_quale_livello = 0 then

	if pos(lower(sqlsyntax), "where", 1)= 0 then
		sqlsyntax += " where vc_nodo like '"+gs_ambito+"%'"
	else
		sqlsyntax += " and vc_nodo like '"+gs_ambito+"%'"	
	end if

else
	
	if pos(lower(sqlsyntax), "where", 1)= 0 then
		sqlsyntax += " where vc_nodo like '"+gs_ambito+"%'" //' and livello= "+string(il_fino_a_quale_livello)
	else
		sqlsyntax += " and vc_nodo like '"+gs_ambito+"%'" //' and livello= "+string(il_fino_a_quale_livello)	
	end if	
		
end if

SetSqlPreview ( sqlsyntax )
end event

event dw_current::retrieveend;call super::retrieveend;this.setRow(1)
parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(1, "vc_nodo") )
end event

type cb_query from w_ricerca_small`cb_query within w_ricerca_struttura_old
integer x = 919
integer y = 1452
integer width = 443
integer height = 112
integer taborder = 20
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricerca_struttura_old
integer x = 1833
integer y = 1452
integer width = 443
integer height = 112
end type

type sle_struttura from singlelineedit within w_ricerca_struttura_old
integer y = 1264
integer width = 2277
integer height = 164
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
end type

