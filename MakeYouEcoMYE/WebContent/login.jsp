<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>


<%
	String wrong = (String) request.getAttribute("wrong-credential");

	if (wrong == null) {
		wrong = "";
	}
	
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		response.sendRedirect("index.jsp");
	}
	
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<link href="style-footer.css" rel="stylesheet" type="text/css">
<title>Pagina di Login</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Login Utente</div>
			<div class="card-body">
 				<%
					String error = "";
					if(wrong!=null && wrong.equals("yes"))
						error = "Nome e password errati o non esistenti!";
				%>
				<p style="color:red;"><%=error%></p>
				<form action="user-login" method="post">
					<div class="form-group">
						<label>Indirizzo Email</label> <input type="email"
							name="login-email" class="form-control"
							placeholder="Inserisci il tuo indirizzo email" required>
					</div>
					<div class="form-group">
						<label>Password</label> <input type="password"
							name="login-password" class="form-control"
							placeholder="Inserisci la tua password" required>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
				<br>
				<div class="text-center">
					<a class="btn btn-primary" href="create_account.jsp">Registrati</a>
				</div>

			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>

