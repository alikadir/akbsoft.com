


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
<form action="?islem=ekle" method="post">

<fieldset style="border:1px solid #000000; padding:2px; width:473px; height:220px">
<legend><font face="Tahoma" size="2">Yeni Saya� Olu�tur</font></legend>
<table border="0" width="95%" id="table1" cellspacing="0" cellpadding="0" height="198">
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="49%">
		<p align="left"><font face="Tahoma" size="2">&nbsp;Kullan�c� Ad�:</font></td>
		<td width="48%"><input type="text" name="kullanici" size="30"> *</td>
	</tr>
	<tr>
		<td width="49%"><font face="Tahoma" size="2">&nbsp;Saya� Ba�lang�c�:</font></td>
		<td width="48%"><input type="text" name="s" size="30" value="0"> *</td>
	</tr>
	<tr>
		<td width="49%"><font face="Tahoma" size="2">&nbsp;Site Adresi:</font></td>
		<td width="48%"><input type="text" name="url" size="30" value="http://"> *</td>
	</tr>
	<tr>
		<td width="49%" height="19">&nbsp;</td>
		<td width="48%" height="19">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;<input type="submit" value="Olu�tur     ">&nbsp;&nbsp;&nbsp;
		<input type="reset" value="S�f�rla     "></td>
	</tr>
	</table>
</fieldset>
</center>
</form>
<%
if (request.querystring("islem"))="ekle" Then
Sorgu="Select * From Sayac"
Rs.Open Sorgu,bag,1,3

'#--------------------------------------------------------------

kullanici = Trim(request.form("kullanici"))
s = Trim(request.form("s"))
url = Trim(request.form("url"))

'#--------------------------------------------------------------

if kullanici="" or s="" or url="" Then
response.write "<center><br><b><font color=red face=verdana size=3>L�tfen Bo� Alan B�rakmay�n�z.<b></font></center>"
else

'#--------------------------------------------------------------


if url="http://" or url="http://www" or url="http://www.com" or url="http://www..com" or url="http://www." or url="'or'"  Then
response.write "<center><br><b><font color=red face=verdana size=3>L�tfen Site Adresinizi Yaz�n�z.<b></font></center>"
else

'#--------------------------------------------------------------


uyesonuc=False
do while (not rs.eof)
if kullanici=rs("kullanici") then
uyesonuc=True
end if
rs.movenext
Loop

if uyesonuc=True then
response.write "<center><br><b><font color=red face=verdana size=3>Kullan�c� Ad� Ba�kas� Taraf�ndan kullan�lmaktad�r.<b></font></center>"
else

'#--------------------------------------------------------------
 
rs.addnew
rs("kullanici")=request.form("kullanici")
rs("ip")=request.servervariables("remote_addr")
rs("s")=request.form("s")
rs("url")=request.form("url")
rs.update
%>
<meta http-equiv="refresh" content="0;URL=?islem=ok&kullanici=<%=rs("kullanici")%>">
<%
end if
end if
end if
end if
%>

<%if (request.querystring("islem"))="ok" Then%>
<%
kullanici=request("kullanici")
Sorgu="Select * From genel"
Rs.Open Sorgu,bag,1,3
%>
<center><br><b><font face="Tahoma" size="2">Sayac� yerle�tirece�iniz b�l�me a�a��daki kodu kopyalay�p yap��t�rabilirsiniz.</font></b><br>
<br>
<textarea rows="5" cols="60" name="kod"><iframe name="Saya�" width="232" height="139" scrolling="no" border="0" frameborder="0" src="<%=rs("sayacyolu")%>?kullanici=<%response.write kullanici%>">_</iframe></textarea>
<br>
<br>
<b><font face="Tahoma" size="2">�nizleme:<br>
<iframe name="Saya�" width="232" height="139" scrolling="no" border="0" frameborder="0" src="sayac.asp?kullanici=<%response.write kullanici%>">_</iframe>
</font></b></center>
<%
END IF

Bag.Close
Set Bag=Nothing
%>