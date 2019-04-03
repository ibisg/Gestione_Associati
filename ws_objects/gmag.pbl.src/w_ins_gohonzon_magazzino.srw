$PBExportHeader$w_ins_gohonzon_magazzino.srw
forward
global type w_ins_gohonzon_magazzino from window
end type
type cb_chiudi from commandbutton within w_ins_gohonzon_magazzino
end type
type rb_uscita from radiobutton within w_ins_gohonzon_magazzino
end type
type rb_entrata from radiobutton within w_ins_gohonzon_magazzino
end type
type gb_rb from groupbox within w_ins_gohonzon_magazzino
end type
type uodw_current from uodw_generica within w_ins_gohonzon_magazzino
end type
end forward

global type w_ins_gohonzon_magazzino from window
integer width = 1646
integer height = 2140
boolean titlebar = true
string title = "Ordini"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean center = true
cb_chiudi cb_chiudi
rb_uscita rb_uscita
rb_entrata rb_entrata
gb_rb gb_rb
uodw_current uodw_current
end type
global w_ins_gohonzon_magazzino w_ins_gohonzon_magazzino

type variables
decimal id_id
dataWindowChild idwc_gho, idwc_dip
end variables

forward prototypes
public subroutine wf_updatemag ()
end prototypes

public subroutine wf_updatemag ();integer li_stato, li_qta
string ls_dip_richiedente, ls_dip_mittente, ls_tipo

li_stato= uodw_current.getItemNumber(uodw_current.getRow(), "stato_ordine")

ls_dip_richiedente= uodw_current.getItemString(uodw_current.getRow(), "cod_dip_tgt")

ls_dip_mittente= uodw_current.getItemString(uodw_current.getRow(), "cod_dip_src")

li_qta= uodw_current.getItemNumber(uodw_current.getRow(), "totale")

ls_tipo= uodw_current.getItemString(uodw_current.getRow(), "tipo_goh")

choose case li_stato
			
	case 1 // Aperto
		
		if ls_dip_mittente= s_session_s.cod_dip then // mittente...
			
			update gohonzon_magazzino
			set 	impegnati= :li_qta + impegnati
			where 	cod_dip= :ls_dip_mittente and
						tipo_goh= :ls_tipo;			
			if trap_sql(sqlca, "INSGOHMAG01") < 0 then return			
			
		end if
			
		
	case 2 // Spedito
		
		if ls_dip_mittente= s_session_s.cod_dip then // mittente
			
			update gohonzon_magazzino
			set 	impegnati= impegnati - :li_qta,
					uscita= :li_qta + uscita,
					totale= :li_qta - uscita
			where 	cod_dip= :ls_dip_mittente and
						tipo_goh= :ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG03") < 0 then return	
			
			update gohonzon_magazzino
			set entrata= :li_qta + entrata
			where 	cod_dip= :ls_dip_richiedente and
						tipo_goh= :ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG04") < 0 then return						
			
		end if		
		
	case 3 // Consegnato
		
		if ls_dip_richiedente= s_session_s.cod_dip then // richiedente
			
			update gohonzon_magazzino
			set totale= :li_qta + totale
			where 	cod_dip= :ls_dip_richiedente and
						tipo_goh= :ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG05") < 0 then return	
			
			update gohonzon_magazzino
			set uscita= uscita - :li_qta
			where 	cod_dip= :ls_dip_mittente and
						tipo_goh= :ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG06") < 0 then return					
			
		end if	
		
	case 4 // Evaso... solo richiedente
		
		update gohonzon_magazzino
		set totale=  :li_qta + totale, 
			 entrata= entrata - :li_qta			
		where 	cod_dip= :ls_dip_richiedente and
					tipo_goh= :ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG07") < 0 then return	
		
		update gohonzon_magazzino
		set uscita= uscita - :li_qta
		where 	cod_dip= :ls_dip_mittente and
					tipo_goh= :ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG08") < 0 then return		
		
	case 5 // annullato...
		
		update gohonzon_magazzino
		set impegnati= impegnati - :li_qta
		where 	cod_dip= :ls_dip_mittente and
					tipo_goh= :ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG09") < 0 then return	
				
end choose
	
end subroutine

on w_ins_gohonzon_magazzino.create
this.cb_chiudi=create cb_chiudi
this.rb_uscita=create rb_uscita
this.rb_entrata=create rb_entrata
this.gb_rb=create gb_rb
this.uodw_current=create uodw_current
this.Control[]={this.cb_chiudi,&
this.rb_uscita,&
this.rb_entrata,&
this.gb_rb,&
this.uodw_current}
end on

on w_ins_gohonzon_magazzino.destroy
destroy(this.cb_chiudi)
destroy(this.rb_uscita)
destroy(this.rb_entrata)
destroy(this.gb_rb)
destroy(this.uodw_current)
end on

event open;string ls_dip_richiedente

uodw_current.setTransObject(sqlca)

uodw_current.GetChild('cod_luogo', idwc_gho)
uodw_current.GetChild('cod_dip_tgt', idwc_dip)

idwc_gho.setTransObject(sqlca)
idwc_dip.setTransObject(sqlca)

idwc_gho.retrieve()
idwc_dip.retrieve()

id_id= message.doubleParm


if id_id= 0 then
	
	uodw_current.insertRow(0)
	
	uodw_current.setItem(uodw_current.getRow(), "cod_dip_src", s_session_s.cod_dip)
	uodw_current.setItem(uodw_current.getRow(), "cod_dip_operativa", s_session_s.cod_dip)
	uodw_current.setItem(uodw_current.getRow(), "data_ordine", today())
	
else
	
	gb_rb.enabled= false
	rb_entrata.enabled= false
	rb_uscita.enabled= false
	
	uodw_current.retrieve(id_id)
	
end if


end event

type cb_chiudi from commandbutton within w_ins_gohonzon_magazzino
integer x = 1243
integer y = 1924
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

event clicked;closeWithReturn(parent, 0)
end event

type rb_uscita from radiobutton within w_ins_gohonzon_magazzino
integer x = 965
integer y = 64
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trasferimento"
boolean checked = true
end type

event clicked;uodw_current.setItem(uodw_current.getRow(), "cod_dip_src", s_session_s.cod_dip)
uodw_current.setItem(uodw_current.getRow(), "cod_dip_tgt", 'ND')
end event

type rb_entrata from radiobutton within w_ins_gohonzon_magazzino
integer x = 439
integer y = 68
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carico diretto"
end type

event clicked;uodw_current.setItem(uodw_current.getRow(), "cod_dip_src", "JP")
uodw_current.setItem(uodw_current.getRow(), "cod_dip_tgt", s_session_s.cod_dip)
end event

type gb_rb from groupbox within w_ins_gohonzon_magazzino
integer x = 41
integer width = 1550
integer height = 172
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo transazione"
end type

type uodw_current from uodw_generica within w_ins_gohonzon_magazzino
event type integer ue_gestionestati ( long al_row,  s_gmag as_gmag_s )
integer x = 23
integer y = 204
integer width = 1586
integer height = 1700
integer taborder = 20
string dataobject = "dw_ins_gohonzon_magazzino"
boolean maxbox = false
boolean vscrollbar = false
end type

event type integer ue_gestionestati(long al_row, s_gmag as_gmag_s);integer li_stato, li_qta,li_disponibili
string ls_dip_richiedente, ls_dip_mittente, ls_tipo

choose case as_gmag_s.li_stato
		
	case 0 // in preparazione
		
			/*
			  *esegue un controllo sulla disponibilità...
			  * ma solo se il tipo di transazione è trasferimento.
			  * si assume infatti che nel caso di carico diretto il mittente abbia disponibilità infinita...
			  */
			  
			if  rb_uscita.checked= true then  
		
					select totale - impegnati
					into :li_disponibili
					from gohonzon_magazzino
					where 	cod_dip= :as_gmag_s.ls_dip_mittente and
								tipo_goh= :as_gmag_s.ls_tipo;			
					if trap_sql(sqlca, "INSGOHMAG00") < 0 then return -1
					
					if li_qta > li_disponibili then
						
						messageBox(parent.title, "La quantità richiesta "+"("+string(as_gmag_s.li_qta)+")"+" è maggiore della disponibilità "+"("+string(li_disponibili)+")")
						
						return -1
						
					end if
					
					update gohonzon_magazzino
					set 	impegnati= :as_gmag_s.li_qta + impegnati
					where 	cod_dip= :as_gmag_s.ls_dip_mittente and
								tipo_goh= :as_gmag_s.ls_tipo;			
					if trap_sql(sqlca, "INSGOHMAG01") < 0 then return -1	
					
					this.object.b_invio.visible= false
					this.object.b_annullainvio.visible= false	
					
					this.object.b_m.visible= true		
					
					this.object.qta.protect= 0
					this.object.tipo_goh.protect= 0
					this.object.cod_dip_src.protect= 0
					
					this.Object.qta.Background.Color = gc_bianco		
					this.Object.tipo_goh.Background.Color = gc_bianco		
					this.Object.cod_dip_src.Background.Color = gc_bianco		
				
					this.setItem(al_row, "stato_ordine", 1) // aperto...
					
				else
					
					update gohonzon_magazzino
					set entrata= :as_gmag_s.li_qta + entrata
					where 	cod_dip= :as_gmag_s.ls_dip_richiedente and
								tipo_goh= :as_gmag_s.ls_tipo;
					if trap_sql(sqlca, "UPDGOHMAG04.1") < 0 then return -1			
					
					if sqlca.sqlcode= 0 then // vuol dire che non esiste il record
					
					  INSERT INTO gohonzon_magazzino  
								( cod_dip,   
								  tipo_goh,   
								  impegnati,   
								  entrata,   
								  uscita,   
								  totale,   
								  danneggiati )  
					  VALUES ( :as_gmag_s.ls_dip_richiedente,   
								  :as_gmag_s.ls_tipo,   
								  0,   
								   :as_gmag_s.li_qta,   
								  0,   
								  0,   
								  0 )  ;
								  
					if trap_sql(sqlca, "INSGOHMAG04.2") < 0 then return -1				
					
				end if

					
					this.setItem(al_row, "stato_ordine", 2) // spedito...
					
			end if
		
	case 1 // Aperto
		
		if as_gmag_s.ls_dip_richiedente= s_session_s.cod_dip then // richiedente
		
			this.object.b_invio.visible= false
			this.object.b_annullainvio.visible= false	
			
			this.object.b_m.visible= false		
			
			this.object.qta.protect= 1
			this.object.tipo_goh.protect= 1
			this.object.cod_dip_src.protect= 1
			this.object.cod_dip_tgt.protect= 1
			
			this.Object.qta.Background.Color = gc_bianco		
			this.Object.tipo_goh.Background.Color = gc_bianco		
			this.Object.cod_dip_src.Background.Color = gc_bianco						
		
		else
			
			this.object.b_invio.visible= true
			this.object.b_annullainvio.visible= false	
			
			this.object.b_m.visible= true		
			
			this.object.qta.protect= 0
			this.object.tipo_goh.protect= 0
			this.object.cod_dip_src.protect= 0
			
			this.Object.qta.Background.Color = gc_bianco		
			this.Object.tipo_goh.Background.Color = gc_bianco		
			this.Object.cod_dip_src.Background.Color = gc_bianco				
				
		end if
		
	case 2 // Spedito
		
		if as_gmag_s.ls_dip_richiedente= s_session_s.cod_dip then // se sono il richiedente...
		
			update gohonzon_magazzino
			set 	impegnati= impegnati - :as_gmag_s.li_qta,
					uscita= :as_gmag_s.li_qta + uscita,
					totale= :as_gmag_s.li_qta - uscita
			where 	cod_dip= :as_gmag_s.ls_dip_mittente and
						tipo_goh= :as_gmag_s.ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG03") < 0 then return -1
			
			update gohonzon_magazzino
			set entrata= :as_gmag_s.li_qta + entrata
			where 	cod_dip= :as_gmag_s.ls_dip_richiedente and
						tipo_goh= :as_gmag_s.ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG04") < 0 then return -1						
			
			this.object.b_invio.visible= false
			this.object.b_annullainvio.visible= false			
			this.object.b_accetta.visible= true
			this.object.b_m.visible= false
			
			this.object.qta.protect= 0
			this.object.tipo_goh.protect= 0
			this.object.cod_dip_src.protect= 0		
			
			this.Object.qta.Background.Color = gc_bianco		
			this.Object.tipo_goh.Background.Color = gc_bianco		
			this.Object.cod_dip_src.Background.Color = gc_bianco							
			
		else // se sono il mittente...
			
			this.object.b_invio.visible= false
			this.object.b_annullainvio.visible= true	
			this.object.b_accetta.visible= false
			this.object.b_m.visible= false
			
			this.object.qta.protect= 0
			this.object.tipo_goh.protect= 1
			this.object.cod_dip_src.protect= 1		
			
			this.Object.qta.Background.Color = gc_buttonface		
			this.Object.tipo_goh.Background.Color = gc_buttonface		
			this.Object.cod_dip_src.Background.Color = gc_buttonface					
			
		end if		
		
	case 3 // Consegnato
		
		if as_gmag_s.ls_dip_richiedente= s_session_s.cod_dip then //  se sono il  richiedente...
		
			update gohonzon_magazzino
			set totale= :as_gmag_s.li_qta + totale
			where 	cod_dip= :as_gmag_s.ls_dip_richiedente and
						tipo_goh= :as_gmag_s.ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG05") < 0 then return -1	
			
			// solo se non è carico diretto 
			
			update gohonzon_magazzino
			set uscita= uscita - :as_gmag_s.li_qta
			where 	cod_dip= :as_gmag_s.ls_dip_mittente and
						tipo_goh= :as_gmag_s.ls_tipo;
			if trap_sql(sqlca, "INSGOHMAG06") < 0 then return -1
			
			this.object.b_invio.visible= false
			this.object.b_annullainvio.visible= false	
			this.object.b_accetta.visible= true
			this.object.b_m.visible= false	
						
		else //  se sono il  mittente...
			
			this.object.b_invio.visible= false
			this.object.b_annullainvio.visible= false				
			this.object.b_accetta.visible= false
			this.object.b_m.visible= false			
			
		end if
		
		this.object.qta.protect= 1
		this.object.tipo_goh.protect= 1
		this.object.cod_dip_src.protect= 1
		
		this.Object.qta.Background.Color = gc_buttonface		
		this.Object.tipo_goh.Background.Color = gc_buttonface		
		this.Object.cod_dip_src.Background.Color = gc_buttonface		
		
	case 4 // Evaso... solo richiedente
		
		update gohonzon_magazzino
		set totale=  :as_gmag_s.li_qta + totale, 
			 entrata= entrata - :as_gmag_s.li_qta			
		where 	cod_dip= :as_gmag_s.ls_dip_richiedente and
					tipo_goh= :as_gmag_s.ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG07") < 0 then return -1	
		
		update gohonzon_magazzino
		set uscita= uscita - :as_gmag_s.li_qta
		where 	cod_dip= :as_gmag_s.ls_dip_mittente and
					tipo_goh= :as_gmag_s.ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG08") < 0 then return -1		
			
		this.object.b_invio.visible= false
		this.object.b_annullainvio.visible= false	
		this.object.b_accetta.visible= false
		this.object.b_m.visible= true
		
		this.object.qta.protect= 1
		this.object.tipo_goh.protect= 1
		this.object.cod_dip_src.protect= 1
			
		this.Object.qta.Background.Color = gc_buttonface		
		this.Object.tipo_goh.Background.Color = gc_buttonface		
		this.Object.cod_dip_src.Background.Color = gc_buttonface		
		
		
	case 5 // annullato...
		
		this.deleteRow(al_row)	
		
		update gohonzon_magazzino
		set impegnati= impegnati - :as_gmag_s.li_qta
		where 	cod_dip= :as_gmag_s.ls_dip_mittente and
					tipo_goh= :as_gmag_s.ls_tipo;
		if trap_sql(sqlca, "INSGOHMAG09") < 0 then return -1	
				
end choose

return 0
	
	
end event

event buttonclicked;
// non esegue la script ancestor

if row <= 0 then return

decimal ld_id
integer li_stato, li_qta,li_disponibili
string ls_dip_richiedente, ls_dip_mittente, ls_tipo
s_gmag s_gmag_s

s_gmag_s.ld_id= this.getItemDecimal(row, "id")

s_gmag_s.li_stato= this.getItemNumber(row, "stato_ordine")

s_gmag_s.ls_dip_richiedente= this.getItemString(row, "cod_dip_tgt")

s_gmag_s.ls_dip_mittente= this.getItemString(row, "cod_dip_src")

s_gmag_s.li_qta= this.getItemNumber(row, "qta")

s_gmag_s.ls_tipo= this.getItemString(row, "tipo_goh")


this.setRedraw(false)

choose case dwo.name
		
	case "b_aggiorna"
		
//		this.ue_bottoni(row)
//
//		if this.uof_aggiorna() < 0 then return
		
	case "b_invio"
		
		if messageBox(parent.title, "Confermi l'invio?", question!, yesNo!, 2)= 2 then return -1
		
		this.setItem(row, "stato_ordine", 2) // inviato...
		
	case "b_annullainvio"
		
		if messageBox(parent.title, "L'invio verrà annullato. Confermi?", question!, yesNo!, 2)= 2 then return -1
		
		this.setItem(row, "stato_ordine", 1) // aperto...	
			
	case "b_m"
			
			if messageBox(parent.title, "La richiesta verrà annullata. Confermi?", question!, yesNo!, 2)= 2 then return -1
			
			this.setItem(row, "stato_ordine", 5) // annullato...
			
		case "b_accetta"
		
			if messageBox(parent.title, "La consegna verrà accettata. Confermi?", question!, yesNo!, 2)= 2 then return -1		
			
			this.setItem(row, "stato_ordine", 4) // evaso...
		
end choose

s_gmag_s.ld_id= this.getItemDecimal(row, "id")

s_gmag_s.li_stato= this.getItemNumber(row, "stato_ordine")

s_gmag_s.ls_dip_richiedente= this.getItemString(row, "cod_dip_tgt")

s_gmag_s.ls_dip_mittente= this.getItemString(row, "cod_dip_src")

s_gmag_s.li_qta= this.getItemNumber(row, "qta")

s_gmag_s.ls_tipo= this.getItemString(row, "tipo_goh")

if this.event ue_gestionestati(row, s_gmag_s)= 0 then

	if this.uof_aggiorna() < 0 then return
	
end if

closeWithReturn(parent, s_gmag_s.ld_id)		
	
		
		
end event

event itemfocuschanged;call super::itemfocuschanged;if dwo.name= "totale" then this.selectText(1, Len(this.GetText()))
end event

event getfocus;call super::getfocus;gb_rb.enabled= false
rb_entrata.enabled= false
rb_uscita.enabled= false
end event

event retrieveend;call super::retrieveend;//this.event ue_gestionestati(uodw_current.getRow() , s_gmag_s) 
end event

