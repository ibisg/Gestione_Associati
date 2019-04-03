$PBExportHeader$pfc_u_cb.sru
$PBExportComments$PFC Commandbutton class
forward
global type pfc_u_cb from commandbutton
end type
end forward

global type pfc_u_cb from commandbutton
int Width=353
int Height=93
int TabOrder=1
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global pfc_u_cb pfc_u_cb

type variables

end variables

forward prototypes
public function integer of_getparentwindow (ref window aw_parent)
end prototypes

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetParentWindow
//
//	Access:  		public
//
//	Arguments:
//	aw_parent		The Parent window for this object (passed by reference).
//						If a parent window is not found, variable returns
//						with NULL.
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Calculates the parent window of a window object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

powerobject	lpo_parent

//Loop getting the parent of the object until it is of type window!
lpo_parent = this.GetParent()
do while lpo_parent.TypeOf() <> window! and IsValid (lpo_parent)
	lpo_parent = lpo_parent.GetParent()
loop

if not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

event getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			getfocus
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	If appropriate, notify the parent window that this
//						control got focus.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window 	lw_parent

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	//Notify the parent.
	of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		lw_parent.Dynamic Event pfc_ControlGotFocus (this)
	End If
End If

end event

