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
	int id = Integer.parseInt(request.getParameter("id"));
	Product product = pm.doRetrieveByKey(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<link href="style-footer.css" rel="stylesheet" type="text/css">
<title>Modifica prodotto</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<a class="btn btn-primary" href="hub.jsp">&larr;</a>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Modifica di un prodotto</div>
			<div class="card-body">
				<form action="product" method="post">
					<input type="hidden" name="action" value="update">
					<input type="hidden" name="id" value="<%=id%>">
					

					<div class="form-group">
						<label>Nome</label> <input type="text" name="name"
							class="form-control" placeholder="<%=product.getName()%>" required>
					</div>
					<div class="form-group">
						<label>Descrizione</label> <input type="text" name="description"
							class="form-control" placeholder="<%=product.getDescription()%>" required>
					</div>
					<div class="form-group">
						<label>Prezzo</label> <input type="number" name="price"
							class="form-control" placeholder="<%=product.getPrice()%>" required>
					</div>
					<div class="form-group">
						<label>Peso</label> <input type="number" name="weight"
							class="form-control" placeholder="<%=product.getWeight()%>" required>
					</div>
					<div class="form-group">
						<label>Immagine</label> <input type="text" name="image"
							class="form-control" placeholder="<%=product.getImage()%>" required>
					</div>
					<div class="form-group">
						<label>Quantità</label> <input type="number" name="quantity"
							class="form-control" placeholder="<%=product.getQuantity()%>" required>
					</div>
					<div class="form-group">
						<label>Iva</label> <input type="number" name="iva"
							class="form-control" placeholder="<%=product.getIva()%>" required>
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn-primary">Modifica</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>

</body>
</html>