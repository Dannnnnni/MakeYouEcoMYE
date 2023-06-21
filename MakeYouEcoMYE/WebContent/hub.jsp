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

	ProductDao pm = new ProductDao(DriverManagerConnectionPool.getConnection());
	List<Product> products = pm.doRetrieveAll(null);
%>
<!DOCTYPE html>
<html lang="it">
<head>
<%@include file="/includes/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Prodotto</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@include file="/includes/navbar.jsp"%>
	<div align="center">
	<a class="btn btn-dark" href="insert_product.jsp">Inserisci un nuovo
		prodotto</a>

	<a class="btn btn-dark" href="search_orders.jsp">Cerca un ordine</a>
	
	<a class="btn btn-dark" href="search_user.jsp">Cerca un utente</a>
	
	</div>
	<br>
	<table class="table">
		<caption>Prodotti</caption>
		<thead class="thead-dark">
			<tr>
				<th>Codice</th>
				<th>Nome</th>
				<th>Prezzo</th>
				<th>Quantità</th>
				<th>Dettagli</th>
				<th>Modifica</th>
				<th>Elimina</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (!products.isEmpty()) {
					for (Product p : products) {
			%>
			<tr>
				<td><%=p.getId()%></td>
				<td><%=p.getName()%></td>
				<td><%=p.getPrice()%> &euro;</td>
				<td><%=p.getQuantity()%></td>
				<td><a href="product.jsp?id=<%=p.getId()%>">Dettagli</a></td>
				<td><a href="update.jsp?id=<%=p.getId()%>">Modifica</a></td>
				<td><a href="product?action=delete&id=<%=p.getId()%>">Elimina</a></td>
			</tr>
			<%
				}
				} else {
					out.println("Nessun prodotto");
				}
			%>
		</tbody>
	</table>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>