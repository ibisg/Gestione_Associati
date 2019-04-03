$PBExportHeader$w_rga_azioni_offline.srw
forward
global type w_rga_azioni_offline from w_rga_azioni
end type
end forward

global type w_rga_azioni_offline from w_rga_azioni
end type
global w_rga_azioni_offline w_rga_azioni_offline

on w_rga_azioni_offline.create
call super::create
end on

on w_rga_azioni_offline.destroy
call super::destroy
end on

type pb_annulla from w_rga_azioni`pb_annulla within w_rga_azioni_offline
end type

type pb_cancella from w_rga_azioni`pb_cancella within w_rga_azioni_offline
end type

type pb_esegui from w_rga_azioni`pb_esegui within w_rga_azioni_offline
string text = "La variazione è stata effettuata!"
end type

type mle_variazione from w_rga_azioni`mle_variazione within w_rga_azioni_offline
end type

type st_1 from w_rga_azioni`st_1 within w_rga_azioni_offline
end type

