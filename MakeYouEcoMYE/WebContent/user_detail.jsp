<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mye.makeyoueco.model.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null || !auth.isAdministrator()) {
		response.sendRedirect("login.jsp");
	}

	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

	String email = request.getParameter("email");
	int id = Integer.parseInt(request.getParameter("id"));

	OrderDao od = new OrderDao(DriverManagerConnectionPool.getConnection());
	List<Order> orders = od.getOrderById(email);

	UserDao ud = new UserDao(DriverManagerConnectionPool.getConnection());
	User user = ud.getUserById(id);

	ArrayList<Address> addresses = new ArrayList<Address>();
	ArrayList<Payment> payments = new ArrayList<Payment>();

	AddressPaymentDao ap = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
	addresses = ap.getAllAddress(id);
	payments = ap.getAllPayment(id);
%>
<!DOCTYPE html>
<html lang="it">
<head>

<%@include file="/includes/head.jsp"%>
<meta charset="UTF-8">
<title>Dettagli dell'utente</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<a class="btn btn-primary" href="hub.jsp">&larr;</a>



	<table class="table">
	<caption>Utente</caption>
		<thead class="thead-dark">
			<tr>
				<th>Codice Utente</th>
				<th>Email</th>
				<th>Nome</th>
				<th>Cognome</th>
				<th>Data di registrazione</th>
				<th>Telefono</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=user.getId()%></td>
				<td><%=user.getEmail()%></td>
				<td><%=user.getName()%></td>
				<td><%=user.getSurname()%></td>
				<td><%=user.getDateRegistration()%></td>
				<td><%=user.getTelephone()%></td>
			</tr>
		</tbody>
	</table>

	<table class="table">
	<caption>Ordini</caption>
		<thead class="thead-dark">
			<tr>
				<th>Codice Ordine</th>
				<th>Quantità Articoli</th>
				<th>Data Ordine</th>
				<th>Costo Totale</th>
				<th>Stato</th>
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


	<table class="table">
	<caption>Indirizzi</caption>
		<thead class="thead-dark">
			<tr>
				<th>Via</th>
				<th>CAP</th>
				<th>Città</th>
				<th>Provincia</th>
				<th>Paese</th>
				<th>Istruzioni</th>
				<th>Elimina</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (!addresses.isEmpty()) {
					for (Address a : addresses) {
			%>
			<tr>
				<td><%=a.getStreet()%></td>
				<td><%=a.getZipCode()%></td>
				<td><%=a.getCity()%></td>
				<td><%=a.getProvince()%></td>
				<td><%=a.getCountry()%></td>
				<td><%=a.getInstructions()%></td>
				<td><a
					href="information?action=deleteAddress&id=<%=a.getId()%>">Elimina</a></td>
			</tr>
			<%
				}
				} else {
					out.println("Nessun indirizzo");
				}
			%>
		</tbody>
	</table>


	<table class="table">
	<caption>Pagamenti</caption>
		<thead class="thead-dark">
			<tr>
				<th>Nome</th>
				<th>Cognome</th>
				<th>Numero Carta</th>
				<th>CVV</th>
				<th>Scadenza</th>
				<th>Elimina</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (!payments.isEmpty()) {
					for (Payment py : payments) {
			%>
			<tr>
				<td><%=py.getFirstName()%></td>
				<td><%=py.getLastName()%></td>
				<td><%=py.getCardNumber()%></td>
				<td><%=py.getCVV()%></td>
				<td><%=py.getExpiryMonth()%> / <%=py.getExpiryYear()%></td>
				<td><a
					href="information?action=deleteAddress&id=<%=py.getId()%>">Elimina</a></td>
			</tr>
			<%
				}
				} else {
					out.println("Nessun metodo di pagamento");
				}
			%>
		</tbody>
	</table>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>