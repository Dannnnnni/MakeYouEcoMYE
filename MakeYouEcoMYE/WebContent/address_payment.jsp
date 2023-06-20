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
		
		ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
		if(cart_list == null || cart_list.size() == 0)
			response.sendRedirect("index.jsp");
		
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

	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Login Utente</div>
			<div class="card-body">
				<label>Indirizzi:</label>

				<form action="information?action=selectAddress" method="post">
					<select name="addressId">
						<%
							if (!addresses.isEmpty()) {
								for (Address a : addresses) {
						%>

						<option value="<%=a.getId()%>"><%=a.getStreet() + " " + a.getZip_code() + ", " + a.getCountry()%></option>

						<%
							}
							}
						%>
					</select> <input class="btn btn-primary" type="submit" value="Seleziona">
				</form>
				<br>
				<form action="information?action=clearAddress" method="post">
					<button type="submit" class="btn btn-danger">Pulisci
						Indirizzo</button>
				</form>
				<br>
				<form action="information?action=selectPayment" method="post">
					<select name="paymentId">
						<%
							if (!payments.isEmpty()) {
								for (Payment p : payments) {
						%>

						<option value="<%=p.getId()%>"><%=p.getFirst_name() + " " + p.getExpiryMonth() + "/" + p.getExpiryYear()%></option>

						<%
							}
							}
						%>
					</select> <input class="btn btn-primary" type="submit" value="Seleziona">
				</form>
				<br>
				<form action="information?action=clearPayment" method="post">
					<button type="submit" class="btn btn-danger">Pulisci
						Pagamento</button>

				</form>

				<%
					if (address == null && payment == null) {
				%>
				<form action="cart-check-out" method="post">

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
							</legend>

							<div class="text-center">
								<button type="submit" class="btn btn-primary">Invia</button>
							</div>
				</form>

				<%
					} else if (address != null && payment == null) {
				%>
				<form action="cart-check-out" method="post">

					<fieldset>
						<div class="form-group">
							<label>Via</label> <input type="text" name="address-street"
								class="form-control" value="<%=address.getStreet()%>" required
								readonly><label>CAP</label> <input type="number"
								name="address-zipcode" class="form-control"
								value="<%=address.getZip_code()%>" required readonly> <label>Città</label>
							<input type="text" name="address-city" class="form-control"
								value="<%=address.getCity()%>" required readonly><label>Provincia</label>
							<input type="text" name="address-province" class="form-control"
								value="<%=address.getProvince()%>" required readonly><label>Paese</label><input
								type="text" name="address-country" class="form-control"
								value="<%=address.getCountry()%>" required readonly><label>Istruzioni
								di consegna</label><input type="text" name="address-instructions"
								class="form-control" value="<%=address.getInstructions()%>"
								required readonly>
						</div>

						<fieldset>
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
							</legend>

							<input type="hidden" name="existingAddress" value="yes"
								class="form-input">

							<div class="text-center">
								<button type="submit" class="btn btn-primary">Invia</button>
							</div>
				</form>
				<%
					} else if (address == null && payment != null) {
				%>
				<form action="cart-check-out" method="post">
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

						<fieldset>
							<div class="form-group">
								<label>Nome</label> <input type="text" name="payment-name"
									class="form-control" value="<%=payment.getFirst_name()%>"
									required readonly> <label>Cognome</label> <input
									type="text" name="payment-surname" class="form-control"
									value="<%=payment.getLast_name()%>" required readonly>
								<label>Numero Carta</label> <input type="number"
									name="payment-number" class="form-control"
									placeholder="XXXX XXXX XXXX XXXX" maxlength="16"
									value="<%=payment.getCardNumber()%>" required readonly>
								<label>CVV</label> <input type="number" name="payment-cvv"
									class="form-control" maxlength="3"
									value="<%=payment.getCVV()%>" required readonly> <label>Mese
									di scadenza</label> <input type="number" name="payment-month"
									class="form-control" maxlength="2"
									value="<%=payment.getExpiryMonth()%>" required readonly>
								<label>Anno di scadenza</label> <input type="number"
									name="payment-year" class="form-control" maxlength="4"
									value="<%=payment.getExpiryYear()%>" required readonly>
							</div>
							</legend>

							<input type="hidden" name="existingPayment" value="yes"
								class="form-input">

							<div class="text-center">
								<button type="submit" class="btn btn-primary">Invia</button>
							</div>
				</form>
				<%
					} else if (address != null && payment != null) {
				%>
				<form action="cart-check-out" method="post">
					<fieldset>
						<div class="form-group">
							<label>Via</label> <input type="text" name="address-street"
								class="form-control" value="<%=address.getStreet()%>" required
								readonly><label>CAP</label> <input type="number"
								name="address-zipcode" class="form-control"
								value="<%=address.getZip_code()%>" required readonly> <label>Città</label>
							<input type="text" name="address-city" class="form-control"
								value="<%=address.getCity()%>" required readonly><label>Provincia</label>
							<input type="text" name="address-province" class="form-control"
								value="<%=address.getProvince()%>" required readonly><label>Paese</label><input
								type="text" name="address-country" class="form-control"
								value="<%=address.getCountry()%>" required readonly><label>Istruzioni
								di consegna</label><input type="text" name="address-instructions"
								class="form-control" value="<%=address.getInstructions()%>"
								required readonly>
						</div>
						<fieldset>
							<div class="form-group">
								<label>Nome</label> <input type="text" name="payment-name"
									class="form-control" value="<%=payment.getFirst_name()%>"
									required readonly> <label>Cognome</label> <input
									type="text" name="payment-surname" class="form-control"
									value="<%=payment.getLast_name()%>" required readonly>
								<label>Numero Carta</label> <input type="number"
									name="payment-number" class="form-control"
									placeholder="XXXX XXXX XXXX XXXX" maxlength="16"
									value="<%=payment.getCardNumber()%>" required readonly>
								<label>CVV</label> <input type="number" name="payment-cvv"
									class="form-control" maxlength="3"
									value="<%=payment.getCVV()%>" required readonly> <label>Mese
									di scadenza</label> <input type="number" name="payment-month"
									class="form-control" maxlength="2"
									value="<%=payment.getExpiryMonth()%>" required readonly>
								<label>Anno di scadenza</label> <input type="number"
									name="payment-year" class="form-control" maxlength="4"
									value="<%=payment.getExpiryYear()%>" required readonly>
							</div>
							</legend>

							<input type="hidden" name="existingAddress" value="yes"
								class="form-input"> <input type="hidden"
								name="existingPayment" value="yes" class="form-input">


							<div class="text-center">
								<button type="submit" class="btn btn-primary">Invia</button>
							</div>
				</form>
				<%
					}
				%>

			</div>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>