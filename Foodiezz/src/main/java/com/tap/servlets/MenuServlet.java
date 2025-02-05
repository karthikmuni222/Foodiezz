package com.tap.servlets;

import java.io.IOException;

import java.util.List;

import com.tap.daoImplementation.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Menu")
public class MenuServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("Menu servlete called");
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		MenuDAOImpl m = new MenuDAOImpl();
		List<Menu> MenuList = m.getAllMenuByRestaurant(restaurantId);

		req.setAttribute("Menus", MenuList);

		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		rd.forward(req, resp);
	}
}
