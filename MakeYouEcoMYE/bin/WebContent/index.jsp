<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="mye.makeyoueco.model.Product"%>
<%@ page import="mye.makeyoueco.model.ProductDao"%>
<%@ page import="mye.makeyoueco.model.DbCon"%>

<%
	ProductDao pm = new ProductDao(DbCon.getConnection());
	List<Product> products = pm.doRetrieveAll(null);
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>Pagina Iniziale</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">Tutti i prodotti</div>
		<div class="row">
			<%
				if (!products.isEmpty()) {
					for (Product p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100">
					<img class="card-img-top" src="product-image/<%=p.getImage()%>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							Price: $<%=p.getPrice()%></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Carrello</a>
							<a class="btn btn-primary"
								href="order-now?quantity=1&id=<%=p.getId()%>">Acquista</a>
						</div>
					</div>
				</div>
			</div>
			<%
				}
				} else {
					out.println("There is no proucts");
				}
			%>

		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>