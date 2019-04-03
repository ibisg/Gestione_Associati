$PBExportHeader$w_consulta_presenze.srw
forward
global type w_consulta_presenze from window
end type
type uodw_current from uodw_generica within w_consulta_presenze
end type
end forward

global type w_consulta_presenze from window
integer width = 5787
integer height = 2724
boolean titlebar = true
string title = "Presenze alla consulta"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
uodw_current uodw_current
end type
global w_consulta_presenze w_consulta_presenze

type variables
m_preview im_preview
s_evento is_evento_s
end variables

on w_consulta_presenze.create
this.uodw_current=create uodw_current
this.Control[]={this.uodw_current}
end on

on w_consulta_presenze.destroy
destroy(this.uodw_current)
end on

event open;im_preview= create m_preview

is_evento_s= message.powerObjectParm

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(is_evento_s.id)

uodw_current.height= this.height -20
end event

event closequery;if uodw_current.uof_modificheincorso()= 3 then return 1
return 0
end event

event resize;uodw_current.height= this.height -180
end event

type uodw_current from uodw_generica within w_consulta_presenze
integer x = 5
integer y = 4
integer width = 5563
integer height = 2260
integer taborder = 20
string dataobject = "dw_consulta_presenze"
boolean hsplitscroll = true
boolean ib_isgrid = true
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;call super::buttonclicked;if dwo.name= "b_aggiornastorico" then
	
	decimal ld_id
	
	if this.uof_modificheincorso()= 3 then return
	
	if messageBox(parent.title, "Attenzione: l'evento verrà cancellato e le presenze verranno trasferite nell'archivio storico.~n"+&
											"Non sarà più possibile aggiornare i dati per cui verificare di avere fatto correttamente l'inserimento presenze.~n"+&
											"Vuoi proseguire?", Question!, OkCancel!, 2)= 2 then return 0
											
		ld_id= this.getItemDecimal(row, "id_evento")
		
	
		insert into eventi_storico
		  ( id,   
           cod_dip,   
           tipo_evento,   
           responsabile_evento,   
           descrizione_evento,   
           data_evento,   
           operatore ) 
		select id, cod_dip, tipo_evento, responsabile_evento, descrizione_evento, data_evento, operatore
		 from eventi where id= :ld_id;
		 
		 if trap_sql(sqlca, "DELPRESENZE01") < 0 then return -1
		 
		 insert into consulta_presenze_storico
		 select
		 c.id_evento,
		 c.codice,
		 c.presenza,
		 m.flag_consulta,
		 m.flag_cdf,
		 m.flag_cn,
		 m.flag_auditore_consulta
		 from consulta_presenze c, membri_gerarchica m
		 where 	id_evento= :ld_id and
		 			c.codice= m.codice;
		 
		 if trap_sql(sqlca, "DELPRESENZE02") < 0 then return -1
		 
		
		delete from eventi where id= :ld_id;
		
		if trap_sql(sqlca, "DELPRESENZE03") < 0 then return -1
		
		if sqlca.sqlcode= 0 then
			
			commit;
			
			if trap_sql(sqlca, "DELPRESENZE04") < 0 then return -1
			
			messageBox(parent.title, "Aggiornamento eseguito")
			
			close(parent)
			
		else
			
			rollback;
			
			if trap_sql(sqlca, "DELPRESENZE05") < 0 then return -1
			
		end if
		
	end if
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

