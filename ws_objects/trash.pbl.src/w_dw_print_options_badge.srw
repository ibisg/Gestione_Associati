$PBExportHeader$w_dw_print_options_badge.srw
forward
global type w_dw_print_options_badge from w_dw_print_options
end type
end forward

global type w_dw_print_options_badge from w_dw_print_options
end type
global w_dw_print_options_badge w_dw_print_options_badge

event open;call super::open;rb_orizzontale.checked= true
rb_verticale.enabled= false
end event

on w_dw_print_options_badge.create
call super::create
end on

on w_dw_print_options_badge.destroy
call super::destroy
end on

type cb_ok from w_dw_print_options`cb_ok within w_dw_print_options_badge
end type

type st_1 from w_dw_print_options`st_1 within w_dw_print_options_badge
end type

type sle_printer from w_dw_print_options`sle_printer within w_dw_print_options_badge
end type

type st_2 from w_dw_print_options`st_2 within w_dw_print_options_badge
end type

type em_copies from w_dw_print_options`em_copies within w_dw_print_options_badge
end type

type rb_all from w_dw_print_options`rb_all within w_dw_print_options_badge
end type

type rb_current_page from w_dw_print_options`rb_current_page within w_dw_print_options_badge
end type

type rb_pages from w_dw_print_options`rb_pages within w_dw_print_options_badge
end type

type sle_page_range from w_dw_print_options`sle_page_range within w_dw_print_options_badge
end type

type st_3 from w_dw_print_options`st_3 within w_dw_print_options_badge
end type

type cbx_print_to_file from w_dw_print_options`cbx_print_to_file within w_dw_print_options_badge
end type

type cbx_collate from w_dw_print_options`cbx_collate within w_dw_print_options_badge
end type

type cb_cancel from w_dw_print_options`cb_cancel within w_dw_print_options_badge
end type

type cb_printer from w_dw_print_options`cb_printer within w_dw_print_options_badge
end type

type st_4 from w_dw_print_options`st_4 within w_dw_print_options_badge
end type

type ddlb_range from w_dw_print_options`ddlb_range within w_dw_print_options_badge
end type

type st_pf from w_dw_print_options`st_pf within w_dw_print_options_badge
end type

type st_print_file from w_dw_print_options`st_print_file within w_dw_print_options_badge
end type

type cb_file from w_dw_print_options`cb_file within w_dw_print_options_badge
end type

type rb_verticale from w_dw_print_options`rb_verticale within w_dw_print_options_badge
end type

type rb_orizzontale from w_dw_print_options`rb_orizzontale within w_dw_print_options_badge
end type

type gb_2 from w_dw_print_options`gb_2 within w_dw_print_options_badge
end type

type gb_1 from w_dw_print_options`gb_1 within w_dw_print_options_badge
end type

