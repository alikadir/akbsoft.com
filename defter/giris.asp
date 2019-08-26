<html>
<head>
<!-- #include file="ohesa.asp" -->
<%
kullanici = Request.Form("kullanici")
parola = Request.Form("parola")
If Kullanici="" or Parola="" Then
Response.Write "Lütfen Admin Adý ve Parolasýný Doðru Giriniz"
Response.end
End If
sql="select * From zdgenel where kullanici = '"& kullanici &"' and '"& parola &" '"
Set kontrol = zdconn.ExeCute(sql)
If Kontrol.eof Then
Response.Write "Böyle kayýt yok"
Else
Session("Adminmisin") = "Evet"
Session("id") = Kontrol("id")
Session("kullanici") = Kontrol("Kullanici")
Response.Redirect "admin.asp"
End If %>