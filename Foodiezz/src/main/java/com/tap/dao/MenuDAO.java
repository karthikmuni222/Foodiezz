package com.tap.dao;

import java.util.List;

import com.tap.model.Menu;

public interface MenuDAO {
	
	void addMenu(Menu menu);
	Menu getMenu(int menuid);
	void deleteMenu(int menuid);
	void updateMenu(Menu menu);
	List<Menu> getAllMenuByRestaurant(int restaurantid);

}