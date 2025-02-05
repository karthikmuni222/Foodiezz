<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Menu, java.util.List, com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Management Dashboard</title>
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        /* Navigation Bar */
        nav {
            background-color: #1a1a1a;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: space-around;
            max-width: 1200px;
            margin: 0 auto;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        nav ul li a:hover {
            background-color: #333;
        }

        /* Welcome Message */
        .welcome-message {
            text-align: center;
            padding: 2rem;
            font-size: 2rem;
            color: #1a1a1a;
            background-color: white;
            margin: 1rem 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Menu Items Container */
        .menu-items-container {
            display: flex !important; /* Force display */
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
        }

        /* Menu Item Card */
        .menu-item-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            width: 300px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .menu-item-card:hover {
            transform: translateY(-5px);
        }

        .menu-item-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .menu-item-details {
            padding: 1.5rem;
        }

        .menu-item-details h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #1a1a1a;
        }

        .menu-item-details p {
            margin: 0.5rem 0;
            color: #666;
        }

        /* Buttons */
        .menu-item-actions {
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            background-color: #f8f8f8;
        }

        .edit-button, .delete-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .edit-button {
            background-color: #4CAF50;
            color: white;
        }

        .edit-button:hover {
            background-color: #45a049;
        }

        .delete-button {
            background-color: #f44336;
            color: white;
        }

        .delete-button:hover {
            background-color: #da190b;
        }

        /* Forms */
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            max-width: 500px;
            margin: 2rem auto;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            margin-bottom: 1.5rem;
            color: #1a1a1a;
        }

        .form-container input {
            width: 100%;
            padding: 0.8rem;
            margin: 0.5rem 0 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .form-container button {
            width: 100%;
            padding: 1rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }

        .form-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="#" onclick="showHome()">🏠 Home</a></li>
                <li><a href="#" onclick="showAddMenu()">➕ Add Menu</a></li>
                <li><a href="#" onclick="showEditMenu()">✏️ Edit Menu</a></li>
                
                <li><a href="Home.jsp">🚪 Logout</a></li>
            </ul>
        </nav>
    </header>

    <div class="welcome-message">
        <% 
            Restaurant rest = (Restaurant) request.getAttribute("rest");
            if(rest != null) {
        %>
            Welcome to <%= rest.getName() %>'s Dashboard!
        <% } else { %>
            Welcome to the Restaurant Dashboard!
        <% } %>
    </div>

    <!-- Debug information -->
    <div style="text-align: center; margin: 10px; color: #666;">
        <%
            List<Menu> menuItems = (List<Menu>) request.getAttribute("Menus");
            if(menuItems != null) {
                out.println("Number of menu items: " + menuItems.size());
            } else {
                out.println("Menu items is null");
            }
        %>
    </div>

    <!-- Menu Items Display Section -->
    <div id="menuItemsList" class="menu-items-container">
        <% 
            if (menuItems != null && !menuItems.isEmpty()) {
                for (Menu menuItem : menuItems) {
        %>
        <div class="menu-item-card">
            <% if(menuItem.getImagePath() != null && !menuItem.getImagePath().isEmpty()) { %>
                <img src="<%= menuItem.getImagePath() %>" 
                     alt="<%= menuItem.getItemName() %>" 
                     class="menu-item-image"
                     onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
            <% } else { %>
                <img src="https://via.placeholder.com/300x200?text=No+Image" 
                     alt="No Image Available" 
                     class="menu-item-image">
            <% } %>
            <div class="menu-item-details">
                <h3><%= menuItem.getItemName() %></h3>
                <p><strong>Description:</strong> <%= menuItem.getDescription() %></p>
                <p><strong>Price:</strong> ₹<%= menuItem.getPrice() %></p>
                <p><strong>Rating:</strong> <%= menuItem.getRatings() %> ⭐</p>
                <p><strong>Available:</strong> <%= menuItem.isAvailable() ? "Yes" : "No" %></p>
            </div>
            <div class="menu-item-actions">
                <button class="edit-button" onclick="location.href='EditMenuItemServlet?id=<%= menuItem.getMenuId() %>'">Edit</button>
                <button class="delete-button" onclick="location.href='DeleteMenuItemServlet?id=<%= menuItem.getMenuId() %>'">Delete</button>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <div class="no-menu-items">
            <p>No menu items available.</p>
        </div>
        <% } %>
    </div>

    <!-- Add Menu Section -->
    <div id="addMenu" class="form-container">
        <h2>Add Menu Item</h2>
        <% 
        Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
        if (restaurant != null) {
        %>
        <form action="AddMenuItemServlet">
            <label for="menuName">Menu Name:</label> 
            <input type="text" id="menuName" name="menuName" required>
            <!-- ... (rest of the form fields) ... -->
            <input type="number" id="menurestaurantId" name="menurestaurantId" 
                   value="<%=restaurant.getRestaurantId()%>" readonly>
            <button type="submit">Add Menu Item</button>
        </form>
        <% } else { %>
        <p>No restaurant data available.</p>
        <% } %>
    </div>

    <script>
        // Modified showHome function to ensure menu items are visible
        function showHome() {
            document.querySelector(".welcome-message").style.display = "block";
            document.getElementById("menuItemsList").style.display = "flex";
            document.getElementById("addMenu").style.display = "none";
            document.getElementById("editMenu").style.display = "none";
            document.getElementById("editProfile").style.display = "none";
        }

        // Call showHome on page load
        window.onload = function() {
            showHome();
        };
    </script>
</body>
</html>