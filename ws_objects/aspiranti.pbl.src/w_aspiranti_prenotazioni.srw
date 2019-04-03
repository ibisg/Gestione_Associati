$PBExportHeader$w_aspiranti_prenotazioni.srw
forward
global type w_aspiranti_prenotazioni from w_generica_sheet
end type
end forward

global type w_aspiranti_prenotazioni from w_generica_sheet
integer width = 5303
integer height = 2660
end type
global w_aspiranti_prenotazioni w_aspiranti_prenotazioni

type variables
decimal id_id
end variables

on w_aspiranti_prenotazioni.create
call super::create
end on

on w_aspiranti_prenotazioni.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;// Non deve eseguire la script nell'ancestor

long ll_row
im_preview= create m_preview

is_assegnastruttura_s= message.powerObjectParm
is_assegnastruttura_s.ab_abilitaincolla= true // se true il bottone incolla è sempre abilitato

open(w_seleziona_cerimonie)

id_id= message.doubleParm


ll_row= uodw_current.retrieve(id_id)


return ll_row
end event

type uodw_current from w_generica_sheet`uodw_current within w_aspiranti_prenotazioni
integer width = 5230
integer height = 2072
string dataobject = "dw_aspiranti_prenotazioni"
end type

event uodw_current::buttonclicked;call super::buttonclicked;if dwo.name= "b_p" then
s_prenotazioni s_prenotazioni_s

s_prenotazioni_s.id=0
s_prenotazioni_s.id_evento= id_id
s_prenotazioni_s.vc_nodo= this.getItemString(row, "vc_parent")


OpenWithParm(w_ins_aspiranti_prenotazioni, s_prenotazioni_s)

uodw_current.retrieve(id_id)

end if
end event

event uodw_current::doubleclicked;call super::doubleclicked;s_prenotazioni s_prenotazioni_s

s_prenotazioni_s.id= this.getItemDecimal(row, "id")
s_prenotazioni_s.id_evento= this.getItemDecimal(row, "id_evento")
s_prenotazioni_s.vc_nodo= this.getItemString(row, "vc_parent")


OpenWithParm(w_ins_aspiranti_prenotazioni, s_prenotazioni_s)

uodw_current.retrieve(id_id)
end event

