package com.tap.dao;

import java.util.List;

import com.tap.model.Orders;

public interface OrdersDAO {
	
	int addOrder(Orders orders);
	Orders getOrder(int orderId);
	void updateOrder(Orders orders);
	void deleteOrder(int orderId);
	List<Orders> getAllOrdersByUser(int userId);
}
