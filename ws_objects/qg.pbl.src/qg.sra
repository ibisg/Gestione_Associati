$PBExportHeader$qg.sra
$PBExportComments$Generated Application Object
forward
global type qg from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables
global type qg from application
string appname = "qg"
end type
global qg qg

on qg.create
appname="qg"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on qg.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_qg)
end event

