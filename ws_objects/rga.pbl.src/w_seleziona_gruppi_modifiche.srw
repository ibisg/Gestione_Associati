$PBExportHeader$w_seleziona_gruppi_modifiche.srw
forward
global type w_seleziona_gruppi_modifiche from window
end type
type rb_messaggi from radiobutton within w_seleziona_gruppi_modifiche
end type
type rb_pendenti from radiobutton within w_seleziona_gruppi_modifiche
end type
type rb_tutte from radiobutton within w_seleziona_gruppi_modifiche
end type
type cb_seleziona from commandbutton within w_seleziona_gruppi_modifiche
end type
type cb_annulla from commandbutton within w_seleziona_gruppi_modifiche
end type
type uodw_seleziona_gruppo_modifiche from uodw_generica within w_seleziona_gruppi_modifiche
end type
type gb_1 from groupbox within w_seleziona_gruppi_modifiche
end type
end forward

global type w_seleziona_gruppi_modifiche from window
integer width = 3840
integer height = 1820
boolean titlebar = true
string title = "Seleziona capitolo"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
rb_messaggi rb_messaggi
rb_pendenti rb_pendenti
rb_tutte rb_tutte
cb_seleziona cb_seleziona
cb_annulla cb_annulla
uodw_seleziona_gruppo_modifiche uodw_seleziona_gruppo_modifiche
gb_1 gb_1
end type
global w_seleziona_gruppi_modifiche w_seleziona_gruppi_modifiche

type variables
string is_tipo
s_rga is_rga_s

m_preview im_preview
end variables

on w_seleziona_gruppi_modifiche.create
this.rb_messaggi=create rb_messaggi
this.rb_pendenti=create rb_pendenti
this.rb_tutte=create rb_tutte
this.cb_seleziona=create cb_seleziona
this.cb_annulla=create cb_annulla
this.uodw_seleziona_gruppo_modifiche=create uodw_seleziona_gruppo_modifiche
this.gb_1=create gb_1
this.Control[]={this.rb_messaggi,&
this.rb_pendenti,&
this.rb_tutte,&
this.cb_seleziona,&
this.cb_annulla,&
this.uodw_seleziona_gruppo_modifiche,&
this.gb_1}
end on

on w_seleziona_gruppi_modifiche.destroy
destroy(this.rb_messaggi)
destroy(this.rb_pendenti)
destroy(this.rb_tutte)
destroy(this.cb_seleziona)
destroy(this.cb_annulla)
destroy(this.uodw_seleziona_gruppo_modifiche)
destroy(this.gb_1)
end on

event open;long ll_ret

im_preview= create m_preview

uodw_seleziona_gruppo_modifiche.setTransObject(sqlca)

open(w_wait_snoopy)

uodw_seleziona_gruppo_modifiche.setRedraw(false)
ll_ret= uodw_seleziona_gruppo_modifiche.retrieve(gs_ambito)
uodw_seleziona_gruppo_modifiche.setFilter("daevadere > 0")
uodw_seleziona_gruppo_modifiche.filter()
uodw_seleziona_gruppo_modifiche.setRedraw(true)

close(w_wait_snoopy)

if ll_ret= 0 then
	
	messageBox("RGA", "Nessuna richiesta")
	is_rga_s.vc_nodo=""
	is_rga_s.tipo= ""

	closeWithReturn(this, is_rga_s)
	return 0
	
end if

return 0
end event

type rb_messaggi from radiobutton within w_seleziona_gruppi_modifiche
integer x = 1531
integer y = 1596
integer width = 1065
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo con messaggi ancora da leggere"
end type

event clicked;uodw_seleziona_gruppo_modifiche.setFilter("messaggi_da_leggere >0")
uodw_seleziona_gruppo_modifiche.filter()
end event

type rb_pendenti from radiobutton within w_seleziona_gruppi_modifiche
integer x = 654
integer y = 1596
integer width = 841
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo le richieste da evadere"
boolean checked = true
end type

event clicked;uodw_seleziona_gruppo_modifiche.setFilter("daevadere > 0 OR messaggi_da_leggere > 0")
uodw_seleziona_gruppo_modifiche.filter()
end event

type rb_tutte from radiobutton within w_seleziona_gruppi_modifiche
integer x = 73
integer y = 1592
integer width = 549
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutte le richieste"
end type

event clicked;uodw_seleziona_gruppo_modifiche.setFilter("")
uodw_seleziona_gruppo_modifiche.filter()
end event

type cb_seleziona from commandbutton within w_seleziona_gruppi_modifiche
integer x = 2633
integer y = 1568
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Seleziona"
boolean default = true
end type

event clicked;uodw_seleziona_gruppo_modifiche.triggerEvent( doubleClicked!)
end event

type cb_annulla from commandbutton within w_seleziona_gruppi_modifiche
integer x = 3109
integer y = 1568
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Annulla"
end type

event clicked;is_rga_s.vc_nodo=""
is_rga_s.tipo= ""

closeWithReturn(parent, is_rga_s)
end event

type uodw_seleziona_gruppo_modifiche from uodw_generica within w_seleziona_gruppi_modifiche
integer width = 3803
integer height = 1532
integer taborder = 10
string dataobject = "dw_seleziona_gruppo_modifiche"
boolean maxbox = false
boolean hscrollbar = false
boolean ib_isgrid = true
boolean ib_allowrowselection = true
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;is_rga_s.vc_nodo= this.getItemString(this.getRow(), "struttura_vc_nodo")
is_rga_s.tipo= is_tipo

closeWithReturn(parent, is_rga_s)
end event

event retrieveend;call super::retrieveend;if rowcount > 0 then cb_seleziona.enabled= true

cb_annulla.enabled= true
end event

event retrievestart;call super::retrievestart;cb_seleziona.enabled= false
cb_annulla.enabled= false
end event

event rbuttondown;call super::rbuttondown;if this.ib_queryMode= true then
	messageBox("RGA", "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

event sqlpreview;call super::sqlpreview;string ls_query1, ls_mid1, ls_mid2
integer li_pos, li_idx


for li_idx= 1 to UpperBound(gs_ambiti)
	
	if li_idx=  UpperBound(gs_ambiti) then
		
		ls_query1 += " r.vc_nodo like  '"+gs_ambiti[li_idx]+"%') "
		
	else
		
		ls_query1 += " r.vc_nodo like '"+gs_ambiti[li_idx]+"%' OR "
		
	end if
	
next	

li_pos= pos(lower(sqlsyntax), "group by")

ls_mid1=  mid(sqlsyntax, 1, li_pos - 1)+" and ("+ls_query1
ls_mid2=  " "+mid(sqlsyntax, li_pos)

sqlsyntax=  ls_mid1 + ls_mid2


SetSqlPreview ( sqlsyntax )
end event

type gb_1 from groupbox within w_seleziona_gruppi_modifiche
integer x = 27
integer y = 1536
integer width = 2578
integer height = 156
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

