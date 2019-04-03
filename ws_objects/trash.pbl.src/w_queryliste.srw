$PBExportHeader$w_queryliste.srw
forward
global type w_queryliste from w_ricerca_small
end type
type pb_1 from picturebutton within w_queryliste
end type
type st_1 from statictext within w_queryliste
end type
type cb_report from commandbutton within w_queryliste
end type
type rb_doc from radiobutton within w_queryliste
end type
type rb_mail from radiobutton within w_queryliste
end type
type rb_labels from radiobutton within w_queryliste
end type
type gb_tipo from groupbox within w_queryliste
end type
end forward

global type w_queryliste from w_ricerca_small
integer width = 4105
integer height = 2212
boolean clientedge = true
pb_1 pb_1
st_1 st_1
cb_report cb_report
rb_doc rb_doc
rb_mail rb_mail
rb_labels rb_labels
gb_tipo gb_tipo
end type
global w_queryliste w_queryliste

type variables
string is_tipo, is_nodo
dataStore ids_liste_dettaglio
end variables

on w_queryliste.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.cb_report=create cb_report
this.rb_doc=create rb_doc
this.rb_mail=create rb_mail
this.rb_labels=create rb_labels
this.gb_tipo=create gb_tipo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_report
this.Control[iCurrent+4]=this.rb_doc
this.Control[iCurrent+5]=this.rb_mail
this.Control[iCurrent+6]=this.rb_labels
this.Control[iCurrent+7]=this.gb_tipo
end on

on w_queryliste.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.cb_report)
destroy(this.rb_doc)
destroy(this.rb_mail)
destroy(this.rb_labels)
destroy(this.gb_tipo)
end on

event open;call super::open;gs_context= "Liste da report runner"

ids_liste_dettaglio= create dataStore

ids_liste_dettaglio.dataObject= 'ds_liste_dettaglio'

ids_liste_dettaglio.setTransObject(sqlca)

is_nodo= message.stringParm
end event

type dw_current from w_ricerca_small`dw_current within w_queryliste
integer width = 3694
integer height = 2060
string dataobject = "dw_queryliste"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_current::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)

if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where vc_parent like '"+gs_ambito+"%'"
else
	sqlsyntax += " and vc_parent like '"+gs_ambito+"%'"
end if	
	
SetSqlPreview ( sqlsyntax )



end event

type cb_importa from w_ricerca_small`cb_importa within w_queryliste
integer x = 3717
integer y = 1188
integer width = 334
integer height = 112
string text = "Importa"
end type

event cb_importa::clicked;long ll_idx, ll_row
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

for ll_idx= 1 to dw_current.rowCount()
	ll_row= ids_liste_dettaglio.insertRow(0)
	ids_liste_dettaglio.setItem(ll_row, "cod_lista", ls_cod_lista)
	ids_liste_dettaglio.setItem(ll_row, "codice", dw_current.getItemString(ll_idx, "codice"))
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

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_queryliste
integer x = 3717
integer y = 176
integer width = 334
integer height = 112
string text = "Annulla l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_queryliste
integer x = 3717
integer y = 52
integer width = 334
integer height = 112
string text = "Estrazione"
end type

event cb_query::clicked;call super::clicked;cb_importa.enabled= false
end event

type cb_annulla from w_ricerca_small`cb_annulla within w_queryliste
integer x = 3717
integer y = 1948
integer width = 334
integer height = 112
string text = "Chiudi"
end type

type pb_1 from picturebutton within w_queryliste
integer x = 3794
integer y = 404
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
string picturename = "where.bmp"
alignment htextalign = left!
end type

event clicked;s_struttura s_struttura_s
s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s.as_struttura_s.livello= gi_maxlivello
s_assegnastruttura_s.ab_abilitaincolla= true

openWithParm(w_assegna_struttura, s_assegnastruttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn("vc_parent")
dw_current.setText(s_struttura_s.vc_nodo) 

return 0
end event

type st_1 from statictext within w_queryliste
integer x = 3717
integer y = 344
integer width = 334
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
string text = "Ricerca struttura"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_report from commandbutton within w_queryliste
integer x = 3717
integer y = 592
integer width = 334
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Altro report"
end type

event clicked;string ls_reportname

open(w_listObjects)

ls_reportname= message.stringParm

dw_current.DataObject = ls_reportname

dw_current.setTransObject(sqlca)

cb_query.event clicked()
end event

type rb_doc from radiobutton within w_queryliste
integer x = 3735
integer y = 836
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

type rb_mail from radiobutton within w_queryliste
integer x = 3735
integer y = 924
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
string text = "E-mail"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_tipo= 'MAIL'
cb_importa.enabled= true
end event

type rb_labels from radiobutton within w_queryliste
integer x = 3735
integer y = 1012
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

type gb_tipo from groupbox within w_queryliste
integer x = 3717
integer y = 764
integer width = 334
integer height = 364
integer taborder = 60
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

