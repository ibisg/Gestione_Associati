$PBExportHeader$w_moveitem_new.srw
forward
global type w_moveitem_new from w_centered
end type
type cb_chiudi from commandbutton within w_moveitem_new
end type
type tab_move from tab within w_moveitem_new
end type
type tabpage_cosa from userobject within tab_move
end type
type cb_next from commandbutton within tabpage_cosa
end type
type dw_current from datawindow within tabpage_cosa
end type
type tabpage_cosa from userobject within tab_move
cb_next cb_next
dw_current dw_current
end type
type tabpage_dove from userobject within tab_move
end type
type cb_back from commandbutton within tabpage_dove
end type
type cb_esegui from commandbutton within tabpage_dove
end type
type tv_struttura from uotv_mostra_struttura within tabpage_dove
end type
type tabpage_dove from userobject within tab_move
cb_back cb_back
cb_esegui cb_esegui
tv_struttura tv_struttura
end type
type tab_move from tab within w_moveitem_new
tabpage_cosa tabpage_cosa
tabpage_dove tabpage_dove
end type
end forward

global type w_moveitem_new from w_centered
integer width = 2304
integer height = 1720
string title = "Spostamento elementi di struttura"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
cb_chiudi cb_chiudi
tab_move tab_move
end type
global w_moveitem_new w_moveitem_new

type variables
long il_row
string is_struttura
s_struttura is_struttura_s, is_struttura_tgt

dataWindow idw_current
end variables

event open;call super::open;string ls_descrizione

is_struttura_s= message.powerObjectParm

idw_current= tab_move.tabpage_cosa.dw_current

//select descrizione into :ls_descrizione from livelli_struttura where livello= :is_struttura_s.livello + 1;

tab_move.tabpage_cosa.dw_current.object.t_header.text= "Elenco entità contenute in: "+is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura

idw_current.setRowFocusIndicator(focusrect!)

idw_current.setTransObject(sqlca)

idw_current.retrieve(is_struttura_s.vc_nodo)


end event

on w_moveitem_new.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.tab_move=create tab_move
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.tab_move
end on

on w_moveitem_new.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.tab_move)
end on

type cb_chiudi from commandbutton within w_moveitem_new
integer x = 1797
integer y = 1452
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;is_struttura_tgt.livello= -1
closeWithReturn(parent, is_struttura_tgt)
end event

type tab_move from tab within w_moveitem_new
integer width = 2249
integer height = 1436
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_cosa tabpage_cosa
tabpage_dove tabpage_dove
end type

on tab_move.create
this.tabpage_cosa=create tabpage_cosa
this.tabpage_dove=create tabpage_dove
this.Control[]={this.tabpage_cosa,&
this.tabpage_dove}
end on

on tab_move.destroy
destroy(this.tabpage_cosa)
destroy(this.tabpage_dove)
end on

event selectionchanged;choose case newindex
		
	case 2
		
		long ll_handle
		
		tabpage_dove.tv_struttura.il_fino_a_quale_livello= is_struttura_s.livello - 1//gi_maxlivello - 1
		tabpage_dove.tv_struttura.uf_populate(0)
		
		tabpage_dove.tv_struttura.uf_cerca_nodo(is_struttura_s.vc_nodo)
		
		return 0
	
		
end choose
end event

type tabpage_cosa from userobject within tab_move
integer x = 18
integer y = 112
integer width = 2213
integer height = 1308
long backcolor = 81324524
string text = "Cosa spostare"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "Question!"
long picturemaskcolor = 536870912
cb_next cb_next
dw_current dw_current
end type

on tabpage_cosa.create
this.cb_next=create cb_next
this.dw_current=create dw_current
this.Control[]={this.cb_next,&
this.dw_current}
end on

on tabpage_cosa.destroy
destroy(this.cb_next)
destroy(this.dw_current)
end on

type cb_next from commandbutton within tabpage_cosa
integer x = 1778
integer y = 1200
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Avanti >>"
boolean default = true
end type

event clicked;if dw_current.find ( "csposta= '1'", 1, dw_current.rowCount() ) > 0 then
	tab_move.tabpage_dove.enabled= true
	tab_move.selectTab(2)
else
	tab_move.tabpage_dove.enabled= false
	messageBox(parent.text, "Selezionare delle entità da spostare.", exclamation!)
end if
end event

type dw_current from datawindow within tabpage_cosa
integer width = 2213
integer height = 1176
integer taborder = 10
string title = "none"
string dataobject = "dw_sposta_nodo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;choose case dwo.name
		
	case "codice"
		this.setItem(row, "vc_nodo", this.getItemString(row, "vc_parent")+"."+data )

end choose
end event

type tabpage_dove from userobject within tab_move
integer x = 18
integer y = 112
integer width = 2213
integer height = 1308
boolean enabled = false
long backcolor = 81324524
string text = "Dove"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "Where!"
long picturemaskcolor = 536870912
cb_back cb_back
cb_esegui cb_esegui
tv_struttura tv_struttura
end type

on tabpage_dove.create
this.cb_back=create cb_back
this.cb_esegui=create cb_esegui
this.tv_struttura=create tv_struttura
this.Control[]={this.cb_back,&
this.cb_esegui,&
this.tv_struttura}
end on

on tabpage_dove.destroy
destroy(this.cb_back)
destroy(this.cb_esegui)
destroy(this.tv_struttura)
end on

type cb_back from commandbutton within tabpage_dove
integer x = 1362
integer y = 1200
integer width = 411
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<< Torna indietro"
end type

event clicked;tab_move.selectTab(1)
end event

type cb_esegui from commandbutton within tabpage_dove
integer x = 1778
integer y = 1200
integer width = 402
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Esegui"
end type

event clicked;integer li_ret
		long ll_idx
		
		this.enabled= false
		
		s_struttura s_struttura_src, s_struttura_tgt
		
		for ll_idx= 1 to idw_current.rowCount()
			
			if idw_current.getItemString(ll_idx, "csposta")= '1' then
			
				s_struttura_src.vc_parent= idw_current.getItemString(ll_idx, "vc_parent")
				s_struttura_src.codice= idw_current.getItemString(ll_idx, "codice")
				s_struttura_src.vc_nodo= s_struttura_src.vc_parent+"."+s_struttura_src.codice
				
				is_struttura_tgt= w_struttura_tv_tab.tv_struttura.uf_aggiorna_parent(s_struttura_src, is_struttura_tgt)
				
				if is_struttura_tgt.livello= -1 then exit
				
			end if
			
		next
		
			if is_struttura_tgt.livello= -1 then
				rollback;
				if trap_sql(sqlca, "MOVEITEM01") < 0 then return
				messageBox(parent.text, "Errore in modifica struttura.", exclamation!)
			else
				commit;
				if trap_sql(sqlca, "MOVEITEM02") < 0 then return
				messageBox(parent.text, "Aggiornamento eseguito.", exclamation!)
			end if
			
			closeWithReturn(parentWindow(), is_struttura_tgt)
	
end event

type tv_struttura from uotv_mostra_struttura within tabpage_dove
integer width = 2208
integer height = 1180
integer taborder = 20
end type

event selectionchanged;call super::selectionchanged;treeViewItem ltvi_struttura

this.getItem(newhandle, ltvi_struttura)

is_struttura_tgt= ltvi_struttura.data

if is_struttura_tgt.livello - 1= il_fino_a_quale_livello then
	cb_esegui.enabled= true
else
	cb_esegui.enabled= false
end if

return 0
end event

