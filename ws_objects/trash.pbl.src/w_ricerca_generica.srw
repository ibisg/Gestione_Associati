$PBExportHeader$w_ricerca_generica.srw
forward
global type w_ricerca_generica from w_centered
end type
type rb_2 from radiobutton within w_ricerca_generica
end type
type rb_1 from radiobutton within w_ricerca_generica
end type
type pb_struttura from picturebutton within w_ricerca_generica
end type
type cb_ordina from commandbutton within w_ricerca_generica
end type
type sle_struttura from singlelineedit within w_ricerca_generica
end type
type cb_importa from commandbutton within w_ricerca_generica
end type
type cb_dbcancel from commandbutton within w_ricerca_generica
end type
type cb_query from commandbutton within w_ricerca_generica
end type
type cb_annulla from commandbutton within w_ricerca_generica
end type
type uodw_current from uodw_generica within w_ricerca_generica
end type
type gb_1 from groupbox within w_ricerca_generica
end type
end forward

global type w_ricerca_generica from w_centered
integer width = 5083
integer height = 2616
string title = ""
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
boolean center = true
boolean ib_centered = false
rb_2 rb_2
rb_1 rb_1
pb_struttura pb_struttura
cb_ordina cb_ordina
sle_struttura sle_struttura
cb_importa cb_importa
cb_dbcancel cb_dbcancel
cb_query cb_query
cb_annulla cb_annulla
uodw_current uodw_current
gb_1 gb_1
end type
global w_ricerca_generica w_ricerca_generica

type variables
m_preview im_preview
s_assegnastruttura is_assegnastruttura_s

boolean ib_resize= true , ib_dbcancel //, ib_sqluselike, ib_selectrow
s_ricerca is_ricerca_s
s_strade is_strade_s
end variables

event open;call super::open;im_preview= create m_preview

is_assegnastruttura_s.as_struttura_s= message.powerObjectParm

is_assegnastruttura_s.ab_abilitaincolla= true

uodw_current.setRowFocusIndicator(focusRect!)

uodw_current.SetTransObject ( sqlca )

uodw_current.Object.DataWindow.QueryMode= 'yes'

uodw_current.SetFocus ()
end event

event resize;call super::resize;if ib_resize= true then 
	if uodw_current.width>= WorkSpaceWidth ( ) then uodw_current.width= WorkSpaceWidth ( ) 
	uodw_current.height= this.height - 180
end if

// da rivedere se questa finestra è da adoperare come template

//if ib_resize= true then
//	
//	sle_struttura.y= uodw_current.height + 120
//	cb_query.y=  uodw_current.height + 120
//	cb_annulla.y=  uodw_current.height + 120
//	cb_dbcancel.y=  uodw_current.height + 120
//	cb_importa.y=  uodw_current.height + 120
//	
//end if
end event

on w_ricerca_generica.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.pb_struttura=create pb_struttura
this.cb_ordina=create cb_ordina
this.sle_struttura=create sle_struttura
this.cb_importa=create cb_importa
this.cb_dbcancel=create cb_dbcancel
this.cb_query=create cb_query
this.cb_annulla=create cb_annulla
this.uodw_current=create uodw_current
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.pb_struttura
this.Control[iCurrent+4]=this.cb_ordina
this.Control[iCurrent+5]=this.sle_struttura
this.Control[iCurrent+6]=this.cb_importa
this.Control[iCurrent+7]=this.cb_dbcancel
this.Control[iCurrent+8]=this.cb_query
this.Control[iCurrent+9]=this.cb_annulla
this.Control[iCurrent+10]=this.uodw_current
this.Control[iCurrent+11]=this.gb_1
end on

on w_ricerca_generica.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.pb_struttura)
destroy(this.cb_ordina)
destroy(this.sle_struttura)
destroy(this.cb_importa)
destroy(this.cb_dbcancel)
destroy(this.cb_query)
destroy(this.cb_annulla)
destroy(this.uodw_current)
destroy(this.gb_1)
end on

type rb_2 from radiobutton within w_ricerca_generica
integer x = 2103
integer y = 2384
integer width = 338
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per località"
boolean checked = true
end type

event clicked;uodw_current.dataObject= 'dw_ricerca_estesa'

uodw_current.SetTransObject ( sqlca )

uodw_current.Object.DataWindow.QueryMode= 'yes'

uodw_current.SetFocus ()
end event

type rb_1 from radiobutton within w_ricerca_generica
integer x = 1586
integer y = 2384
integer width = 507
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per responsabilità"
end type

event clicked;uodw_current.dataObject= 'dw_responsabili'

uodw_current.SetTransObject ( sqlca )

uodw_current.Object.DataWindow.QueryMode= 'yes'

uodw_current.SetFocus ()
end event

type pb_struttura from picturebutton within w_ricerca_generica
integer x = 3173
integer y = 2344
integer width = 183
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "where.bmp"
alignment htextalign = left!
end type

event clicked;is_assegnastruttura_s.ab_abilitaincolla= true
is_assegnastruttura_s.as_struttura_s.livello= gi_maxlivello - 1

is_assegnastruttura_s.ai_maxlivello= gi_maxlivello
is_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello -1
is_assegnastruttura_s.as_ambito= gs_ambito

uodw_current.uof_struttura(is_assegnastruttura_s)

is_assegnastruttura_s.as_struttura_s= message.powerObjectParm

uodw_current.setColumn("vc_parent")

uodw_current.setText(is_assegnastruttura_s.as_struttura_s.vc_parent)


end event

type cb_ordina from commandbutton within w_ricerca_generica
integer x = 2478
integer y = 2356
integer width = 338
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Ordina"
end type

event clicked;string sort_string

if uodw_current.getRow() = 0 or uodw_current.Object.DataWindow.QueryMode = "yes" then return 0

openWithParm(w_ordina, uodw_current)
	
	sort_string= message.stringParm
	
	if uodw_current.setSort(sort_string) < 0 then
		
		messageBox(parent.title, "I criteri di ordinamento non sono stati correttamente impostati", information!)
											
		return -1
		
	end if
	
uodw_current.sort()

uodw_current.GroupCalc()

return 0
end event

type sle_struttura from singlelineedit within w_ricerca_generica
integer y = 2356
integer width = 1559
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
boolean autohscroll = false
end type

type cb_importa from commandbutton within w_ricerca_generica
integer x = 3360
integer y = 2356
integer width = 338
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Importa"
end type

event clicked;uodw_current.triggerEvent(doubleClicked!)
end event

type cb_dbcancel from commandbutton within w_ricerca_generica
integer x = 4329
integer y = 2356
integer width = 338
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
boolean enabled = false
string text = "Annulla"
end type

event clicked;ib_dbcancel= true
end event

type cb_query from commandbutton within w_ricerca_generica
integer x = 2825
integer y = 2356
integer width = 338
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Estrazione"
boolean default = true
end type

event clicked;long ll_rows

setPointer(hourGlass!)

/*uodw_current*/ parent.setRedraw(false)

ricerca:	if uodw_current.Object.DataWindow.QueryMode= 'yes' then
	
				cb_annulla.enabled= false
				cb_importa.enabled= false
				pb_struttura.enabled= false
			
				uodw_current.acceptText()
				uodw_current.Object.DataWindow.QueryMode= 'no' 
				cb_dbcancel.enabled= true
				ll_rows= uodw_current.retrieve(is_strade_s.cod_com)
				
				cb_dbcancel.enabled= false
				cb_query.text= "Ricerca"
				
				if ll_rows = 0 then
					messageBox(parent.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					uodw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
				cb_importa.enabled= true
				
			else
			//	uodw_current.reset()
				cb_query.text= "Estrazione"
				uodw_current.Object.DataWindow.QueryClear= 'yes'
				uodw_current.Object.DataWindow.QueryMode= 'yes' 
				
				cb_importa.enabled= false
				cb_dbcancel.enabled= false
				pb_struttura.enabled= true
				
				sle_struttura.text= ""
				
		end if

/*uodw_current*/ parent.setRedraw(true)

setPointer(arrow!)

cb_annulla.enabled= true

uodw_current.Object.DataWindow.ReadOnly="No"

uodw_current.setFocus()

end event

type cb_annulla from commandbutton within w_ricerca_generica
integer x = 4677
integer y = 2356
integer width = 338
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;is_ricerca_s.i_retcode= -1

//closeWithReturn(parent, is_ricerca_s)

close(parent)
end event

type uodw_current from uodw_generica within w_ricerca_generica
integer y = 4
integer width = 5010
integer height = 2284
integer taborder = 80
string dataobject = "dw_responsabili"
boolean hsplitscroll = true
boolean ib_isgrid = true
boolean ib_sqluselike = true
boolean ib_allowrowselection = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.enabled= false
im_preview.m_inserisci.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false
im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_ricerca_generica.PointerX(), w_ricerca_generica.PointerY() )
end event

event doubleclicked;call super::doubleclicked;if this.Object.DataWindow.QueryMode = "yes" or this.getRow() <= 0 then return -1
//closeWithReturn(parent, this.getItemString(this.getRow(), "vc_parent")+"."+this.getItemString(this.getRow(), "cognome")	+" "+this.getItemString(this.getRow(), "nome"))

string ls_struttura
ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

SetPointer ( hourglass! )

if ls_struttura <> ""  then
	
	w_ricerca_generica.visible= false
	
	open(w_wait_snoopy)
	
	w_frame_gestioneassociati.SetRedraw ( false )

	w_struttura_tv_tab.tv_struttura.uf_cerca_nodo(ls_struttura)
	
	w_frame_gestioneassociati.SetRedraw ( true )
	
	close(w_wait_snoopy)
	
	setPointer(arrow!)
	
end if
	
end event

event sqlpreview;call super::sqlpreview;if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where vc_parent like '"+gs_ambito+"%'"
else
	sqlsyntax += " and vc_parent like '"+gs_ambito+"%'"
end if	

SetSqlPreview ( sqlsyntax )

if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)
		
	SetSqlPreview ( sqlsyntax )
end if
end event

event rowfocuschanged;call super::rowfocuschanged;if this.getRow() > 0 and this.Object.DataWindow.QueryMode = "no" then
	parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") )		
end if
end event

event retrieveend;call super::retrieveend;this.Object.DataWindow.ReadOnly="Yes"
end event

type gb_1 from groupbox within w_ricerca_generica
integer x = 1568
integer y = 2328
integer width = 896
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo di ricerca"
end type

