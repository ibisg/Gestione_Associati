$PBExportHeader$w_gestione_partecipanti_sheet_old.srw
forward
global type w_gestione_partecipanti_sheet_old from window
end type
type pb_cerca from picturebutton within w_gestione_partecipanti_sheet_old
end type
type st_seleziona from statictext within w_gestione_partecipanti_sheet_old
end type
type sle_filtra from singlelineedit within w_gestione_partecipanti_sheet_old
end type
type sle_sigla from singlelineedit within w_gestione_partecipanti_sheet_old
end type
type pb_aggiorna from picturebutton within w_gestione_partecipanti_sheet_old
end type
type pb_reset from picturebutton within w_gestione_partecipanti_sheet_old
end type
type pb_pe from picturebutton within w_gestione_partecipanti_sheet_old
end type
type pb_m from picturebutton within w_gestione_partecipanti_sheet_old
end type
type pb_p from picturebutton within w_gestione_partecipanti_sheet_old
end type
type uodw_current from uodw_generica within w_gestione_partecipanti_sheet_old
end type
type gb_bottoni from groupbox within w_gestione_partecipanti_sheet_old
end type
type dw_ricerca from datawindow within w_gestione_partecipanti_sheet_old
end type
type gb_ricerca from groupbox within w_gestione_partecipanti_sheet_old
end type
end forward

global type w_gestione_partecipanti_sheet_old from window
integer width = 4247
integer height = 3228
boolean titlebar = true
string title = "Gestione partecipanti"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_open ( )
event type long ue_insert_esterni ( )
event type integer ue_ricerca_membri ( )
event type integer ue_reset ( )
pb_cerca pb_cerca
st_seleziona st_seleziona
sle_filtra sle_filtra
sle_sigla sle_sigla
pb_aggiorna pb_aggiorna
pb_reset pb_reset
pb_pe pb_pe
pb_m pb_m
pb_p pb_p
uodw_current uodw_current
gb_bottoni gb_bottoni
dw_ricerca dw_ricerca
gb_ricerca gb_ricerca
end type
global w_gestione_partecipanti_sheet_old w_gestione_partecipanti_sheet_old

type variables
boolean ib_partecipante_esterno, ib_dbcancel, ib_deleterow, ib_modifica, ib_pe
long il_codice_part
string is_sort='A'
end variables

forward prototypes
public subroutine wf_reset ()
public function integer wf_modified ()
end prototypes

event type long ue_insert_esterni();//gb_ricerca.visible= false
//dw_ricerca.visible= false
//
//gb_ric.visible= false
//
//cb_query.visible= false
//cb_dbcancel.visible= false
//cb_importa.visible= false

long ll_row

ll_row= uodw_current.insertRow(0)

uodw_current.enabled= true
	
ib_pe= true

uodw_current.setFocus()

return ll_row
end event

event type integer ue_ricerca_membri();integer li_ret

ib_dbcancel= false

dw_ricerca.setTransObject(sqlca)

retry: 

if  dw_ricerca.Object.DataWindow.QueryMode= 'no' then
	dw_ricerca.setRedraw(false)
	dw_ricerca.reset()
	dw_ricerca.Object.DataWindow.QueryClear= 'yes'
	dw_ricerca.Object.DataWindow.QueryMode= 'yes'
	dw_ricerca.setRedraw(true)
	dw_ricerca.setFocus()
	return 0
else
	long ll_rows
	dw_ricerca.acceptText()
	dw_ricerca.Object.DataWindow.QueryMode= 'no'
	
	open(w_wait_annulla)
	
		ll_rows= dw_ricerca.retrieve()
	
	close(w_wait_annulla)
	
		if  ll_rows= 0 then
			messageBox(this.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
			goto retry
		end if
		
		return 0
end if

end event

event type integer ue_reset();if ib_modifica= false and ib_pe= false then
	
	pb_p.event clicked()
	
	return 0
	
end if

wf_reset()

return 0
end event

public subroutine wf_reset ();//uodw_current.object.b_aggiorna.visible= '0'
 //uodw_current.Object.DataWindow.ReadOnly="Yes"
 
 pb_aggiorna.visible= false
 pb_m.visible= false
  
 pb_p.visible= true
 pb_pe.visible= true
 
 ib_modifica= false
 ib_pe= false

//gb_ricerca.visible= true
//dw_ricerca.visible= true
uodw_current.reset()
dw_ricerca.reset()
//setPointer(hourGlass!)
//
//dw_ricerca.enabled= false
//
//dw_ricerca.setRedraw(false)
//dw_ricerca.retrieve(gd_idcorso)
//dw_ricerca.setRedraw(true)
//
//dw_ricerca.enabled= true

//gb_ric.visible= false
//
//cb_query.visible= true
//cb_dbcancel.visible= true
//cb_importa.visible= true

dw_ricerca.setFocus()
end subroutine

public function integer wf_modified ();if uodw_current.modifiedCount() > 0 then
	
	integer li_ret
	
	li_ret= messageBox( this.title, "Attenzione: hai eseguito delle modifiche. Le vuoi salvare?", question!, yesNoCancel!, 1)
	
	choose case li_ret
	
		case 1
	
			if uodw_current.uof_aggiorna() < 0 then return 3
			
			return 1
		
		case 2
		
		//uodw_current.reselectRow(uodw_current.getRow() )
		
			return 2 // non salva
		
		case 3
		
			return 3 // annulla
		
	end choose
	
end if

return 0
end function

event open;integer li_ret
string ls_where

dw_ricerca.setTransObject(sqlca)

//setPointer(hourGlass!)
//
//this.setRedraw(false)
//
//	dw_ricerca.retrieve(gd_idcorso)
//
//this.setRedraw(true)
//
//dw_ricerca.setFocus()



end event

event resize;gb_ricerca.x= (this.workSpaceWidth()/2) - (gb_ricerca.width/2)
dw_ricerca.x= gb_ricerca.x + 30

uodw_current.x= dw_ricerca.x

gb_bottoni.x= uodw_current.x + uodw_current.width + 15

pb_p.x= (gb_bottoni.width / 2 ) + gb_bottoni.x - pb_p.width/2
pb_m.x= (gb_bottoni.width / 2 ) + gb_bottoni.x - pb_m.width/2
pb_pe.x= (gb_bottoni.width / 2 ) + gb_bottoni.x - pb_pe.width/2
pb_aggiorna.x= (gb_bottoni.width / 2 ) + gb_bottoni.x - pb_aggiorna.width/2
pb_reset.x= (gb_bottoni.width / 2 ) + gb_bottoni.x - pb_reset.width/2

st_seleziona.x= dw_ricerca.x

sle_filtra.x= dw_ricerca.x + 700
pb_cerca.x= sle_filtra.x + sle_filtra.width + 20

gb_ricerca.height= this.height - gb_ricerca.y - 180

dw_ricerca.height= this.height - dw_ricerca.y - 210 /*- 160*/ - sle_sigla.height

sle_sigla.y= dw_ricerca.y + dw_ricerca.height + 10

sle_sigla.x= dw_ricerca.x

end event

on w_gestione_partecipanti_sheet_old.create
this.pb_cerca=create pb_cerca
this.st_seleziona=create st_seleziona
this.sle_filtra=create sle_filtra
this.sle_sigla=create sle_sigla
this.pb_aggiorna=create pb_aggiorna
this.pb_reset=create pb_reset
this.pb_pe=create pb_pe
this.pb_m=create pb_m
this.pb_p=create pb_p
this.uodw_current=create uodw_current
this.gb_bottoni=create gb_bottoni
this.dw_ricerca=create dw_ricerca
this.gb_ricerca=create gb_ricerca
this.Control[]={this.pb_cerca,&
this.st_seleziona,&
this.sle_filtra,&
this.sle_sigla,&
this.pb_aggiorna,&
this.pb_reset,&
this.pb_pe,&
this.pb_m,&
this.pb_p,&
this.uodw_current,&
this.gb_bottoni,&
this.dw_ricerca,&
this.gb_ricerca}
end on

on w_gestione_partecipanti_sheet_old.destroy
destroy(this.pb_cerca)
destroy(this.st_seleziona)
destroy(this.sle_filtra)
destroy(this.sle_sigla)
destroy(this.pb_aggiorna)
destroy(this.pb_reset)
destroy(this.pb_pe)
destroy(this.pb_m)
destroy(this.pb_p)
destroy(this.uodw_current)
destroy(this.gb_bottoni)
destroy(this.dw_ricerca)
destroy(this.gb_ricerca)
end on

event closequery;wf_modified()
end event

type pb_cerca from picturebutton within w_gestione_partecipanti_sheet_old
integer x = 1353
integer y = 1640
integer width = 119
integer height = 104
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "doublenextarrow.gif"
alignment htextalign = right!
end type

event clicked;if sle_filtra.text= "" then
	
	messageBox(parent.title, "Inserire un cognome")
	
else
	
	dw_ricerca.reset()
	
	if dw_ricerca.retrieve("%"+sle_filtra.text+"%")= 0 then
		
		messageBox(parent.title, "Nessun partecipante trovato")
		
	end if
	
end if
end event

type st_seleziona from statictext within w_gestione_partecipanti_sheet_old
integer x = 55
integer y = 1656
integer width = 667
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Cognome da cercare:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_filtra from singlelineedit within w_gestione_partecipanti_sheet_old
integer x = 750
integer y = 1648
integer width = 599
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
textcase textcase = upper!
end type

event modified;if this.text= "" then
	
	dw_ricerca.setFilter("")
	
else

	dw_ricerca.setFilter("cognome like ~'%"+this.text+"%~'")
	
end if

dw_ricerca.filter()
end event

event getfocus;selectText(1, len(this.text) )
end event

type sle_sigla from singlelineedit within w_gestione_partecipanti_sheet_old
integer x = 59
integer y = 2516
integer width = 4105
integer height = 148
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean displayonly = true
end type

type pb_aggiorna from picturebutton within w_gestione_partecipanti_sheet_old
boolean visible = false
integer x = 3680
integer y = 684
integer width = 379
integer height = 156
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aggiorna"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 8421376
long backcolor = 67108864
end type

event clicked;long ll_ret

if uodw_current.getRow() <= 0 then return 0

if  uodw_current.getItemNumber(uodw_current.getRow(), "codice_part")= 0 then

	long ll_code
	
	SELECT counter
	  INTO :ll_code
	  FROM eventi HOLDLOCK
	 WHERE id = :gd_idcorso;
	if trap_sql(sqlca, "COUNTER01") < 0 then return 1 // non esegue l'update 
	 
	 if IsNull ( ll_code ) or ll_code= 0 then
		ll_code = 1
	else
		ll_code ++
	end if
	
	uodw_current.setItem(uodw_current.getRow(), "id", gd_idcorso)
	
	uodw_current.SetItem ( uodw_current.getRow(), "codice_part", ll_code )
	
	uodw_current.SetItem ( uodw_current.getRow(), "cod_dip", gs_dip_operativa )	
	
	update eventi set counter= :ll_code
	 where id = :gd_idcorso;
	if trap_sql(sqlca, "COUNTER02") < 0 then
		
		uodw_current.SetItem ( uodw_current.getRow(), "codice_part", 0 )
		
		rollback;
		
		return -1 // non esegue l'inserimento  
		
	else
		
		commit; // fa subito la commit del contatore
		
	end if
	
	il_codice_part=  ll_code
	
end if

ll_ret= uodw_current.uof_esegui(uodw_current.ic_aggiornamento)

if ll_ret < 0 then return 0

post event ue_reset()
end event

type pb_reset from picturebutton within w_gestione_partecipanti_sheet_old
integer x = 3680
integer y = 864
integer width = 379
integer height = 156
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Reset"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;integer li_ret

li_ret= wf_modified()

choose case li_ret
		
	case 0 to 2

	wf_reset()
	
case 3
	
	return 0
	
end choose
end event

type pb_pe from picturebutton within w_gestione_partecipanti_sheet_old
integer x = 3680
integer y = 504
integer width = 379
integer height = 156
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "+ &esterni"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;if wf_modified()= 1 then return

uodw_current.reset()

parent.event ue_insert_esterni()

this.visible= false
pb_m.visible= false
pb_p.visible= false
end event

type pb_m from picturebutton within w_gestione_partecipanti_sheet_old
boolean visible = false
integer x = 3762
integer y = 324
integer width = 215
integer height = 156
integer taborder = 70
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "-"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 255
long backcolor = 67108864
end type

event clicked;long ll_ret

ll_ret= uodw_current.uof_esegui(uodw_current.ic_cancellazione)

if ll_ret= 0 then return

wf_reset()

update stanze
set codice_part= null, flag_man= 'N'
where codice_part= :il_codice_part and  id = :gd_idcorso;
if trap_sql(sqlca, "UPDSTART01") < 0 then goto errore // non esegue l'update 

update posti_bus_a
set codice_part= null, flag_man= 'N'
where codice_part= :il_codice_part and id = :gd_idcorso;
if trap_sql(sqlca, "UPDSTART02") < 0 then goto errore // non esegue l'update 

update posti_bus_r
set codice_part= null, flag_man= 'N'
where codice_part= :il_codice_part and id = :gd_idcorso;
if trap_sql(sqlca, "UPDSTART03") < 0 then goto errore // non esegue l'update 

commit;

if trap_sql(sqlca, "UPDSTART4") < 0 then return -1

errore:

rollback;

if trap_sql(sqlca, "UPDSTART5") < 0 then return -1
end event

type pb_p from picturebutton within w_gestione_partecipanti_sheet_old
integer x = 3762
integer y = 144
integer width = 215
integer height = 156
integer taborder = 60
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "+"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;integer li_ret

s_ricerca ls_ricerca_s

if wf_modified()= 1 then return

uodw_current.reset()

this.visible= false
pb_m.visible= false
pb_pe.visible= false

open(w_ricercatramembri)

ls_ricerca_s=  message.powerObjectParm

if ls_ricerca_s.i_retcode= -1 then
	wf_reset()
else
//	setPointer(hourGlass!)
//
//	dw_ricerca.enabled= false
//	
//	dw_ricerca.setRedraw(false)
//	dw_ricerca.retrieve(gd_idcorso)
//	dw_ricerca.setRedraw(true)
//	
//	dw_ricerca.enabled= true
end if
end event

type uodw_current from uodw_generica within w_gestione_partecipanti_sheet_old
integer x = 14
integer width = 3511
integer height = 1584
integer taborder = 10
string dataobject = "dw_gestione_partecipanti"
boolean hscrollbar = false
boolean vscrollbar = false
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event itemchanged;call super::itemchanged;integer li_count
long ll_codice

if row <= 0 or  this.Object.DataWindow.QueryMode = "yes" then return 0

ll_codice= this.getItemNumber(row, "codice_part")

choose case dwo.name
		
	case "cod_div"
		
		if mod(integer(data), 2)= 0 then
			this.setItem(row, "sesso", 'F')
		else
			this.setItem(row, "sesso", 'M')
		end if

	case "tipo_trasporto"
		
		if ll_codice= 0 then return 0
		
		if trim(data)= 'MP' then
				
				select count(*)
				into :li_count
				from posti_bus_a
				where id= :gd_idcorso and codice_part= :ll_codice;
				
				if li_count > 0 then
			
			
					if messageBox(parent.title, "Attenzione, questo partecipante è stato già inserito in un mezzo.~n"+&
														"Assegnando il mezzo privato verrà tolto dalla lista mezzi andata.~n"+&
														"Confermi l'assegnazione del mezzo privato?", question!, yesNo!, 2)= 2 then
								
						
						return 1
						
					else
						
						update posti_bus_a set codice_part= null where id= :gd_idcorso and codice_part= :ll_codice;
						
					end if

			end if
			
		end if
			
	case  "tipo_trasporto_r"
			
		if ll_codice= 0 then return 0
		
		if trim(data)= 'MP' then
				
				select count(*)
				into :li_count
				from posti_bus_r
				where id= :gd_idcorso and codice_part= :ll_codice;
				
				if li_count > 0 then
			
					if messageBox(parent.title, "Attenzione, questo partecipante è stato già inserito in un mezzo.~n"+&
														"Assegnando il mezzo privato verrà tolto dalla lista mezzi ritorno.~n"+&
														"Confermi l'assegnazione del mezzo privato?", question!, yesNo!, 2)= 2 then
								
						
						return 1
						
					else
						
						update posti_bus_r set codice_part= null where id= :gd_idcorso and codice_part= :ll_codice;
						
					end if
					
				end if
			
		end if
	
end choose

pb_aggiorna.visible= true
	
	

end event

event updatestart;call super::updatestart;//dw_ricerca.enabled= false

//if this.getRow() <= 0 then return 0

//if  this.getItemNumber(this.getRow(), "codice_part")= 0 then
//	
//	long ll_code
//	
//	SELECT counter
//	  INTO :ll_code
//	  FROM eventi HOLDLOCK
//	 WHERE id = :gd_idcorso;
//	if trap_sql(sqlca, "COUNTER01") < 0 then return 1 // non esegue l'update 
//	 
//	 if IsNull ( ll_code ) or ll_code= 0 then
//		ll_code = 1
//	else
//		ll_code ++
//	end if
//	
//	this.setItem(this.getRow(), "id", gd_idcorso)
//	
//	this.SetItem ( this.getRow(), "codice_part", ll_code )
//	
//	this.SetItem ( this.getRow(), "cod_dip", gs_dip_operativa )	
//	
//	update eventi set counter= :ll_code
//	 where id = :gd_idcorso;
//	if trap_sql(sqlca, "COUNTER02") < 0 then
//		
//		this.SetItem ( this.getRow(), "codice_part", 0 )
//		
//		rollback;
//		
//		return 1 // non esegue l'update  
//		
//	end if
//	
//	il_codice_part=  ll_code
//	
//end if
//
//return 0
end event

event sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, uodw_current, false)

if sqltype= PreviewSelect!	 then 
	
	sqlSyntax += " and partecipanti.id= "+string(gd_idcorso)
	
	setSqlPreview(sqlSyntax)
	
end if
end event

event retrieveend;call super::retrieveend;//il_codice_part=  uodw_current.getItemNumber(uodw_current.getRow(), "codice_part")
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_occupanti_stanza" then
	
	s_stanza s_stanza_s


	s_stanza_s.ad_id= gd_idcorso
	s_stanza_s.as_cod_albergo= this.getItemString(row, "cod_albergo")
	s_stanza_s.as_num_albergo= this.getItemString(row, "num_albergo")
	
	openWithParm(w_occupanti_stanza, s_stanza_s)
	
end if
end event

type gb_bottoni from groupbox within w_gestione_partecipanti_sheet_old
integer x = 3557
integer y = 76
integer width = 635
integer height = 1024
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
end type

type dw_ricerca from datawindow within w_gestione_partecipanti_sheet_old
event ue_keyenter pbm_dwnprocessenter
event type long ue_estraidettaglio ( )
integer x = 59
integer y = 1760
integer width = 4105
integer height = 744
integer taborder = 50
string title = "none"
string dataobject = "dw_partecipanti"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_keyenter;triggerEvent(doubleclicked!)
end event

event type long ue_estraidettaglio();//long ll_row, ll_quanti
//string ls_att, ls_codice, ls_rif1, ls_rif2
//
//if this.getRow() <= 0 then return 0
//
//ls_codice= this.getItemString(this.getRow(), "codice_part")
//
//select Count(*)
//into :ll_quanti
//from partecipanti
//where codice= :ls_codice and
//			id= :gd_idcorso;
//if trap_sql(sqlca, "DOUBLECLICK01") <  0 then return -1
//
//if isNull(ll_quanti) then ll_quanti= 0
//
//if ll_quanti > 0 then
//	messageBox(parent.title, "Il partecipante "+this.getItemString(this.getRow(), "cognome")+" "+this.getItemString(this.getRow(), "nome")+" è già stato inserito.")
//	return 0
//end if
//
//ll_row = uodw_current.GetRow ( )
//uodw_current.SetItem ( ll_row, "cognome", this.getItemString(this.getRow(), "cognome") )
//uodw_current.SetItem ( ll_row, "nome", this.getItemString(this.getRow(), "nome") )
//uodw_current.SetItem ( ll_row, "data_nasc", this.getItemDateTime(this.getRow(), "data_nas") )
//uodw_current.SetItem ( ll_row, "cod_div", this.getItemString(this.getRow(), "cod_div") )
//uodw_current.SetItem ( ll_row, "codice", ls_codice )
//
//if mod(integer(this.getItemString(this.getRow(), "cod_div")), 2)= 0 then
//		uodw_current.setItem(ll_row, "sesso", 'F')
//	else
//		uodw_current.setItem(ll_row, "sesso", 'M')
//end if
//
////choose case mid( this.getItemString(row, "cod_att_ist_1"), 1, 1) 
////	case '0'
////		ls_att= '0'
////	case '1'
////		ls_att= '07'
////	case '2'
////		ls_att= '06'
////	case '3'
////		ls_att= '05'
////	case '4'
////		ls_att= '04'
////	case '5'
////		ls_att= '03'
////	case '6'
////		ls_att= '02'
////	case '7'
////		ls_att= '01'
////	case '8'
////		ls_att= '08'
////end choose
////
////dw_current.SetItem ( ll_row, "posizione", ls_att )
//
//uodw_current.SetItem ( ll_row, "livello_resp", this.getItemNumber(this.getRow(), "livello") )
//
//uodw_current.SetItem ( ll_row, "indirizzo", this.getItemString(this.getRow(), "ind_dom") )
//uodw_current.SetItem ( ll_row, "cap", this.getItemString(this.getRow(), "cap_dom") )
//uodw_current.SetItem ( ll_row, "citta", this.getItemString(this.getRow(), "comune") )
//uodw_current.SetItem ( ll_row, "prov", this.getItemString(this.getRow(), "provincia") )
//
//select riferimento_descr
//into :ls_rif1
//from riferimenti
//where
//codice= :ls_codice and
//cod_rif= 'TF' and
//predefinito= '1' and
//flag_riservato= 'N';
//if trap_sql(sqlca, "RETRIEVERIF01") < 0 then return -1
//
//select riferimento_descr
//into :ls_rif2
//from riferimenti
//where
//codice= :ls_codice and
//cod_rif= 'TM' and
//predefinito= '1' and
//flag_riservato= 'N';
//if trap_sql(sqlca, "RETRIEVERIF02") < 0 then return -1
//
//uodw_current.SetItem ( ll_row, "tel_1", ls_rif1 )
//uodw_current.SetItem ( ll_row, "tel_2", ls_rif2 )
//uodw_current.SetItem ( ll_row, "sigla_org", this.getItemString(this.getRow(), "vc_parent") )
//
////uodw_current.Object.DataWindow.ReadOnly="No"
//
// uodw_current.object.b_aggiorna.visible= '1'
//
//uodw_current.setFocus()
//
return 0
end event

event doubleclicked;//return this.event ue_estraidettaglio(this.getRow())

long ll_row

if row <= 0 then return

if wf_modified()= 1 then return

il_codice_part=  this.getItemNumber(row, "codice_part")

ll_row= uodw_current.retrieve(this.getItemNumber(row, "id"), il_codice_part )

dw_ricerca.setFilter("")
dw_ricerca.filter()
sle_filtra.text=""

pb_m.visible= true
pb_p.visible= false
pb_pe.visible= false

ib_modifica= true

return 0
end event

event retrieverow;yield()

//if row > 100 then
//	
//	messageBox( parent.title, "Attenzione: finora sono stati estratti più di 100 risultati, ripetere la ricerca con più elementi", information!)
//	return 1
//	
//end if

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if


end event

event rowfocuschanged;f_select_current_row (this)

sle_sigla.text= f_descrizione_struttura( this.getItemString(this.getRow(), "sigla_org") )
end event

event sqlpreview;if f_has_p("S")= false then 
	sqlsyntax+= " and partecipanti.id= "+string(gd_idcorso)+" and partecipanti.cod_dip= '"+gs_dip_operativa+"'"
else
	sqlsyntax+= " and partecipanti.id= "+string(gd_idcorso)
end if

f_sql_use_like(sqlType, sqlsyntax, dw_ricerca, false)

SetSqlPreview ( sqlsyntax)
end event

event clicked;string ls_name

IF dwo.Type = "text" then
	
	setPointer(hourGlass!)
	
	parent.setRedraw(false)

        //dwo.Color = RGB(255,0,0)

        ls_name = dwo.Name

        ls_name = Left(ls_name, Len(ls_name) - 2)

        This.SetSort(ls_name + ", A")

        This.Sort()
		  
	 parent.setRedraw(true)

END IF
end event

event retrieveend;gb_ricerca.text= "Partecipanti estratti: "+string(rowCount(), "###,##0")
end event

type gb_ricerca from groupbox within w_gestione_partecipanti_sheet_old
integer x = 27
integer y = 1572
integer width = 4160
integer height = 1140
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Partecipanti estratti"
end type

