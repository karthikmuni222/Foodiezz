package com.tap.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.daoImplementation.UserDAOImpl;
import com.tap.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserDAOImpl userDAOImpl;
    
    @Override
    public void init() throws ServletException {
        userDAOImpl = new UserDAOImpl();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	System.out.println("login servlet activated");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        boolean isValid = userDAOImpl.isValidUser(username, password);
        String role = userDAOImpl.getUserRole(username, password);
        User user = userDAOImpl.validateUser(username, password);
        HttpSession session = request.getSession();
        
        if(user != null) {
	        if(isValid && role.equals("Customer")) {
	            session.setAttribute("user", user);
	            session.setAttribute("username", username);
				System.out.println(username+" "+"Customer is excecuting");
	            response.sendRedirect("Home.jsp");
	        }
	        if(isValid && role.equals("Admin")) {
	        	RestaurantDAOImpl restDaoImpl = new RestaurantDAOImpl();
	        	int restaurantOwnerId=userDAOImpl.getRestaurantOwnerId(username, password);
				int restaurantId=restDaoImpl.getRestaurantId(restaurantOwnerId);
				session.setAttribute("user",user);
				session.setAttribute("username", username);
				session.setAttribute("restaurantId", restaurantId);
				System.out.println(username+" "+"Restaurant Admin is excecuting");
				response.sendRedirect("RestaurantOwnerServlet");
	        }
	        if(isValid && role.equals("DeliveryAgent")) {
	        	session.setAttribute("user",user);
				session.setAttribute("username", username);
				System.out.println(username+" "+"DeliveryAgentisexcecuting");
				response.sendRedirect("DeliveryAgent.jsp");
	        }
	        if(isValid && role.equals("SuperAdmin")) {
	        	session.setAttribute("user",user);
				session.setAttribute("userName", username);
				System.out.println(username+" "+"SystemAdminisexcecuting");
				response.sendRedirect("AllRestaurantServlet");
	        }
        }
        else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}