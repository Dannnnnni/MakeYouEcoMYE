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

	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

	int id = Integer.parseInt(request.getParameter("id"));

	ProductOrderDao pm = new ProductOrderDao(DriverManagerConnectionPool.getConnection());
	ArrayList<Product> products = pm.doRetrieveByKey(id);

	OrderDao o = new OrderDao(DriverManagerConnectionPool.getConnection());
	User user = o.getUserByOrder(id);
	String data = o.getOrderData(id);
	AddressPaymentDao ap = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
	Address a = ap.getAddressByKey(id);
	Payment py = ap.getPaymentByKey(id);
	
	
	if(!auth.isAdministrator()) {
		if(auth.getId() != user.getId()) {
			response.sendRedirect("index.jsp");
		}
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>

<%@include file="/includes/head.jsp"%>
<meta charset="UTF-8">
<title>Dettagli del tuo ordine</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<a class="btn btn-primary" href="hub.jsp">&larr;</a>
	
	<button class="btn btn-danger" onClick="generatePDF()">Scarica Fattura</button>

	<script src="https://unpkg.com/jspdf-invoice-template@1.4.0/dist/index.js"></script>
	<script>
	function generatePDF() {
		var pdfObject = jsPDFInvoiceTemplate.default(props);
	}
	
	const date = new Date();

	var props = {
		    outputType: jsPDFInvoiceTemplate.OutputType.Save,
		    returnJsPDFDocObject: true,
		    fileName: "Fattura Ordine #" + '<%=id%>',
		    orientationLandscape: false,
		    compress: true,
		    logo: {
		        src: "./product-image/logo.png",
		        type: 'PNG', //optional, when src= data:uri (nodejs case)
		        width: 35, //aspect ratio = width/height
		        height: 35,
		        margin: {
		            top: -5, //negative or positive num, from the current position
		            left: -5 //negative or positive num, from the current position
		        }
		    },
		    stamp: {
		        inAllPages: true, //by default = false, just in the last page
		        src: "https://raw.githubusercontent.com/edisonneza/jspdf-invoice-template/demo/images/qr_code.jpg",
		        type: 'JPG', //optional, when src= data:uri (nodejs case)
		        width: 20, //aspect ratio = width/height
		        height: 20,
		        margin: {
		            top: 0, //negative or positive num, from the current position
		            left: 0 //negative or positive num, from the current position
		        }
		    },
		    business: {
		        name: "MakeYouEco",
		        address: "Salerno, SA 84100, IT",
		        phone: "+ 39 089 11 22 33",
		        email: "makeyoueco@info.com",
/* 			        email_1: "info@example.al", */
		        website: "www.makeyoueco.it",
		    },
		    contact: {
		        label: "Fattura emessa per:",
		        name: '<%=user.getName()%>' + " " + '<%=user.getSurname()%>',
		        address: '<%=a.getCountry()%>' + ", " + '<%=a.getCity()%>',
		        phone: '<%=user.getTelephone()%>' ,
		        email: '<%=user.getEmail()%>',
/* 			        otherInfo: "www.website.al", */
		    },
		    invoice: {
		        label: "Fattura numero #: " + '<%=id%>',
		        num: 19,
		        invDate: "Data Pagamento: " + '<%=data%>',
		        invGenDate: "Data Emissione: " + date.getFullYear() + '-' + ('0' + (date.getMonth()+1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2),
		        headerBorder: false,
		        tableBodyBorder: false,
		        header: [
		          {
		            title: "#", 
		            style: { 
		              width: 10 
		            } 
		          }, 
		          { 
		            title: "Nome",
		            style: {
		              width: 30
		            } 
		          }, 
		          { 
		            title: "Descrizione",
		            style: {
		              width: 70
		            } 
		          }, 
		          
		          { title: "Prezzo"},
		          { title: "Quantità"},
		          { title: "Iva"}
		        ],
		        table: [
		            <% if (!products.isEmpty()) {
		            	for (int i = 0; i < products.size(); i++) {
		            		Product p = products.get(i);
		                   %> 
		                   [ 
		                     <%= i+1 %>, 
		                     '<%= p.getName() %>', 
		                     '<%= p.getDescription() %>', 
		                     '<%= p.getPrice() %>' + "\u20AC", 
		                     '<%= p.getQuantity() %>', 
		                     '<%= p.getIva() %>'
		                   ],
		                <% } 
		               } %> 
		          ],
				additionalRows: [{
		            col1: 'Total:',
		            col2: '8a',
		            col3: 'ALL',
		            style: {
		                fontSize: 14 //optional, default 12
		            }
		        },
		        {
		            col1: 'VAT:',
		            col2: '20',
		            col3: '%',
		            style: {
		                fontSize: 10 //optional, default 12
		            }
		        },
		        {
		            col1: 'SubTotal:',
		            col2: '116,199.90',
		            col3: 'ALL',
		            style: {
		                fontSize: 10 //optional, default 12
		            }
		        }],
		        invDescLabel: "TERMINI E CONDIZIONI",
		        invDesc: "1. Il Venditore non sarà responsabile nei confronti dell'Acquirente direttamente o indirettamente per eventuali perdite o danni subiti dall'Acquirente.\n"
		        	+"2. Il Venditore garantisce il prodotto per un (1) anno dalla data di spedizione.\n"
		        	+"3. Qualsiasi ordine di acquisto ricevuto dal venditore sarà interpretato come accettazione della presente offerta e dell'offerta di vendita per iscritto. L'acquirente può acquistare il prodotto in questa offerta solo in base ai Termini e condizioni del venditore inclusi in questa offerta.",
		    },
		    footer: {
		        text: "La fattura è creata a computer ed è valida senza la firma e il timbro.",
		    },
		    pageEnable: true,
		    pageLabel: "Page ",
		};
	</script>
	

	<table class="table">
	<caption>Indirizzo</caption>
		<thead class="thead-dark">
			<tr>
				<th>Via</th>
				<th>CAP</th>
				<th>Città</th>
				<th>Provincia</th>
				<th>Paese</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=a.getStreet()%></td>
				<td><%=a.getZipCode()%></td>
				<td><%=a.getCity()%></td>
				<td><%=a.getProvince()%></td>
				<td><%=a.getCountry()%></td>
			</tr>
		</tbody>
	</table>


	<table class="table">
	<caption>Pagamento</caption>
		<thead class="thead-dark">
			<tr>
				<th>Nome</th>
				<th>Cognome</th>
				<th>Numero Carta</th>
				<th>CVV</th>
				<th>Scadenza</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=py.getFirstName()%></td>
				<td><%=py.getLastName()%></td>
				<td><%=py.getCardNumber()%></td>
				<td><%=py.getCVV()%></td>
				<td><%=py.getExpiryMonth()%> / <%=py.getExpiryYear()%></td>
			</tr>
		</tbody>
	</table>

	<table class="table">
	<caption>Prodotti</caption>
		<thead class="thead-dark">
			<tr>
				<th>Nome</th>
				<th>Descrizione</th>
				<th>Prezzo</th>
				<th>Quantità</th>
				<th>Iva</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (!products.isEmpty()) {
					for (Product p : products) {
			%>
			<tr>
				<td><%=p.getName()%></td>
				<td><%=p.getDescription()%></td>
				<td><%=p.getPrice()%> &euro;</td>
				<td><%=p.getQuantity()%></td>
				<td><%=p.getIva()%> %</td>
			</tr>
			<%
				}
				} else {
					out.println("Nessun ordine");
				}
			%>
		</tbody>
	</table>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>