<!--#include file="db.asp"-->
<% if (Request.Querystring("islem"))="cikis" Then %>
<%
Session.Abandon
%>
<%response.write " <a href=default.asp>Siteye D�n!</a> "%>
<%end if%>
<%
Sorgu = " Select * From Genel " 
Rs.Open Sorgu,bag,1,3

Dim pass
pass = rs("adminsifre")  ' Buras� �ifremizi Oldu�u Alan !

if session("sifrecik") <> pass then

if Request.form("sifrecik") <> pass then

call parolashf
else
session("sifrecik") = pass
end if
end if
%>
<%
'##########################################################################################
%>
<%
Sub parolashf
goster = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
%>
<%
'##########################################################################################
%>
<head>

<link rel="stylesheet" type="text/css" href="stil.css">

<title></title>
</head>

<p align="center"><font face="Tahoma"><b><font style="font-size: 8pt">L�tfen y�netici �ifrenizi giriniz</font></b><font style="font-size: 8pt">
</font></font><form method=post action="<%=goster%>">
<p align="center"><font face="Verdana" size="1">
<input type="password" name="sifrecik" value="" size="28" style="background-color: #FBFBFB; font-family: Tahoma; font-size: 8pt; border: 1px ridge #525454; "></font><font size="1">
</font>
<font size="1">&nbsp;<input type="submit" value="Gir !" style="background-color: #F7F7F7; font-family: Tahoma; font-size: 8pt; border: 1px outset #525454; ">
</font>
</form>
        <p align="center"><font style="font-size: 8pt" face="Tahoma"><b>
		<font color="#008000">�ifre Denemesinde Bulunan Ki�inin IP si Kaydedilir 
		!!&nbsp;&nbsp; ..:: Webmaster By alikadir� ::..</font></b><br>
</font></p>
<%rs.Close%>
<%
Response.end
End sub
%>