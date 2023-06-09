<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int id = Integer.parseInt(request.getParameter("id"));

	ProductDao pm = new ProductDao(DbCon.getConnection());
	Product product = pm.doRetrieveByKey(id);
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,mye.makeyoueco.model.*"%>
<head>
<%@include file="/includes/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Prodotto</title>
<link href="style-item.css" rel="stylesheet" type="text/css">
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="image-container">
			<img class="card-img-top" src="product-image/<%=product.getImage()%>"
				alt="Immagine mancante">
		</div>
		<div class="paragraphs-container">
			<h1><strong><%=product.getName()%></strong></h1><br>
			<h2><%=product.getDescription()%></h2><br>
			<h3>Prezzo: <%=product.getPrice()%> &euro;</h3><br>
			<h4>Peso: <%=product.getWeight()%> kg</h4> <br>
			<a class="btn btn-dark"	href="add-to-cart?id=<%=product.getId()%>">Carrello</a>
			<a class="btn btn-primary" href="add-to-cart?id=<%=product.getId()%>&order-now=yes">Acquista</a>
		</div>
	</div>
	<br><br><br>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>