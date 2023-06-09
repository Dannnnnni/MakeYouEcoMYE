package mye.makeyoueco.control;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mye.makeyoueco.model.DriverManagerConnectionPool;
import mye.makeyoueco.model.User;
import mye.makeyoueco.model.UserDao;

//@WebServlet("/create-account")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CreateAccountServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			
		    BufferedReader reader = request.getReader();
		    StringBuilder stringBuilder = new StringBuilder();
		    String line;
		    while ((line = reader.readLine()) != null) {
		        stringBuilder.append(line);
		    }
		    String formData = stringBuilder.toString();
		    
	        String nome = "";
	        String cognome = "";
	        String email = "";
	        String password = "";
	        String telefono = "";

	        String[] params = formData.split("&");
	        for (String param : params) {
	            String[] keyValue = param.split("=");
	            if (keyValue.length == 2) {
	                String key = keyValue[0];
	                String value = keyValue[1];
	                try {
	                    value = URLDecoder.decode(value, "UTF-8");
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }

	                if (key.equals("nome")) {
	                    nome = value;
	                } else if (key.equals("cognome")) {
	                    cognome = value;
	                } else if (key.equals("email")) {
	                    email = value;
	                } else if (key.equals("password")) {
	                    password = value;
	                } else if (key.equals("telefono")) {
	                    telefono = value;
	                }
	            }
	        }
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDateTime now = LocalDateTime.now();
			UserDao udao = new UserDao(DriverManagerConnectionPool.getConnection());
			if (udao.insertUser(nome, cognome, email, password, dtf.format(now), telefono)) {
				User user = udao.userLogin(email, password);
				if (user != null) {
					request.getSession().setAttribute("auth", user);

					if (user.isAdministrator()) {
						response.sendRedirect("hub.jsp");

					} else {
						response.sendRedirect("orders.jsp");
					}
				}
			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
