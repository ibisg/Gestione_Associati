$PBExportHeader$w_badge_sheet.srw
forward
global type w_badge_sheet from w_generica_sheet
end type
end forward

global type w_badge_sheet from w_generica_sheet
integer width = 5947
string menuname = "m_badge_sheet"
event type integer ue_faibadge ( )
event type integer ue_dwselect ( )
end type
global w_badge_sheet w_badge_sheet

type variables
boolean ib_selected
end variables

event type integer ue_faibadge();long ll_idx, ll_row
string ls_nome, ls_localita, ls_codice
s_preview s_preview_s

if uodw_current.Object.DataWindow.QueryMode = "yes" then
	messageBox(this.title, "Prima eseguire l'estrazione", exclamation!)
	return 0
end if

if uodw_current.rowCount()= 0 then
	messageBox(this.title, "Selezionare uno o più nominativi.", exclamation!)
	return -1
end if

//open(w_stampa_badge)
//
//w_stampa_badge.sle_totale.text= "Attendere..."

setPointer(hourglass!)

s_preview_s.doretrieve= false
s_preview_s.ib_dwcreate= false
s_preview_s.ib_anteprima= false
s_preview_s.dataObject= "dw_labels_membri"

if NOT isValid(w_preview_badge) then
	openWithParm(w_preview_badge, s_preview_s)
end if

w_preview_badge.uodw_current.setRedraw(false)

for ll_idx= 1 to uodw_current.rowCount()
	
	if  NOT uodw_current.isSelected(ll_idx) then continue
	
	ls_nome= uodw_current.getItemString(ll_idx, "nome")
		ls_nome += " "+uodw_current.getItemString(ll_idx, "cognome")
	
	ls_codice= string(uodw_current.getItemString(ll_idx, "codice") )
	ls_localita= uodw_current.getItemString(ll_idx, "regione")
	
	ll_row= 	w_preview_badge.uodw_current.insertRow(0)
				w_preview_badge.uodw_current.setItem(ll_row, "cnome", ls_nome)
				w_preview_badge.uodw_current.setItem(ll_row, "codice", ls_codice)
				w_preview_badge.uodw_current.setItem(ll_row, "regione", ls_localita)
	
	ls_nome= ""
	ls_codice= ""
	ls_localita= ""
	
next

// messageBox(this.title, "Inserite "+string(ll_row)+" righe" )

w_preview_badge.uodw_current.setRedraw(true)

if ll_row= 0 then
	messageBox(this.title, "Selezionare uno o più nominativi.", exclamation!)
	return -1
end if

return 0
end event

event type integer ue_dwselect();ib_selected= NOT ib_selected

uodw_current.selectRow(0, ib_selected)

return 0
end event

on w_badge_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_badge_sheet" then this.MenuID = create m_badge_sheet
end on

on w_badge_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_badge_sheet
integer width = 5760
string dataobject = "dw_ricerca_badge"
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
end type

event uodw_current::clicked;call super::clicked;if keyDown(keycontrol!) then
	
	selectRow(row, NOT isSelected(row))
	
end if
end event

event uodw_current::sqlpreview;call super::sqlpreview;integer li_idx
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next				

if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )

if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)
	SetSqlPreview ( sqlsyntax )
end if
end event

