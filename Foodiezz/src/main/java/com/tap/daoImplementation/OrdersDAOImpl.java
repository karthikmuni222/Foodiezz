package com.tap.daoImplementation;

import com.tap.dao.OrdersDAO;
import com.tap.model.Orders;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAOImpl implements OrdersDAO{
	
	private static final String INSERT_ORDER_QUERY = "INSERT INTO orders (userid,restaurantid,orderdate,totalamount,status,paymentmode) values(?,?,?,?,?,?) ";
	private static final String FETCH_ORDER_QUERY = "SELECT o.*, r.* FROM orders o LEFT JOIN restaurant r ON o.restaurantid = r.restaurantid WHERE o.orderid = ?";
	private static final String UPDATE_ORDER_QUERY = "UPDATE orders SET totalamount=?, status = ?, paymentmode=? WHERE orderid = ?";
	private static final String DELETE_ORDER_QUERY = "DELETE FROM orders WHERE orderid = ?";
	private static final String GET_ALL_ORDERS_QUERY = "SELECT o.*, r.* FROM orders o LEFT JOIN restaurant r ON o.restaurantid = r.restaurantid WHERE o.userid = ? ORDER BY o.orderdate DESC";

	
	@Override
	public int addOrder(Orders orders) {
		int orderId = 0;
		try (Connection connection = DBConnection.getConnection();
	        	 PreparedStatement pstmt = connection.prepareStatement(INSERT_ORDER_QUERY, Statement.RETURN_GENERATED_KEYS)) 
	        {
				pstmt.setInt(1, orders.getUserId());
				pstmt.setInt(2, orders.getRestaurantId());
				pstmt.setTimestamp(3, new Timestamp(orders.getOrderdate().getTime()));
				pstmt.setInt(4, orders.getTotalAmount());
				pstmt.setString(5, orders.getStatus());
				pstmt.setString(6, orders.getPaymentMode());
	            
	            pstmt.executeUpdate();
	            
	            ResultSet res = pstmt.getGeneratedKeys();
	            if(res.next()) {
	            	orderId = res.getInt(1);
	            }
	        }
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
		return orderId;
	}

	@Override
	public Orders getOrder(int orderId) {
		
		Orders orders = null;
		
		try (Connection connection = DBConnection.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(FETCH_ORDER_QUERY);) 
	        {
				pstmt.setInt(1, orderId);
	            ResultSet resultSet = pstmt.executeQuery();
	            if(resultSet.next()) {
	            	orders = extractOrderWithRestaurant(resultSet);
	            }
	        }
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
			return orders;
	}

	@Override
	public void updateOrder(Orders orders) {

	        try (Connection connection = DBConnection.getConnection();
	        	 PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_QUERY)) 
	        {
	            pstmt.setInt(1, orders.getTotalAmount());
	            pstmt.setString(2, orders.getStatus());
	            pstmt.setString(3,orders.getPaymentMode());
	            pstmt.setInt(4, orders.getOrderId());
	            pstmt.executeUpdate();
	        }
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
	}

	@Override
	public void deleteOrder(int orderId) {
		
		try (Connection connection = DBConnection.getConnection();
	        PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDER_QUERY)) 
	        {
	            pstmt.setInt(1, orderId);
	            pstmt.executeUpdate();
	        }
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
	}

	@Override
	public List<Orders> getAllOrdersByUser(int userId) {
		
		List<Orders> ordersList = new ArrayList<>();
		
		try (Connection connection = DBConnection.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(GET_ALL_ORDERS_QUERY);) 
	        {
				pstmt.setInt(1, userId);
	            ResultSet resultSet = pstmt.executeQuery();
	            while(resultSet.next()) {
	            	Orders orders = extractOrderWithRestaurant(resultSet);
	            	ordersList.add(orders);
	            }
	        }
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
		return ordersList;
	}
	
	private Orders extractOrderWithRestaurant(ResultSet resultSet) throws SQLException  {
		
		int orderId = resultSet.getInt("orderid");
   	 	int userId = resultSet.getInt("userid");
   	 	int restaurantId = resultSet.getInt("restaurantid");
   	 	Timestamp orderDate = resultSet.getTimestamp("orderdate");
   	 	int totalAmount = resultSet.getInt("totalamount");
   	 	String status = resultSet.getString("status");
   	 	String paymentMode = resultSet.getString("paymentmode");
   	 
   	 	Orders orders = new Orders(orderId, userId, restaurantId, orderDate, totalAmount, status, paymentMode);
   	 	
   	 	Restaurant restaurant = new Restaurant();
   	 	restaurant.setRestaurantId(restaurantId);
   	 	restaurant.setName(resultSet.getString("name"));
   	 	restaurant.setAddress(resultSet.getString("address"));
   	 	restaurant.setPhone(resultSet.getString("phone"));
   	 	restaurant.setRating(resultSet.getFloat("rating"));
   	 	restaurant.setCuisisneType(resultSet.getString("cuisinetype"));
   	 	restaurant.setActive(resultSet.getBoolean("isactive"));
   	 	restaurant.setEstimatedTimeArrival(resultSet.getInt("estimatedtimearrival"));
   	 	restaurant.setImagePath(resultSet.getString("imagepath"));
   	 	
   	 	orders.setRestaurant(restaurant);
   	 	
   	 	return orders;
	}
}
