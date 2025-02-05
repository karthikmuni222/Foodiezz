package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Home")
public class HomeServlet extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("Home servlet activated");
		RestaurantDAOImpl rdi = new RestaurantDAOImpl();
		List<Restaurant> Restaurants = rdi.getAllRestaurants();
		

		HttpSession session = req.getSession();
		session.setAttribute("RestaurantList", Restaurants);

		RequestDispatcher rd = req.getRequestDispatcher("Home.jsp");
		rd.forward(req, resp);
		
	}
	
}
