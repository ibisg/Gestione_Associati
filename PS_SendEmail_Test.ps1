param(
[string] $Username,
[string] $Password ,
[string] $to ,
[string] $subject
)
 #, [string]$body, [string]$password, [string]$SMTPServer, [string]$SMTPPort)
#, [string]$attachment)
$SMTPServer = "smtp.office365.com"
$SMTPPort = "587"
#$Username = "gino.desimone@sgi-italia.org"
$Password = "inFilax3"

write-output $Username
