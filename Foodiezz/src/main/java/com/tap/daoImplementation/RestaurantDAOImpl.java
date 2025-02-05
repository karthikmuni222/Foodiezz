package com.tap.daoImplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO{
	
	private static final String INSERT_REST_QUERY = "INSERT INTO `restaurant` (`name`, `address`, `phone`, `rating`, `cuisinetype`, `isactive`, `estimatedtimearrival`, `adminuserid`, `imagepath`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String FETCH_REST_BY_ID = "SELECT * FROM `restaurant` WHERE `restaurantid` = ?";
	private static final String DELETE_REST_QUERY = "DELETE FROM `restaurant` WHERE `restaurantid` = ?";
	private static final String UPDATE_REST_QUERY = "UPDATE restaurant SET name = ?, address = ?, phone = ?, rating = ?, cuisinetype = ?, isactive = ?, estimatedtimearrival = ?, adminuserid = ?, imagepath = ? WHERE restaurantid = ?";
	private static final String GET_ALL_REST_QUERY = "SELECT * FROM restaurant";
	private static final String SELECT_RID_QUERY = "SELECT restaurantId FROM restaurant WHERE adminuserid = ?";

	private Connection connection;
	
	public RestaurantDAOImpl() {
		this.connection = DBConnection.getConnection();
	}
	
	@Override
	public void addRestaurant(Restaurant restaurant) {
		
        try (Connection connection = DBConnection.getConnection();
        	PreparedStatement prepareStatement = connection.prepareStatement(INSERT_REST_QUERY);) 
        {
            prepareStatement.setString(1, restaurant.getName());
            prepareStatement.setString(2, restaurant.getAddress());
            prepareStatement.setString(3, restaurant.getPhone());
            prepareStatement.setFloat(4, restaurant.getRating());
            prepareStatement.setString(5, restaurant.getCuisisneType());
            prepareStatement.setBoolean(6, restaurant.isActive());
            prepareStatement.setInt(7, restaurant.getEstimatedTimeArrival());
            prepareStatement.setInt(8, restaurant.getAdminUserId());
            prepareStatement.setString(9, restaurant.getImagePath());
            
            prepareStatement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	
	@Override
	public Restaurant getRestaurant(int restaurantId) {

		Restaurant restaurant = null;
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement prepareStatement = connection.prepareStatement(FETCH_REST_BY_ID);)
		{
			
			prepareStatement.setInt(1, restaurantId);
			ResultSet resultSet = prepareStatement.executeQuery();
			
			if(resultSet.next()) {
				restaurant = extractRestaurant(resultSet);	
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {
		        
        try(Connection connection = DBConnection.getConnection();
        	PreparedStatement pstmt = connection.prepareStatement(UPDATE_REST_QUERY);)
        {
        	
        	pstmt.setString(1, restaurant.getName());
        	pstmt.setString(2, restaurant.getAddress());
        	pstmt.setString(3, restaurant.getPhone());
        	pstmt.setFloat(4, restaurant.getRating());
        	pstmt.setString(5, restaurant.getCuisisneType());
        	pstmt.setBoolean(6, restaurant.isActive());
        	pstmt.setInt(7, restaurant.getEstimatedTimeArrival());
        	pstmt.setInt(8, restaurant.getAdminUserId());
        	pstmt.setString(9, restaurant.getImagePath());
        	
        	pstmt.executeUpdate();
        	
        }
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {
		
        try (Connection connection = DBConnection.getConnection();
        	PreparedStatement prepareStatement = connection.prepareStatement(DELETE_REST_QUERY);) 
        {
            prepareStatement.setInt(1, restaurantId);
            prepareStatement.executeUpdate();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }		
	}
	
	@Override
	public List<Restaurant> getAllRestaurants() {
		List<Restaurant> restaurants = new ArrayList<>();
		String query = "SELECT * FROM restaurant";
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query);
			 ResultSet rs = pstmt.executeQuery()) {
			
			while (rs.next()) {
				Restaurant restaurant = new Restaurant();
				restaurant.setRestaurantId(rs.getInt("restaurantid"));
				restaurant.setName(rs.getString("name"));
				restaurant.setImagePath(rs.getString("imagepath"));
				restaurant.setAddress(rs.getString("address"));
				restaurant.setPhone(rs.getString("phone"));
				restaurant.setRating(rs.getFloat("rating"));
				restaurant.setCuisisneType(rs.getString("cuisinetype"));
				restaurant.setEstimatedTimeArrival(rs.getInt("estimatedtimearrival"));
				restaurant.setActive(rs.getBoolean("isactive"));
				restaurant.setAdminUserId(rs.getInt("adminuserid"));
				
				restaurants.add(restaurant);
			}
			
			System.out.println("Retrieved " + restaurants.size() + " restaurants from database");
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error fetching restaurants: " + e.getMessage());
		}
		
		return restaurants;
	}
	
	@Override
	public int getRestaurantId(int restaurantOwnerId) {
		try (PreparedStatement prepareStatement = connection.prepareStatement(SELECT_RID_QUERY)) {
			prepareStatement.setInt(1, restaurantOwnerId);
			
			try (ResultSet res = prepareStatement.executeQuery()) {
				if (res.next()) {
					return res.getInt("restaurantId");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;  // Return 0 if no restaurant found or error occurs
	}
	
	private Restaurant extractRestaurant(ResultSet resultSet) throws SQLException {
		
		int restaurantId = resultSet.getInt("restaurantid");
		String name = resultSet.getString("name");
		String address = resultSet.getString("address");
		String phone = resultSet.getString("phone");
		float rating = resultSet.getFloat("rating");
		String cuisinetype = resultSet.getString("cuisinetype");
		boolean isactive = resultSet.getBoolean("isactive");
		int time = resultSet.getInt("estimatedtimearrival");
		int adminUserId = resultSet.getInt("adminuserid");
		String imagePath = resultSet.getString("imagepath");
		
		Restaurant restaurant = new Restaurant(restaurantId, name, address, phone, rating, cuisinetype, isactive, time, adminUserId, imagePath);
		
		return restaurant;
	}

}
