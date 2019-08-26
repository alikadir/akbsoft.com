
<!--#include file="db.asp"-->

<head>
<style>
<!--
input        { font-family: Tahoma; font-size: 8pt; color: #000000; font-weight: bold; 
               border: 1px dotted #C0C0C0; background-color: #F8F8F8 }
textarea     { font-family: Tahoma; font-size: 8pt; font-weight: bold; 
               border: 1px dotted #C0C0C0 }
-->
</style>
</head>

<body bgcolor="#EFEFEF">

<center>
<form action="?islem=goster" method="post">

<fieldset style="border:1px solid #000000; padding:2px; width:449px; height:91px">
<legend><font face="Tahoma" size="2">
<img border="0" src="img/sayac.gif" width="20" height="20"> Saya� Kodumu G�ster</font></legend>
<table border="0" width="95%" id="table1" cellspacing="0" cellpadding="0" height="54">
	<tr>
		<td width="28%">
		<p align="left"><font face="Tahoma" size="2">&nbsp;&nbsp; Kullan�c� Ad�:</font></td>
		<td width="72%"><input type="text" name="kullanici" size="30">&nbsp;&nbsp; <input type="submit" value="Kodu G�ster"></td>
	</tr>
	</table>
</fieldset>
</center>
</form>
<%
if (request.querystring("islem"))="goster" Then
kullanici=request("kullanici")
if kullanici="" Then
Response.redirect "uyekodum.asp"
end if
Sorgu="Select * From Sayac Where kullanici='"&kullanici&"'"
Rs.Open Sorgu,bag,1,3
if rs.eof then
response.redirect "uyekodum.asp"
end if
response.redirect "uyekodum.asp?islem=goster2&kullanici="&kullanici&""
%>
<%
end if
%>

<%
if (request.querystring("islem"))="goster2" Then
kullanici=request("kullanici")
Sorgu="Select * From genel"
Rs.Open Sorgu,bag,1,3
%>


<center><br><br>
<table border="0" width="473" id="table2" cellspacing="0" cellpadding="0" bgcolor="#E8E8E8" height="239">
	<tr>
		<td>
		<table border="0" width="473" id="table3" cellspacing="0" cellpadding="0" bgcolor="#E8E8E8" height="346">
			<tr>
				<td bordercolor="#000000" style="border-style: solid; border-width: 1px">
				<div align="center">
					<table border="0" width="445" id="table4" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF" height="281">
						<tr>
							<td valign="top">
							<p align="center">
							<font face="Tahoma" size="2" color="#008080"><br><%Response.Write" "&kullanici&", i�in saya� kodu . "%><br><br><%Response.Write"Saya� Kodunuz"%><br><br></font>
<textarea rows="11" cols="65" name="kod"><iframe name="Saya�" width="232" height="139" scrolling="no" border="0" frameborder="0" src="<%=rs("sayacyolu")%>?kullanici=<%response.write kullanici%>">_</iframe></textarea></td>
						</tr>
					</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</center>



<%
end if
%><%Bag.Close : Set Bag=Nothing%>