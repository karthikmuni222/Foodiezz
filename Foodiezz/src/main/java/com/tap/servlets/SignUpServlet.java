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

@WebServlet("/SignUp")
public class SignUpServlet extends HttpServlet
{
	private UserDAOImpl userDAOImpl;

	@Override
	public void init() throws ServletException {
		userDAOImpl = new UserDAOImpl();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// Get form parameters
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			String address = req.getParameter("address");
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String role = "Customer";  // Fixed typo from "Customers"

			if (name == null || email == null || username == null || password == null || 
				name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
				resp.sendRedirect("SignUp.jsp?error=missingFields");
				return;
			}

			// Create new user
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

			userDAOImpl.addUser(user);  

			resp.sendRedirect("login.jsp?success=registered");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("SignUp.jsp?error=registrationFailed");
		}
	}
}
