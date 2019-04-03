$PBExportHeader$w_gestioneaccessoremoto_new.srw
forward
global type w_gestioneaccessoremoto_new from window
end type
type cb_chiudi from commandbutton within w_gestioneaccessoremoto_new
end type
type uodw_current from uodw_generica within w_gestioneaccessoremoto_new
end type
end forward

global type w_gestioneaccessoremoto_new from window
integer width = 1541
integer height = 2068
boolean titlebar = true
string title = "Gestione utenti"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
uodw_current uodw_current
end type
global w_gestioneaccessoremoto_new w_gestioneaccessoremoto_new

type variables
integer ii_max_livello
string is_codice
dataWindowChild idwc_strutturalivelli
end variables

event open;long ll_row
string ls_max_cod_att

is_codice= message.stringParm

uodw_current.getChild("livello_statistica", idwc_strutturalivelli)

uodw_current.setTransObject(sqlca)
idwc_strutturalivelli.setTransObject(sqlca)

select
	case when
		cod_att_ist_1>cod_att_ist_2 then
		cod_att_ist_1 
	else
		cod_att_ist_2
	end
	into :ls_max_cod_att
	 from membri_gerarchica
	where codice= :is_codice;
	
	select livello
	into :ii_max_livello
	from att_ist
where cod_att_ist= :ls_max_cod_att;

ll_row= idwc_strutturalivelli.retrieve()

ll_row= uodw_current.retrieve(is_codice)

if ll_row= 0 then
	uodw_current.insertRow(0)
	uodw_current.setItem(uodw_current.getRow(), "codice", is_codice)
end if
end event

on w_gestioneaccessoremoto_new.create
this.cb_chiudi=create cb_chiudi
this.uodw_current=create uodw_current
this.Control[]={this.cb_chiudi,&
this.uodw_current}
end on

on w_gestioneaccessoremoto_new.destroy
destroy(this.cb_chiudi)
destroy(this.uodw_current)
end on

event closequery;if uodw_current.uof_modificheincorso()= 3 /* annulla */ then return 1

return 0
end event

type cb_chiudi from commandbutton within w_gestioneaccessoremoto_new
integer x = 585
integer y = 1816
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type uodw_current from uodw_generica within w_gestioneaccessoremoto_new
integer width = 1509
integer height = 1796
integer taborder = 10
string dataobject = "dw_gestioneaccessoremoto_new"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;long ll_ret

choose case dwo.name
		
	case "b_aggiorna"

		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)
	
	case "b_m"
			
		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)

end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name
		
	case "id_ruolo_web"
		
		if data < "2" then return 0
		
		uodw_current.setItem(row, "livello_statistica", ii_max_livello)	
		
	case "chk_pw"
		
		integer li_ret
		
		if data= '1' then 
			
			openWithParm(w_check_pw, s_utente_s)
		
			if message.doubleParm= -1 then return 1
			
			this.Object.password_t.Visible= 1
			this.Object.password.Visible= 1
			
			this.Object.chk_pw.Visible= 0
			
		else
			
			this.Object.password_t.Visible= 1
			this.Object.password.Visible= 0
			
		end if
			
		
	case "flag_ambito"
		
		integer li_livello
	
//		if data= 'T' then
//			
//			this.setItem(row, "flag_superuser", 'S')
//			
//		else
//			
//			this.setItem(row, "flag_superuser", 'N')		
		
			if data= "C" then // Competenza Istituzionale
		
				select a.livello
						into :li_livello
						from membri_gerarchica m, att_ist a
						where 
						m.cod_att_ist_1= a.cod_att_ist and
						m.codice=  :is_codice; // corrisponde al codice personale...
						
						if trap_sql(sqlca, "UTENTEREMOTO.1") < 0 then return	
						
						if li_livello= 0 then
							
							messageBox("Gestione accessi", "Nessuna responsabilità istituzionale. ~nNon è possibile assegnare un ambito operativo all'utente", exclamation!)
							close(parent)
							
						end if
	
			end if
				
//		end if

	case "password"
		
		if len(data) < 8 then
			messageBox(parent.title, "Minimo 8 caratteri.", information!)
			return 1
		end if
		
		this.setItem(row, "dt_pwchange", today())
		
	case "flag_abilitato"
		
		datetime ldt_null
		
		setNull(ldt_null)
		
		if data= '1' then
			
			if messageBox( parent.title, "Questa utenza verrà riattivata.~nConfermi?", question!, yesNo!, 2)= 2 then
				
					return 2
					
				else
					
					this.setItem(row, "dt_lastlogin", today())
					
					this.setItem(row, "flag_accettazione", 0)
					
					return 0
					
			end if
			
		end if
	
end choose
end event

event retrieveend;call super::retrieveend;integer li_ret
string ls_filter

ls_filter= "livello <= "+string(ii_max_livello)
li_ret= idwc_strutturalivelli.setFilter(ls_filter)
li_ret= idwc_strutturalivelli.filter()
return
end event

