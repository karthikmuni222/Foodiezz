package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.daoImplementation.OrdersDAOImpl;
import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.model.Orders;
import com.tap.model.Restaurant;
import com.tap.model.User;

@WebServlet("/OrderHistory")
public class OrderHistory extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // If not logged in, redirect to login page
            resp.sendRedirect("Login.jsp");
            return;
        }
        
        // Get userId from the user object
        int userId = user.getUserId();
        System.out.println("Fetching orders for user ID: " + userId);
        
        // Get all orders for the user
        OrdersDAOImpl ordersDAO = new OrdersDAOImpl();
        List<Orders> ordersList = ordersDAO.getAllOrdersByUser(userId);
        System.out.println("Found " + (ordersList != null ? ordersList.size() : 0) + " orders");
        
        // Get restaurant details for each order
        if (ordersList != null && !ordersList.isEmpty()) {
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            for (Orders order : ordersList) {
                try {
                    Restaurant restaurant = restaurantDAO.getRestaurant(order.getRestaurantId());
                    order.setRestaurant(restaurant);
                } catch (Exception e) {
                    System.out.println("Error getting restaurant for order " + order.getOrderId() + ": " + e.getMessage());
                }
            }
        }
        
        // Set attributes and forward to JSP
        req.setAttribute("orders", ordersList);
        RequestDispatcher rd = req.getRequestDispatcher("OrderHistory.jsp");
        rd.forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
