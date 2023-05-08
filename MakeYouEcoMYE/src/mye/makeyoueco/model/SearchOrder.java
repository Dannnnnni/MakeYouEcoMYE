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
//@WebServlet("/search_orders")
public class SearchOrder extends HttpServlet {

	public SearchOrder() {
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

			request.removeAttribute("search_order");

			String email = request.getParameter("email");
			String sdate = request.getParameter("start_date");
			String edate = request.getParameter("end_date");

			ArrayList<Order> orders = new ArrayList<Order>();
			OrderDao orderDao = new OrderDao(DriverManagerConnectionPool.getConnection());

			if (email.equals("0") && (sdate == null || edate == null)) {
				orders = (ArrayList<Order>) orderDao.getAllOrders();
			}
			if (!email.equals("0") && !(sdate == null || edate == null)) {
				orders = orderDao.getOrderByDateAndId(email, sdate, edate);
			}
			if (!email.equals("0") && (sdate == null || edate == null)) {
				orders = orderDao.getOrderById(email);
			}

			if (email.equals("0") && !(sdate == null || edate == null)) {
				orders = orderDao.getOrderByDate(sdate, edate);
			}

			request.getSession().setAttribute("search_order", orders);
//			request.getSession().setAttribute("wrong-credential", "yes");

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/search_orders.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
