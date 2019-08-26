



<%
Set Bag = Server.CreateObject("ADODB.Connection")
Bag.Open "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("db/db.mdb")
Set Rs=Server.CreateObject("Adodb.Recordset")
%>