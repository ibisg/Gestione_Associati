$PBExportHeader$w_segnala_anomalie.srw
forward
global type w_segnala_anomalie from window
end type
type st_avviso from statictext within w_segnala_anomalie
end type
type cb_annulla from commandbutton within w_segnala_anomalie
end type
type st_4 from statictext within w_segnala_anomalie
end type
type em_trasf from editmask within w_segnala_anomalie
end type
type em_gv from editmask within w_segnala_anomalie
end type
type em_gsr from editmask within w_segnala_anomalie
end type
type em_rdt from editmask within w_segnala_anomalie
end type
type st_3 from statictext within w_segnala_anomalie
end type
type st_2 from statictext within w_segnala_anomalie
end type
type st_1 from statictext within w_segnala_anomalie
end type
end forward

global type w_segnala_anomalie from window
integer width = 1998
integer height = 1228
boolean titlebar = true
string title = "Rilevazione anomalie"
boolean controlmenu = true
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
st_avviso st_avviso
cb_annulla cb_annulla
st_4 st_4
em_trasf em_trasf
em_gv em_gv
em_gsr em_gsr
em_rdt em_rdt
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_segnala_anomalie w_segnala_anomalie

type variables
s_assegnastruttura is_assegnastruttura_s
end variables

event open;integer li_idx
long ll_count, ll_totale, ll_inconsistenze
string ls_query, ls_query1, ls_query2

for li_idx= 1 to UpperBound(gs_ambiti)
				
				if li_idx=  UpperBound(gs_ambiti) then
					
					ls_query2 += " m.vc_parent like  '"+gs_ambiti[li_idx]+"%') "
					
				else
					
					ls_query2 += " m.vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
					
				end if
				
next	

DECLARE ricerca_cur DYNAMIC CURSOR FOR SQLSA ;

ls_query1= +&
"select count(*)"+&
" from membri_gerarchica m, gohonzon_storico g "+&
 "where m.codice= g.codice and dbo.uf_gohonzon_rdt(m.codice, cod_dis)= 'RDT' and g.cod_causale= 'RDT' and ("

ls_query= ls_query1+ls_query2
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC ricerca_cur ;
	if trap_sql(sqlca, "RUNQUERYRICERCA01") < 0 then return -1
			
			fetch  ricerca_cur
			into :ll_count;

CLOSE ricerca_cur;

em_rdt.text= string(ll_count, "###,###,##0")

ll_totale += ll_count

// resp da confermare

ls_query1= +&
"SELECT count(*)"+&
" FROM att_ist att_ist_a, att_ist att_ist_b, membri_gerarchica m"+&
" WHERE ( m.cod_att_ist_1 = att_ist_a.cod_att_ist ) and "+&
" ( m.cod_att_ist_2 = att_ist_b.cod_att_ist ) and "+&
" ( ( cast(m.cod_att_ist_1 AS int) < 0 ) OR "+&
" ( cast(m.cod_att_ist_2 AS int) < 0 ) ) and ("


ls_query= ls_query1+ls_query2
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC ricerca_cur ;
	if trap_sql(sqlca, "RUNQUERYRICERCA02") < 0 then return -1
			
			fetch  ricerca_cur
			into :ll_count;

CLOSE ricerca_cur;

em_trasf.text= string(ll_count, "###,###,##0")
ll_totale += ll_count

// gruppi senza resp

ls_query2= ""

for li_idx= 1 to UpperBound(gs_ambiti)
				
				if li_idx=  UpperBound(gs_ambiti) then
					
					ls_query2 += " s.vc_nodo like  '"+gs_ambiti[li_idx]+"%') "
					
				else
					
					ls_query2 += " s.vc_nodo like '"+gs_ambiti[li_idx]+"%' OR "
					
				end if
				
next	

ls_query1= +&
"select count(*) "+&
" from struttura s"+&
" where s.livello= 7 and ("+ls_query2+&
" and (select count(*) from membri_gerarchica m1, att_ist a1 where a1.livello= 7 and (m1.cod_att_ist_1= a1.cod_att_ist OR m1.cod_att_ist_2= a1.cod_att_ist)  and m1.vc_parent= s.vc_nodo)=0"+&
" and  (select count(*) from membri_gerarchica m2 where m2.vc_parent = s.vc_nodo ) > 0 "
ls_query= ls_query1
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC ricerca_cur ;
	if trap_sql(sqlca, "RUNQUERYRICERCA03") < 0 then return -1
			
			fetch  ricerca_cur
			into :ll_count;

CLOSE ricerca_cur;

em_gsr.text= string(ll_count, "###,###,##0")
ll_totale += ll_count

ls_query1= +&
"select count(*) "+&
" from struttura s"+&
" where livello= 7 and ("+ls_query2+&
"and (select count(*) from membri_gerarchica m where m.vc_parent= s.vc_nodo"

ls_query= ls_query1+")=0"
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC ricerca_cur ;
	if trap_sql(sqlca, "RUNQUERYRICERCA04") < 0 then return -1
			
			fetch  ricerca_cur
			into :ll_count;

CLOSE ricerca_cur;

em_gv.text= string(ll_count, "###,###,##0")
ll_totale += ll_count

if ll_totale= 0 then
	st_avviso.text= "Complimenti... nessuna anomalia da correggere."
else
	st_avviso.text= "C~'è qualcosa da sistemare... ~r~n ~r~nRiscontrate "+string(ll_totale+ ll_inconsistenze)+" anomalie. Per effettuare le correzioni vai in ~'Ricerca anomalie~'"
end if

return 0


end event

on w_segnala_anomalie.create
this.st_avviso=create st_avviso
this.cb_annulla=create cb_annulla
this.st_4=create st_4
this.em_trasf=create em_trasf
this.em_gv=create em_gv
this.em_gsr=create em_gsr
this.em_rdt=create em_rdt
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_avviso,&
this.cb_annulla,&
this.st_4,&
this.em_trasf,&
this.em_gv,&
this.em_gsr,&
this.em_rdt,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_segnala_anomalie.destroy
destroy(this.st_avviso)
destroy(this.cb_annulla)
destroy(this.st_4)
destroy(this.em_trasf)
destroy(this.em_gv)
destroy(this.em_gsr)
destroy(this.em_rdt)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_avviso from statictext within w_segnala_anomalie
integer x = 110
integer y = 596
integer width = 1778
integer height = 284
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_annulla from commandbutton within w_segnala_anomalie
integer x = 1545
integer y = 964
integer width = 343
integer height = 124
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
boolean default = true
end type

event clicked;	close(parent)
end event

type st_4 from statictext within w_segnala_anomalie
integer x = 14
integer y = 216
integer width = 1504
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Responsabilità dopo un trasferimento: confermata o no?"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_trasf from editmask within w_segnala_anomalie
integer x = 1550
integer y = 196
integer width = 343
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type em_gv from editmask within w_segnala_anomalie
integer x = 1550
integer y = 404
integer width = 343
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type em_gsr from editmask within w_segnala_anomalie
integer x = 1550
integer y = 300
integer width = 343
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type em_rdt from editmask within w_segnala_anomalie
integer x = 1550
integer y = 92
integer width = 343
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type st_3 from statictext within w_segnala_anomalie
integer x = 192
integer y = 424
integer width = 1326
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Gruppi vuoti"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_segnala_anomalie
integer x = 192
integer y = 320
integer width = 1326
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Gruppi senza responsabili"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_segnala_anomalie
integer x = 192
integer y = 108
integer width = 1326
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Gohonzon in deposito temporaneo da più di 3 anni"
alignment alignment = right!
boolean focusrectangle = false
end type

