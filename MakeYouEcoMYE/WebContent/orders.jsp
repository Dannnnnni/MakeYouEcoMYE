<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mye.makeyoueco.model.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null) {
		response.sendRedirect("login.jsp");
	}
	
	
/* 	if(!auth.isAdministrator()) {
		if(!)
		
	} */
	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

	List<Order> orders = null;
	if (auth != null) {
		OrderDao orderDao = new OrderDao(DriverManagerConnectionPool.getConnection());
		orders = orderDao.userOrders(auth.getId());
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<title>Pagina degli Ordini</title>
<!-- <link href="style-footer.css" rel="stylesheet" type="text/css"> -->
<%@include file="/includes/head.jsp"%>
</head>
<body>

	<%@include file="/includes/navbar.jsp"%>

	<table class="table">
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


<%-- 	<%@include file="/includes/footer.jsp"%> --%>
</body>
</html>