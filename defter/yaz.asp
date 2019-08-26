<html>
<!-- #include file="ohesa.asp" -->
<head>
<link rel='stylesheet' href='style.css' type='text/css'>
</head>
<body bgcolor='#CECECE' text='#2E4753' style="background-color: #996633">
<div align="center">

<table width='558' cellpadding='0' cellspacing='0' height=100%>
<td align=center valign=center width="558">

<table width='544' cellpadding='0' cellspacing='0'>
<td background='images/bg.gif'  height='25' width="544"><font style=font-size:9pt face=tahoma color=black>
<b>&nbsp;Bastoncu.com</b> &nbsp;<b>Sipariþ Bölümü</b></font></td>
<tr>
<td height=2 bgcolor=black width="544"></td>
<tr>
<td height=10 background=images/bg.gif width="544"></td>
</table>
<table width='544' cellpadding='0' cellspacing='0' background=images/bg.gif height=300>
<td width="544">
<form action="yaz.asp?yaz=tamam" method="post">
<div align="center">
<table border="0" width="427" cellspacing="0" cellpadding="0" height="257">
	<tr>
		<td width="123" height="26" align="center">
		<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ad Soyad : </td>
		<td width="298" height="26">
		<input type="text" name="yazan" size="43" style="color: #007090; font-family: Verdana; font-size: 9">
        <font size="3" color="#FF00FF">*</font></td>
	</tr>
	<tr>
		<td width="123" height="26" align="center">
		<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Adress : </b> </td>
		<td width="298" height="26">
		<input type="text" name="yer" size="43" style="color: #007090; font-family: Verdana; font-size: 9; ">
        <font color="#FF00FF" size="3">*</font></td>
	</tr>
	<tr>
		<td width="123" height="25" align="center">
		<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Telefon : </td>
		<td width="298" height="25">
		<input type="text" name="email" size="43" style="font-size: 9; font-family: verdana; color: #007090">
        <font size="3" color="#FF00FF">*</font></td>
	</tr>
	<tr>
		<td width="123" height="26" align="center">
		<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; E-mail : </td>
		<td width="298" height="26">
		<input type="text" name="msn" size="43" style="font-family: verdana; font-size: 9; color: #007090"></td>
	</tr>
	<tr>
		<td width="123" height="33" align="center">
		<p><b>&nbsp;&nbsp;&nbsp;&nbsp; Sipariþ Ürün No : </b> </td>
		<td width="298" height="33">
		<input type="text" name="web" size="43" style="color: #007090; font-family: Verdana; font-size: 9; "></td>
	</tr>
		<tr>
		<td width="123" height="76">
		<p align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sipariþ Ayrýntý&nbsp; :&nbsp; </b> </td>
		<td width="298" height="76">
		<p align="left">
		<textarea rows="8" name="mesaj" cols="50" style="color: #007090; font-family: Verdana; font-size: 9"></textarea>
        <font size="5" color="#FF00FF">*</font></td>
	</tr>
	<tr>
		<td width="123" height="45"></td>
		<td width="298" height="45"><p><br>
        <input type="submit" value="Gönder" onclick="history.go(-1)"
    style="font-family:Verdana;color:#008000;font-size:1em;font-weight:bold"><br><br></td>
</tr>
</table></div></form></td>
<tr>
<td height=2 bgcolor=black width="544"></td><tr>
  <td height=25 background=bg.gif width="544">
<font size="2">&nbsp; </font><font size="2" color="#FF00FF">* Doldurulmasý zorunlu alanlardýr..</font></td></tr></table>
</div>
<%
yaz = Request.QueryString("yaz")
%>
<%if yaz="tamam" Then %>
<%
yazan = Server.HTMLEncode(Request.Form("yazan"))
yer = Server.HTMLEncode(Request.Form("yer"))
mesaj = Server.HTMLEncode(Request.Form("mesaj"))
email = Server.HTMLEncode(Request.Form("email"))
msn = Server.HTMLEncode(Request.Form("msn"))
web = Server.HTMLEncode(Request.Form("web"))
If yazan="" or mesaj="" or email="" or yer="" Then
response.write " ---  !!  Lütfen Geri Dönerek Gerekli Alanlarý Doldurun  !! --- "
response.end
End If
Set zd = Server.CreateObject("adodb.recordset")
sql="Select * From Zd"
zd.open sql,zdconn,1,3
zd.addnew
zd("yazan") = yazan
zd("yer") = yer
zd("email") = email
zd("msn") = msn
zd("web") = web
zd("mesaj") = mesaj
zd("tarih") = now()
zd("onay") = "0"
zd.update
%>
<p align="center">
<font face="Verdana" style="font-weight: 700" color="#FFFF00" size="6">
Sipariþiniz Gönderildi !!</font></p>
<p align="center">
<font face="Verdana" style="font-weight: 700" color="#00FFFF" size="4">
&nbsp;Ana sayfaya yönlendiriliyorsunuz .. </font>
<font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#00FFFF">
<br> Hata var ise, Lütfen</font><font face="Verdana" style="font-size: 7pt; font-weight: 700" color="#FFFFFF">
<a href="http://www.bastoncu.com"> <font color="#FFFF00">Buraya Týklayýn</font></a></font></p>
<head>
<meta http-equiv="refresh" content="3;URL=http://www.bastoncu.com"></head>
<%
zd.close
Set zd = Nothing
zdconn.close
Set Zdconn = Nothing
%>

<%end if%>

</body>
</html>