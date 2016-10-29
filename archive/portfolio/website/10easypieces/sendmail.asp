<%
Function webulate(text)
  text = Replace(text,"&","&amp;")
  text = Replace(text,"""","&quot;")
  text = Replace(text,"<","&lt;")
  text = Replace(text,">","&gt;")
  text = Replace(text,vbCrLf,"<br>")
  webulate = text
End function

Dim fwd
If Instr(LCase(Request.ServerVariables("SERVER_NAME")),"lee.dev.lookandfeel.com") > 0 Then
  fwd = "http://10easypieces.lee.dev.lookandfeel.com/main.html"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"teneasypiecesstage") > 0 Then
  fwd = "http://10easypieces.vfstaging.dev.lookandfeel.com/main.html"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"167.64.49") > 0 Then
  fwd = "http://10easypieces.vfstaging.dev.lookandfeel.com/main.html"
ElseIf (Instr(LCase(Request.ServerVariables("SERVER_NAME")), "vfstaging.dev.lookandfeel.com") > 0) Then
  fwd = "http://10easypieces.vfstaging.dev.lookandfeel.com/main.html"
Else
  fwd = "http://www.teneasypieces.com/main.html"
End If

senderName     = Request("senderName")
senderEmail    = Request("senderEmail")
recipientName  = Request("recipientName")
recipientEmail = Request("recipientEmail")
personalNote   = Request("personalNote")
msgSubject = "Check out Lee 10 Easy Pieces"
newline = vbCrLf & vbCrLf

msgBody = "Dear " & recipientName & ":" & newline
msgBody = msgBody & senderName
msgBody = msgBody & " has sent you a link to 10 Easy Pieces, brought to you by Riveted by Lee."
msgBody = msgBody & newline
msgBody = msgBody & fwd & newline

If personalNote <> "" Then
  msgBody = msgBody & personalNote
End If

Set newMail = Server.CreateObject("CDONTS.NewMail")
newMail.To = recipientEmail
newMail.From = senderEmail
newMail.Subject = msgSubject
newMail.Body = msgBody
newMail.send()
Set newMail = Nothing
}
%>
<head>
<title>10 Easy Pieces by RivetedbyLee</title>

<meta name="keywords" content="RivetedByLee, apparel, basic fashion,
casual, clothing, career casual, career clothing, casual friday, weekend
wardrobe, contemporary, career dressing, casual classics, casual
clothing,
casual dressing, classic clothing, clothes, denim, denim clothing,
fabrics,
fashion, fashion attitude, fit, fit finder, jackets, jean jackets,
jeans,
jeanswear, khaki, large sizes, lee, lee apparel company, lee jeans, lee
riveted, long, misses clothing, misses jeans, misses pants, misses tops,
misses shirts, misses skirts, misses shorts, jeans, overall, overalls,
pant, pants, petites, riveted, riveted by lee, shirt, shirts, short,
shorts, skirt, skirts, style, stylish clothes, stylish clothing, top,
tops,
twill, twills, updated, washable fabrics, washable, wardrobe, women's
fashion, women's sizes, womens clothing, womens jeans, working
wardrobe">

<meta name="description" content="RivetedByLee, classic styles for
contemporary women.  If you're looking for jeans, pants, shorts, skirts
or
tops, Riveted by Lee is your clothing solution.">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--

body, td {
font-family: Verdana, sans-serif;
font-size: 12px;
color: #3D3C39;
}

.red {
color: #6E0000;
}

a:link { color: #6E0000}
a:active { color: #6E0000}
a:visited { color: #6E0000}
a:hover { color: #6E0000}

-->
</style>
</head>

<body bgcolor="#ffffff" text="#3D3C39" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" background="images/form/bgimg-full.gif">

<p>The following message has been sent 
from
<b><%=senderName%></b> at <b><%=senderEmail%></b>
to 
<b><%=recipientName%></b> at <b><%=recipientEmail%></b></p>

<table border="1" cellspacing="0" cellpadding="6" width="85%" align="center" bgcolor="#DEDEDE">
<tr>
<td><%=webulate(msgBody)%></td>
</table>

<p><form><input type="button" value="Close Window" onclick="javascript:window.close()"></form></p>

</body>