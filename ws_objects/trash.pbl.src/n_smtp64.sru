$PBExportHeader$n_smtp64.sru
$PBExportComments$SMTP Email Object
forward
global type n_smtp64 from n_smtp
end type
end forward

global type n_smtp64 from n_smtp
end type
global n_smtp64 n_smtp64

type prototypes
// Cryptlib Functions
Function long cryptInit ( &
	) Library "cl64.dll"

Function long cryptEnd ( &
	) Library "cl64.dll"

Function long cryptCreateSession ( &
	Ref long pSession, &
	long cryptUser, &
	long SessionType &
	) Library "cl64.dll"

Function long cryptDestroySession ( &
	long session &
	) Library "cl64.dll"

Function long cryptSetAttributeString ( &
	long hCrypt, &
	long CryptAttType, &
	Ref string pBuff, &
	long StrLen &
	) Library "cl64.dll" Alias For "cryptSetAttributeString;Ansi"

Function long cryptSetAttribute ( &
	long hCrypt, &
	long CryptAttType, &
	long value &
	) Library "cl64.dll"

Function long cryptPopData ( &
	long envelope, &
	Ref string pBuff, &
	long StrLen, &
	Ref long pBytesCopied &
	) Library "cl64.dll" Alias For "cryptPopData;Ansi"

Function long cryptPushData ( &
	long envelope, &
	Ref string pBuff, &
	long StrLen, &
	Ref long pBytesCopied &
	) Library "cl64.dll" Alias For "cryptPushData;Ansi"

Function long cryptFlushData ( &
	long envelope &
	) Library "cl64.dll"

Function long cryptGetAttributeString ( &
	long hCrypt, &
	long CryptAttType, &
	Ref string pBuff, &
	Ref integer StrLen &
	) Library "cl64.dll" Alias For "cryptGetAttributeString;Ansi"

end prototypes
on n_smtp64.create
call super::create
end on

on n_smtp64.destroy
call super::destroy
end on

