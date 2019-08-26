<html>
<head>
<title>DEFTER</title>

<!-- #include file="ohesa.asp" -->

<link rel='stylesheet' href='style.css' type='text/css'>
<div align="center">
<table width='790' cellpadding='0' cellspacing='0' height=100%>
<td align=center valign=center>
<table width='788' cellpadding='0' cellspacing='0' border=0>
<td height=1 bgcolor=black></td>
<tr>
<td height=25 background=images/bg.gif>
<font style=font-size:9pt color=black face=tahoma><b>&nbsp; &nbsp;Ziyaretçi Defteri okunuyor</font></td>
<tr>
<td height=1 bgcolor=black></td>
</table>

<div align="center">

<table width='790' cellpadding='0' cellspacing='0' class='border' height="165">

<td background=images/bg.gif width="790">
<div align='center'>&nbsp;</div>
<div align='center'>
<a href="yaz.asp">MESAJ YAZ</a></div><br>
	
<%
set zd = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=1 order by id desc" 
zd.open Sql, zdconn, 1, 3 
%>
<font size=1 face=verdana><center>
<%
If zd.eof or zd.bof then 
Response.Write "Ziyaretçi defterinde henüz bir kayýt yok !" 
%>
<br> <b> <font size=1 face=verdana> 
<br>Onaylanan Toplam Mesaj Sayýsý:<%Response.write ""& zd.recordcount &"" %>
<%
set zdo = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=0" 
zdo.open Sql, zdconn, 1, 3 
%> 
Onay Bekleyen Mesaj Sayýsý:<%Response.write ""& zdo.recordcount &"" %>
<br>Her sayfada <%=zd.pagesize%> adet mesaj gösterilmekte. </font>
<%
Response.end 
end if 
%>

</font></center>

<%
sayfa = request.Querystring("sayfa")
if sayfa="" then
sayfa=1 
end if
zd.pagesize = sayfas
zd.absolutepage = sayfa 
Sayfa_top = zd.pagecount 
for i=1 to zd.pagesize 
if zd.eof then exit for 
%>

<div align='center'>

<table width='780' cellpadding='0' cellspacing='0' border=0>
<td width=200>
<table width='200' cellpadding='0' cellspacing='0' border=0>
<td width=16 height=16 background=images/ust-sol.gif></td>
<td width=168 height=16 background=images/ust.gif></td>
<td width=16 height=16 background=images/ust-sag.gif></td>
<tr>
<td width=16 background=images/sol.gif></td>
<td width=168 bgcolor=white height=100>
<table width='168' cellpadding='0' cellspacing='0' border=0>
<td width=50>
<b>Yazan: </td>
<td width=118><font color="darkgreen"><b><%=zd("Yazan")%></b></font></td>
<tr>
<td width=50><b> Yer:</td>
<td width=118><b><font color="darkgreen"><%=zd("yer")%></font> </td>
</table>
<table>
<td><br>
Eklenme Tarihi: <br>
<img src=gg.jpg width=1 height=3><br>
<font color="darkgreen"><b><%=zd("tarih")%></b></font> 
</td>
</table>
</td>
<td width=16 background=images/sag.gif></td>
<tr>
<td width=16 height=16 background=images/alt-sol.gif></td>
<td width=168 height=16 background=images/alt.gif></td>
<td width=16 height=16 background=images/alt-sag.gif></td>
</table>
</td>

<td width=580>
<table width='580' cellpadding='0' cellspacing='0' border=0>
<td width=16 height=16 background=images/ust-sol.gif></td>
<td width=548 height=16 background=images/ust.gif></td>
<td width=16 height=16 background=images/ust-sag.gif></td>
<tr>
<td width=16 background=images/sol.gif></td>
<td width=548 bgcolor=white height=100>
<table cellpadding='0' cellspacing='0' border=0>
<td height=80 valign=top>
&nbsp;&nbsp;&nbsp;&nbsp;<%=zd("mesaj")%></font>
</td>
<tr>
<td height=20>
<a href="<%=zd("web")%>"><img border="0" src="images/www.gif" width="59" 
height="18"></a> <a href="mailto:<%=zd("email")%>"><img border="0" src="images/e-mail.gif" 
width="59" height="18"></a> <a href="mailto:<%=zd("msn")%>"><img border="0" 
src="images/msnm.gif" width="59" height="18"></a>
</td></table>
</td>
<td width=16 background=images/sag.gif></td>
<tr>
<td width=16 height=16 background=images/alt-sol.gif></td>
<td width=548 height=16 background=images/alt.gif></td>
<td width=16 height=16 background=images/alt-sag.gif></td>
</table>
</td>
</table>
<br>
<%
zd.MoveNext
next
%>

<font size=1 face=verdana><b>

<%
response.write "<font size=1 face=verdana>Sayfa :</font>"
for y=1 to sayfa_top 
 if sayfa=y then 
response.write y 
else 
response.write "<font size=1 face=verdana>"
response.write "<a href=""?sayfa="& y &" ""> "& y &"</a> " 
response.write "</font>"
end if 
next 
%>
</b></font> <font size=1 face=verdana> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Onaylý mesaj : <%Response.write ""& zd.recordcount &"" %><b>&nbsp; | &nbsp;</b>
<%
set zdo = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=0" 
zdo.open Sql, zdconn, 1, 3 
%> 
Onaysýz mesaj : <%Response.write ""& zdo.recordcount &"" %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%=zd.pagesize%> adet mesaj görüntülenmektedir. </font>

<br><br>