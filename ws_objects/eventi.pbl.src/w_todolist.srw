$PBExportHeader$w_todolist.srw
forward
global type w_todolist from w_centered
end type
type uodw_current from uodw_generica within w_todolist
end type
end forward

global type w_todolist from w_centered
integer width = 2981
integer height = 1984
string title = "TO-DO list"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Form!"
boolean clientedge = true
uodw_current uodw_current
end type
global w_todolist w_todolist

type variables
decimal id_id
m_preview_todolist  im_preview
end variables

on w_todolist.create
int iCurrent
call super::create
this.uodw_current=create uodw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_current
end on

on w_todolist.destroy
call super::destroy
destroy(this.uodw_current)
end on

event open;call super::open;long ll_rows

im_preview= create m_preview_todolist

s_session_s.context= "Lista delle cose da fare"

id_id= message.doubleParm

uodw_current.setTransObject(sqlca)

ll_rows= uodw_current.retrieve(id_id)

return 0

end event

event closequery;call super::closequery;choose case uodw_current.uof_modificheincorso()
		
	case 1

		return uodw_current.uof_esegui(uodw_current.ic_aggiornamento)
		
	case 2 // NO
		
		return 0
		
	case 3 // Annulla
		
		return 1
		
end choose
end event

type uodw_current from uodw_generica within w_todolist
integer y = 8
integer width = 2889
integer height = 1828
integer taborder = 10
string dataobject = "dw_todolist"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
end type

event rowfocuschanged;call super::rowfocuschanged;if this.getRow() = 0 then return

if this.getItemString(this.getRow(), "tipo_scadenza") = 'I' then
	this.Object.DataWindow.ReadOnly="Yes"
else
	this.Object.DataWindow.ReadOnly="No"
end if


end event

event rbuttondown;call super::rbuttondown;//if row <= 0 then return

//if f_np(parent.title) < 0 then return 0

//im_preview.PopMenu ( w_todolist.PointerX(), w_todolist.PointerY() )

im_preview.iuodw_generica= uodw_current

	im_preview.m_aggiungi.enabled= true
	im_preview.m_inserisci.enabled= true

if row <= 0 then
	im_preview.m_rimuovi.enabled= false
	im_preview.m_salva.enabled= false
else
	if uodw_current.getItemString(uodw_current.getRow(), "tipo_scadenza")= "A" then
		im_preview.m_rimuovi.enabled= false
		im_preview.m_salva.enabled= false
	else
		im_preview.m_rimuovi.enabled= true
		im_preview.m_salva.enabled= true
	end if
end if

im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_todolist.PointerX(), w_todolist.PointerY() )
end event

event itemchanged;// non esegue la script dell'ancestor

if dwo.name= "stato" then
	
	if data= '1' then
		this.setItem(row, "operatore", "")
	else
		this.setItem(row, "operatore", s_session_s.s_utente_s.s_nome_esteso)			
	end if
	
end if
	
	
end event

event updatestart;call super::updatestart;long ll_idx

for ll_idx= 1 to this.rowCount()
	
	this.setItem(ll_idx, "ordine", ll_idx)
	
next
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_salva" then
	if uodw_current.uof_esegui(uodw_current.ic_aggiornamento) < 0 then return
	close(parent)
end if
return
end event

