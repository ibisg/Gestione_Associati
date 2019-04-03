$PBExportHeader$uodw_anag.sru
forward
global type uodw_anag from uodw_generica
end type
end forward

global type uodw_anag from uodw_generica
end type
global uodw_anag uodw_anag

type variables
u_ds_com ids_com
end variables

event itemchanged;call super::itemchanged;//this.object.b_aggiorna.visible= '1'
//
//integer i_err, li_exists, li_ret
//long ll_rows
//boolean first_time = true
//string ls_data, search_string, old_comune, ls_nuovaOrganizzazione
//
//if row > 0 then
//	
//	data = trim ( data )
//	
//	old_comune= data
//
//	CHOOSE CASE dwo.name
//			
//		case "cap_dom"
//		
//		this.Object.cap_dom.Protect=1
//			
//		CASE "comune"
//			
//			s_strade s_strade_s
//			
//			s_strade_s.comune= trim(data)
//			
//			/*s_strade_s=*/ f_cap(s_strade_s)
//			
//			choose case s_strade_s.return_code
//					
//				case 0
//					
//					messageBox(this.title, "Operazione annullata.", information!)
//					
//					li_ret= 0
//					
//				case -1
//					
//					li_ret= 1
//					
//				case 1
//					
//					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
//					
//					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
//					i_err= this.setText ( s_strade_s.comune )
//					
//					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
//					
//					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//					
//					i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
//					
//					this.setColumn("pres_da")
//								
//					li_ret=0// 2
//					
//				case 2
//								
//					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
//					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
//					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
//					//i_err= this.SetItem ( row, "comune", s_strade_s.comune )
//					//i_err= this.setText ( s_strade_s.comune )
//					data= s_strade_s.comune
//					
//					//this.setColumn("ind_dom")
//					
//					//return 2
//					
//					li_ret= 2  //0
//					
//			end choose
//			
//			return li_ret
//			
//		CASE "data_nas"
//			
//			if f_min ( data ) = 1 then
//				if MessageBox ( "Inserimento", "E' consentito inserire minorenni solo con il consenso dei genitori."+&
//														"~nAbbiamo il modulo di consenso firmato da ambedue i genitori?" , question!, yesNo!, 2)= 2 then
//					return 1
//				else
//					return 0
//				end if
//			end if
//
//	END CHOOSE
//	
//end if
//
////return 0
//
end event

on uodw_anag.create
call super::create
end on

on uodw_anag.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_com= create u_ds_com
ids_com.setTransObject(sqlca)

end event

event retrieveend;call super::retrieveend;string ls_struttura

if this.getRow() <= 0 then return -1

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cstruttura", ls_struttura)

this.object.b_aggiorna.visible= '0'

this.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

