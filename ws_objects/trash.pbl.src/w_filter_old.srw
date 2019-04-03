$PBExportHeader$w_filter_old.srw
forward
global type w_filter_old from window
end type
type cb_annulla from commandbutton within w_filter_old
end type
type cb_applica from commandbutton within w_filter_old
end type
type sle_filter from singlelineedit within w_filter_old
end type
type cb_cancella from commandbutton within w_filter_old
end type
type dw_current from datawindow within w_filter_old
end type
type cb_verifica from commandbutton within w_filter_old
end type
end forward

global type w_filter_old from window
integer x = 832
integer y = 360
integer width = 2661
integer height = 1468
boolean titlebar = true
string title = "Definizione filtro"
windowtype windowtype = response!
long backcolor = 81324524
string icon = "DataPipeline!"
boolean clientedge = true
cb_annulla cb_annulla
cb_applica cb_applica
sle_filter sle_filter
cb_cancella cb_cancella
dw_current dw_current
cb_verifica cb_verifica
end type
global w_filter_old w_filter_old

type variables
string filter_string

dataWindow dw_passed

dataWindowChild idw_ncolonna

long sel_index
end variables

event open;

uint how_many, idx

integer i_ret, i_num

string col_name, col_testata

dw_passed= message.powerObjectParm

dw_current.GetChild('num_col', idw_ncolonna)

how_many= integer(dw_passed.object.dataWindow.column.count)

for idx= 1 to how_many
	
	col_name= dw_passed.describe("#"+string(idx)+".name")
	
	col_testata= dw_passed.describe(col_name+"_t.Text")
	
	if trim(dw_passed.describe(col_name+"_t.Type")) <> "!" then
	
		i_num++	
		idw_ncolonna.insertRow(0)
		idw_ncolonna.setItem(i_num, "numcolonna", idx)
//		idw_ncolonna.setItem(i_num, "numcolonna_src", idx)		
		idw_ncolonna.setItem(i_num, "ncolonna", col_testata)
		
	end if
	
next

dw_current.insertRow(0)
end event

on w_filter_old.create
this.cb_annulla=create cb_annulla
this.cb_applica=create cb_applica
this.sle_filter=create sle_filter
this.cb_cancella=create cb_cancella
this.dw_current=create dw_current
this.cb_verifica=create cb_verifica
this.Control[]={this.cb_annulla,&
this.cb_applica,&
this.sle_filter,&
this.cb_cancella,&
this.dw_current,&
this.cb_verifica}
end on

on w_filter_old.destroy
destroy(this.cb_annulla)
destroy(this.cb_applica)
destroy(this.sle_filter)
destroy(this.cb_cancella)
destroy(this.dw_current)
destroy(this.cb_verifica)
end on

type cb_annulla from commandbutton within w_filter_old
integer x = 2167
integer y = 1196
integer width = 306
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type cb_applica from commandbutton within w_filter_old
integer x = 1253
integer y = 1196
integer width = 306
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "A&pplica"
boolean default = true
end type

event clicked;//dw_passed.setFilter(filter_string)

closeWithReturn(parent, filter_string)

//close(parent)
end event

type sle_filter from singlelineedit within w_filter_old
integer x = 18
integer y = 976
integer width = 2578
integer height = 192
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 81324524
boolean autohscroll = false
boolean displayonly = true
end type

type cb_cancella from commandbutton within w_filter_old
integer x = 1856
integer y = 1196
integer width = 306
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Ca&ncella riga"
end type

event clicked;dw_current.deleteRow(dw_current.getRow())

if dw_current.rowCount()= 0 then
	cb_verifica.enabled= false
	cb_cancella.enabled= false
	cb_applica.enabled= false
end if
end event

type dw_current from datawindow within w_filter_old
integer x = 18
integer y = 16
integer width = 2578
integer height = 940
integer taborder = 20
string dataobject = "dw_set_filter"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemerror;return 1
end event

event rowfocuschanged;if rowCount()= 0 then
	parent.cb_verifica.enabled= false
	parent.cb_cancella.enabled= false
//	parent.cb_applica.enabled= false
else
	parent.cb_verifica.enabled= true
	parent.cb_cancella.enabled= true
//	parent.cb_applica.enabled= true
end if
end event

event itemchanged;if dwo.name= "logici" then this.insertRow(0)
end event

type cb_verifica from commandbutton within w_filter_old
integer x = 942
integer y = 1196
integer width = 306
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "&Verifica"
end type

event clicked;string colonna, col_name, operatore, confronto, logici, col_type

long idx

int num_col, num_col_src

filter_string= ""

dw_current.acceptText()

for idx= 1 to dw_current.rowCount()
	
	num_col= dw_current.getItemNumber(idx, "num_col")
//	num_col_src= dw_current.getItemNumber(idx, "num_col_src")

//	col_name= dw_current.Describe("Evaluate ('LookUpDisplay(num_col) ',  "+string(idx)+")") // trim(dw_current.getItemString(idx, "colonna"))
	
	operatore= trim(dw_current.getItemString(idx, "operatore"))
	
	confronto= trim(dw_current.getItemString(idx, "confronto"))
	
		if isNull(confronto) then confronto=""

col_name= dw_passed.describe("#"+string(num_col)+".name")	
//	col_name= dw_passed.describe("#"+string(num_col)+".name")
//col_name= dw_current.describe("#"+string(num_col)+".name")
	
	col_type= dw_passed.describe(col_name+".colType")
	
//	col_type= trim(dw_passed.describe(col_name+"_t.Type"))

choose case mid(col_type, 1, 4)
		
	case "char"
		
		confronto="'"+confronto+"'"
		
	case "date"
		
		confronto="datetime('"+confronto+"')"
		
end choose
	
//	if col_type= "datetime" then
//		
//		confronto="datetime('"+confronto+"')"
//		
//		
//	end if
	
	logici= trim(dw_current.getItemString(idx, "logici"))
	
	if isNull(logici) then logici=" "
	
		filter_string+= col_name+" "+operatore+" "+confronto+" "+logici+" "
	
next

if filter_string= "" or isNull(filter_string) then
	messageBox(parent.title, "Devono prima essere impostati i criteri.", information!)	
	return -1
end if

sle_filter.text= filter_string

if dw_passed.setFilter(filter_string) < 0 then
	
	cb_applica.enabled= false
	
	messageBox(parent.title, "I criteri non sono stati impostati correttamente", exclamation!)
	
else
	
	cb_applica.enabled= true
	
end if
end event

