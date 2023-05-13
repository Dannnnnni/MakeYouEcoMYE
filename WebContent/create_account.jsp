<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<title>Crea un nuovo account</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>


	<a class="btn btn-primary" href="index.jsp">&larr;</a>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Crea il tuo account</div>
			<div class="card-body">
				<form action="create-account" method="post">
					<input type="hidden" name="action" value="insert">
					<div class="form-group">
						<label>Nome</label> <input type="text" name="name"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label>Cognome</label> <input type="text" name="surname"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label>Email</label> <input type="email" name="email"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label>Password</label> <input type="password" name="password"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label>Numero di telefono</label> <input type="text"
							name="telephone" class="form-control" required> <br>
						<div class="text-center">
							<button type="submit" class="btn btn-primary">Registrati</button>
						</div>
				</form>
			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>

</body>
</html>