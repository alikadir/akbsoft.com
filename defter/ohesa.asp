<%
Set zdconn = Server.CreateObject("adodb.connection")
zdconn.open "Provider=Microsoft.Jet.Oledb.4.0;data Source=" & Server.MapPath("db/defterimiz.mdb")
%>

<%
sayfas = "10"                 'Sayfada gösterilen mesaj adeti
%>