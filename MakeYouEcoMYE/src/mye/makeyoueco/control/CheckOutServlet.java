package mye.makeyoueco.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mye.makeyoueco.model.*;

//@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ArrayList<Cart> cartList = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			
			ProductDao pDao = new ProductDao(DriverManagerConnectionPool.getConnection());
			ArrayList<Cart> cartProduct = pDao.getCartProducts(cartList);
			double total = pDao.getTotalCartPrice(cartList);

			User auth = (User) request.getSession().getAttribute("auth");

			if (cartList != null && auth != null) {

				AddressPaymentDao apDao = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
				Address address = new Address();
				Payment payment = new Payment();

				address.setStreet((String) request.getParameter("address-street"));
				address.setZip_code((String) request.getParameter("address-zipcode"));
				address.setCity((String) request.getParameter("address-city"));
				address.setProvince((String) request.getParameter("address-province"));
				address.setCountry((String) request.getParameter("address-country"));
				address.setInstructions((String) request.getParameter("address-instructions"));
				address.setUser_id(auth.getId());

				payment.setFirst_name((String) request.getParameter("payment-name"));
				payment.setLast_name((String) request.getParameter("payment-surname"));
				payment.setCardNumber(Integer.parseInt(request.getParameter("payment-number")));
				payment.setCVV(Integer.parseInt(request.getParameter("payment-cvv")));
				payment.setExpiryMonth(Integer.parseInt(request.getParameter("payment-month")));
				payment.setExpiryYear(Integer.parseInt(request.getParameter("payment-year")));
				payment.setUser_id(auth.getId());

				if (request.getParameter("existingAddress") == null
						&& request.getParameter("existingPayment") == null) {
					
					// Se l'indirizzo e il metodo di pagamento sono nuovi
					apDao.insertAddressPayment(address, payment, 1);

				} else if (request.getParameter("existingAddress") == null
						&& request.getParameter("existingPayment") != null) {

					// Se l'indirizzo è nuovo ma non il metodo di pagamento
					apDao.insertAddressPayment(address, payment, 2);

				} else if (request.getParameter("existingAddress") != null
						&& request.getParameter("existingPayment") == null) {

					// Se il metodo di pagamento è nuovo ma non l'indirizzo
					apDao.insertAddressPayment(address, payment, 3);
				} else if (request.getParameter("existingAddress") != null
						&& request.getParameter("existingPayment") != null) {

					// Se l'indirizzo e il metodo di pagamento non sono nuovi
					apDao.insertAddressPayment(address, payment, 4);
				}

				int addressId = apDao.getAddress_id(address);
				int paymentId = apDao.getPayment_id(payment);

				Order order = new Order();

				order.setQuantity(cartList.size());
				order.setDate(formatter.format(date));
				order.setTotalCost(total);
				order.setStatus("IN LAVORAZIONE");
				order.setUser_id(auth.getId());
				order.setAddress_id(addressId);
				order.setPayment_id(paymentId);

				OrderDao oDao = new OrderDao(DriverManagerConnectionPool.getConnection());
				boolean result = oDao.insertOrder(order);

				int order_id = oDao.getOrder_id(order);

				if (result && order_id != -1) {
					
					for (Cart c : cartProduct) {
						ProductOrder product_order = new ProductOrder();
						product_order.setProduct_id(c.getId());
						product_order.setOrder_id(order_id);
						product_order.setQuantity(c.getQuantity());
						product_order.setPrice(c.getPrice());
						product_order.setIva(c.getIva());

						ProductOrderDao poDao = (ProductOrderDao) new ProductOrderDao(DriverManagerConnectionPool.getConnection());
						result = poDao.insertProductOrder(product_order);
						if (!result)
							break;
					}
					cartList.clear();
					response.sendRedirect("orders.jsp");
				}
			} else {
				if (auth == null) {
					response.sendRedirect("login.jsp");
				}
				response.sendRedirect("cart.jsp");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}