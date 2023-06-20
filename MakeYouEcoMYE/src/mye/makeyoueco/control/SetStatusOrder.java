package mye.makeyoueco.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mye.makeyoueco.model.DriverManagerConnectionPool;
import mye.makeyoueco.model.OrderDao;

//@WebServlet("/set-status-order")
public class SetStatusOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SetStatusOrder() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		try {
			OrderDao orderDao = new OrderDao(DriverManagerConnectionPool.getConnection());
			
			String status = request.getParameter("status");
			int id = Integer.parseInt(request.getParameter("id"));
			orderDao.setStatus(status.toUpperCase(), id);
			
			response.sendRedirect("search_orders.jsp");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
