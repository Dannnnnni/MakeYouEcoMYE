<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<%@include file="/includes/head.jsp"%>
<title>Crea un nuovo account</title>
<link href="style-footer.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<script>
	
	function validateForm() {
		event.preventDefault();
		var nome = document.getElementById("name").value;
		  var cognome = document.getElementById("surname").value;
		  var email = document.getElementById("email").value;
		  var password = document.getElementById("password").value;
		  var telefono = document.getElementById("telephone").value;

		  var regexNome = /^[a-zA-Z]{2,}$/; // almeno due lettere
		  var regexEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		  var regexPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; // almeno 8 caratteri, con almeno una lettera maiuscola, una lettera minuscola, un numero e un carattere speciale
		  // Abc123!@
		  var regexTelefono = /^[1-9]\d{1,14}$/;

		  var isValidNome = regexNome.test(nome);
		  var isValidCognome = regexNome.test(cognome);
		  var isValidEmail = regexEmail.test(email);
		  var isValidPassword = regexPassword.test(password);
		  var isValidTelefono = regexTelefono.test(telefono);
		  
		  if(!isValidNome) {
			  var error = document.getElementById("error_name");
			  error.textContent = "Inserisci un nome valido";
			  error.style.color = "red";
		  }
		  else {
			  var error = document.getElementById("error_name");
			  error.textContent = "";
		  }
		  if(!isValidCognome){
			  var error = document.getElementById("error_surname");
			  error.textContent = "Inserisci un cognome valido";
			  error.style.color = "red";
		  }
		  else {
			  var error = document.getElementById("error_surname");
			  error.textContent = "";
		  }
		  if(!isValidEmail){
			  var error = document.getElementById("error_email");
			  error.textContent = "Inserisci un'email valida";
			  error.style.color = "red";
		  }
		  else {
			  var error = document.getElementById("error_email");
			  error.textContent = "";
		  }
		  if(!isValidPassword){
			  var error = document.getElementById("error_password");
			  error.textContent = "Inserisci una password valida";
			  error.style.color = "red";
		  }
		  else {
			  var error = document.getElementById("error_password");
			  error.textContent = "";
		  }
		  if(!isValidTelefono){
			  var error = document.getElementById("error_telephone");
			  error.textContent = "Inserisci un numero di telefono valido";
			  error.style.color = "red";
		  }
		  else {
			  var error = document.getElementById("error_telephone");
			  error.textContent = "";
		  }
		  if (isValidNome && isValidCognome && isValidEmail && isValidPassword && isValidTelefono) {

		      var formData = {
		    	        nome: nome,
		    	        cognome: cognome,
		    	        email: email,
		    	        password: password,
		    	        telefono: telefono
		    	      };

		    	      $.ajax({
		    	        url: "create-account",
		    	        type: "POST",
		    	        data: formData,
		    	        success: function(response) {
		    	        	window.location.href = "index.jsp";
		    	        },
		    	        error: function(xhr, status, error) {
		    	          console.error(error);
		    	        }
		    	      });
		    	    }
		}
	
	</script>
	
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Crea il tuo account</div>
			<div class="card-body">
			<div id="responseContainer2"></div>
				<form id="registration-form" onsubmit="return validateForm()" method="post">
					<input type="hidden" name="action" value="insert">
					<div class="form-group">
						<label>Nome</label> <input type="text" name="name"
							class="form-control" id="name" required>
						
						<span id="error_name"></span>
					</div>
					<div class="form-group">
						<label>Cognome</label> <input type="text" name="surname"
							class="form-control" id="surname" required>
							
						<span id="error_surname"></span>
					</div>
					<div class="form-group">
						<label>Email</label> <input type="email" name="email"
							class="form-control" id="email" onkeyup="showResult(this.value)" required>
							
						<span id="error_email"></span>
					</div>
					<div class="form-group">
						<label>Password</label> <input type="password" name="password"
							class="form-control" id="password" placeholder="8 caratteri, uno speciale, maiuscolo, minuscolo e un numero" required>
							
						<span id="error_password"></span>
					</div>
					<div class="form-group">
						<label>Numero di telefono</label> <input type="text"
							name="telephone" class="form-control" id="telephone" required> <br>
							
						<span id="error_telephone"></span>
					</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary">Registrati</button>
						</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
    $(document).ready(function() {
      $('#email').on('input', function() {
        var searchText = $(this).val();

        $.ajax({
          url: 'create-account-servlet?email=' + searchText,
          type: 'GET',
          data: { q: searchText },
          success: function(response) {
       
          	var data = JSON.parse(response);
          	var container = $('#responseContainer2');

      		container.empty();
          	if(String(data) === "true") {
		    	container.append("<p style="+"color:red;"+">Indirizzo email già esistente!</p>");
          	}
          }
        });
      });
    });
  </script>

<%-- 	<%@include file="/includes/footer.jsp"%> --%>

</body>
</html>