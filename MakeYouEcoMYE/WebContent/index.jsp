<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="mye.makeyoueco.model.Product"%>
<%@ page import="mye.makeyoueco.model.ProductDao"%>
<%@ page import="mye.makeyoueco.model.Cart"%>
<%@ page import="mye.makeyoueco.model.User"%>
<%@ page import="mye.makeyoueco.model.DriverManagerConnectionPool"%>


<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		request.setAttribute("person", auth);
	}
	ProductDao pm = new ProductDao(DriverManagerConnectionPool.getConnection());
	List<Product> products = pm.doRetrieveAll(null);

	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

	String product = (String) request.getAttribute("search");

	if (product == null) {
		product = "";
	}
	
%>
<!DOCTYPE html>
<html lang="it">
<head>
<%@include file="/includes/head.jsp"%>
<title>Pagina Iniziale</title>
<link href="style.css" rel="stylesheet" type="text/css">
<link href="style-footer.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<!-- 	<iframe src="menu.jsp" name="targetframe" style="position:absolute;top:100px;left:0;width:100%;height:100%;
		allowTransparency="true" scrolling="yes" frameborder="0"> </iframe>
 	-->

	<div class="container">
		<div class="card-header my-3">Tutti i nostri prodotti</div>

		<div class="row">
			<%
				if (!products.isEmpty()) {
					for (Product p : products) {
						if (p.getName().toLowerCase().contains(product.toLowerCase())) {
			%>
			<div class="col-md-3 my-3" height="500">
				<div class="card w-100">
					<a href="item.jsp?id=<%=p.getId()%>"> <img class="card-img-top"
						src="product-image/<%=p.getImage()%>" width="300" height="200"
						alt="Immagine mancante" style="object-fit: cover;">
					</a>
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							Prezzo:
							<%=p.getPrice()%>&euro;
						</h6>
						<div class="mt-3 d-flex justify-content-between">
							<a class="btn btn-success" href="add-to-cart?id=<%=p.getId()%>"
								target=_self><i class="fa fa-shopping-cart"></i></a> <a class="btn btn-primary"
								href="add-to-cart?id=<%=p.getId()%>&order-now=yes"><i class="fas fa-home mr-3"></i></a>
						</div>
					</div>
				</div>
			</div>
			<%
				}
					}
				} else {
					out.println("Nessun prodotto");
				}
			%>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>