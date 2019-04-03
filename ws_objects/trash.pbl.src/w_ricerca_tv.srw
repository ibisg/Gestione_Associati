$PBExportHeader$w_ricerca_tv.srw
forward
global type w_ricerca_tv from w_generica_sheet
end type
type mdi_1 from mdiclient within w_ricerca_tv
end type
end forward

global type w_ricerca_tv from w_generica_sheet
windowtype windowtype = mdihelp!
mdi_1 mdi_1
end type
global w_ricerca_tv w_ricerca_tv

on w_ricerca_tv.create
int iCurrent
call super::create
this.mdi_1=create mdi_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
end on

on w_ricerca_tv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type uodw_current from w_generica_sheet`uodw_current within w_ricerca_tv
string dataobject = "dw_responsabili"
end type

event uodw_current::doubleclicked;call super::doubleclicked;if this.Object.DataWindow.QueryMode = "yes" or this.getRow() <= 0 then return -1
//closeWithReturn(parent, this.getItemString(this.getRow(), "vc_parent")+"."+this.getItemString(this.getRow(), "cognome")	+" "+this.getItemString(this.getRow(), "nome"))

string ls_struttura
ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

SetPointer ( hourglass! )

if ls_struttura <> ""  then
	
	w_ricerca_generica.visible= false
	
	open(w_wait_snoopy)
	
	w_frame_gestioneassociati.SetRedraw ( false )

	w_struttura_tv_tab.tv_struttura.uf_cerca_nodo(ls_struttura)
	
	w_frame_gestioneassociati.SetRedraw ( true )
	
	close(w_wait_snoopy)
	
	setPointer(arrow!)
	
end if
end event

event uodw_current::rowfocuschanged;call super::rowfocuschanged;if this.getRow() > 0 and this.Object.DataWindow.QueryMode = "no" then
	parent.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") )		 )
end if
end event

type mdi_1 from mdiclient within w_ricerca_tv
long BackColor=268435456
end type

