package mye.makeyoueco.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductOrderDao {

	private static final String TABLE_NAME = "product_order";

	private Connection con;

	public ProductOrderDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertProductOrder(ProductOrder model) {
		boolean result = false;
		String query;
		PreparedStatement pst;
		ResultSet rs;
		try {
			query = "INSERT INTO " + ProductOrderDao.TABLE_NAME
					+ "(PRODUCT_ID, ORDER_ID, QUANTITY, PRICE, IVA) values(?,?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, model.getProductId());
			pst.setInt(2, model.getOrderId());
			pst.setInt(3, model.getQuantity());
			pst.setDouble(4, model.getPrice());
			pst.setInt(5, model.getIva());

			pst.executeUpdate();
			con.commit();
			result = true;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public synchronized ArrayList<Product> doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		ArrayList<Product> product = new ArrayList<Product>();

		String query = "SELECT * FROM " + ProductOrderDao.TABLE_NAME + " INNER JOIN " + ProductDao.TABLE_NAME
				+ " ON PRODUCT_ID = ID WHERE ORDER_ID = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Product bean = new Product();
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getDouble(ProductOrderDao.TABLE_NAME+".PRICE"));
				bean.setQuantity(rs.getInt(ProductOrderDao.TABLE_NAME+".QUANTITY"));
				bean.setIva(rs.getInt(ProductOrderDao.TABLE_NAME+".IVA"));
				product.add(bean);
			}


		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return product;
	}

}
