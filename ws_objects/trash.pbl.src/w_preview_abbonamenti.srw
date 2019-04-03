$PBExportHeader$w_preview_abbonamenti.srw
forward
global type w_preview_abbonamenti from w_preview
end type
end forward

global type w_preview_abbonamenti from w_preview
boolean ib_esportadw = true
event type long ue_postopen ( )
end type
global w_preview_abbonamenti w_preview_abbonamenti

event type long ue_postopen();dataStore lds_report_abbonamenti
integer li_ret
long ll_idx, ll_idx_1, ll_rows, ll_nr= 0, ll_bs= 0, ll_ivc= 0
string ls_nodo

lds_report_abbonamenti= create datastore
lds_report_abbonamenti.dataObject= 'ds_report_abbonamenti'

lds_report_abbonamenti.setTransObject(sqlca_ediz)

this.setRedraw(false)

for ll_idx= 1 to uodw_current.rowCount()
	
	ls_nodo= uodw_current.getItemString(ll_idx, "vc_nodo")

	ll_rows= lds_report_abbonamenti.retrieve(ls_nodo)
	
	for ll_idx_1= 1 to ll_rows
		
		choose case  lds_report_abbonamenti.getItemNumber(ll_idx_1, "tipo_riv")
				
			case 0
				
				ll_nr= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")
				
			case 500
				
				ll_ivc= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")		
				
			case 1000
				
				
				ll_bs= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")
				
				
		end choose	
		
	next
	
	li_ret= uodw_current.setItem(ll_idx, "nr",  ll_nr)
	li_ret= uodw_current.setItem(ll_idx, "bs", ll_bs)
	li_ret= uodw_current.setItem(ll_idx, "ivc", ll_ivc)
	
	li_ret= uodw_current.setItem(ll_idx, "intestazione", w_struttura_tv_tab.tv_struttura.is_struttura_s.descrizione_livello+" "+ w_struttura_tv_tab.tv_struttura.is_struttura_s.descrizione_struttura)

next

this.setRedraw(true)


return ll_rows
end event

on w_preview_abbonamenti.create
call super::create
end on

on w_preview_abbonamenti.destroy
call super::destroy
end on

event open;call super::open;event post ue_postopen()
end event

type uodw_current from w_preview`uodw_current within w_preview_abbonamenti
string dataobject = "dw_test_report_riviste"
end type

event uodw_current::retrievestart;call super::retrievestart;return 2 // append delle righe estratte
end event

event uodw_current::retrieveend;call super::retrieveend;//dataStore lds_report_abbonamenti
//integer li_ret
//long ll_idx, ll_idx_1, ll_rows, ll_nr= 0, ll_bs= 0, ll_ivc= 0
//string ls_nodo
//
//lds_report_abbonamenti= create datastore
//lds_report_abbonamenti.dataObject= 'ds_report_abbonamenti'
//
//lds_report_abbonamenti.setTransObject(sqlca)
//
//for ll_idx= 1 to this.rowCount()
//	
//	ls_nodo= uodw_current.getItemString(ll_idx, "vc_nodo")
//
//	ll_rows= lds_report_abbonamenti.retrieve(ls_nodo)
//	
//	for ll_idx_1= 1 to ll_rows
//		
//		choose case  lds_report_abbonamenti.getItemNumber(ll_idx_1, "tipo_riv")
//				
//			case 0
//				
//				ll_nr= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")
//				
//			case 500
//				
//				ll_ivc= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")		
//				
//			case 1000
//				
//				
//				ll_bs= lds_report_abbonamenti.getItemNumber(ll_idx_1, "tot_riviste")
//				
//				
//		end choose	
//		
//	next
//	
//	li_ret= this.setItem(ll_idx, "nr",  ll_nr)
//	li_ret= this.setItem(ll_idx, "bs", ll_bs)
//	li_ret= this.setItem(ll_idx, "ivc", ll_ivc)
//
//next
//
//return ll_rows
end event

