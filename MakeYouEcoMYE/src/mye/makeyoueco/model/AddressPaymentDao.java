package mye.makeyoueco.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddressPaymentDao extends HttpServlet {

	private static final String TABLE_NAME1 = "address";
	private static final String TABLE_NAME2 = "payment";

	private Connection con;

	private String query;
	private PreparedStatement pst;

	public AddressPaymentDao() {
		super();
	}

	public AddressPaymentDao(Connection con) {
		super();
		this.con = con;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		HttpSession session = request.getSession();

		User auth = (User) request.getSession().getAttribute("auth");
		Address address = new Address();
		Payment payment = new Payment();

		String url = "/index.jsp";

		try {
			if (action != null) {
				con = DriverManagerConnectionPool.getConnection();
				
				if(action.equalsIgnoreCase("insertAddress")) {
					AddressPaymentDao apDao = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
					
					address.setStreet((String) request.getParameter("address-street"));
					address.setZip_code((String) request.getParameter("address-zipcode"));
					address.setCity((String) request.getParameter("address-city"));
					address.setProvince((String) request.getParameter("address-province"));
					address.setCountry((String) request.getParameter("address-country"));
					address.setInstructions((String) request.getParameter("address-instructions"));
					address.setUser_id(auth.getId());

					apDao.insertAddressPayment(address, payment, 2);
				}
				if(action.equalsIgnoreCase("insertPayment")) {
					AddressPaymentDao apDao = new AddressPaymentDao(DriverManagerConnectionPool.getConnection());
					
					payment.setFirst_name((String) request.getParameter("payment-name"));
					payment.setLast_name((String) request.getParameter("payment-surname"));
					payment.setCardNumber(Integer.parseInt(request.getParameter("payment-number")));
					payment.setCVV(Integer.parseInt(request.getParameter("payment-cvv")));
					payment.setExpiryMonth(Integer.parseInt(request.getParameter("payment-month")));
					payment.setExpiryYear(Integer.parseInt(request.getParameter("payment-year")));
					payment.setUser_id(auth.getId());
					
					apDao.insertAddressPayment(address, payment, 3);
				}

				if (action.equalsIgnoreCase("clearAddress")) {
					session.removeAttribute("address");
					url = "/address_payment.jsp";
				}

				if (action.equalsIgnoreCase("clearPayment")) {
					session.removeAttribute("payment");
					url = "/address_payment.jsp";
				}

				if (action.equalsIgnoreCase("selectAddress")) {

					int id = Integer.parseInt(request.getParameter("addressId"));

//					STREET, ZIP_CODE, CITY, PROVINCE, COUNTRY, INSTRUCTIONS

					try {

						query = "SELECT * FROM " + AddressPaymentDao.TABLE_NAME1 + " WHERE ID = ?";

						pst = con.prepareStatement(query);

						pst.setInt(1, id);

						ResultSet rs = pst.executeQuery();

						while (rs.next()) {

							address.setId(rs.getInt("ID"));
							address.setStreet(rs.getString("STREET"));
							address.setZip_code(rs.getString("ZIP_CODE"));
							address.setCity(rs.getString("CITY"));
							address.setProvince(rs.getString("PROVINCE"));
							address.setCountry(rs.getString("COUNTRY"));
							address.setInstructions(rs.getString("INSTRUCTIONS"));
							session.setAttribute("address", address);

//							request.setAttribute("address_id", rs.getInt("ID"));
//							request.setAttribute("street", rs.getString("STREET"));
//							request.setAttribute("zip_code", rs.getString("ZIP_CODE"));
//							request.setAttribute("city", rs.getString("CITY"));
//							request.setAttribute("province", rs.getString("PROVINCE"));
//							request.setAttribute("country", rs.getString("COUNTRY"));
//							request.setAttribute("instructions", rs.getString("INSTRUCTIONS"));

						}

					} catch (SQLException e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}

					url = "/address_payment.jsp";

				}
				if (action.equalsIgnoreCase("selectPayment")) {

					int id = Integer.parseInt(request.getParameter("paymentId"));

//					STREET, ZIP_CODE, CITY, PROVINCE, COUNTRY, INSTRUCTIONS

					try {

						query = "SELECT * FROM " + AddressPaymentDao.TABLE_NAME2 + " WHERE ID = ?";

						pst = con.prepareStatement(query);

						pst.setInt(1, id);

						ResultSet rs = pst.executeQuery();

						while (rs.next()) {

							payment.setId(rs.getInt("ID"));
							payment.setFirst_name(rs.getString("FIRST_NAME"));
							payment.setLast_name(rs.getString("LAST_NAME"));
							payment.setCardNumber(rs.getInt("CARDNUMBER"));
							payment.setCVV(rs.getInt("CVV"));
							payment.setExpiryMonth(rs.getInt("EXPIRYMONTH"));
							payment.setExpiryYear(rs.getInt("EXPIRYYEAR"));
							session.setAttribute("payment", payment);

//							request.setAttribute("payment_id", rs.getInt("ID"));
//							request.setAttribute("first_name", rs.getString("FIRST_NAME"));
//							request.setAttribute("last_name", rs.getString("LAST_NAME"));
//							request.setAttribute("card_number", rs.getString("CARDNUMBER"));
//							request.setAttribute("cvv", rs.getString("CVV"));
//							request.setAttribute("expirymonth", rs.getString("EXPIRYMONTH"));
//							request.setAttribute("expiryyear", rs.getString("EXPIRYYEAR"));
						}

					} catch (SQLException e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
					}

					url = "/address_payment.jsp";

				}

				if (action.equalsIgnoreCase("deleteAddress")) {

					int id = Integer.parseInt(request.getParameter("id"));
					query = "DELETE FROM " + AddressPaymentDao.TABLE_NAME1 + " WHERE ID = ?";

					url = "/information.jsp";

					pst = con.prepareStatement(query);
					pst.setInt(1, id);
					pst.executeUpdate();
					con.commit();

				}
				if (action.equalsIgnoreCase("deletePayment")) {

					int id = Integer.parseInt(request.getParameter("id"));
					query = "DELETE FROM " + AddressPaymentDao.TABLE_NAME2 + " WHERE ID = ?";

					url = "/information.jsp";

					pst = con.prepareStatement(query);
					pst.setInt(1, id);
					pst.executeUpdate();
					con.commit();

				}
			}
		} catch (Exception e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

	public boolean insertAddressPayment(Address address, Payment payment, int choice) {
		boolean result = false;

		try {

			if (choice == 1) {
				query = "INSERT INTO " + AddressPaymentDao.TABLE_NAME1
						+ "(STREET, ZIP_CODE, CITY, PROVINCE, COUNTRY, INSTRUCTIONS, USER_ID) values(?,?,?,?,?,?,?)";
				pst = this.con.prepareStatement(query);
				pst.setString(1, address.getStreet());
				pst.setString(2, address.getZip_code());
				pst.setString(3, address.getCity());
				pst.setString(4, address.getProvince());
				pst.setString(5, address.getCountry());
				pst.setString(6, address.getInstructions());
				pst.setInt(7, address.getUser_id());

				pst.executeUpdate();
				con.commit();

				query = "INSERT INTO " + AddressPaymentDao.TABLE_NAME2
						+ "(FIRST_NAME, LAST_NAME, CARDNUMBER, CVV, EXPIRYMONTH, EXPIRYYEAR, USER_ID) values(?,?,?,?,?,?,?)";
				pst = this.con.prepareStatement(query);
				pst.setString(1, payment.getFirst_name());
				pst.setString(2, payment.getLast_name());
				pst.setInt(3, payment.getCardNumber());
				pst.setInt(4, payment.getCVV());
				pst.setInt(5, payment.getExpiryMonth());
				pst.setInt(6, payment.getExpiryYear());
				pst.setInt(7, payment.getUser_id());

				pst.executeUpdate();
				con.commit();

				result = true;
			}
			if (choice == 2) {
				query = "INSERT INTO " + AddressPaymentDao.TABLE_NAME1
						+ "(STREET, ZIP_CODE, CITY, PROVINCE, COUNTRY, INSTRUCTIONS, USER_ID) values(?,?,?,?,?,?,?)";
				pst = this.con.prepareStatement(query);
				pst.setString(1, address.getStreet());
				pst.setString(2, address.getZip_code());
				pst.setString(3, address.getCity());
				pst.setString(4, address.getProvince());
				pst.setString(5, address.getCountry());
				pst.setString(6, address.getInstructions());
				pst.setInt(7, address.getUser_id());

				pst.executeUpdate();
				con.commit();
			}
			if (choice == 3) {
				query = "INSERT INTO " + AddressPaymentDao.TABLE_NAME2
						+ "(FIRST_NAME, LAST_NAME, CARDNUMBER, CVV, EXPIRYMONTH, EXPIRYYEAR, USER_ID) values(?,?,?,?,?,?,?)";
				pst = this.con.prepareStatement(query);
				pst.setString(1, payment.getFirst_name());
				pst.setString(2, payment.getLast_name());
				pst.setInt(3, payment.getCardNumber());
				pst.setInt(4, payment.getCVV());
				pst.setInt(5, payment.getExpiryMonth());
				pst.setInt(6, payment.getExpiryYear());
				pst.setInt(7, payment.getUser_id());

				pst.executeUpdate();
				con.commit();
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public Address getAddressByKey(int id) {

		Address bean = new Address();
		try {

			query = "SELECT * FROM " + OrderDao.TABLE_NAME + " INNER JOIN " + AddressPaymentDao.TABLE_NAME1
					+ " ON ADDRESS_ID = " + AddressPaymentDao.TABLE_NAME1 + ".ID WHERE " + OrderDao.TABLE_NAME
					+ ".ID=?";

			pst = con.prepareStatement(query);

			pst.setInt(1, id);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				bean.setStreet(rs.getString("STREET"));
				bean.setZip_code(rs.getString("ZIP_CODE"));
				bean.setCity(rs.getString("CITY"));
				bean.setProvince(rs.getString("PROVINCE"));
				bean.setCountry(rs.getString("COUNTRY"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return bean;
	}

	public ArrayList<Address> getAllAddress(int id) {

		ArrayList<Address> addresses = new ArrayList<Address>();

		try {

			query = "SELECT * FROM " + AddressPaymentDao.TABLE_NAME1 + " WHERE USER_ID = ?";

			pst = con.prepareStatement(query);

			pst.setInt(1, id);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				Address bean = new Address();
				bean.setId(rs.getInt("ID"));
				bean.setStreet(rs.getString("STREET"));
				bean.setZip_code(rs.getString("ZIP_CODE"));
				bean.setCity(rs.getString("CITY"));
				bean.setProvince(rs.getString("PROVINCE"));
				bean.setCountry(rs.getString("COUNTRY"));
				bean.setInstructions(rs.getString("INSTRUCTIONS"));
				addresses.add(bean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return addresses;
	}

	public Payment getPaymentByKey(int id) {

		Payment bean = new Payment();
		try {

			query = "SELECT * FROM " + OrderDao.TABLE_NAME + " INNER JOIN " + AddressPaymentDao.TABLE_NAME2
					+ " ON PAYMENT_ID = " + AddressPaymentDao.TABLE_NAME2 + ".ID WHERE " + OrderDao.TABLE_NAME
					+ ".ID=?";

			pst = con.prepareStatement(query);

			pst.setInt(1, id);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				bean.setFirst_name(rs.getString("FIRST_NAME"));
				bean.setLast_name(rs.getString("LAST_NAME"));
				bean.setCardNumber(rs.getInt("CARDNUMBER"));
				bean.setCVV(rs.getInt("CVV"));
				bean.setExpiryMonth(rs.getInt("EXPIRYMONTH"));
				bean.setExpiryYear(rs.getInt("EXPIRYYEAR"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return bean;
	}

	public ArrayList<Payment> getAllPayment(int id) {

		ArrayList<Payment> payments = new ArrayList<Payment>();

		try {

			query = "SELECT * FROM " + AddressPaymentDao.TABLE_NAME2 + " WHERE USER_ID = ?";

			pst = con.prepareStatement(query);

			pst.setInt(1, id);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				Payment bean = new Payment();
				bean.setId(rs.getInt("ID"));
				bean.setFirst_name(rs.getString("FIRST_NAME"));
				bean.setLast_name(rs.getString("LAST_NAME"));
				bean.setCardNumber(rs.getInt("CARDNUMBER"));
				bean.setCVV(rs.getInt("CVV"));
				bean.setExpiryMonth(rs.getInt("EXPIRYMONTH"));
				bean.setExpiryYear(rs.getInt("EXPIRYYEAR"));
				payments.add(bean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return payments;
	}

	public int getAddress_id(Address model) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			query = "SELECT ID FROM " + AddressPaymentDao.TABLE_NAME1
					+ " WHERE (STREET = ? AND ZIP_CODE = ? AND CITY = ? AND PROVINCE = ? AND COUNTRY = ? AND INSTRUCTIONS = ? AND USER_ID = ?)";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, model.getStreet());
			preparedStatement.setString(2, model.getZip_code());
			preparedStatement.setString(3, model.getCity());
			preparedStatement.setString(4, model.getProvince());
			preparedStatement.setString(5, model.getCountry());
			preparedStatement.setString(6, model.getInstructions());
			preparedStatement.setInt(7, model.getUser_id());

			rs = preparedStatement.executeQuery();

			rs.next();
			return (int) rs.getInt("ID");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
		}
		return -1;
	}

	public int getPayment_id(Payment model) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			query = "SELECT ID FROM " + AddressPaymentDao.TABLE_NAME2
					+ " WHERE (FIRST_NAME = ? AND LAST_NAME = ? AND CARDNUMBER = ? AND CVV = ? AND EXPIRYMONTH = ? AND EXPIRYYEAR = ? AND USER_ID = ?)";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, model.getFirst_name());
			preparedStatement.setString(2, model.getLast_name());
			preparedStatement.setInt(3, model.getCardNumber());
			preparedStatement.setInt(4, model.getCVV());
			preparedStatement.setInt(5, model.getExpiryMonth());
			preparedStatement.setInt(6, model.getExpiryYear());
			preparedStatement.setInt(7, model.getUser_id());

			rs = preparedStatement.executeQuery();

			rs.next();
			return (int) rs.getInt("ID");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
		}

		return -1;
	}

}
