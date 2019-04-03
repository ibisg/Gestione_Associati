$SMTPServer = "smtp.office365.com"
$SMTPPort = "587"
#$Username = "gino.desimone@sgi-italia.org"
#$Password = "inFilax3"

#$to = "gdscons@gmail.com, gino.desimone@sgi-italia.org"
#$cc = "gino.desimone@sgi-italia.org"
#$bcc= "gino.desimone@sgi-italia.org"
#$subject = "Email Subject"
#$body = "Insert body text here"
#$attachment = "C:\users\gds\desktop\cat_video.xlsx"
$body= Get-Content c:\svil_pb\Gestione_Associati\docdir\templates\maildisclaimer.txt

$message = New-Object System.Net.Mail.MailMessage
$message.subject = $subject
$message.body = $body
$message.to.add($to)
#$message.cc.add($cc)
#$message.bcc.add($bcc)
$message.from = $username
#$message.attachments.add($attachment)

$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$smtp.send($message)
write-host $body
write-host "Mail Sent"