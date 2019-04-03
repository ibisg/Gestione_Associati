$PBExportHeader$w_doppioni.srw
forward
global type w_doppioni from w_ricerca_small
end type
type cb_del2 from commandbutton within w_doppioni
end type
type cb_del1 from commandbutton within w_doppioni
end type
type dw_mem_1 from datawindow within w_doppioni
end type
type dw_mem_2 from datawindow within w_doppioni
end type
type p_goh_1 from picture within w_doppioni
end type
type st_3 from statictext within w_doppioni
end type
type p_studio_1 from picture within w_doppioni
end type
type st_7 from statictext within w_doppioni
end type
type p_zaimu_1 from picture within w_doppioni
end type
type st_8 from statictext within w_doppioni
end type
type p_offerte_1 from picture within w_doppioni
end type
type st_9 from statictext within w_doppioni
end type
type st_10 from statictext within w_doppioni
end type
type p_offerte_2 from picture within w_doppioni
end type
type st_11 from statictext within w_doppioni
end type
type p_zaimu_2 from picture within w_doppioni
end type
type st_12 from statictext within w_doppioni
end type
type p_studio_2 from picture within w_doppioni
end type
type st_16 from statictext within w_doppioni
end type
type p_goh_2 from picture within w_doppioni
end type
type cb_reset from commandbutton within w_doppioni
end type
type cb_imp2 from commandbutton within w_doppioni
end type
type cb_imp1 from commandbutton within w_doppioni
end type
type gb_1 from groupbox within w_doppioni
end type
end forward

global type w_doppioni from w_ricerca_small
integer width = 4146
integer height = 2564
string title = "Ricerca doppi inserimenti"
boolean clientedge = true
boolean ib_sqluselike = true
boolean ib_selectrow = true
cb_del2 cb_del2
cb_del1 cb_del1
dw_mem_1 dw_mem_1
dw_mem_2 dw_mem_2
p_goh_1 p_goh_1
st_3 st_3
p_studio_1 p_studio_1
st_7 st_7
p_zaimu_1 p_zaimu_1
st_8 st_8
p_offerte_1 p_offerte_1
st_9 st_9
st_10 st_10
p_offerte_2 p_offerte_2
st_11 st_11
p_zaimu_2 p_zaimu_2
st_12 st_12
p_studio_2 p_studio_2
st_16 st_16
p_goh_2 p_goh_2
cb_reset cb_reset
cb_imp2 cb_imp2
cb_imp1 cb_imp1
gb_1 gb_1
end type
global w_doppioni w_doppioni

type variables
boolean stop_retrieval = false
long retrieved_rows, t_row
long n = 0
int sort_order = 1
long il_count = 0
DataWindowChild dwc_alb, dwc_mezzo
string is_dis, is_cognome
string is_tabs[4]={"gohonzon_storico", "esami_curr", "zaimu","offerte"}
picture paint[2,4]

end variables

forward prototypes
public function integer wf_select_item (long al_row)
public function integer wf_tb_dip (string as_codice, ref long ai_num)
public function integer wf_cancella (string as_codice_src, string as_codice_tgt)
end prototypes

public function integer wf_select_item (long al_row);string ls_codice

ls_codice = dw_current.GetItemString ( al_row, "codice")

choose case il_count
		
	case 1
		
		if dw_mem_1.Retrieve (ls_codice ) < 1 then return -1
		if wf_tb_dip (ls_codice, il_count ) = -1 then return -1
		
	case 2
		
		if dw_mem_2.Retrieve ( ls_codice ) < 1 then return -1
		if wf_tb_dip (ls_codice, il_count ) = -1 then return -1
		
	case else
		
		MessageBox ( "Errore grave", "Contattare il CED.", StopSign! )
		return -2
		
end choose

return 0
end function

public function integer wf_tb_dip (string as_codice, ref long ai_num);string ls_stat
int li_tab, li_ret

for li_tab = 1 to 4
	
	declare crs_count dynamic cursor for sqlsa;
	
	ls_stat = "select count(*) from " + is_tabs[li_tab] + " where codice = ?"
	prepare sqlsa from :ls_stat;
	open dynamic crs_count using :as_codice;
	fetch crs_count into :li_ret;
	
	if sqlca.Sqlcode = -1 then 
		MessageBox ( "Errore Db " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText, StopSign! )
		return -1
	end if
	
	if li_ret > 0 then paint[ai_num, li_tab].PictureName = "d_yellow.bmp"
	
	close crs_count;
	
next

return 0
end function

public function integer wf_cancella (string as_codice_src, string as_codice_tgt);datetime ldt_data, ldt_data_esame
string ls_tipo, ls_causale, ls_studio, ls_esito

declare goh_cur cursor for
select tipo_goh, data, cod_causale
from gohonzon_storico
where codice IN (:as_codice_src, :as_codice_tgt)
group by tipo_goh, data, cod_causale
having count(*) = 1;

open goh_cur;

do while sqlca.sqlcode <> 100
	
	fetch goh_cur into :ls_tipo, :ldt_data, :ls_causale;
	if sqlca.sqlcode= 100 then continue
	if trap_sql(sqlca, "ACCORPA01") < 0 then goto errore
	
	update gohonzon_storico
	set codice= :as_codice_tgt
	where codice= :as_codice_src and tipo_goh= :ls_tipo and data= :ldt_data and cod_causale= :ls_causale;
	if trap_sql(sqlca, "ACCORPA02") < 0 then goto errore
	
loop

close goh_cur;

declare esami_cur cursor for
select cod_studio, data_esame, esito
from esami_curr
where codice IN (:as_codice_src, :as_codice_tgt)
group by cod_studio, data_esame, esito
having count(*) = 1;

open esami_cur;

do while sqlca.sqlcode <> 100
	
	fetch esami_cur into :ls_studio, :ldt_data_esame, :ls_esito;
	if sqlca.sqlcode= 100 then continue
	if trap_sql(sqlca, "ACCORPA03") < 0 then goto errore
	
	update esami_curr
	set codice= :as_codice_tgt
	where codice= :as_codice_src and cod_studio= :ls_studio and data_esame= :ldt_data_esame and esito= :ls_esito;
	if trap_sql(sqlca, "ACCORPA04") < 0 then goto errore
	
loop

close esami_cur;

update zaimu set codice= :as_codice_tgt where codice= :as_codice_src;
if trap_sql(sqlca, "ACCORPA05") < 0 then goto errore


update offerte set codice= :as_codice_tgt where codice= :as_codice_src;
if trap_sql(sqlca, "ACCORPA06") < 0 then goto errore

delete from membri_gerarchica
where codice = :as_codice_src;
if trap_sql(sqlca, "ACCORPA07") < 0 then goto errore

return 0

errore:

return -1

end function

on w_doppioni.create
int iCurrent
call super::create
this.cb_del2=create cb_del2
this.cb_del1=create cb_del1
this.dw_mem_1=create dw_mem_1
this.dw_mem_2=create dw_mem_2
this.p_goh_1=create p_goh_1
this.st_3=create st_3
this.p_studio_1=create p_studio_1
this.st_7=create st_7
this.p_zaimu_1=create p_zaimu_1
this.st_8=create st_8
this.p_offerte_1=create p_offerte_1
this.st_9=create st_9
this.st_10=create st_10
this.p_offerte_2=create p_offerte_2
this.st_11=create st_11
this.p_zaimu_2=create p_zaimu_2
this.st_12=create st_12
this.p_studio_2=create p_studio_2
this.st_16=create st_16
this.p_goh_2=create p_goh_2
this.cb_reset=create cb_reset
this.cb_imp2=create cb_imp2
this.cb_imp1=create cb_imp1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_del2
this.Control[iCurrent+2]=this.cb_del1
this.Control[iCurrent+3]=this.dw_mem_1
this.Control[iCurrent+4]=this.dw_mem_2
this.Control[iCurrent+5]=this.p_goh_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.p_studio_1
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.p_zaimu_1
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.p_offerte_1
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.st_10
this.Control[iCurrent+14]=this.p_offerte_2
this.Control[iCurrent+15]=this.st_11
this.Control[iCurrent+16]=this.p_zaimu_2
this.Control[iCurrent+17]=this.st_12
this.Control[iCurrent+18]=this.p_studio_2
this.Control[iCurrent+19]=this.st_16
this.Control[iCurrent+20]=this.p_goh_2
this.Control[iCurrent+21]=this.cb_reset
this.Control[iCurrent+22]=this.cb_imp2
this.Control[iCurrent+23]=this.cb_imp1
this.Control[iCurrent+24]=this.gb_1
end on

on w_doppioni.destroy
call super::destroy
destroy(this.cb_del2)
destroy(this.cb_del1)
destroy(this.dw_mem_1)
destroy(this.dw_mem_2)
destroy(this.p_goh_1)
destroy(this.st_3)
destroy(this.p_studio_1)
destroy(this.st_7)
destroy(this.p_zaimu_1)
destroy(this.st_8)
destroy(this.p_offerte_1)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.p_offerte_2)
destroy(this.st_11)
destroy(this.p_zaimu_2)
destroy(this.st_12)
destroy(this.p_studio_2)
destroy(this.st_16)
destroy(this.p_goh_2)
destroy(this.cb_reset)
destroy(this.cb_imp2)
destroy(this.cb_imp1)
destroy(this.gb_1)
end on

event open;call super::open;s_session_s.context= "Doppi inserimenti"

ib_selectrow= true

dw_mem_1.setTransObject(sqlca)
dw_mem_2.setTransObject(sqlca)

paint[1,1] = p_goh_1
paint[1,2] = p_studio_1
paint[1,3] = p_zaimu_1
paint[1,4] = p_offerte_1
paint[2,1] = p_goh_2
paint[2,2] = p_studio_2
paint[2,3] = p_zaimu_2
paint[2,4] = p_offerte_2

dw_current.setRowFocusIndicator(hand!)

dw_current.setColumn("cognome")
end event

type dw_current from w_ricerca_small`dw_current within w_doppioni
event type integer ue_select ( long al_row )
integer x = 50
integer y = 64
integer width = 3849
integer height = 932
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type integer dw_current::ue_select(long al_row);long ll_rows, ll_idx
string ls_codice1, ls_codice2, ls_cognome_1, ls_nome_1, ls_cognome_2, ls_nome_2, ls_sel_1, ls_sel_2
int li_ret

setPointer(hourGlass!)
		
		if al_row= 1 then
			dw_mem_1.reset()
			ls_codice1 = dw_current.GetItemString ( dw_current.getRow(), "codice")
			if dw_mem_1.Retrieve (ls_codice1 ) < 1 then return -1
			if wf_tb_dip (ls_codice1, al_row ) = -1 then return -1
		else
			dw_mem_2.reset()
			ls_codice2 = dw_current.GetItemString ( dw_current.getRow(), "codice")
			if dw_mem_2.Retrieve (ls_codice2 ) < 1 then return -1
			if wf_tb_dip (ls_codice2, al_row ) = -1 then return -1
		end if

//if al_row= 1 then
//
//	ls_codice1 = dw_mem_1.GetItemString ( 1, "codice")
//	
//	ls_cognome_1 = dw_mem_1.GetItemString ( 1, "cognome" )
//	ls_nome_1 = dw_mem_1.GetItemString ( 1, "nome" )
//	
//	ls_sel_1 = ls_codice1+ " - " + trim ( ls_cognome_1 ) + " " + ls_nome_1
//	
//else
//
//	ls_codice2 = dw_mem_1.GetItemString ( 1, "codice")
//	
//	ls_cognome_2 = dw_mem_2.GetItemString ( 1, "cognome" )
//	ls_nome_2 = dw_mem_2.GetItemString ( 1, "nome" )
//	
//	ls_sel_2 = ls_codice2 + " - " + trim ( ls_cognome_2 ) + " " + ls_nome_2
//	
//end if

return 0


end event

event dw_current::dberror;call super::dberror;return 1
end event

event dw_current::retrieveend;call super::retrieveend;cb_query.enabled= false
cb_imp1.enabled= true
end event

type cb_importa from w_ricerca_small`cb_importa within w_doppioni
boolean visible = false
integer x = 82
integer y = 1016
integer width = 398
integer height = 112
string text = "Importa"
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_doppioni
integer x = 1701
integer y = 1016
integer width = 466
integer height = 112
string text = "Annulla l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_doppioni
integer x = 1243
integer y = 1016
integer width = 398
integer height = 112
string text = "Estrazione"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_doppioni
integer x = 2862
integer y = 1016
integer width = 398
integer height = 112
string text = "Chiudi"
boolean cancel = false
end type

type cb_del2 from commandbutton within w_doppioni
integer x = 1701
integer y = 1932
integer width = 457
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Cancella il secondo"
end type

event clicked;long ll_code_a, ll_code_c
string ls_dip_a, ls_dip_c, ls_cognome_1, ls_nome_1, ls_cognome_2, ls_nome_2, ls_to_canc, ls_to_merge, ls_codice_1, ls_codice_2
int li_ret

ls_codice_1 = dw_mem_1.GetItemString ( 1, "codice" )
ls_cognome_1 = dw_mem_1.GetItemString ( 1, "cognome" )
ls_nome_1 = dw_mem_1.GetItemString ( 1, "nome" )

ls_codice_2 = dw_mem_2.GetItemString ( 1, "codice" )
ls_cognome_2 = dw_mem_2.GetItemString ( 1, "cognome" )
ls_nome_2 = dw_mem_2.GetItemString ( 1, "nome" )

ls_to_merge =ls_codice_1 + " - " + trim ( ls_cognome_1 ) + " " + ls_nome_1
ls_to_canc = ls_codice_2 + " - " + trim ( ls_cognome_2 ) + " " + ls_nome_2

li_ret = MessageBox ( "Attenzione", "Confermi la cancellazione di~n" + ls_to_canc + &
							 "?~nI dati verranno accorpati a quelli di~n" + ls_to_merge + ".", &
							 Question!, YesNo!, 2 )

if li_ret = 2 then return 1

this.enabled = false
cb_del1.enabled = false

string ls_message

ls_message=  "ACCORPAMENTO: cancellati i dati di ~n" + ls_to_canc + &
							 "~nI dati sono stati accorpati a quelli di ~n" + ls_to_merge + "."

f_log(s_session_s, ls_message, false)

if wf_cancella ( ls_codice_2, ls_codice_1 ) = -1 then
	
	ROLLBACK;
	open(w_message_negative)
	return
	
else
	
	COMMIT;
	open(w_message)
	return
	
end if

cb_reset.triggerEvent(clicked!)


end event

type cb_del1 from commandbutton within w_doppioni
integer x = 82
integer y = 1932
integer width = 398
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Cancella il primo"
end type

event clicked;long ll_code_a, ll_code_c
string ls_dip_a, ls_dip_c, ls_cognome_1, ls_nome_1, ls_cognome_2, ls_nome_2, ls_to_canc, ls_to_merge, ls_codice_1, ls_codice_2
int li_ret

ls_codice_1 = dw_mem_1.GetItemString ( 1, "codice" )
ls_cognome_1 = dw_mem_1.GetItemString ( 1, "cognome" )
ls_nome_1 = dw_mem_1.GetItemString ( 1, "nome" )

ls_codice_2 = dw_mem_2.GetItemString ( 1, "codice" )
ls_cognome_2 = dw_mem_2.GetItemString ( 1, "cognome" )
ls_nome_2 = dw_mem_2.GetItemString ( 1, "nome" )

ls_to_canc =ls_codice_1 + " - " + trim ( ls_cognome_1 ) + " " + ls_nome_1
ls_to_merge = ls_codice_2 + " - " + trim ( ls_cognome_2 ) + " " + ls_nome_2

li_ret = MessageBox ( "Attenzione", "Confermi la cancellazione di~n" + ls_to_canc + &
							 "?~n~nI dati verranno accorpati a quelli di~n" + ls_to_merge + ".", &
							 Question!, YesNo!, 2 )

if li_ret = 2 then return 1

this.enabled = false
cb_del2.enabled = false

string ls_message

ls_message=  "ACCORPAMENTO: cancellati i dati di ~n" + ls_to_canc + &
							 "~nI dati sono stati accorpati a quelli di~n" + ls_to_merge + "."

f_log(s_session_s, ls_message, false)

if wf_cancella ( ls_codice_1, ls_codice_2 ) = -1 then
	
	ROLLBACK;
	open(w_message_negative)
	
else
	
	COMMIT;
	open(w_message)
	
end if

cb_reset.triggerEvent(clicked!)

return 0


end event

type dw_mem_1 from datawindow within w_doppioni
integer x = 82
integer y = 1320
integer width = 1559
integer height = 608
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mem_dbl"
boolean livescroll = true
end type

event dberror;//f_log_err ( gs_context, SqlErrText )
//MessageBox ( "Errore Db " + string ( SqlDbCode ), SqlErrText, StopSign! )
//
//return 1

end event

event retrieveend;cb_del1.enabled= true
end event

type dw_mem_2 from datawindow within w_doppioni
integer x = 1701
integer y = 1320
integer width = 1559
integer height = 608
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mem_dbl"
boolean livescroll = true
end type

event dberror;//f_log_err ( gs_context, SqlErrText )
//MessageBox ( "Errore Db " + string ( SqlDbCode ), SqlErrText, StopSign! )
//
//return 1

end event

event retrieveend;cb_del2.enabled= true
end event

type p_goh_1 from picture within w_doppioni
integer x = 87
integer y = 2084
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_doppioni
integer x = 174
integer y = 2088
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Storico Gohonzon"
boolean focusrectangle = false
end type

type p_studio_1 from picture within w_doppioni
integer x = 87
integer y = 2164
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_7 from statictext within w_doppioni
integer x = 174
integer y = 2156
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Studio"
boolean focusrectangle = false
end type

type p_zaimu_1 from picture within w_doppioni
integer x = 87
integer y = 2244
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_8 from statictext within w_doppioni
integer x = 174
integer y = 2316
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Zaimu"
boolean focusrectangle = false
end type

type p_offerte_1 from picture within w_doppioni
integer x = 87
integer y = 2324
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_9 from statictext within w_doppioni
integer x = 174
integer y = 2236
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Offerte E.R."
boolean focusrectangle = false
end type

type st_10 from statictext within w_doppioni
integer x = 1787
integer y = 2236
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Offerte E.R."
boolean focusrectangle = false
end type

type p_offerte_2 from picture within w_doppioni
integer x = 1701
integer y = 2244
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_11 from statictext within w_doppioni
integer x = 1787
integer y = 2316
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Zaimu"
boolean focusrectangle = false
end type

type p_zaimu_2 from picture within w_doppioni
integer x = 1701
integer y = 2324
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_12 from statictext within w_doppioni
integer x = 1787
integer y = 2156
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Studio"
boolean focusrectangle = false
end type

type p_studio_2 from picture within w_doppioni
integer x = 1701
integer y = 2164
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type st_16 from statictext within w_doppioni
integer x = 1787
integer y = 2088
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Storico Gohonzon"
boolean focusrectangle = false
end type

type p_goh_2 from picture within w_doppioni
integer x = 1701
integer y = 2084
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "d_gray.bmp"
boolean focusrectangle = false
end type

type cb_reset from commandbutton within w_doppioni
integer x = 2409
integer y = 1016
integer width = 448
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
boolean cancel = true
end type

event clicked;integer li_tab

dw_current.reset()
dw_mem_1.reset()
dw_mem_2.reset()

cb_imp1.enabled= false
cb_imp2.enabled= false

cb_del1.enabled= false
cb_del2.enabled= false

for li_tab = 1 to 4
	
	paint[1, li_tab].PictureName = "d_gray.bmp"
	paint[2, li_tab].PictureName = "d_gray.bmp"
	
next

cb_query.enabled= true

dw_current.Object.DataWindow.QueryMode= 'yes' 

dw_current.enabled= true

dw_current.setFocus()

dw_current.setColumn("cognome")

end event

type cb_imp2 from commandbutton within w_doppioni
integer x = 1701
integer y = 1188
integer width = 448
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Importa il secondo"
end type

event clicked;dw_current.event ue_select(2)

dw_current.deleteRow(0)

this.enabled= false
end event

type cb_imp1 from commandbutton within w_doppioni
integer x = 82
integer y = 1188
integer width = 384
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Importa il primo"
end type

event clicked;string ls_codice_fam

ls_codice_fam= dw_current.getItemString(dw_current.getRow(), "codice_fam")

if isNull(ls_codice_fam) or ls_codice_fam= "" then

	dw_current.event ue_select(1)
	
	dw_current.deleteRow(0)
	
	this.enabled= false
	cb_imp2.enabled= true
	
else
	
	messageBox(parent.title, "Questa persona fa parte di un nucleo familiare, non è possibile effettuare l'accorpamento.~nOccorre prima sciogliere il nucleo.", exclamation!)
	
end if

return 0
end event

type gb_1 from groupbox within w_doppioni
integer x = 27
integer y = 12
integer width = 3909
integer height = 1156
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selezione"
end type

