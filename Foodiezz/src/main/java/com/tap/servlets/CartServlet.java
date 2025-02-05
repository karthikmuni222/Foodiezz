package com.tap.servlets;

import java.io.IOException;

import com.tap.daoImplementation.MenuDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CallingCartServlet")
public class CartServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		HttpSession session = req.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		
//		int newRestaurantId = Integer.parseInt(req.getParameter("restaurantId"));
//		|| newRestaurantId != currentRestaurantId	
//		session.setAttribute("restaurantId", newRestaurantId);		
//		Integer  currentRestaurantId= (Integer) session.getAttribute("restaurantId");
		
		if (cart == null  ) {
			cart = new Cart();
			session.setAttribute("cart", cart);
			
		}
		
		String action = req.getParameter("action");
		Integer restaurantId = (Integer) session.getAttribute("restaurantId");
		
		if (action != null) {
//			try {
				if (action.equals("add")) {
					addItemToCart(req, cart);
				} else if (action.equals("update")) {
					updateCartItem(req, cart);
				} else if (action.equals("remove")) {
					removeItemFromCart(req, cart);
				} else if (action.equals("clear")) {
					cart.clear();
				}
				session.setAttribute("cart", cart);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
		}
		session.setAttribute("cart", cart);
		resp.sendRedirect("cart.jsp");
	}

	private void addItemToCart(HttpServletRequest req, Cart cart) {
		try {
			int itemId = Integer.parseInt(req.getParameter("itemId"));
			int quantity = Integer.parseInt(req.getParameter("quantity"));
			int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
						
			MenuDAOImpl menuDao = new MenuDAOImpl();
			Menu menuItem = menuDao.getMenu(itemId);
			
			req.getSession().setAttribute("restaurantId", menuItem.getRestaurantId());
			
			if (menuItem != null) {
				CartItem item = new CartItem(
						menuItem.getMenuId(), 
						restaurantId, 
						menuItem.getItemName(), 
						quantity,
						menuItem.getPrice());

				cart.addItem(item);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	
	private void updateCartItem(HttpServletRequest req, Cart cart) {
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		System.out.println(itemId);
		cart.updateItem(itemId, quantity);
	}
	
	private void removeItemFromCart(HttpServletRequest req, Cart cart) {
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		System.out.println(itemId);
		cart.removeItem(itemId);
	}
	
	private void clearFromCart(HttpServletRequest request, Cart cart) {
		cart.clear();
	}
	
	
	
}
