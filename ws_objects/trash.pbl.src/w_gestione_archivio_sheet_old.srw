$PBExportHeader$w_gestione_archivio_sheet_old.srw
forward
global type w_gestione_archivio_sheet_old from window
end type
type dw_current from datawindow within w_gestione_archivio_sheet_old
end type
end forward

global type w_gestione_archivio_sheet_old from window
integer width = 2697
integer height = 1408
boolean titlebar = true
string menuname = "m_gestione_archivio_sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
boolean clientedge = true
event type integer ue_insert ( )
event type s_action ue_action ( boolean ab_query_mode )
event type integer ue_delete ( )
event type integer ue_update ( )
event type integer ue_close ( )
event type integer ue_stampa ( )
event type integer ue_insertend ( long ll_newrow )
event type long ue_myretrieve ( )
event ue_reset ( )
event type integer ue_undo ( )
event type integer ue_dbcancel ( )
event type integer ue_actionend ( boolean ab_search )
event type integer ue_queryon ( )
event type integer ue_ordina ( )
event type integer ue_salva_come ( )
event ue_exporttoexcel ( )
event ue_selectall ( )
dw_current dw_current
end type
global w_gestione_archivio_sheet_old w_gestione_archivio_sheet_old

type variables
boolean ib_dbcancel= false // se true interrompe la query in corso
boolean ib_centered= false // se true fa in modo che la finestra sia centrata rispetto allo schermo
boolean ib_selected
/*
 *  La variabile booleana ib_dw_query_mode indica la modalità di funzionamento della data window (dw_current) in questa finestra: 
 * il valore di false indica che la dw non è in query mode, tipicamente dopo un'estrazione,
 * il valore di true indica che la dw è in query mode e quindi è pronta ad accettare degli argomenti da utilizzare come criteri di ricerca.
 * N.B. la variabile che in realtà va utilizzata per dare la modalità iniziale di funzionamento è la ib_search che è una variabile di istanza
 * di m_gestione_archivio_sheet; cioè ib_dw_query_mode è dipendente da ib_search.
 */
boolean ib_dw_query_mode= false

s_action s_action_s
end variables

forward prototypes
public function integer wf_modwarning (ref datawindow dw_arg)
public function integer wf_center ()
end prototypes

event ue_insert;long ll_ret

if wf_modwarning(dw_current) = 1 then return -1

ll_ret= dw_current.insertRow(0)
dw_current.scrollToRow(ll_ret)
dw_current.setColumn(1)
event post ue_insertend(ll_ret)
dw_current.setFocus()
return 0


end event

event type s_action ue_action(boolean ab_query_mode);long ll_rows= 0

if wf_modwarning(dw_current) = 1 then
	s_action_s.ll_ret= -1
	goto uscita
end if

ib_dbcancel= false

if   ab_query_mode /*ib_dw_query_mode */ = false  then
	//dw_current.reset()
	dw_current.Object.DataWindow.QueryClear= 'yes'
	dw_current.setTransObject(sqlca)
	dw_current.Object.DataWindow.QueryMode= 'yes'
	
		event ue_queryon()
		
		event ue_actionend(ab_query_mode)
	
	s_action_s.ll_ret= 0
else
	dw_current.Object.DataWindow.QueryMode= 'no'
	open(w_wait_annulla)
	s_action_s.ll_rows= dw_current.retrieve()
	close(w_wait_annulla)
	if  s_action_s.ll_rows= 0 then
		messageBox(this.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
		dw_current.reset()
	else
		event ue_actionend(ab_query_mode)
	end if
	
end if

uscita:

s_action_s.lb_search= NOT ab_query_mode

//ib_dw_query_mode= NOT ib_dw_query_mode

return s_action_s
end event

event ue_delete;
// ritorna 	1 se la cancellazione è andata a buon fine, 
// 			0 se c.s. + se non ci sono altre righe da cancellare, 
// 		    -1 se la cancellazione non è andata a buon fine.
integer li_ret
li_ret= dw_current.deleteRow(0)
if li_ret < 0 then return -1
if dw_current.rowCount()= 0 then
	return 0
else
	return 1
end if

end event

event type integer ue_update();if checknull (dw_current) < 0 then return -1

dw_current.setTransObject(sqlca)

integer li_ret

li_ret= dw_current.update()

if li_ret < 0 then return -2

// se a seguito di una cancellazione non vi sono più record nella dw ritorna 2

if dw_current.rowCount()= 0 then return 2

return 0
end event

event ue_close;return close(this)
end event

event ue_stampa;	return OpenWithParm ( w_dw_print_options, this.dw_current )
end event

event ue_myretrieve;return dw_current.retrieve()
end event

event ue_undo;dw_current.acceptText()
if dw_current.getItemStatus(dw_current.getRow(), 0, primary!) = New!  OR &
		dw_current.getItemStatus(dw_current.getRow(), 0, primary!) = dataModified! then
	return dw_current.ReselectRow(dw_current.getRow() )
else
	return 0
end if


end event

event ue_dbcancel;ib_dbcancel= true

return 0
end event

event type integer ue_ordina();/*
 * Se non siamo in query mode e se il presentation style della dw e' "grid"...
 */

if s_action_s.lb_search= false /* and &
		dw_current.Object.DataWindow.Processing = "1"*/ then

	string sort_string
	
	openWithParm(w_ordina, dw_current)
		
		sort_string= message.stringParm
		
		if dw_current.setSort(sort_string) < 0 then
			
			messageBox(this.title, "I criteri di ordinamento non sono~n~n"+&
												"stati correttamente impostati", exclamation!)
												
			return -1
			
		end if
		
	dw_current.sort()
	
	dw_current.GroupCalc()

end if

return 0
end event

event ue_salva_come;return dw_current.saveAs()
end event

event ue_exporttoexcel();nca_excel lnca_excel

lnca_excel.exportData(dw_current, dw_current.rowCount())
end event

event ue_selectall();ib_selected= NOT ib_selected

dw_current.selectRow(0, ib_selected)
end event

public function integer wf_modwarning (ref datawindow dw_arg);DwItemStatus lc_status
integer li_ret

li_ret= dw_arg.acceptText()

if dw_arg.object.datawindow.queryMode= 'yes'  then return 0

if dw_arg.modifiedCount() > 0 OR dw_arg.deletedCount() > 0 then 

	li_ret= messageBox(this.title, "Sono stati modificati dei dati. Li vuoi salvare?", question!, yesNoCancel!, 3)
	
	if li_ret= 3 then return 1
	if li_ret= 1 then
		if event ue_update() < 0 then
			rollback;
			messageBox(this.title, "Salvataggio non riuscito.", exclamation!)
			return 1
		else
			commit;
		end if
	end if
end if

return 0
end function

public function integer wf_center ();//*-----------------------------------------------------------------*/
//*    f_Center:  Center the window
//*-----------------------------------------------------------------*/
int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

/*  Check for a window association with this object  */
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

/*  Get environment  */
If GetEnvironment ( lenv_obj ) = -1 Then Return -1

/*  Determine current screen resolution and validate  */
li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

/*  Get center points  */
If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth / 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( li_screenheight / 2 ) - ( this.Height / 2 )
End If

/*  Center window  */
li_rc = this.Move ( li_x, li_y )
If li_rc <> 1 Then Return -1

Return 1
end function

event open;if ib_centered then wf_center()
dw_current.setRowFocusIndicator(focusRect!)
dw_current.setTransObject(sqlca)
end event

on w_gestione_archivio_sheet_old.create
if this.MenuName = "m_gestione_archivio_sheet" then this.MenuID = create m_gestione_archivio_sheet
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_gestione_archivio_sheet_old.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_current)
end on

event closequery;return wf_modwarning(dw_current)
			
			
end event

event resize;dw_current.width= this.width - 120
dw_current.height= this.height -180
end event

type dw_current from datawindow within w_gestione_archivio_sheet_old
integer x = 32
integer y = 32
integer width = 2455
integer height = 780
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;long l_beforeRow

choose case sqldbcode

	case 2601

		messageBox(parent.title+" - Errore DB: "+string(sqldbcode), &
					  "E' stato inserito un record gia' esistente in base dati~n~n"+&
					  sqlerrtext, &
					  stopsign! )
					  
	case 999

		messageBox(parent.title, "L'operazione e' stata annullata")
				  
	case 547 

		messageBox(parent.title+" - Codice DB: "+string(sqldbcode), &
					  "La cancellazione non e' possibile.~n"+&
					  "Cancellare prima le entita' dipendenti.",&
						exclamation! )
						
		l_beforeRow= this.getRow()
		
		if l_beforeRow= 0 then l_beforeRow= 1
						
		this.RowsMove(1, this.DeletedCount(), Delete!, this, l_beforeRow, Primary!)
					
	case 247

		messageBox(parent.title+" - Codice DB: "+string(sqldbcode), &
					  "Formato dati non corretto,~n",&
						stopsign! )
						
	case is > 30000
		
		messageBox(parent.title+" - Codice DB: "+string(sqldbcode), &
					  sqlerrtext, exclamation! )
					  
		l_beforeRow= this.getRow()
		
		if l_beforeRow= 0 then l_beforeRow= 1
					  
		this.RowsMove(1, this.DeletedCount(), Delete!, this, l_beforeRow, Primary!) 

	case else

		messageBox(parent.title+" - Codice DB: "+string(sqldbcode), sqlerrtext, stopsign! )


end choose

rollback;

return 1
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)

SetSqlPreview ( sqlsyntax)
end event

event itemerror;return 1
end event

event itemchanged;if row <= 0 then return 0

if NOT m_gestione_archivio_sheet.m_gestionearchivio.m_salva.enabled and &
											this.Object.DataWindow.QueryMode = "no" then m_gestione_archivio_sheet.m_gestionearchivio.m_salva.enabled= true

return 0
end event

event editchanged;if row <= 0 then return 0

if NOT m_gestione_archivio_sheet.m_gestionearchivio.m_salva.enabled and &
											this.Object.DataWindow.QueryMode = "no" then
	m_gestione_archivio_sheet.m_gestionearchivio.m_salva.enabled= true
	m_gestione_archivio_sheet.m_gestionearchivio.m_undo.enabled= true
end if
return 0
end event

event retrieverow;yield()

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

