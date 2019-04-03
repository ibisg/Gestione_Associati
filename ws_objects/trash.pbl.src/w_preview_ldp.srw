$PBExportHeader$w_preview_ldp.srw
forward
global type w_preview_ldp from w_centered
end type
type ole_1 from olecontrol within w_preview_ldp
end type
end forward

global type w_preview_ldp from w_centered
integer width = 3360
integer height = 1676
string title = "Visualizzazione documenti"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 81324524
string icon = "Window!"
boolean clientedge = true
event type integer ue_open ( string as_codice )
ole_1 ole_1
end type
global w_preview_ldp w_preview_ldp

type variables
string is_path_ldp
nca_pdf inca_pdf
end variables

event type integer ue_open(string as_codice);integer li_ret
string lsa_resp[]= {"None", "Block", "District", "Chapter", "Headquarter", "Territory", "Area", "National", "Generale director"}, &
lsa_studio[]= {"None", "1° Level", "2° Level", "3° Level", "4° Level", "5° Level"}, &
lsa_div[]={"MD", "WD", "YMD", "YWD"}

if messageBox(this.title, "Vuoi aggiungere una firma al documento?", question!, yesNo!, 2)= 1 then
	openWithParm(w_dirlist, gs_docdir+"\firme")
	inca_pdf.isa_valori[9]= message.stringParm
end if

setPointer(hourGlass!)

inca_pdf.isa_datipersonali[1]= 'nome'
inca_pdf.isa_datipersonali[2]= 'responsabilita'
inca_pdf.isa_datipersonali[3]= 'divisione'
inca_pdf.isa_datipersonali[4]= 'data_cerimonia'
inca_pdf.isa_datipersonali[5]= 'data_nascita'
inca_pdf.isa_datipersonali[6]= 'livello_studio'
inca_pdf.isa_datipersonali[7]= 'organizzazione'
inca_pdf.isa_datipersonali[8]= 'indirizzo'
inca_pdf.isa_datipersonali[9]= 'firma'
inca_pdf.isa_datipersonali[10]= 'data_odierna'

select nome+" "+cognome,
		cod_att_ist_1,
		cod_div,
		convert(varchar,  data_cer),
		convert(varchar, data_nas),
		cod_studio,
		vc_parent,
		ind_dom+"  -  "+cap_dom+" - "+comune
		into	:inca_pdf.isa_valori[1],
				:inca_pdf.isa_valori[2],
				:inca_pdf.isa_valori[3],
				:inca_pdf.isa_valori[4],
				:inca_pdf.isa_valori[5],
				:inca_pdf.isa_valori[6],
				:inca_pdf.isa_valori[7],
				:inca_pdf.isa_valori[8]
		from membri_gerarchica, tab_comuni
		where membri_gerarchica.cod_com= tab_comuni.cod_com and codice= :as_codice;
		
		if trap_sql(sqlca, "LPRESENTAZIONE01") < 0 then return -1
		
inca_pdf.isa_valori[10]= string(today(), "dd.mm.yyyy")

inca_pdf.isa_valori[2]= lsa_resp[long(mid(inca_pdf.isa_valori[2], 1, 1) ) + 1 ] // responsabilità

inca_pdf.isa_valori[3]= lsa_div[long(inca_pdf.isa_valori[3] ) ] // divisione

inca_pdf.isa_valori[6]= lsa_studio[long(inca_pdf.isa_valori[6] ) + 1 ] // studio

//		if wf_action(LPRESENTAZIONE, 0) < 0 then return -1

//		return tab_dati.selectTab(tab_dati.tabpage_visualizza)

//		OpenWithParm ( w_lettere_auto, dw_dati.getItemString(dw_dati.getRow(), "codice" ) )

//is_path_ldp= inca_pdf.uof_test()

//ole_viewer.object.SRC= is_path_ldp

//li_ret= run("'"+gs_pdfreader+"' "+is_path_ldp)
li_ret= run(gs_pdfreader+" "+is_path_ldp)

return 0
end event

on w_preview_ldp.create
int iCurrent
call super::create
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
end on

on w_preview_ldp.destroy
call super::destroy
destroy(this.ole_1)
end on

event open;call super::open;string ls_codice

ls_codice= message.stringParm

event post ue_open(ls_codice)
	

end event

type ole_1 from olecontrol within w_preview_ldp
integer x = 50
integer y = 20
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_preview_ldp.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Ew_preview_ldp.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Ew_preview_ldp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
