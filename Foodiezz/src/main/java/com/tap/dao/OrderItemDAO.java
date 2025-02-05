package com.tap.dao;

import com.tap.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
	
	void addOrderItem(OrderItem orderItem);
	OrderItem getOrderItem(int orderItemId);
	void updateOrderItem(OrderItem orderItem);
	void deleteOrderItem(int OrderItemId);
	List<OrderItem> getOrderItemsByOrder(int orderId);
//	List<OrderItem> getOrderItemsWithMenu(int orderId);
}
