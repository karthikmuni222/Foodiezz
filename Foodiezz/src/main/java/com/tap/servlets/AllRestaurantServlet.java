package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AllRestaurantServlet")
public class AllRestaurantServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
		
		// Debug print
		System.out.println("Number of restaurants fetched: " + (restaurants != null ? restaurants.size() : 0));
		
		HttpSession session = req.getSession();
		session.setAttribute("restaurants", restaurants);
		
		req.getRequestDispatcher("admin.jsp").forward(req, resp);
	}
}
