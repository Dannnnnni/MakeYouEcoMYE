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

	List<Order> orders = null;
	List<User> users = null;

	orders = (ArrayList<Order>) request.getSession().getAttribute("search_order");

	if (orders == null || orders.isEmpty()) {
		OrderDao orderDao = new OrderDao(DriverManagerConnectionPool.getConnection());
		orders = orderDao.getAllOrders();
	}

	if (auth != null) {
		UserDao userDao = new UserDao(DriverManagerConnectionPool.getConnection());
		users = userDao.getAllUser();
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<link href="style-footer.css" rel="stylesheet" type="text/css">
<title>Ricerca di un ordine</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>


	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Cerca per utente e per
				data</div>
			<div class="card-body">

				<form action="search_orders" method="post">
					<select name="email">
						<option value="0">Seleziona un utente</option>

						<%
							if (!users.isEmpty()) {
								for (User user : users) {
						%>

						<option value="<%=user.getEmail()%>"><%=user.getEmail()%></option>

						<%
								}
							}
						%>
					</select>

					<div class="form-group">
						<label>Data di inizio</label> <input type="date" name="start-date"
							class="form-control">
					</div>
					<div class="form-group">
						<label>Data di fine</label> <input type="date" name="end-date"
							class="form-control">
					</div>

					<input class="btn btn-primary" type="submit" value="Seleziona">
				</form>
			</div>
		</div>
	</div>

	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>Codice Ordine</th>
				<th>Quantità Articoli</th>
				<th>Data Ordine</th>
				<th>Costo Totale</th>
				<th>Stato</th>
				<th>Imposta</th>
				<th>Dettagli</th>
			</tr>
		</thead>
		<tbody>

			<%
				if (!orders.isEmpty()) {
					for (Order o : orders) {
			%>
			<tr>
				<td><%=o.getId()%></td>
				<td><%=o.getQuantity()%></td>
				<td><%=o.getDate()%></td>
				<td><%=o.getTotalCost()%> &euro;</td>
				<td><%=o.getStatus()%></td>
				<td><a href="set-status-order?id=<%=o.getId()%>&status=completato">Completa</a></td>
				<td><a href="order_detail.jsp?id=<%=o.getId()%>">Dettagli</a></td>
			</tr>
			<%
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

