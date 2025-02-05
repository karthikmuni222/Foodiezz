package com.tap.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.tap.daoImplementation.OrdersDAOImpl;
import com.tap.daoImplementation.OrderItemDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Orders;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkoutservlet")
public class CheckoutServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		// Get user from session
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		// Get cart from session
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null || cart.getItems().isEmpty()) {
			response.sendRedirect("cart.jsp");
			return;
		}
		
		try {
			// Create new order
			Orders order = new Orders();
			
			// Set user ID from session
			order.setUserId(user.getUserId());
			
			// Set restaurant ID from session
			Integer restaurantId = (Integer) session.getAttribute("restaurantId");
			if (restaurantId == null) {
				throw new ServletException("Restaurant ID not found in session");
			}
			order.setRestaurantId(restaurantId);
			
			// Set order date to current date
			order.setOrderdate(new Date());
			
			// Set total amount from cart
			order.setTotalAmount(cart.getTotalPrice());
			
			// Set initial status
			order.setStatus("Pending");
			
			// Get payment mode from request parameter, default to "Cash"
			String paymentMode = request.getParameter("paymentMode");
			if (paymentMode == null || paymentMode.trim().isEmpty()) {
				paymentMode = "Cash on Delivery";
			}
			order.setPaymentMode(paymentMode);
			
			// Save order using your existing DAO
			OrdersDAOImpl ordersDAO = new OrdersDAOImpl();
			int orderId = ordersDAO.addOrder(order);  // Using your existing addOrder method
			
			if (orderId > 0) {
				// Order created successfully
				// Create OrderItemDAOImpl instance
				OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
				
				// Now create order items for each cart item
				Map<Integer, CartItem> cartItems = cart.getItems();
				for (CartItem cartItem : cartItems.values()) {
					OrderItem orderItem = new OrderItem();
					orderItem.setOrderId(orderId);
					orderItem.setMenuId(cartItem.getItemId());
					orderItem.setQuantity(cartItem.getQuantity());
					orderItem.setTotalPrice(cartItem.getTotalPrice());
					
					orderItemDAO.addOrderItem(orderItem);  // Using your existing addOrderItem method
				}
				session.setAttribute("orderItems", new ArrayList<>(cart.getItems().values()));
                session.setAttribute("orderTotal", cart.getTotalPrice());
                session.setAttribute("orderId", orderId);
                session.setAttribute("paymentMode", paymentMode);
				// Clear the cart
				session.removeAttribute("cart");
				session.removeAttribute("restaurantId");
				
				// Redirect to order confirmation page
				response.sendRedirect("checkout.jsp?orderId=" + orderId + "&payment=" + paymentMode);
			} else {
				throw new ServletException("Failed to create order");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Failed to process order: " + e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
