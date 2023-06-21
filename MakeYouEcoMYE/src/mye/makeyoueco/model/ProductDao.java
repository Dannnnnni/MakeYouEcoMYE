package mye.makeyoueco.model;

import java.awt.List;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/product")
public class ProductDao extends HttpServlet {

	public static final String TABLE_NAME = "product";

	private Connection connection;

	private String query;
	private PreparedStatement preparedStatement;
	private ResultSet rs;

	public ProductDao() {
		super();
	}

	public ProductDao(Connection connection) {
		this.connection = connection;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("delete")) {
					connection = DriverManagerConnectionPool.getConnection();

					int id = Integer.parseInt(request.getParameter("id"));
					int result = 0;
					String deleteSQL = "DELETE FROM " + ProductDao.TABLE_NAME + " WHERE ID = ?";
					try {
						connection = DriverManagerConnectionPool.getConnection();
						preparedStatement = connection.prepareStatement(deleteSQL);
						preparedStatement.setInt(1, id);
						result = preparedStatement.executeUpdate();
						connection.commit();
					} finally {
						try {
							if (preparedStatement != null)
								preparedStatement.close();
						} finally {
							DriverManagerConnectionPool.releaseConnection(connection);

						}
					}

				} else if (action.equalsIgnoreCase("insert")) {
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					double price = Double.parseDouble(request.getParameter("price"));
					float weight = Float.parseFloat(request.getParameter("weight"));
					String image = request.getParameter("image");
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					int iva = Integer.parseInt(request.getParameter("iva"));

					String insertSQL = "INSERT INTO " + ProductDao.TABLE_NAME
							+ " (NAME, DESCRIPTION, PRICE, WEIGHT, IMAGE, QUANTITY, IVA) VALUES (?, ?, ?, ?, ?, ?, ?)";

					try {
						connection = DriverManagerConnectionPool.getConnection();
						preparedStatement = connection.prepareStatement(insertSQL);
						preparedStatement.setString(1, name);
						preparedStatement.setString(2, description);
						preparedStatement.setDouble(3, price);
						preparedStatement.setFloat(4, weight);
						preparedStatement.setString(5, image);
						preparedStatement.setInt(6, quantity);
						preparedStatement.setInt(7, iva);

						preparedStatement.executeUpdate();

						connection.commit();
					} finally {
						try {
							if (preparedStatement != null)
								preparedStatement.close();
						} finally {
							DriverManagerConnectionPool.releaseConnection(connection);
						}
					}
				} else if (action.equalsIgnoreCase("update")) {
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					double price = Double.parseDouble(request.getParameter("price"));
					float weight = Float.parseFloat(request.getParameter("weight"));
					String image = request.getParameter("image");
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					int iva = Integer.parseInt(request.getParameter("iva"));
					int id = Integer.parseInt(request.getParameter("id"));

					String insertSQL = "UPDATE " + ProductDao.TABLE_NAME
							+ " SET NAME = ?, DESCRIPTION = ?, PRICE = ?, WEIGHT = ?, IMAGE = ?, QUANTITY = ?, IVA = ? WHERE ID = ?";

					try {
						connection = DriverManagerConnectionPool.getConnection();
						preparedStatement = connection.prepareStatement(insertSQL);
						preparedStatement.setString(1, name);
						preparedStatement.setString(2, description);
						preparedStatement.setDouble(3, price);
						preparedStatement.setFloat(4, weight);
						preparedStatement.setString(5, image);
						preparedStatement.setInt(6, quantity);
						preparedStatement.setInt(7, iva);
						preparedStatement.setInt(8, id);

						preparedStatement.executeUpdate();

						connection.commit();
					} finally {
						try {
							if (preparedStatement != null)
								preparedStatement.close();
						} finally {
							DriverManagerConnectionPool.releaseConnection(connection);
						}
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/hub.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public ArrayList<Product> doRetrieveAll(String order) {

		ArrayList<Product> products = new ArrayList<Product>();

		try {

			String query = "SELECT * FROM " + ProductDao.TABLE_NAME;

			if (order != null && !order.equals("")) {
			    query += " ORDER BY ?";
			    preparedStatement = connection.prepareStatement(query);
			    preparedStatement.setString(1, order);
			} else {
			    preparedStatement = connection.prepareStatement(query);
			}


			preparedStatement = connection.prepareStatement(query);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Product bean = new Product();

				bean.setId(rs.getInt("ID"));
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setWeight(rs.getFloat("WEIGHT"));
				bean.setImage(rs.getString("IMAGE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setIva(rs.getInt("IVA"));

				products.add(bean);
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return products;
	}

	public synchronized Product doRetrieveByKey(int code) throws SQLException {

		Product bean = new Product();

		String selectSQL = "SELECT * FROM " + ProductDao.TABLE_NAME + " WHERE ID = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setId(rs.getInt("ID"));
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setWeight(rs.getFloat("WEIGHT"));
				bean.setImage(rs.getString("IMAGE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setIva(rs.getInt("IVA"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return bean;
	}

	public synchronized boolean doDelete(int code) throws SQLException {

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductDao.TABLE_NAME + " WHERE CODE = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return (result != 0);
	}

	public ArrayList<Cart> getCartProducts(ArrayList<Cart> cartList) {

		ArrayList<Cart> products = new ArrayList<>();
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "SELECT * FROM " + ProductDao.TABLE_NAME + " WHERE ID=?";
					preparedStatement = this.connection.prepareStatement(query);
					preparedStatement.setInt(1, item.getId());
					rs = preparedStatement.executeQuery();
					while (rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("ID"));
						row.setName(rs.getString("NAME"));
						row.setPrice(rs.getDouble("PRICE") * item.getQuantity());
						row.setIva(rs.getInt("IVA"));
						row.setQuantity(item.getQuantity());

						products.add(row);
					}

				}
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return products;
	}

	public double getTotalCartPrice(ArrayList<Cart> cartList) {
		double sum = 0;
		try {
			if (!cartList.isEmpty()) {
				for (Cart item : cartList) {
					query = "SELECT PRICE FROM " + ProductDao.TABLE_NAME + " WHERE ID=?";
					preparedStatement = this.connection.prepareStatement(query);
					preparedStatement.setInt(1, item.getId());
					rs = preparedStatement.executeQuery();
					while (rs.next()) {
						sum += rs.getDouble("price") * item.getQuantity();
					}

				}
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return sum;
	}
}
