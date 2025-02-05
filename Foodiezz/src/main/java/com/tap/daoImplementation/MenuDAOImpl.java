package com.tap.daoImplementation;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO{

	private static final String INSERT_MENU_QUERY = "INSERT INTO menu (restaurantid, itemname, description, price, ratings, isavailable, imagepath) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_MENU_BYID_QUERY = "SELECT * FROM menu WHERE menuid = ?";
	private static final String GET_ALL_RMENU_QUERY = "SELECT * FROM menu WHERE restaurantid = ?";
	private static final String DELETE_MENU_QUERY = "DELETE FROM menu WHERE menuid = ?";		
	private static final String UPDATE_MENU_QUERY = "UPDATE menu SET restaurantid = ?, itemname = ?, description = ?, price = ?, ratings = ?, isavailable = ?, imagepath = ? WHERE menuid = ?";

	@Override
	public void addMenu(Menu menu) {
		
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(INSERT_MENU_QUERY)) 
		{
			pstmt.setInt(1, menu.getRestaurantId());
			pstmt.setString(2,menu.getItemName());
			pstmt.setString(3,menu.getDescription());
			pstmt.setInt(4, menu.getPrice());
			pstmt.setFloat(5,menu.getRatings());
			pstmt.setBoolean(6, menu.isAvailable());
	        pstmt.setString(7, menu.getImagePath());
	        
	        pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenu(int menuid) {
		Menu menu = null;
		try(Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(GET_MENU_BYID_QUERY)) 
			{
				pstmt.setInt(1, menuid);
				ResultSet resultSet = pstmt.executeQuery();
				if(resultSet.next()) {
					menu = extractMenu(resultSet);
				}
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
		return menu;
	}

	@Override
	public List<Menu> getAllMenuByRestaurant(int restaurantid) {
		
        List<Menu> menuList = new ArrayList<>();
        
        try (Connection connection = DBConnection.getConnection();
        	 PreparedStatement pstmt = connection.prepareStatement(GET_ALL_RMENU_QUERY)) 
        {
            pstmt.setInt(1, restaurantid);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
            	Menu menu = extractMenu(resultSet);
            	menuList.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
       
	}

	@Override
	public void deleteMenu(int menuid) {
		
		try (Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(DELETE_MENU_QUERY);) 
		{
            pstmt.setInt(1, menuid);
            pstmt.executeUpdate();
        } 
		catch (SQLException e) {
            e.printStackTrace();
        }
	}

	@Override
	public void updateMenu(Menu menu) {
		
        try (Connection connection = DBConnection.getConnection();
        	PreparedStatement stmt = connection.prepareStatement(UPDATE_MENU_QUERY)) 
        {
            stmt.setInt(1, menu.getRestaurantId());
            stmt.setString(2, menu.getItemName());
            stmt.setString(3, menu.getDescription());
            stmt.setInt(4, menu.getPrice());
            stmt.setFloat(5, menu.getRatings());
            stmt.setBoolean(6, menu.isAvailable());
            stmt.setString(7, menu.getImagePath());
            stmt.setInt(8, menu.getMenuId());
            
            stmt.executeUpdate();
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
		
		
	}
	
	private Menu extractMenu(ResultSet resultSet) throws SQLException  {
		
		int menuid = resultSet.getInt("menuid");
		int restaurantId = resultSet.getInt("restaurantid");
		String itemName = resultSet.getString("itemname");
		String description = resultSet.getString("description");
		int price = resultSet.getInt("price");
		float ratings = resultSet.getFloat("ratings");
		boolean isAvailable = resultSet.getBoolean("isavailable");
		String imagePath = resultSet.getString("imagepath");
		
		Menu menu = new Menu(menuid, restaurantId, itemName, description, price, ratings, isAvailable, imagePath);
		return menu;
	}
	
}
