$PBExportHeader$w_anomalie_esami_curr.srw
forward
global type w_anomalie_esami_curr from window
end type
type vpb_idx from vprogressbar within w_anomalie_esami_curr
end type
type em_data from editmask within w_anomalie_esami_curr
end type
type cb_correggi from commandbutton within w_anomalie_esami_curr
end type
type dw_current from datawindow within w_anomalie_esami_curr
end type
end forward

global type w_anomalie_esami_curr from window
integer width = 3936
integer height = 1816
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
vpb_idx vpb_idx
em_data em_data
cb_correggi cb_correggi
dw_current dw_current
end type
global w_anomalie_esami_curr w_anomalie_esami_curr

event resize;dw_current.height= this.height - 120
end event

on w_anomalie_esami_curr.create
this.vpb_idx=create vpb_idx
this.em_data=create em_data
this.cb_correggi=create cb_correggi
this.dw_current=create dw_current
this.Control[]={this.vpb_idx,&
this.em_data,&
this.cb_correggi,&
this.dw_current}
end on

on w_anomalie_esami_curr.destroy
destroy(this.vpb_idx)
destroy(this.em_data)
destroy(this.cb_correggi)
destroy(this.dw_current)
end on

event open;dw_current.setTransObject(sqlca)

dw_current.retrieve()
end event

type vpb_idx from vprogressbar within w_anomalie_esami_curr
integer x = 3511
integer y = 652
integer width = 91
integer height = 848
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type em_data from editmask within w_anomalie_esami_curr
integer x = 3328
integer y = 220
integer width = 475
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 0
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type cb_correggi from commandbutton within w_anomalie_esami_curr
integer x = 3328
integer y = 444
integer width = 475
integer height = 148
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Esegui allineamento"
end type

event clicked;long  ll_idx= 0
string ls_codice, ls_cod_studio, ls_data_esame, ls_esito
datetime ldt_data_cer

vpb_idx.maxposition= 100
vpb_idx.minposition= 0

for ll_idx= 1 to dw_current.rowCount()
	
	ls_codice= dw_current.getItemString(ll_idx, "codice")
	ls_cod_studio= "04"
	ldt_data_cer= dw_current.getItemDatetime(ll_idx, "data_cer")
	ls_data_esame=  "01/11/1980" // string(RelativeDate(date(ldt_data_cer), 366), "dd/mm/yyyy")
	ls_esito= 'P'
	
	insert into esami_curr	
	(codice, cod_studio, data_esame, esito, voto, soglia, note, id_esami_sessioni)
	values(
	:ls_codice, 
	:ls_cod_studio,
	:ls_data_esame, /*this.em_data.text,*/ 
	:ls_esito, 
	null, 
	null, 
	"Inserito manualmente (data fittizia)", 
	null);
	
	if trap_sql(sqlca, "Insert in esami_curr") < 0 then
		
		rollback;
		return -1
		
	end if
	
	vpb_idx.position=100*( ll_idx/ dw_current.rowCount() )
	
next	

//rollback;
commit;
if trap_sql(sqlca, "Commit in esami_curr") <0 then 
	rollback;
	messageBox("test", "Commit non effettuata")
end if


end event

type dw_current from datawindow within w_anomalie_esami_curr
integer width = 3282
integer height = 1528
integer taborder = 10
string dataobject = "dw_anomalie_esami_curr"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

