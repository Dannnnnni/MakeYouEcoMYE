<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="mye.makeyoueco.model.*"%>


<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null || !auth.isAdministrator()) {
		response.sendRedirect("login.jsp");
	}

	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

	List<User> users = null;

	String email = (String) request.getSession().getAttribute("search_user");
	if (email==null)
		email = "";
	UserDao userDao = new UserDao(DriverManagerConnectionPool.getConnection());
	users = userDao.getAllUser();
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<link href="style-footer.css" rel="stylesheet" type="text/css">
<title>Ricerca di un utente</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

<div>
	<form class="mx-auto w-50" action="search_users" method="get">
		<div class="input-group">
			<input class="form-control rounded-0" type="search"
				placeholder="Inserisci l'email di un utente" aria-label="Search"
				name="email">
			<button class="btn btn-outline-success rounded-0" type="submit">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
</div>
	<table class="table">
	<caption>Utenti</caption>
		<thead class="thead-dark">
			<tr>
				<th>Codice Utente</th>
				<th>Email</th>
				<th>Nome</th>
				<th>Cognome</th>
				<th>Data di registrazione</th>
				<th>Telefono</th>
				<th>Dettagli</th>
			</tr>
		</thead>
		<tbody>

			<%
				if (!users.isEmpty()) {
					for (User user : users) {
							if (user.getEmail().toLowerCase().contains(email.toLowerCase())) {
			%>
			<tr>
				<td><%=user.getId()%></td>
				<td><%=user.getEmail()%></td>
				<td><%=user.getName()%></td>
				<td><%=user.getSurname()%></td>
				<td><%=user.getDateRegistration()%></td>
				<td><%=user.getTelephone()%></td>
				<td><a
					href="user_detail.jsp?id=<%=user.getId()%>&email=<%=user.getEmail()%>">Dettagli</a></td>
			</tr>
			<%
							}
						}
				} else {
					out.println("Nessun ordine");
				}
			%>
		</tbody>
	</table>


	<%@include file="/includes/footer.jsp"%>
</body>
</html>

