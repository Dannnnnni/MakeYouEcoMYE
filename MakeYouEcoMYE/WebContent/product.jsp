<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int id = Integer.parseInt(request.getParameter("id"));

	ProductDao pm = new ProductDao(DbCon.getConnection());
	Product product = pm.doRetrieveByKey(id);
%>

<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,mye.makeyoueco.model.*"%>

<head>
<%@include file="/includes/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Prodotto</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@include file="/includes/navbar.jsp"%>

	<a class="btn btn-primary" href="hub.jsp">&larr;</a>
	<table class="table">
	<caption>Prodotto</caption>
		<thead class="thead-dark">
			<tr>
				<th>Codice</th>
				<th>Nome</th>
				<th>Descrizione</th>
				<th>Prezzo</th>
				<th>Peso</th>
				<th>Immagine</th>
				<th>Quantità</th>
				<th>Iva</th>
				<th>Modifica</th>
				<th>Elimina</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=product.getId()%></td>
				<td><%=product.getName()%></td>
				<td><%=product.getDescription()%></td>
				<td><%=product.getPrice()%> &euro;</td>
				<td><%=product.getWeight()%></td>
				<td><img class="card-img-top"
					src="product-image/<%=product.getImage()%>" width="70" height="100" alt="Immagine non disponibile">
				<td><%=product.getQuantity()%></td>
				<td><%=product.getIva()%>%</td>
				<td><a href="update.jsp?id=<%=id%>">Modifica</a></td>
				<td><a href="product?action=delete&id=<%=id%>">Elimina</a></td>
			</tr>
		</tbody>
	</table>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>