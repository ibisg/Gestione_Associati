$PBExportHeader$w_stampa_diplomi_sheet.srw
forward
global type w_stampa_diplomi_sheet from w_generica_sheet
end type
end forward

global type w_stampa_diplomi_sheet from w_generica_sheet
integer width = 3886
string title = "Liste esami e diplomi"
string menuname = "m_genericodiplomi_sheet"
event ue_diplomi ( )
event use_select ( )
end type
global w_stampa_diplomi_sheet w_stampa_diplomi_sheet

event ue_diplomi();integer li_ret
long ll_idx, ll_row, ll_pos
string ls_nome, ls_esito, ls_div

messageBox(this.title, "I singoli diplomi verranno generati solo in caso di esito positivo dell'esame", information!)

open (w_diplomi)

li_ret= messageBox("Seleziona il modello", "Vuoi utilizzare il modello nuovo?", Question!, YesNo!, 1)

if li_ret= 1 then w_diplomi.uodw_diplomi.dataObject= "dw_diplomi_europanew"

for ll_idx= 1 to uodw_current.rowCount()
	
	if NOT uodw_current.isSelected(ll_idx) then continue
	
	ls_esito= uodw_current.getItemString(ll_idx, "esito")
	
	if ls_esito <> "P" then continue
	
	ll_row= w_diplomi.uodw_diplomi.insertRow(0)
	
	open(w_wait_meter)
	
	w_wait_meter.hpb_meter.position= (ll_idx/uodw_current.rowCount())*100
	
	w_diplomi.uodw_diplomi.setItem(ll_row, "data_esame", uodw_current.getItemdatetime(ll_idx, "data_esame") )
	w_diplomi.uodw_diplomi.setItem(ll_row, "livello", uodw_current.getitemString(ll_idx, "cod_studio") )
	
	ls_nome= trim(uodw_current.getItemString(ll_idx, "nome"))+" "+trim(uodw_current.getItemString(ll_idx, "cognome"))
	
	ls_div= uodw_current.getItemString(ll_idx, "cod_div")
	
	ls_nome= f_iniziali(ls_nome)
	
	w_diplomi.uodw_diplomi.setItem(ll_row, "cognomenome",  ls_nome )	
	
	w_diplomi.uodw_diplomi.setItem(ll_row, "cod_div",  ls_div )	
	
next

close(w_wait_meter)

if ll_row= 0 then
	
	messageBox(this.title, "Selezionare almeno una riga.", information!)
	//close(this)
	
end if

return
end event

on w_stampa_diplomi_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_genericodiplomi_sheet" then this.MenuID = create m_genericodiplomi_sheet
end on

on w_stampa_diplomi_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_stampa_diplomi_sheet
string dataobject = "dw_sel_aventidiritto"
boolean ib_allowstop = true
boolean ib_sqluselike = true
end type

event uodw_current::rowfocuschanged;call super::rowfocuschanged;if lower(this.Object.DataWindow.QueryMode)= 'no'  and this.getRow() > 0 then
	
//	f_select_current_row(this)
	
	setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
	
end if
end event

event uodw_current::clicked;call super::clicked;if keyDown(keycontrol!) then
	
	selectRow(row, NOT isSelected(row))
	
end if
end event

event uodw_current::retrieveend;call super::retrieveend;//this.Object.DataWindow.ReadOnly="Yes"
end event

