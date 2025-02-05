package com.tap.servlets;

import java.io.IOException;
import java.time.LocalDateTime;

import com.tap.daoImplementation.RestaurantDAOImpl;
import com.tap.daoImplementation.UserDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddRestaurant")
public class AddRestaurantServlet extends HttpServlet {
    
    private RestaurantDAOImpl restaurantDAO;
    private UserDAOImpl userDAOImpl;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        userDAOImpl = new UserDAOImpl();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // First create the user
            String name = request.getParameter("u_name");
            String email = request.getParameter("u_email");
            String phone = request.getParameter("u_phone");
            String address = request.getParameter("u_address");
            String username = request.getParameter("u_username");
            String password = request.getParameter("u_password");
            String role = "Admin";
            int adminUserId = Integer.parseInt(request.getParameter("restaurantOwnerId"));
            
            if (name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
                response.sendRedirect("RestaurantSignUp.jsp?error=missingField");
                return;
            }
            
            User user = new User();
            user.setUserId(adminUserId);
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setUsername(username);
            user.setPassword(password);
            user.setAddress(address);
            user.setRole(role);
            user.setCreatedDate(LocalDateTime.now());
            user.setLastLogindate(LocalDateTime.now());
            
            // Add user first
            userDAOImpl.addRUser(user);
            
            // Then create the restaurant
            String r_name = request.getParameter("r_name");
            String imagepath = request.getParameter("image");
            String r_address = request.getParameter("r_address");
            String r_phone = request.getParameter("r_phone");
            float r_rating = Float.parseFloat(request.getParameter("r_rating"));
            String cuisineType = request.getParameter("cuisineType");
            int etaMinutes = Integer.parseInt(request.getParameter("eta"));
            
            Restaurant restaurant = new Restaurant();
            restaurant.setName(r_name);
            restaurant.setAddress(r_address);
            restaurant.setPhone(r_phone);
            restaurant.setRating(r_rating);
            restaurant.setCuisisneType(cuisineType);
            restaurant.setActive(true);
            restaurant.setEstimatedTimeArrival(etaMinutes);
            restaurant.setAdminUserId(adminUserId);
            restaurant.setImagePath(imagepath);
            
            // Add restaurant after user is created
            restaurantDAO.addRestaurant(restaurant);
            
            response.sendRedirect("login.jsp?success=true");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RestaurantSignUp.jsp?error=true");
        }
    }
}
