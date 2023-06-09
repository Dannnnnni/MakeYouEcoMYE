package mye.makeyoueco.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class OrderDao {

	public static final String TABLE_NAME = "orders";

	private Connection con;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public OrderDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertOrder(Order model) {
		boolean result = false;
		try {
			query = "INSERT INTO " + OrderDao.TABLE_NAME
					+ " (QUANTITY, DATA, TOTALCOST, STATUS, USER_ID, ADDRESS_ID, PAYMENT_ID) values(?,?,?,?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, model.getQuantity());
			pst.setString(2, model.getDate());
			pst.setDouble(3, model.getTotalCost());
			pst.setString(4, "IN LAVORAZIONE");
			pst.setInt(5, model.getUserId());
			pst.setInt(6, model.getAddressId());
			pst.setInt(7, model.getPaymentId());

			pst.executeUpdate();
			result = true;
			con.commit();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public int getOrderId(Order model) {

		try {
			query = "SELECT ID FROM " + OrderDao.TABLE_NAME
					+ " WHERE (QUANTITY = ? AND DATA = ? AND TOTALCOST = ? AND STATUS = ? AND USER_ID = ? AND ADDRESS_ID = ? AND PAYMENT_ID = ?)";
			con = DriverManagerConnectionPool.getConnection();
			pst = con.prepareStatement(query);
			pst.setInt(1, model.getQuantity());
			pst.setString(2, model.getDate());
			pst.setDouble(3, model.getTotalCost());
			pst.setString(4, "IN LAVORAZIONE");
			pst.setInt(5, model.getUserId());
			pst.setInt(6, model.getAddressId());
			pst.setInt(7, model.getPaymentId());

			rs = pst.executeQuery();

			rs.next();
			return rs.getInt("ID");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					System.err.println(e.getMessage());
				}
			}
		}
		return -1;
	}

	public List<Order> userOrders(int id) {
		List<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM " + OrderDao.TABLE_NAME + " WHERE USER_ID=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {

				Order order = new Order();

				order.setId(rs.getInt("ID"));
				order.setQuantity(rs.getInt("QUANTITY"));
				order.setDate(rs.getString("DATA"));
				order.setTotalCost(rs.getDouble("TOTALCOST"));
				order.setStatus(rs.getString("STATUS"));

				list.add(order);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public List<Order> getAllOrders() {
		List<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM " + OrderDao.TABLE_NAME;
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("ID"));
				order.setQuantity(rs.getInt("QUANTITY"));
				order.setDate(rs.getString("DATA"));
				order.setTotalCost(rs.getDouble("TOTALCOST"));
				order.setStatus(rs.getString("STATUS"));
				list.add(order);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public ArrayList<Order> getOrderByDateAndId(String email, String sdate, String edate) {
		ArrayList<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM USER INNER JOIN ORDERS ON USER.ID = ORDERS.USER_ID WHERE USER.EMAIL = ? AND ? < ? AND DATA < ? AND DATA > ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, sdate);
			pst.setString(3, edate);
			pst.setString(4, edate);
			pst.setString(5, sdate);

			rs = pst.executeQuery();
			while (rs.next()) {

				Order order = new Order();

				order.setId(rs.getInt("ID"));
				order.setQuantity(rs.getInt("QUANTITY"));
				order.setDate(rs.getString("DATA"));
				order.setTotalCost(rs.getDouble("TOTALCOST"));
				order.setStatus(rs.getString("STATUS"));

				list.add(order);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public List<Order> getOrderByDate(String sdate, String edate) {
		ArrayList<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM USER INNER JOIN ORDERS ON USER.ID = ORDERS.USER_ID WHERE ? < ? AND DATA < ? AND DATA > ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, sdate);
			pst.setString(2, edate);
			pst.setString(3, edate);
			pst.setString(4, sdate);

			rs = pst.executeQuery();
			while (rs.next()) {

				Order order = new Order();

				order.setId(rs.getInt("ID"));
				order.setQuantity(rs.getInt("QUANTITY"));
				order.setDate(rs.getString("DATA"));
				order.setTotalCost(rs.getDouble("TOTALCOST"));
				order.setStatus(rs.getString("STATUS"));

				list.add(order);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public List<Order> getOrderById(String email) {
		ArrayList<Order> list = new ArrayList<>();
		try {
			query = "SELECT * FROM USER INNER JOIN ORDERS ON USER.ID = ORDERS.USER_ID WHERE USER.EMAIL = ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);

			rs = pst.executeQuery();
			while (rs.next()) {

				Order order = new Order();

				order.setId(rs.getInt("ID"));
				order.setQuantity(rs.getInt("QUANTITY"));
				order.setDate(rs.getString("DATA"));
				order.setTotalCost(rs.getDouble("TOTALCOST"));
				order.setStatus(rs.getString("STATUS"));

				list.add(order);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

	public User getUserByOrder(int id) {
		User user = new User();
		try {
			query = "SELECT * FROM " + UserDao.TABLE_NAME + " INNER JOIN " + OrderDao.TABLE_NAME + " ON "
					+ UserDao.TABLE_NAME + ".ID=" + OrderDao.TABLE_NAME + ".USER_ID WHERE ORDERS.ID=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setSurname(rs.getString("surname"));
				user.setEmail(rs.getString("email"));
				user.setDateRegistration(rs.getString("date_registration"));
				user.setTelephone(rs.getString("telephone"));
				user.setAdministrator(rs.getBoolean("administrator"));

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return user;
	}

	public String getOrderData(int id) {

		String data = "";
		try {
			query = "SELECT * FROM " + UserDao.TABLE_NAME + " INNER JOIN " + OrderDao.TABLE_NAME + " ON "
					+ UserDao.TABLE_NAME + ".ID=" + OrderDao.TABLE_NAME + ".USER_ID WHERE ORDERS.ID=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				data = rs.getString("DATA");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return data;
	}

	public void cancelOrder(int id) {

		try {
			query = "DELETE FROM " + OrderDao.TABLE_NAME + " WHERE ID=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}

	}
	
	
	public void setStatus(String status, int id) {

		try {
			query = "UPDATE " + OrderDao.TABLE_NAME + " SET STATUS = ? WHERE ID = ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, status);
			pst.setInt(2, id);
			pst.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
	}
	
}