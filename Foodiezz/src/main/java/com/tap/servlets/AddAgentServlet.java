package com.tap.servlets;

import java.io.IOException;
import java.time.LocalDateTime;

import com.tap.daoImplementation.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AgentSignUpServlet")
public class AddAgentServlet extends HttpServlet {
    
    private UserDAOImpl userDAOImpl;
    
    @Override
    public void init() throws ServletException {
        userDAOImpl = new UserDAOImpl();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = "DeliveryAgent"; 
            
            // Validate required fields
            if (name == null || email == null || username == null || password == null || 
                name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
                response.sendRedirect("AgentSignUp.jsp?error=missingFields");
                return;
            }
            
            // Create new user object
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setUsername(username);
            user.setPassword(password);
            user.setAddress(address);
            user.setRole(role);
            user.setCreatedDate(LocalDateTime.now());
            user.setLastLogindate(LocalDateTime.now());
            
            // Add user to database
            userDAOImpl.addUser(user);
            
            // Redirect to login page on success
            response.sendRedirect("login.jsp?success=registered");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AgentSignUp.jsp?error=registrationFailed");
        }
    }
}
