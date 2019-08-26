




<!--#include file="db.asp"-->
<%
kullanici=request.querystring("kullanici")
Sorgu="Select * From Sayac Where kullanici='"&kullanici&"'"
Rs.Open Sorgu,bag,1,3
%>
<head>
<title><%=rs("kullanici")%></title>
</head>
<%
Rs("s")=Rs("s")+1
rs.update
%>

<body bgcolor="#FFFFFF" topmargin="3" bottommargin="0"><div align="center">
	<table border="0" width="205" id="table1" cellpadding="2" bordercolor="#F3F3F3" height="56" style="border-left-width:1px; border-right-width:1px; border-bottom-width:1px" bgcolor="#F7F7F7">
		<tr>
			<td width="67" bordercolor="#00FF00" bgcolor="#FFFFFF" style="font-size: 12pt; color: #FF00FF; font-weight: bold"><font face="Tahoma" size="2"><img src="img/sayac.gif">&nbsp;Saya�:</font></td>
			<td width="123" bordercolor="#00FF00" bgcolor="#FFFFFF" style="font-size: 12pt; color: #008000; font-weight: bold">
			<b><font face="Tahoma" size="2">
			&nbsp;<%=rs("s")%></font></b></td>
		</tr>
		<tr>
			<td width="67" bordercolor="#00FF00" bgcolor="#FFFFFF" style="font-size: 12pt; color: #FF00FF; font-weight: bold"><font face="Tahoma" size="2">&nbsp;<img src="img/ip.gif">&nbsp; 
			Ip No:</font></td>
			<td width="123" bordercolor="#00FF00" bgcolor="#FFFFFF" style="font-size: 12pt; color: #800000; font-weight: bold"><b><font face="Tahoma" size="2">&nbsp;<% =request.servervariables("remote_addr") %></font></b></td>
		</tr>
	</table>
	<p>
	<%Rs.Close%><b><font color="#FFFF00"><a href="http://www.adilcevazasyader.com/sayac/yonetim.asp"><font color="#FFFF00"> 
	</font></a></font></b>
</div>
<%
Rs.Close
Set Rs=nothing
bag.close
set bag=nothing
%>