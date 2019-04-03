$PBExportHeader$w_conteggio_old.srw
forward
global type w_conteggio_old from window
end type
type st_6 from statictext within w_conteggio_old
end type
type st_5 from statictext within w_conteggio_old
end type
type st_4 from statictext within w_conteggio_old
end type
type cb_start1 from commandbutton within w_conteggio_old
end type
type uodw_sessioni from uodw_generica within w_conteggio_old
end type
type ddlb_livello from dropdownlistbox within w_conteggio_old
end type
type pb_struttura from picturebutton within w_conteggio_old
end type
type cb_start from commandbutton within w_conteggio_old
end type
type st_3 from statictext within w_conteggio_old
end type
type st_2 from statictext within w_conteggio_old
end type
type st_1 from statictext within w_conteggio_old
end type
type em_struttura from editmask within w_conteggio_old
end type
type em_ultimoesame from editmask within w_conteggio_old
end type
type em_datasoglia from editmask within w_conteggio_old
end type
type uodw_current from uodw_generica within w_conteggio_old
end type
type gb_1 from groupbox within w_conteggio_old
end type
type gb_2 from groupbox within w_conteggio_old
end type
type gb_3 from groupbox within w_conteggio_old
end type
end forward

global type w_conteggio_old from window
integer width = 4233
integer height = 3420
boolean titlebar = true
string title = "Conteggio aventi diritto"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
event type integer ue_runquery ( integer ai_livello_esame,  datetime adt_data_ultimo_esame,  datetime adt_data_cerimonia_soglia )
event type integer ue_query ( string as_nodo,  integer ai_livello,  integer ai_livello_sup )
st_6 st_6
st_5 st_5
st_4 st_4
cb_start1 cb_start1
uodw_sessioni uodw_sessioni
ddlb_livello ddlb_livello
pb_struttura pb_struttura
cb_start cb_start
st_3 st_3
st_2 st_2
st_1 st_1
em_struttura em_struttura
em_ultimoesame em_ultimoesame
em_datasoglia em_datasoglia
uodw_current uodw_current
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_conteggio_old w_conteggio_old

type variables
m_preview im_preview
s_struttura is_strutturatgt_s

integer ii_livello_esame
end variables

event type integer ue_runquery(integer ai_livello_esame, datetime adt_data_ultimo_esame, datetime adt_data_cerimonia_soglia);integer li_ret, li_livello_raggruppamento,li_livello_superiore
long ll_row, ll_conteggio
string ls_nodo, ls_query, ls_livello_raggruppamento, ls_livello_esame

if ai_livello_esame= 0 then
	messageBox(this.title, "Selezionare un livello", exclamation!)
	return 0
end if

ls_nodo=is_strutturatgt_s.vc_nodo

if ls_nodo= "" then
	messageBox(this.title, "Selezionare una struttura", exclamation!)
	return 0
end if

choose case ai_livello_esame
		
	case 1
		
		ls_livello_esame= "1° livello"
		
	case 2
		
		ls_livello_esame= "2° livello"		
		
	case 3
		
		ls_livello_esame= "3° livello"		
		
	case 4
		
		ls_livello_esame= "4° livello"		
		
	case 5
		
		ls_livello_esame= "5° livello"		
		
end choose

			uodw_current.reset()
		
			openWithParm(w_selezione_livello, is_strutturatgt_s.livello)
		
			li_livello_raggruppamento= message.doubleParm
			
			if li_livello_raggruppamento= 0 then return -1
				
					if li_livello_raggruppamento= gi_maxlivello then
						
						li_livello_superiore= gi_maxlivello
						
					else
					
						openWithParm(w_selezione_livello_minimo, li_livello_raggruppamento)
					
						li_livello_superiore= message.doubleParm
						
						if li_livello_superiore= 0 then return -1		
						
					end if
			
//		end if

select descrizione into : ls_livello_raggruppamento from struttura_livelli where livello= :li_livello_raggruppamento;

if trap_sql(sqlca, "RUNQUERY00") < 0 then return -1

	
	setpointer(hourGlass!)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_superiore)+" and substring(vc_nodo, 1, " + string(len(ls_nodo))+") = '"+ls_nodo+"' order by vc_nodo"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			ll_row= uodw_current.insertRow(0)	
			uodw_current.setItem(ll_row, "livello_esame", ls_livello_esame )	
			uodw_current.setItem(ll_row, "struttura_sup", f_descrizione_nodo(is_strutturatgt_s.vc_nodo, is_strutturatgt_s.livello) )
			uodw_current.setItem(ll_row, "livello", f_descrizione_livello(ls_nodo) )	
			uodw_current.setItem(ll_row, "livello_raggruppamento", ls_livello_raggruppamento )			
			uodw_current.setItem(ll_row, "struttura_raggruppamento", f_nome_nodo(ls_nodo, li_livello_raggruppamento ) )			
			uodw_current.setItem(ll_row, "struttura", f_nome_nodo(ls_nodo, li_livello_superiore ) )
			
			ll_conteggio= f_conteggioaventidiritto( ai_livello_esame , adt_data_cerimonia_soglia, adt_data_ultimo_esame, ls_nodo )
			
			uodw_current.setItem(ll_row, "conteggio", ll_conteggio)
			
			if ll_row= -1 then exit
			
			ll_row++
	
		loop
		
		close query_cur;

uodw_current.sort()
uodw_current.groupCalc()

return li_ret
end event

event type integer ue_query(string as_nodo, integer ai_livello, integer ai_livello_sup);integer li_ret, li_livello
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row, ll_idx
decimal ld_importo, ld_zero

integer li_anno
datetime ldt_data_cer
string ls_luogo_cer, ls_parent, ls_struttura, ls_struttura_old
			
			open(w_wait_snoopy_writing)
			
			for ll_idx= 1 to ll_row
				
//				ls_struttura_gruppo= w_preview.uodw_current.getItemString(ll_idx, "vc_parent")
				li_livello= w_preview.uodw_current.getItemNumber(ll_idx, "att_ist_livello")
				
				ls_struttura= f_parse_struttura_left (ls_parent,  li_livello )
				if ls_struttura <> ls_struttura_old then ls_descrizione_struttura= f_nome_nodo( ls_parent, li_livello)
				
				w_preview.uodw_current.setItem(ll_idx, "catt_ist_struttura", ls_struttura)
				w_preview.uodw_current.setItem(ll_idx, "catt_ist_nome_struttura", ls_descrizione_struttura)
				
				ls_struttura_old= ls_struttura
				
			next
			
			close(w_wait_snoopy_writing)

return 0


end event

on w_conteggio_old.create
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.cb_start1=create cb_start1
this.uodw_sessioni=create uodw_sessioni
this.ddlb_livello=create ddlb_livello
this.pb_struttura=create pb_struttura
this.cb_start=create cb_start
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_struttura=create em_struttura
this.em_ultimoesame=create em_ultimoesame
this.em_datasoglia=create em_datasoglia
this.uodw_current=create uodw_current
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.st_6,&
this.st_5,&
this.st_4,&
this.cb_start1,&
this.uodw_sessioni,&
this.ddlb_livello,&
this.pb_struttura,&
this.cb_start,&
this.st_3,&
this.st_2,&
this.st_1,&
this.em_struttura,&
this.em_ultimoesame,&
this.em_datasoglia,&
this.uodw_current,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_conteggio_old.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_start1)
destroy(this.uodw_sessioni)
destroy(this.ddlb_livello)
destroy(this.pb_struttura)
destroy(this.cb_start)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_struttura)
destroy(this.em_ultimoesame)
destroy(this.em_datasoglia)
destroy(this.uodw_current)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;im_preview= create m_preview

uodw_sessioni.setTransObject(sqlca)
end event

event resize;uodw_current.height=this.height - uodw_current.y - 180
end event

type st_6 from statictext within w_conteggio_old
integer x = 2697
integer y = 1112
integer width = 1435
integer height = 116
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Utilizzare il metodo 2 se è già stato definito un evento per la sessione d~'esame."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_conteggio_old
integer x = 2697
integer y = 488
integer width = 1435
integer height = 112
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Utilizzare il metodo 1 se non è stato definito un evento per la sessione d~'esame."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_conteggio_old
integer x = 2793
integer y = 132
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Livello"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_start1 from commandbutton within w_conteggio_old
integer x = 3287
integer y = 2800
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Esegui"
end type

event clicked;
event ue_runquery(ii_livello_esame,  uodw_sessioni.getItemDatetime(1, "data_ultimo_esame"),uodw_sessioni.getItemDatetime(1, "data_cerimonia_soglia")  )
end event

type uodw_sessioni from uodw_generica within w_conteggio_old
integer x = 2738
integer y = 1316
integer width = 1161
integer height = 1496
string dataobject = "dw_view_esami_sessioni"
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
boolean ib_readonly = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

type ddlb_livello from dropdownlistbox within w_conteggio_old
integer x = 2990
integer y = 112
integer width = 704
integer height = 476
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string item[] = {"Esami 1° Livello","Esami 2° Livello","Esami 3° Livello","Esami 4° Livello","Esami 5° Livello"}
end type

event selectionchanged;integer idx, li_tipo_evento
long ll_row

ii_livello_esame= index

	// deve estrarre un solo record, quello con data= MIN(data)
	
	select id
	into :idx
	from esami_sessioni
	where tipo_evento= convert(integer, :index) and
				data_evento= (select MIN(data_evento) from esami_sessioni e
										where e.tipo_evento= esami_sessioni.tipo_evento);
	
	if trap_sql(sqlca, "CONTEGGIO01") < 0 then return -1
	
	// se esiste estrae i dati identificativi della sessione...
	
	if isNull(idx) then idx= 0
	
	if idx = 0 then
		
		messageBox(parent.title, "Nessuna sessione di esame è stata definita per questo livello.")
		return 1
		
	else
		
		ll_row= uodw_sessioni.retrieve(idx)
		
	end if
	
	return ll_row
end event

type pb_struttura from picturebutton within w_conteggio_old
integer x = 3767
integer y = 216
integer width = 183
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "where.bmp"
alignment htextalign = left!
end type

event clicked;long ll_handle
s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s.ai_maxlivello= gi_maxlivello
s_assegnastruttura_s.as_ambito= gs_ambito
s_assegnastruttura_s.ab_abilitaincolla= true

is_strutturatgt_s=  uodw_current.uof_struttura(s_assegnastruttura_s)

if is_strutturatgt_s.livello= -1 then return -1

em_struttura.text= f_descrizione_nodo(is_strutturatgt_s.vc_nodo, is_strutturatgt_s.livello)
end event

type cb_start from commandbutton within w_conteggio_old
integer x = 3287
integer y = 928
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Esegui"
end type

event clicked;if  em_ultimoesame.text= 'none' then  em_ultimoesame.text= '00.00.0000'

if  em_datasoglia.text= 'none' then  em_datasoglia.text= '00.00.0000'

uodw_current.Object.t_data_ultimo_esame.Text = em_ultimoesame.text

uodw_current.Object.t_data_cerimonia.Text = em_datasoglia.text

event ue_runquery(ii_livello_esame,  datetime(em_ultimoesame.text), datetime(em_datasoglia.text)  )
end event

type st_3 from statictext within w_conteggio_old
integer x = 2766
integer y = 252
integer width = 206
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Struttura"
boolean focusrectangle = false
end type

type st_2 from statictext within w_conteggio_old
integer x = 2848
integer y = 828
integer width = 357
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ultimo esame"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_conteggio_old
integer x = 2848
integer y = 724
integer width = 357
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Soglia cerimonia"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_struttura from editmask within w_conteggio_old
integer x = 2990
integer y = 240
integer width = 704
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
textcase textcase = upper!
maskdatatype maskdatatype = stringmask!
end type

type em_ultimoesame from editmask within w_conteggio_old
integer x = 3218
integer y = 820
integer width = 475
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd.mm.yyyy"
end type

type em_datasoglia from editmask within w_conteggio_old
integer x = 3218
integer y = 712
integer width = 475
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd.mm.yyyy"
end type

type uodw_current from uodw_generica within w_conteggio_old
integer x = 37
integer y = 36
integer width = 2615
integer height = 1472
integer taborder = 30
string dataobject = "edw_ad"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.visible= false
im_preview.m_inserisci.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.m_ordina.visible= true // is_preview_s.ib_sort

//if ib_esportadw= false then
//	im_preview.m_esporta.visible= false
//else
	im_preview.m_esporta.visible= true
//end if

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "pb_struttura" then
		
		long ll_handle
		s_assegnastruttura s_assegnastruttura_s
		
		//s_struttura is_strutturatgt_s
		
//		s_assegnastruttura_s.as_struttura_s.vc_nodo= 
//		s_assegnastruttura_s.as_struttura_s.livello= is_assegnastruttura_s.ai_maxlivello
//		s_assegnastruttura_s.ab_abilitaincolla= false
//		s_assegnastruttura_s.ai_maxlivello= is_assegnastruttura_s.ai_maxlivello
//		s_assegnastruttura_s.ai_ultimolivelloparent= is_assegnastruttura_s.ai_ultimolivelloparent
//		s_assegnastruttura_s.as_ambito= is_assegnastruttura_s.as_ambito
		
		is_strutturatgt_s=  uodw_current.uof_struttura(s_assegnastruttura_s)
		
		if is_strutturatgt_s.livello= -1 then return -1
		
		em_struttura.text= s_assegnastruttura_s.as_struttura_s.vc_nodo
		
	end if
		
		return 0
end event

type gb_1 from groupbox within w_conteggio_old
integer x = 2697
integer y = 36
integer width = 1435
integer height = 444
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = " Seleziona livello e struttura"
end type

type gb_2 from groupbox within w_conteggio_old
integer x = 2697
integer y = 616
integer width = 1435
integer height = 440
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Metodo 1: Simula i criteri di partecipazione"
end type

type gb_3 from groupbox within w_conteggio_old
integer x = 2697
integer y = 1224
integer width = 1435
integer height = 1708
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Metodo 2: Seleziona una sessione predefinita"
end type

