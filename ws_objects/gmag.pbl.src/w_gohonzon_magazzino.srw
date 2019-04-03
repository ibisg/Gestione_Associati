$PBExportHeader$w_gohonzon_magazzino.srw
forward
global type w_gohonzon_magazzino from window
end type
type uodw_gohonzon_movimenti from uodw_generica within w_gohonzon_magazzino
end type
type uodw_gohonzon_magazzino from uodw_generica within w_gohonzon_magazzino
end type
end forward

global type w_gohonzon_magazzino from window
integer width = 5216
integer height = 2660
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
uodw_gohonzon_movimenti uodw_gohonzon_movimenti
uodw_gohonzon_magazzino uodw_gohonzon_magazzino
end type
global w_gohonzon_magazzino w_gohonzon_magazzino

on w_gohonzon_magazzino.create
this.uodw_gohonzon_movimenti=create uodw_gohonzon_movimenti
this.uodw_gohonzon_magazzino=create uodw_gohonzon_magazzino
this.Control[]={this.uodw_gohonzon_movimenti,&
this.uodw_gohonzon_magazzino}
end on

on w_gohonzon_magazzino.destroy
destroy(this.uodw_gohonzon_movimenti)
destroy(this.uodw_gohonzon_magazzino)
end on

event open;uodw_gohonzon_movimenti.setTransObject(sqlca)

uodw_gohonzon_movimenti.retrieve()

uodw_gohonzon_magazzino.setTransObject(sqlca)

uodw_gohonzon_magazzino.retrieve()

commit;
end event

type uodw_gohonzon_movimenti from uodw_generica within w_gohonzon_magazzino
integer x = 14
integer width = 4933
integer height = 1276
integer taborder = 20
string dataobject = "dw_gohonzon_movimenti"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_aggiorna = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;// non esegue la script ancestor

decimal ld_id

choose case dwo.name
		
	case "b_p"
	
		openWithParm(w_ins_gohonzon_magazzino, 0)
		
		ld_id= message.doubleParm
		
		parent.setRedraw(false)
			
			this.retrieve()
		
			uodw_gohonzon_magazzino.retrieve()
		
		parent.setRedraw(true)
		
end choose
end event

event doubleclicked;call super::doubleclicked;decimal ld_id
integer li_in_modifica

ld_id= this.getItemDecimal(row, "id")

select flag_modifica 
into :li_in_modifica 
from gohonzon_movimenti 
where id= :ld_id;

if trap_sql(sqlca, "GOHMOV01") < 0 then return -1

if li_in_modifica= 1 then // se è bloccata daltri...
	
	messageBox(parent.title, "Un altro utente sta modificando questa richiesta.", information!)
	return -1
	
else // altrimenti blocco io...
	
	update gohonzon_movimenti
	set flag_modifica= 1
	where id= :ld_id;
	
	if trap_sql(sqlca, "GOHMOV02") < 0 then return -1	
	
	commit;
	
	if trap_sql(sqlca, "GOHMOV02.1") < 0 then return -1	
	
end if

openWithParm(w_ins_gohonzon_magazzino, ld_id)
		
//ld_id= message.doubleParm

// ora sblocco...
update gohonzon_movimenti
set flag_modifica= 0
where id= :ld_id;

if trap_sql(sqlca, "GOHMOV03") < 0 then return -1

commit;

if trap_sql(sqlca, "GOHMOV03.1") < 0 then return -1	

this.setRedraw(false)
		
	this.retrieve()
	
	uodw_gohonzon_magazzino.retrieve()
	
this.setRedraw(true)
		
end event

type uodw_gohonzon_magazzino from uodw_generica within w_gohonzon_magazzino
integer x = 9
integer y = 1300
integer width = 3602
integer height = 1200
integer taborder = 10
string dataobject = "dw_gohonzon_magazzino"
boolean ib_readonly = true
end type

