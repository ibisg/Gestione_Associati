$PBExportHeader$w_tipo_lista_auto.srw
forward
global type w_tipo_lista_auto from w_centered
end type
type cb_chiudi from commandbutton within w_tipo_lista_auto
end type
type cb_importa from commandbutton within w_tipo_lista_auto
end type
type rb_labels from radiobutton within w_tipo_lista_auto
end type
type rb_doc from radiobutton within w_tipo_lista_auto
end type
type rb_mail from radiobutton within w_tipo_lista_auto
end type
type gb_tipo from groupbox within w_tipo_lista_auto
end type
end forward

global type w_tipo_lista_auto from w_centered
integer width = 1001
integer height = 628
string title = "Selezione del tipo lista"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
cb_chiudi cb_chiudi
cb_importa cb_importa
rb_labels rb_labels
rb_doc rb_doc
rb_mail rb_mail
gb_tipo gb_tipo
end type
global w_tipo_lista_auto w_tipo_lista_auto

type variables
string is_tipo, is_nodo
dataStore ids_liste_dettaglio, ids_liste_source
end variables

on w_tipo_lista_auto.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_importa=create cb_importa
this.rb_labels=create rb_labels
this.rb_doc=create rb_doc
this.rb_mail=create rb_mail
this.gb_tipo=create gb_tipo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.rb_labels
this.Control[iCurrent+4]=this.rb_doc
this.Control[iCurrent+5]=this.rb_mail
this.Control[iCurrent+6]=this.gb_tipo
end on

on w_tipo_lista_auto.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_importa)
destroy(this.rb_labels)
destroy(this.rb_doc)
destroy(this.rb_mail)
destroy(this.gb_tipo)
end on

event open;call super::open;dataWindow ldw_source

ids_liste_dettaglio= create dataStore

ids_liste_dettaglio.dataObject= 'ds_liste_dettaglio'

ids_liste_dettaglio.setTransObject(sqlca)

ids_liste_source= create dataStore

//ids_liste_dettaglio.dataObject= 'ds_liste_dettaglio'

ldw_source= message.PowerObjectParm

ids_liste_source.setTransObject(sqlca)

ids_liste_source.ShareData(ldw_source)

//is_nodo= message.stringParm
end event

type cb_chiudi from commandbutton within w_tipo_lista_auto
integer x = 512
integer y = 280
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type cb_importa from commandbutton within w_tipo_lista_auto
integer x = 512
integer y = 104
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
boolean default = true
end type

event clicked;long ll_idx, ll_row
string ls_cod_lista, ls_descrizione

ids_liste_dettaglio.reset()

// Crea una lista temporanea del tipo definito. fa una insert in tabella liste
ls_cod_lista= mid(is_tipo, 1, 1)+string(now(), "hh:mm:ss")
ls_descrizione= "Lista temporanea del tipo "+is_tipo

openWithParm(w_rinomina_lista, ls_descrizione)

ls_descrizione= message.stringParm

if ls_descrizione= "" then return

  INSERT INTO liste  
         ( cod_lista,   
           descrizione,   
           cod_tipo,   
           genere )  
  VALUES ( 	:ls_cod_lista,   
           		:ls_descrizione,   
          		:is_tipo,   
          		"T" )  ;
					 
if trap_sql(sqlca, "TEMPLISTA01") < 0 then goto errore

// Inserisce nella tabella liste_dettaglio i codici delle pesone selezionate

for ll_idx= 1 to ids_liste_source.rowCount()
	ll_row= ids_liste_dettaglio.insertRow(0)
	ids_liste_dettaglio.setItem(ll_row, "cod_lista", ls_cod_lista)
	ids_liste_dettaglio.setItem(ll_row, "codice", ids_liste_source.getItemString(ll_idx, "codice"))
next

if ids_liste_dettaglio.update() < 0 then
	open(w_message_negative)
	goto errore
else
	commit;
	if trap_sql(sqlca, "TEMPLISTA02") < 0 then goto errore
	open(w_message)
end if

// ritorna con il codice della lista che servirà per la successiva retrieve

closeWithReturn(parent, ls_cod_lista)

errore:

rollback;
trap_sql(sqlca, "TEMPLISTA03")

return -1
end event

type rb_labels from radiobutton within w_tipo_lista_auto
integer x = 123
integer y = 304
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Etichette"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_tipo= 'LABELS'
cb_importa.enabled= true
end event

type rb_doc from radiobutton within w_tipo_lista_auto
integer x = 123
integer y = 128
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lettera"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_tipo= 'DOC'
cb_importa.enabled= true
end event

type rb_mail from radiobutton within w_tipo_lista_auto
integer x = 123
integer y = 216
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "E-mail"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_tipo= 'MAIL'
cb_importa.enabled= true
end event

type gb_tipo from groupbox within w_tipo_lista_auto
integer x = 105
integer y = 56
integer width = 334
integer height = 364
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo lista"
borderstyle borderstyle = stylelowered!
end type

