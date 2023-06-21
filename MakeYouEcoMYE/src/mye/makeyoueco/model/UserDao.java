package mye.makeyoueco.model;

import java.sql.*;
import java.util.ArrayList;

public class UserDao {

	public static final String TABLE_NAME = "user";

	private Connection connection;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public UserDao(Connection connection) {
		this.connection = connection;
	}

	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "SELECT * FROM " + UserDao.TABLE_NAME + " WHERE EMAIL = ? AND PASSWORD = ?";
			pst = this.connection.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setSurname(rs.getString("surname"));
				user.setEmail(rs.getString("email"));
				user.setDateRegistration(rs.getString("date_registration"));
				user.setTelephone(rs.getString("telephone"));
				user.setAdministrator(rs.getBoolean("administrator"));
			}
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return user;
	}
	
	
	public boolean insertUser(String name, String surname, String email, String password, String dateRegistration, String telephone) {
		
		try {
			
			query = "SELECT EMAIL FROM " + UserDao.TABLE_NAME + " WHERE EMAIL = ?";
			pst = this.connection.prepareStatement(query);
			pst.setString(1, email);

			rs = pst.executeQuery();

			if(rs.next())
				return false;

			query = "INSERT INTO " + UserDao.TABLE_NAME + "(NAME, SURNAME, EMAIL, PASSWORD, DATE_REGISTRATION, TELEPHONE) VALUES(?, ?, ?, ?, ?, ?)";
			pst = this.connection.prepareStatement(query);
			pst.setString(1, name);
			pst.setString(2, surname);
			pst.setString(3, email);
			pst.setString(4, password);
			pst.setString(5, dateRegistration);
			pst.setString(6, telephone);
			
			pst.executeUpdate();
			connection.commit();
			
			return true;
		
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		
		return false;
	}
	
	
	public ArrayList<User> getAllUser() {
		ArrayList<User> list = new ArrayList<>();
		try {
			query = "SELECT * FROM " + UserDao.TABLE_NAME;
			pst = this.connection.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setSurname(rs.getString("surname"));
				user.setEmail(rs.getString("email"));
				user.setDateRegistration(rs.getString("date_registration"));
				user.setTelephone(rs.getString("telephone"));
				user.setAdministrator(rs.getBoolean("administrator"));
				
				list.add(user);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}
	
	public User getUserById(int id) {
		User user = new User();
		try {
			query = "SELECT * FROM " + UserDao.TABLE_NAME + " WHERE ID = ?";
			pst = this.connection.prepareStatement(query);
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
}