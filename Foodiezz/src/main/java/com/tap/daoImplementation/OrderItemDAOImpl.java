package com.tap.daoImplementation;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {
	
	private static final String INSERT_ORDERITEM_QUERY = "INSERT INTO orderitem (orderid,menuid,quantity,totalprice) values(?,?,?,?)";
	private static final String GET_ORDERITEM_QUERY = "SELECT * FROM orderitem WHERE orderitemid = ?";
	private static final String DELETE_ORDERITEM = "DELETE FROM orderitem where orderitemid = ?";
	private static final String UPDATE_ORDERITEM_QUERY = "UPDATE orderitem SET quantity=?, totalprice=?";
	private static final String GET_ALL_ORDERSITEMS_QUERY = "SELECT * FROM orderitem WHERE orderid = ?";
	private static final String GET_ORDERITEMS_WITH_MENU_QUERY = 
		"SELECT oi.*, m.name, m.price FROM orderitem oi " +
		"JOIN menu m ON oi.menuid = m.menuid " +
		"WHERE oi.orderid = ?";

	
	@Override
	public void addOrderItem(OrderItem orderitem) {
		
		
		try (Connection connection = DBConnection.getConnection();
			PreparedStatement stmt = connection.prepareStatement(INSERT_ORDERITEM_QUERY);) 
		{
            stmt.setInt(1, orderitem.getOrderId());
            stmt.setInt(2, orderitem.getMenuId());
            stmt.setInt(3, orderitem.getQuantity());
            stmt.setInt(4, orderitem.getTotalPrice());
            stmt.executeUpdate();
            
        } 
		catch (SQLException e) {
            e.printStackTrace();
        }
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {
		
		OrderItem orderItem =null;
		
		try (Connection connection = DBConnection.getConnection();
			PreparedStatement stmt = connection.prepareStatement(GET_ORDERITEM_QUERY)) 
		{
            stmt.setInt(1, orderItemId);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
            	orderItem  = extractOrderItem(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItem;
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {

		try(Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDERITEM_QUERY);)
		{
			pstmt.setInt(1, orderItem.getQuantity());
			pstmt.setInt(2, orderItem.getTotalPrice());
			pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemId) {
		
		try (Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(DELETE_ORDERITEM);) 
			{
	            stmt.setInt(1,orderItemId);
	            stmt.executeUpdate();
	            
	        } 
			catch (SQLException e) {
	            e.printStackTrace();
	        }
	}

	@Override
	public List<OrderItem> getOrderItemsByOrder(int orderId) {
		
		List<OrderItem> orderItemList = new ArrayList<OrderItem>();
		
		try (Connection connection = DBConnection.getConnection();
		     PreparedStatement pstmt = connection.prepareStatement(GET_ALL_ORDERSITEMS_QUERY);) 
		     {
					pstmt.setInt(1, orderId);
		            ResultSet resultSet = pstmt.executeQuery();
		            while(resultSet.next()) {
		            	OrderItem orderItem = extractOrderItem(resultSet);
		            	orderItemList.add(orderItem);
		            }
		        }
		        catch (SQLException e) {
		            e.printStackTrace();
		        }
		return orderItemList;
	}
	
	private OrderItem extractOrderItem(ResultSet resultSet) throws SQLException {
		
		int orderItemId = resultSet.getInt("orderitemid");
        int orderId = resultSet.getInt("orderid");
        int menuId = resultSet.getInt("menuid");
        int quantity = resultSet.getInt("quantity");
        int totalPrice = resultSet.getInt("totalprice");
        
        OrderItem orderItem = new OrderItem(orderItemId, orderId, menuId, quantity, totalPrice);
        return orderItem;
	}

	public List<OrderItem> getOrderItemsWithMenu(int orderId) {
		List<OrderItem> orderItems = new ArrayList<>();
		
		try (Connection connection = DBConnection.getConnection();
			 PreparedStatement pstmt = connection.prepareStatement(GET_ORDERITEMS_WITH_MENU_QUERY)) {
			
			pstmt.setInt(1, orderId);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				OrderItem item = new OrderItem();
				item.setOrderItemId(rs.getInt("orderitemid"));
				item.setOrderId(rs.getInt("orderid"));
				item.setMenuId(rs.getInt("menuid"));
				item.setQuantity(rs.getInt("quantity"));
				item.setTotalPrice(rs.getInt("totalprice"));
				
				item.setName(rs.getString("name"));
				item.setPrice(rs.getInt("price"));
				
				orderItems.add(item);
			}
			
		} catch (SQLException e) {
			System.out.println("Error fetching order items with menu details: " + e.getMessage());
			e.printStackTrace();
		}
		
		return orderItems;
	}
}



















