<!--#include file="sifre.asp"-->

<!--#include file="db.asp"-->

<head>
<meta http-equiv="Content-Language" content="tr">
</head>


<div align="center">
	<table border="1" width="477" id="table1" cellspacing="1">
		<tr>
			<td><b><font face="Tahoma" size="2">
			<img border="0" src="img/sayac.gif" width="20" height="20">
			<a href="?islem=uyeler"><font color="#000000">
			<span style="text-decoration: none">Kay�tl� �yeler</span></font></a></font></b></td>
			<td width="150"><b><font face="Tahoma" size="2">
			<img border="0" src="img/ip.gif" width="16" height="16">&nbsp;
			<a href="?islem=genel"><font color="#000000">
			<span style="text-decoration: none">Ayarlar</span></font></a></font></b></td>
			<td width="152">&nbsp;&nbsp; <b><font face="Tahoma" size="2">&nbsp;| 
			| <a href="sifre.asp?islem=cikis">
			<span style="text-decoration: none"><font color="#000000">Log Out</font></span></a> 
			| |</font></b></td>
		</tr>
	</table>
	<p><br>








<%IF request.querystring("islem")="genel" Then%>
<%
Sorgu="Select * From genel"
Rs.Open Sorgu,bag,1,3
%>
<form action="?islem=duzenle" method="post">
<font size="1" face="Tahoma"><b><font color="#FF0000">Sitenizin Adresi:</font>
</b>
<input name="siteadresi" size="54" value="<%=rs("siteadresi")%>" style="font-weight: 700"><b><br>
<font color="#FF0000">&nbsp;* Not: Buraya Sitenizin Adresinizi Yaz�n��zz! �rnek :
</font><a href="http://www.site.com/sayac/default.asp"><font color="#FF0000">
http://www.site.com/sayac/default.asp</font></a><font color="#FF0000"> gibi !..
<br>
�ste�e Ba�l� (</font>Saya�taki Sitene Ekle B�l�m� Linki<font color="#FF0000">)<br>
<br>
<br>
<br>
</font></b><font color="#808000"><b>Saya� Yolu (�NEML�):
</b>
<input name="sayacyolu" size="54" value="<%=rs("sayacyolu")%>" style="font-weight: 700"><b><br>
&nbsp;* �nemli Not: Sayac�n Bulundu�u Adresi Tam Yaz�n�z �rnek : </b> </font><b><a href="http://www.site.com/sayac/default.asp">
<font color="#808000">
http://www.site.com/sayac/sayac.asp</font></a><font color="#808000"> gibi !..
<br>
Bu Olay� Dikkate Almassan�z Saya� �al��maz!</font></b></font><b><br>
<br>
<br>
</b>
<font face="Tahoma"><b><font size="1" color="#000080">Admin 
�ifresi:</font></b><font color="#800000" size="1"><b> </b>
<input name="adminsifre" size="54" value="<%=rs("adminsifre")%>" style="font-weight: 700"><b>

<br>
</b>
</font><b><font size="1" color="#000080">* Not: T�rk�e Karakter Kullanmay�n 
�,�,�,�,�,� Gibi Harfleri �ifrede Kullanmay�n�z! ..</font></b></font><br><br>
<input type="submit" value="      D�zenle      "></form>

</div>
<%Rs.Close%>
<%end if%>







<%IF request.querystring("islem")="duzenle" Then%>
<%
Sorgu="Select * From genel"
Rs.Open Sorgu,bag,1,3

rs("siteadresi")=Request.Form("siteadresi")
rs("sayacyolu")=Request.Form("sayacyolu")
rs("adminsifre")=Request.Form("adminsifre")
rs.update
response.write"<br><br><center>Ayarlar Ba�ar�yla D�zenlendi.</center>"
end if
%>








<%IF request.querystring("islem")="uyeler" Then%>
<center><br>
<%
Sorgu="Select * From sayac"
Rs.Open Sorgu,bag,1,3
if rs.eof then
response.write"<center>Kay�tl� �ye Bulunamad�.</center>"
end if
do while not rs.eof
%>
<table border="1" width="354" id="table2" bordercolor="#C0C0C0" cellspacing="0" cellpadding="0">
	<tr>
		<td><b><font face="Tahoma" size="2">&nbsp;<%=rs("kullanici")%></font></b></td>
		<td width="40"><b><font face="Tahoma" size="2">&nbsp;<a target="_blank" href="<%=rs("url")%>"><font color="#000000">Web</font></a></font></b></td>
		<td width="30"><b><font face="Tahoma" size="2">&nbsp;<a href="?islem=sil&id=<%=rs("id")%>"><font color="#000000">S�L</font></a></font></b></td>
	</tr>
</table>
<br>
<%
Rs.Movenext
Loop
End if

%>
<p>&nbsp;</p>
</center>





<%IF request.querystring("islem")="sil" Then%>
<%
Sorgu="Delete * From sayac Where id=" & (Request.QueryString("id"))
Rs.Open Sorgu,bag,1,3
Response.Redirect"?islem=uyeler"
end if
%>