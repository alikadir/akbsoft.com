<html>
<head>
<!-- #include file="ohesa.asp" -->
<link rel='stylesheet' href='style.css' type='text/css'>

<%
if Not Session("Adminmisin") = "Evet" Then 
%>

<b> 
<div align="center">

<table width='569' cellpadding='0' cellspacing='0' style='border=0' height=100%>
<td align=center valign=center>

<table width='569' cellpadding='0' cellspacing='0' style='border: 1px solid #6D7F98' background=images/bg.gif><tr>
<td height='30'>
<font style=font-size:10pt face=tahoma>
<b> &nbsp; Admin Ayarlarý</font></td></tr></table></div>

<div align="center">
<table width='569' cellpadding='0' cellspacing='0' background=images/bg.gif style='border: 1px solid #6D7F98'>
<td>

<br>
<form action="giris.asp" method="post">

<div align="center">

<table border="0" width="312" cellspacing="0" cellpadding="0" id="table18" height=100>
	<tr>
		<td width="147" height="19">
		<p align="right"><font style=font-size:8pt face=tahoma>KULLANICI : &nbsp;</td>
		<td width="165" height="19">
		<input type="text" name="kullanici" size="30" style="color: #007090; font-family: Verdana; font-size: 9"></td>
	</tr>
	<tr>
		<td width="147">
		<p align="right"><font style=font-size:8pt face=tahoma>ÞÝFRE : &nbsp;</td>
		<td width="165">
		<input type="password" name="parola" size="30" style="font-family: verdana; font-size: 9; color: #007090"></td>
	</tr>
	<tr>
<td width="147"></td>
<td width="165"><br>
<input type="submit" value="Gönder" onclick="history.go(-1)" style="font-family:verdana;color:#000000;font-size:11px;"></td>
</tr>
</table></div></form></td></tr></table></div></b>

<p align="center">

<%
Else
%>

<td valign='top' class='main-bg' width="569">
</td></tr></table></div>

<div align="center">
<table width='700' cellpadding='0' cellspacing='0' style='border=0' height=100% bgcolor=808080>
<td align=center valign=center>

<table width='676' cellpadding='0' cellspacing='0'>
<td bgcolor='#B1B8C4' height='30' width="572" background=images/bg.gif>
<font style=font-size:9pt face=tahoma> <b> &nbsp; &nbsp; Ziyaretçi Admin Bölümü</font></td></tr></table>
</div>
<div align="center">
<table width='578' cellpadding='0' cellspacing='0' class='border' height="165" background=images/bg.gif><tr>
<td width="559">
<div align='center'>&nbsp;</div>
<div align='center'>
&nbsp;</div>
	
<%
set zd = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd " 
zd.open Sql, zdconn, 1, 3 
%>
<font size=1 face=verdana><center>
<%
If zd.eof then 
Response.Write "Ziyaretçi defterinizde henüz mesaj yok." 
%>
<br><font size=1 face=verdana> 
<br>Onaylanan Toplam Mesaj Sayýsý:<%Response.write ""& zd.recordcount &"" %>
<%
set zdo = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=0" 
zdo.open Sql, zdconn, 1, 3 
%> 
Onay Bekleyen Mesaj Sayýsý:<%Response.write ""& zdo.recordcount &"" %>
<br>Sayfada <%=zd.pagesize%> adet mesaj gösterilmektedir. </font>
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
<b> 
<table width='676' cellpadding='0' cellspacing='0' class='tbl-border' id="table12">

<td bgcolor=f5f5f5 width="159" rowspan="2">
<p align="left">
&nbsp;&nbsp;Yazan: <%=zd("Yazan")%><br> 
&nbsp;&nbsp;Yer:&nbsp;<%=zd("yer")%> <br>
&nbsp;&nbsp;Eklenme Tarihi: <br>
&nbsp;&nbsp;<font color="#036497"><%=zd("tarih")%></font> 
</b> </td>
<td style=padding-left:5px bgcolor=ffffff width="381" height="75" colspan="3">
&nbsp;&nbsp;<font color="#036497"><%=zd("mesaj")%></font></td>
</tr>
<tr>
<td width='177' bgcolor=eeeeee height="22"><b><a href="<%=zd("web")%>">
<img border="0" src="images/www.gif" width="59" height="18"></a><a href="mailto:<%=zd("email")%>"><img border="0" src="images/e-mail.gif" width="59" height="18"></a><a href="mailto:<%=zd("msn")%>"><img border="0" src="images/msnm.gif" width="59" height="18"></a></td>
<td width='30' bgcolor=eeeeee height="22" align=center>
<b> 
<a href="?git=sil&sill=<%=zd("id")%>">
Sil</a></b></td>
<td width='170' bgcolor=eeeeee height="22" align=center>
<% if zd("onay") = 0 then %>
<a href="?git=onayla&id=<%=zd("id")%>">Onayla</a></td>
<%else%>
<a href="?git=onaykaldir&id1=<%=zd("id")%>">OnayKaldýr</a></td>
<%end if%>
</tr>
</table></b><br><br>
<%
zd.MoveNext
next
%>
<b> <font size=1 face=verdana>
<%
response.write "<font size=1 face=verdana>Sayfa :</font>"
for y=1 to sayfa_top  
if sayfa=y then 
response.write y 
else 
response.write "<font size=1 face=verdana>"
response.write "<a href=""?git=mesajlar&sayfa="& y &" ""> "& y &"</a> " 
response.write "</font>"
end if 
next 
%>
</b></font>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<font size=1 face=verdana> 
<%

set zdasd = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=0" 
zdasd.open Sql, zdconn, 1, 3 
%>
Onaylanmamýþ :<%Response.write ""& zdasd.recordcount &"" %> &nbsp; | &nbsp;
<%
set zdo = Server.Createobject("ADODB.Recordset")
Sql = "select * from zd where onay=1" 
zdo.open Sql, zdconn, 1, 3 
%> 
Onaylanmýþ : <%Response.write ""& zdo.recordcount &"" %>
&nbsp;&nbsp; Sayfada <%=zd.pagesize%> mesaj Gösteriliyor. <br><br></font>
</div>
</div>
</div>

<%
set zdg = Server.Createobject("ADODB.Recordset")
Sql = "select * from zdgenel" 
zdg.open Sql, zdconn, 1, 3 
%>

<div align="center">
<table width='676' cellpadding='0' cellspacing='0' id="table5"><tr>
<td bgcolor='#252525' height='25'><font style=font-size:10pt face=tahoma color=eeeeee><b>
&nbsp;&nbsp;Ziyaretçi Defteri Admin Ayarlarý</font></td></tr></table></div>
<div align="center">

<table width='676' cellpadding='0' cellspacing='0' class='border' id="table6">
<td height=120>
<form action="?git=ayarisle" method="post">

<div align="center">

<table border="0" width="312" cellspacing="0" cellpadding="0" id="table7">
	<tr>
		<td width="147" height="19">
		<p align="right">Baþlýk : &nbsp;</td>
		<td width="165" height="19">
		<input type="text" name="title" size="30" style="color: #007090; font-family: Verdana; font-size: 9" value="<%=zdg("title")%>"></td>
	</tr>
	<tr>
		<b> 
		<td width="147">
		<p align="right">Kullanýcý adý : &nbsp;</td>
		<td width="165">
		<input type="text" name="kullanici" size="30" style="font-family: verdana; font-size: 9; color: #007090" value="<%=zdg("kullanici")%>"></td>
	</tr>
	<tr>
		<td width="147">
		<p align="right">Kullanýcý Þifresi : &nbsp;</td>
		<td width="165">
		<input type="text" name="parola" size="30" style="font-family: verdana; font-size: 9; color: #007090" value="<%=zdg("parola")%>"></td>
	</tr>
	<tr>
<td width="147"></td>
<td width="165"><br>
<input type="submit" value="Gönder"  onclick="history.go(-1)" style="font-family:verdana;color:#000000;font-size:11px;"></td>
</table></div></form></td></tr></table></div>

<!------------------------------ Ayarlama Bölümü Baþlangýcý --------------------------->
<%
git = Request.QueryString("git")
%>
<%if git="ayarisle" Then %>

<%
title = Server.HTMLEncode(Request.Form("title"))
kullanici = Server.HTMLEncode(Request.Form("kullanici"))
parola = Server.HTMLEncode(Request.Form("parola"))
Set zdga = Server.CreateObject("adodb.recordset")
sql="Select * From Zdgenel"
zdga.open sql,zdconn,1,3
zdga("title") = title
zdga("kullanici") = kullanici
zdga("parola") = parola
zdga.update
%>
<p align="center">
<font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#FFFFFF">
Ýþlem Gerçekleþtiriliyor..... <br> Eðer 
Hata olursa <a href="admin.asp">Burayý Týklayýn</a></font></p>
<head>
<meta http-equiv="refresh" content="3;URL=admin.asp">
</head>
<%
zdga.close
Set zdga = Nothing

%><%end if%>

<!-- Ayarisle Bölümü Bitiþi -->

<!------------------------------- sil Bölümü Baþlangýcý ----------------------------->
<%
git = Request.QueryString("git")
%><%if git="sil" Then %><%
sill = Request("sill")
Set zds = Server.CreateObject("ADODB.RecordSet")
SQL_delete = "DELETE from zd WHERE id="&sill&""
zds.open SQL_delete,zdconn,1,3
%>
<p align="center">
<font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#FFFFFF">
Ýþlem Gerçekleþtiriliyor..... <br> Eðer hata <a href="admin.asp">Burayý týklayýn</a></font></p>
<head>
<meta http-equiv="refresh" content="3;URL=admin.asp"></head>

<%end if%>

<!-- sil Bölümü Bitiþi -->

<!----------------------------- onayla Bölümü Bitiþi ----------------------------->

<% if request("git") = "onayla" then %>
<%
Set id = Request.QueryString("id")%>

<%
Set zdonay = Server.CreateObject("ADODB.Recordset")
sorgu = "UPDATE zd SET onay=1 WHERE id = " + id 
zdonay.open sorgu,zdconn,1,3
%>

<p align="center">
<font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#FFFFFF">
Ýþlem Gerçekleþtiriliyor..... <br> Eðer hata olursa <a href="admin.asp">Burayý Týklayýn</a></font></p>
<head>
<meta http-equiv="refresh" content="3;URL=admin.asp"></head>

<%end if%>
<!------------------------------------- onaylama kýsým sonu --------------------------------------------->

<!-- Onaykaldýr Bölümü baþlangýcý -->

<% 
if request("git") = "onaykaldir" then 
%>

<%
Set id1 = Request.QueryString("id1")
%>

<%
Set zdonay = Server.CreateObject("ADODB.Recordset")
sorgu = "UPDATE zd SET onay=0 WHERE id = " + id1 
zdonay.open sorgu,zdconn,1,3
%>

<p align="center">
<font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#FFFFFF">
Ýþlem Gerçekleþtiriliyor..... <br> Eðer hata olursa <a href="zd_admin.asp"> Burayý týklayýn</a></font></p>
<head>
<meta http-equiv="refresh" content="3;URL=admin.asp"></head>

<%end if%>

<!-- Onaykaldýr Bölümü Bitiþi -->

<%
END IF
%>