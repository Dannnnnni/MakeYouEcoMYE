package mye.makeyoueco.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mye.makeyoueco.model.Cart;

//@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		try (PrintWriter out = response.getWriter()) {

			ArrayList<Cart> cartList = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			Cart cm = new Cart();
			cm.setId(id);
			cm.setQuantity(1);
			HttpSession session = request.getSession();
			ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

			String order_now = (String) request.getParameter("order-now");

			if (cart_list == null) {
				cartList.add(cm);
				session.setAttribute("cart-list", cartList);

				if (order_now!=null && order_now.equals("yes")) {
					response.sendRedirect("address_payment.jsp");
				} else {
					response.sendRedirect("index.jsp");
				}
			} else {
				cartList = cart_list;

				boolean exist = false;
				for (Cart c : cart_list) {
					if (c.getId() == id) {
						exist = true;
						out.println(
								"<script>alert('Prodotto già nel carrello');"
								+ "window.location.href = 'index.jsp'</script>");
					}
				}

				if (!exist) {
					cartList.add(cm);

					System.out.println(request.getParameter("order-now"));
					if (order_now!=null && order_now.equals("yes")) {
						response.sendRedirect("address_payment.jsp");
					} else {
						response.sendRedirect("index.jsp");
					}
				}
			}
		}
	}

}