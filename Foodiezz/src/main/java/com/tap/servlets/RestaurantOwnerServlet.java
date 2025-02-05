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

import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.daoImplementation.MenuDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

@WebServlet("/RestaurantOwnerServlet")
public class RestaurantOwnerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Debug prints
        System.out.println("Session attributes: ");
        java.util.Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            System.out.println(attributeName + ": " + session.getAttribute(attributeName));
        }
        
        int restaurantId = (int) session.getAttribute("restaurantId");
        System.out.println("Restaurant ID from session: " + restaurantId);
        
        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
        System.out.println("Retrieved restaurant: " + (restaurant != null ? restaurant.getName() : "null"));
        
        MenuDAOImpl menuDAO = new MenuDAOImpl();
        List<Menu> menuList = menuDAO.getAllMenuByRestaurant(restaurantId);
        System.out.println("Retrieved menu items: " + (menuList != null ? menuList.size() : "null"));
        
        req.setAttribute("Menus", menuList);
        req.setAttribute("rest", restaurant);
        
        RequestDispatcher rd = req.getRequestDispatcher("RestaurantAdmin.jsp");
        rd.forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
