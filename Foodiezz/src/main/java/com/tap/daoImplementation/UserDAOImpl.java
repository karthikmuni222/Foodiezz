package com.tap.daoImplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

import jakarta.servlet.http.HttpSession;

public class UserDAOImpl implements UserDAO {
	
	private static final String INSERT_USER_QUERY = "INSERT INTO `user`(`name`,`username`,`password`,`email`,`phone`,`address`,`role`,createddate, lastlogindate) values(?,?,?,?,?,?,?,?,?)";
	private static final String GET_USER_QUERY = "SELECT * FROM `user` WHERE `userid` = ?";
	private static final String UPDATE_USER_QUERY = "UPDATE `user` set name = ? ,password = ? ,phone = ? ,address = ? ,role = ? WHERE `userid` = ?";
	private static final String DELETE_USER_QUERY = "DELETE FROM `user` WHERE `userid` = ?";
	private static final String GET_ALL_USER_QUERY = "SELECT * FROM `user`";
	private static final String VALIDATE_USER_QUERY = "SELECT * FROM `user` WHERE `username` = ? AND `password` = ?";
	private static final String SELECTBYUSERANDPASS = 
		"SELECT * FROM user WHERE username = ? AND password = ?";
	private static final String SELECTBYUSERANDPASSTOROLE = 
		"SELECT role FROM user WHERE username = ? AND password = ?";
	private static final String GETRIDBYUSERANDPASS = 
		"SELECT userid FROM user WHERE username = ? AND password = ?";
	
	private static final String INSERT_RUSER_QUERY = "INSERT INTO `user`(`userid`,`name`,`username`,`password`,`email`,`phone`,`address`,`role`,createddate, lastlogindate) values(?,?,?,?,?,?,?,?,?,?)";
	
	private Connection connection;
	
	public UserDAOImpl() {
		this.connection = DBConnection.getConnection();
	}
	
	@Override
	public void addRUser(User user) {
		
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RUSER_QUERY);)
		{
			preparedStatement.setInt(1, user.getUserId());
			preparedStatement.setString(2, user.getName());
			preparedStatement.setString(3, user.getUsername());
			preparedStatement.setString(4, user.getPassword());
			preparedStatement.setString(5, user.getEmail());
			preparedStatement.setString(6, user.getPhone());
			preparedStatement.setString(7, user.getAddress());
			preparedStatement.setString(8, user.getRole());
			preparedStatement.setObject(9, user.getCreatedDate());
            preparedStatement.setObject(10, user.getLastLogindate());
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error adding user to database", e);
		}
	}
	
	@Override
	public void addUser(User user) {
		
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_QUERY);)
		{
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getUsername());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setString(4, user.getEmail());
			preparedStatement.setString(5, user.getPhone());
			preparedStatement.setString(6, user.getAddress());
			preparedStatement.setString(7, user.getRole());
			preparedStatement.setObject(8, user.getCreatedDate());
            preparedStatement.setObject(9, user.getLastLogindate());
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error adding user to database", e);
		}
	}

	@Override
	public User getUser(int userId) {
		
		User user = null;
		
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_QUERY);) 
		{	
			preparedStatement.setInt(1, userId);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			user = extractUser(resultSet);
		
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public void updateUser(User user) {

		try(Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_QUERY);)
		{
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPassword());
			preparedStatement.setString(3, user.getPhone());
			preparedStatement.setString(4, user.getAddress());
			preparedStatement.setString(5, user.getRole());
			preparedStatement.setInt(6, user.getUserId());
			
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(int userId) {

		try(Connection connection = DBConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_QUERY);)
		{		
			preparedStatement.setInt(1, userId);
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<User> getAllUser() {
		
		List<User> usersList = new ArrayList<User>();
		User user = null;
		try {
			Connection connection = DBConnection.getConnection();
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(GET_ALL_USER_QUERY);
			
			while(resultSet.next()) {
				user = extractUser(resultSet);
				usersList.add(user);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return usersList;
	}
	
	@Override
	public User validateUser(String username, String password) {
		User user = null;
		
		try (Connection connection = DBConnection.getConnection();
			 PreparedStatement preparedStatement = connection.prepareStatement(VALIDATE_USER_QUERY)) {
			
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);
			
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					user = extractUser(resultSet);
					
				}
			}
			
		} catch (SQLException e) {
			System.out.println("Error validating user: " + e.getMessage());
			e.printStackTrace();
		}
		
		return user;
	}
	
	@Override
	public boolean isValidUser(String username, String password) {
		try (PreparedStatement prepareStatement = connection.prepareStatement(SELECTBYUSERANDPASS)) {
			prepareStatement.setString(1, username);
			prepareStatement.setString(2, password);
			
			try (ResultSet res = prepareStatement.executeQuery()) {
				return res.next();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public String getUserRole(String username, String password) {
		try (PreparedStatement prepareStatement = connection.prepareStatement(SELECTBYUSERANDPASSTOROLE)) {
			prepareStatement.setString(1, username);
			prepareStatement.setString(2, password);
			
			try (ResultSet res = prepareStatement.executeQuery()) {
				if (res.next()) {
					return res.getString("role");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "Invalid User";
	}
	
	@Override
	public User getUserByUsernameAndPassword(String username, String password) {
		User user = new User();
		try (PreparedStatement prepareStatement = connection.prepareStatement(SELECTBYUSERANDPASS)) {
			prepareStatement.setString(1, username);
			prepareStatement.setString(2, password);
			
			try (ResultSet res = prepareStatement.executeQuery()) {
				if (res.next()) {
					user.setUserId(res.getInt("userId"));
					user.setName(res.getString("name"));
					user.setEmail(res.getString("email"));
					user.setPhone(res.getString("phone"));
					user.setAddress(res.getString("address"));
					user.setUsername(username);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	@Override
	public int getRestaurantOwnerId(String username, String password) {
		try (PreparedStatement prepareStatement = connection.prepareStatement(GETRIDBYUSERANDPASS)) {
			prepareStatement.setString(1, username);
			prepareStatement.setString(2, password);
			
			try (ResultSet res = prepareStatement.executeQuery()) {
				if (res.next()) {
					return res.getInt("userid");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	private User extractUser(ResultSet resultSet) throws SQLException{
		
		int userId = resultSet.getInt("userid");
		String name = resultSet.getString("name");
		String username = resultSet.getString("username");
		String password = resultSet.getString("password");
		String email = resultSet.getString("email");
		String phone = resultSet.getString("phone");
		String address = resultSet.getString("address");
		String role = resultSet.getString("role");
		
		User user = new User(userId, username, name, password, email, phone, address, role, null, null);
		return user;
	}
}
