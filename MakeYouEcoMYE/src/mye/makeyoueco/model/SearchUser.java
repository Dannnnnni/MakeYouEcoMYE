package mye.makeyoueco.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mye.makeyoueco.model.*;

/**
 * Servlet implementation class LoginServlet
 */
//@WebServlet("/search_user")
public class SearchUser extends HttpServlet {

	public SearchUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {

			System.out.println("cias");
			request.removeAttribute("search_user");

			String email = request.getParameter("email");
			request.getSession().setAttribute("search_user", email);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/search_user.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
