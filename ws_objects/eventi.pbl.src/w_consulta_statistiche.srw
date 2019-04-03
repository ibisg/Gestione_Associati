$PBExportHeader$w_consulta_statistiche.srw
forward
global type w_consulta_statistiche from window
end type
type uodw_consulta_statistiche from uodw_generica within w_consulta_statistiche
end type
end forward

global type w_consulta_statistiche from window
integer width = 3186
integer height = 1892
boolean titlebar = true
string title = "Statistiche presenze alla consulta"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
uodw_consulta_statistiche uodw_consulta_statistiche
end type
global w_consulta_statistiche w_consulta_statistiche

type variables
m_preview im_preview
end variables

event open;im_preview= create m_preview

uodw_consulta_statistiche.setTransObject(sqlca)
uodw_consulta_statistiche.retrieve(year(today()) )
end event

on w_consulta_statistiche.create
this.uodw_consulta_statistiche=create uodw_consulta_statistiche
this.Control[]={this.uodw_consulta_statistiche}
end on

on w_consulta_statistiche.destroy
destroy(this.uodw_consulta_statistiche)
end on

event resize;uodw_consulta_statistiche.height= this.height - 240
uodw_consulta_statistiche.width= this.width -120
end event

type uodw_consulta_statistiche from uodw_generica within w_consulta_statistiche
integer taborder = 10
string title = "Statistiche presenze alla consulta"
string dataobject = "dctb_consulta_presenze"
string icon = "Report5!"
boolean hsplitscroll = true
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
	case "b_anno"

		integer li_anno
		
		open(w_anno)
		
		li_anno= message.doubleParm
		
		this.setRedraw(false)
		
		this.retrieve(li_anno)
		
		this.setRedraw(true)
		
	case "b_filtra"
		
		integer li_ret
		string ls_filter
		
		open(w_consulta_filtra)
		
		li_ret= message.doubleParm
		
		choose case li_ret
				
			case 0
				
				ls_filter= ""
				
			case 1
				
				ls_filter= "flag_consulta='1'"
				
			case 2
				
				ls_filter= "flag_cdf='1'"
				
			case 3
				
				ls_filter= "flag_cn='1'"
				
			case 4
				
				ls_filter= "flag_auditore_consulta='1'"
				
		end choose
			
		
		this.setFilter(ls_filter)
		
		this.filter()
		
end choose
end event

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_esporta.visible= false
im_preview.m_ordina.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

