<html>
<head>
<!-- #include file="ohesa.asp" -->
<%
kullanici = Request.Form("kullanici")
parola = Request.Form("parola")
If Kullanici="" or Parola="" Then
Response.Write "L�tfen Admin Ad� ve Parolas�n� Do�ru Giriniz"
Response.end
End If
sql="select * From zdgenel where kullanici = '"& kullanici &"' and '"& parola &" '"
Set kontrol = zdconn.ExeCute(sql)
If Kontrol.eof Then
Response.Write "B�yle kay�t yok"
Else
Session("Adminmisin") = "Evet"
Session("id") = Kontrol("id")
Session("kullanici") = Kontrol("Kullanici")
Response.Redirect "admin.asp"
End If %>