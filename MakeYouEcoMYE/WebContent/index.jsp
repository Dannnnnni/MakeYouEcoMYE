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
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<%@include file="/includes/head.jsp"%>
<title>Pagina Iniziale</title>
<link href="style.css" rel="stylesheet" type="text/css">
<link href="style-footer.css" rel="stylesheet" type="text/css">
<link href="style-slider.css" rel="stylesheet" type="text/css">


</head>
<body>

<script>
$(document).ready(function() {
	  $('.immagine-ingrandibile').mouseenter(function() {
	    $(this).css('transform', 'scale(1.5)');
	  }).mouseleave(function() {
	    $(this).css('transform', 'scale(1)');
	  });
	});
</script>
	<%@include file="/includes/navbar.jsp"%>

	<!-- 	<iframe src="menu.jsp" name="targetframe" style="position:absolute;top:100px;left:0;width:100%;height:100%;
		allowTransparency="true" scrolling="yes" frameborder="0"> </iframe>
 	-->
 	
 	<style type="text/css">
 	
 	#slider {
 		overflow: hidden;
 	}
 	
 	#slider figure {
 		position: relative;
 		width: 250%;
 		margin: 0;
 		left: 0;
 		animation: 15s slider infinite; 	
 	}
 	
 	#slider figure img {
 		float: left;
 		width: 20%;
 	}
 	
 	@keyframes slider {
 		0% {
 			left: 0;
 		}
 		15% {
 			left: 0;
 		}
 		30% {
 			left: 0%;
 		}
 		45% {
 			left: -50%;
 		}
 		50% {
 			left: -50%;
 		}
 		55% {
 			left: -50%;
 		}
 		70% {
 			left: -100%;
 		}
 		85% {
 			left: -100%;
 		}
 		100% {
 			left: 0%;
 		}
 	}
 	</style>
 	<div id="slider">
        <figure>
        	<img src="product-image/image1.jpg">
        	<img src="product-image/image2.jpg">
        	<img src="product-image/image3.jpg">
        	<img src="product-image/image4.jpg">
        	<img src="product-image/image5.png">
        </figure>
    </div>
       
<style>
.bubbles
{
	position: relative;
	display: flex;
	z-index: -100;
}

.bubbles span
{
	position: relative;
	width: 30px;
	height: 30px;
	background: #4fc3dc;
	margin: 0 4px;
	border-radius: 50%;
	box-shadow: 0 0 0 10px #4fc3dc44, 0 0 50px #4fc3dc, 0 0 100px #4fc3dc;
	animation: animate 25s linear infinite;
	animation-duration: calc(125s / var(--i));
}

.bubbles span:nth-child(even)
{
	background: #00ffd8;
	box-shadow: 0 0 0 10px #2cffdf, 0 0 50px #2cffdf, 0 0 100px #2cffdf;
}

@keyframes animate
{
	0%
	{
		transform: translateY(500vh) scale(0);
	}
	100%
	{
		transform: translateY(-100vh) scale(1);
	}
}

</style>
	<div class="container">
    	<div class="bubbles">
    		<span style="--i:11;"></span>
    		<span style="--i:12;"></span>
    		<span style="--i:24;"></span>
    		<span style="--i:10;"></span>
    		<span style="--i:14;"></span>
    		<span style="--i:23;"></span>
    		<span style="--i:18;"></span>
    		<span style="--i:16;"></span>
    		<span style="--i:19;"></span>
    		<span style="--i:20;"></span>
    		<span style="--i:22;"></span>
    		<span style="--i:15;"></span>
    		<span style="--i:18;"></span>
    		<span style="--i:21;"></span>
    		<span style="--i:15;"></span>
    		<span style="--i:13;"></span>
    		<span style="--i:26;"></span>
    		<span style="--i:17;"></span>
    		<span style="--i:13;"></span>
    		<span style="--i:28;"></span>
    		<span style="--i:11;"></span>
    		<span style="--i:12;"></span>
    		<span style="--i:24;"></span>
    		<span style="--i:10;"></span>
    		<span style="--i:14;"></span>
    		<span style="--i:23;"></span>
    		<span style="--i:18;"></span>
    		<span style="--i:16;"></span>
    		<span style="--i:19;"></span>
    		<span style="--i:20;"></span>    		
    	</div>
    </div>

        
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
					<a href="item.jsp?id=<%=p.getId()%>"> <img class="card-img-top immagine-ingrandibile"
						src="product-image/<%=p.getImage()%>" width="300" height="200"
						alt="Immagine mancante" style="object-fit: cover;">
					</a>
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">Prezzo: <%=p.getPrice()%>&euro;</h6>
						<div class="mt-3 d-flex justify-content-between">
							<a class="btn btn-success" href="add-to-cart?id=<%=p.getId()%>"
								target=_self><i class="fa fa-shopping-cart"></i></a>
							<a class="btn btn-primary" href="add-to-cart?id=<%=p.getId()%>&order-now=yes"><i class="fas fa-home mr-3"></i></a>
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