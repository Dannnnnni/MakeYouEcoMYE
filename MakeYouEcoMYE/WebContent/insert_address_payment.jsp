<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mye.makeyoueco.model.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	ArrayList<Address> addresses = new ArrayList<Address>();
	ArrayList<Payment> payments = new ArrayList<Payment>();
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null) {
		response.sendRedirect("login.jsp");
	} else {
		/* 	ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
		
			if (cart_list == null || cart_list.size() == 0) {
				response.sendRedirect("login.jsp");
			} */

		AddressPaymentDao ap = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
		addresses = ap.getAllAddress(auth.getId());
		payments = ap.getAllPayment(auth.getId());
	}

	Address address = new Address();
	address = (Address) request.getSession().getAttribute("address");

	Payment payment = new Payment();
	payment = (Payment) request.getSession().getAttribute("payment");
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<title>Pagina di pagamento</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

			<div class="container">
				<div class="fieldset-container">
					<form action="information?action=insertAddress" method="post">

						<fieldset>
							<legend>Inserisci il tuo indirizzo di consegna</legend>
							<div class="form-group">
								<label>Via</label> <input type="text" name="address-street"
									class="form-control" required> <label>CAP</label> <input
									type="number" name="address-zipcode" class="form-control"
									required> <label>Città</label> <input type="text"
									name="address-city" class="form-control" required> <label>Provincia</label>
								<input type="text" name="address-province" class="form-control"
									required> <label>Paese</label> <input type="text"
									name="address-country" class="form-control" required> <label>Istruzioni
									di consegna</label> <input type="text" name="address-instructions"
									class="form-control" required>
							</div>
						</fieldset>
						<div class="text-center">
							<button type="submit" class="btn btn-primary">Inserisci</button>
						</div>
					</form>

				</div>
				<div class="fieldset-container">
					<form action="information?action=insertPayment" method="post">
						<fieldset>
							<legend>Inserisci i dati di pagamento</legend>
							<div class="form-group">
								<label>Nome</label> <input type="text" name="payment-name"
									class="form-control" required> <label>Cognome</label> <input
									type="text" name="payment-surname" class="form-control"
									required> <label>Numero Carta</label> <input
									type="number" name="payment-number" class="form-control"
									placeholder="XXXX XXXX XXXX XXXX" maxlength="16" required>
								<label>CVV</label> <input type="number" name="payment-cvv"
									class="form-control" maxlength="3" required> <label>Mese
									di scadenza</label> <input type="number" name="payment-month"
									class="form-control" maxlength="2" required> <label>Anno
									di scadenza</label> <input type="number" name="payment-year"
									class="form-control" maxlength="4" required>
							</div>

							<div class="text-center">
								<button type="submit" class="btn btn-primary">Inserisci</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>

	<%@include file="/includes/footer.jsp"%>


	<style>
	.container {
		display: flex;
		justify-content: space-between;
	}
	
	.fieldset-container {
		width: 50%;
		margin-right: 5%;
	}
	</style>
	
</body>
</html>