<%@ page import="mye.makeyoueco.model.User"%>
<link rel="stylesheet" href="css/style-navbar.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  
<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light bg-gradient" aria-labelledby="nav-label">
<div class="cover-container d-flex w-100 h-100 mx-auto flex-column">
	<nav class="navbar navbar-expand-lg navbar-light bg-light" aria-labelledby="nav-label">
		<div class="container">
			<a class="navbar-brand" href="index.jsp"><img src="product-image/logo.png" alt="Logo" style="max-height: 125px;"></a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapse" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="navbar-collapse collapse" id="collapse">
					<form class="mx-auto w-50" action="search" method="get">
						<div class="input-group">
							<input class="form-control rounded-0" type="text" placeholder="Cerca un prodotto . . ." aria-label="Search" id="search" name="search" onkeyup="showResult(this.value)">
								<button class="btn btn-outline-success rounded-0" type="submit"><i class="fas fa-search"></i></button>
							</div>
							<div id="responseContainer"></div>
						</form>		
						<div class="navbar-nav">
							<a class="nav-link" href="cart.jsp"><i
								class="fas fa-shopping-cart"></i><span
								class="badge badge-pill badge-primary">${cart_list.size()}</span></a>
							<%
								User u = (User) request.getSession().getAttribute("auth");
								if (u != null) {
							%>
							<li class="nav-item"><a class="nav-link"
								href="information.jsp">Ciao <%=u.getName()%>!
							</a></li>
							<ul class="navbar-nav mr-auto">
								<li class="nav-item"><a class="nav-link" href="orders.jsp">Ordini</a></li>
		
								<%
									if (u.isAdministrator()) {
								%>
								<li class="nav-item"><a class="nav-link" href="hub.jsp">Hub</a></li>
								<%
									}
								%>
								<li class="nav-item"><a class="nav-link" href="log-out"><i class="fas fa-sign-out-alt"></i></a></li>
								<%
									} else {
								%>
								<li class="nav-item"><a class="nav-link" href="login.jsp"><i
								class="fa fa-user"></i></a></li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
			</nav>
			<div id="wrapper" class="toggled" style="margin-left: 5%; display: inline;">
		<div class="container-fluid" id="conteudo"></div>
	</div>
</div>
</nav>
  

<script>
$(document).ready(function() {
	$('#search').on('input', function() {
	var searchText = $(this).val();
	
	$.ajax({
		url: 'search-product?name=' + searchText,
		type: 'GET',
		data: { q: searchText },
		success: function(response) {
		
		var data = JSON.parse(response);
		
		var container = $('#responseContainer');
		container.empty();
		
		for (var i = 0; i < data.length; i++) {
		//var paragraph = $('<a href="ciao.html">').text(data[i]);
		container.append("<a href='search?search="+data[i]+"'>"+data[i]+"</a><br>");
				}
			}
		});
	});
});
</script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/js/bootstrap.bundle.min.js"
	integrity="sha512-PqRelaJGXVuQ81N6wjUrRQelCDR7z8RvKGiR9SbSxKHPIt15eJDmIVv9EJgwq0XvgylszsjzvQ0+VyI2WtIshQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>