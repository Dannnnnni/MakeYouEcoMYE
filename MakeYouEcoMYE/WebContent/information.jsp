<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="mye.makeyoueco.model.*"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null) {
		response.sendRedirect("login.jsp");
	}

	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}
	
	ArrayList<Address> addresses = new ArrayList<Address>();
	ArrayList<Payment> payments = new ArrayList<Payment>();
	
	if (auth != null) {
		AddressPaymentDao ap = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
		addresses = ap.getAllAddress(auth.getId());
		payments = ap.getAllPayment(auth.getId());
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<title>Informazioni personali</title>
<!-- <link href="style-footer.css" rel="stylesheet" type="text/css"> -->
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div align="center">
		<a class="btn btn-dark" href="insert_address_payment.jsp">Inserisci informazioni di pagamento o indirizzo</a>
	</div>

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
				<td><%=a.getZip_code()%></td>
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
				<td><%=py.getFirst_name()%></td>
				<td><%=py.getLast_name()%></td>
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

<%-- 	<%@include file="/includes/footer.jsp"%> --%>
</body>
</html>