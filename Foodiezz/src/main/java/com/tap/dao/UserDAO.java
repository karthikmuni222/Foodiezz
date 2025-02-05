package com.tap.dao;

import com.tap.model.User;
import java.util.List;

public interface UserDAO {
	
	void addUser(User user);
	User getUser(int userId);
	void updateUser(User user);
	void deleteUser(int userId);
	List<User> getAllUser();
	User validateUser(String email, String password);
	boolean isValidUser(String username, String password);
	String getUserRole(String username, String password);
	User getUserByUsernameAndPassword(String username, String password);
	int getRestaurantOwnerId(String username, String password);
	void addRUser(User user);
}
