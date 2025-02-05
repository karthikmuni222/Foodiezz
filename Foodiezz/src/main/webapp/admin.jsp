<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.Orders"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Foodiezz</title>
    <style>
        :root {
            --primary-color: #FAB12F;
            --secondary-color: #FA4032;
            --background-color: #f5f6fa;
            --text-color: #2d3436;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --card-bg: #ffffff;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: var(--background-color);
            color: var(--text-color);
        }

        /* Navbar Styles */
        .navbar {
            background: linear-gradient(135deg, #FA4032, #FAB12F);
            padding: 1rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        .nav-list {
            display: flex;
            justify-content: space-around;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0;
            list-style: none;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Restaurant Card Styles */
        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .restaurant-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.3s ease;
        }

        .restaurant-card:hover {
            transform: translateY(-5px);
        }

        .restaurant-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .restaurant-info {
            padding: 1.5rem;
        }

        .restaurant-name {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin: 0 0 1rem;
        }

        .restaurant-details {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }

        .label {
            color: var(--text-color);
            font-weight: 500;
        }

        .value {
            color: var(--secondary-color);
        }

        .value.active {
            color: #2ecc71;
        }

        .value.inactive {
            color: #e74c3c;
        }

        .card-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .btn {
            flex: 1;
            padding: 0.75rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: var(--primary-color);
            color: white;
        }

        .btn-delete {
            background: var(--secondary-color);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--text-color);
        }

        @media (max-width: 768px) {
            .nav-list {
                flex-direction: column;
                align-items: center;
            }

            .nav-link {
                margin: 0.5rem 0;
            }

            .restaurant-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <ul class="nav-list">
            <li><a href="#" class="nav-link" >🏠 Home</a></li>
            <li><a href="#" class="nav-link" >🙎‍♂️ Add Delivery Agent</a></li>
            <li><a href="#" class="nav-link" >📋 View Orders</a></li>
            <li><a href="Home.jsp" class="nav-link">➡️ Logout</a></li>
        </ul>
    </nav>

    <div id="removeRestaurantForm" class="section restaurant-grid">
        <% 
        System.out.println("Starting JSP processing");
        List<Restaurant> restaurants = (List<Restaurant>) session.getAttribute("restaurants");
        System.out.println("Restaurants from session: " + (restaurants != null ? restaurants.size() : "null"));
        
        if (restaurants != null && !restaurants.isEmpty()) {
            System.out.println("Found restaurants, starting loop");
            for (Restaurant restaurant : restaurants) {
        %>
            <div class="restaurant-card">
                <img src="<%= restaurant.getImagePath() %>" alt="<%= restaurant.getName() %>" class="restaurant-image">
                <div class="restaurant-info">
                    <h3 class="restaurant-name"><%= restaurant.getName() %></h3>
                    <div class="restaurant-details">
                        <div class="detail-item">
                            <span class="label">⭐ Rating:</span>
                            <span class="value"><%= restaurant.getRating() %></span>
                        </div>
                        <div class="detail-item">
                            <span class="label">🕒 ETA:</span>
                            <span class="value"><%= restaurant.getEstimatedTimeArrival() %> mins</span>
                        </div>
                        <div class="detail-item">
                            <span class="label">🍽️ Cuisine:</span>
                            <span class="value"><%=restaurant.getCuisisneType()%></span>
                        </div>
                        <div class="detail-item">
                            <span class="label">📍 Address:</span>
                            <span class="value"><%= restaurant.getAddress() %></span>
                        </div>
                        <div class="detail-item">
                            <span class="label">📞 Phone:</span>
                            <span class="value"><%= restaurant.getPhone() %></span>
                        </div>
                        <div class="detail-item">
                            <span class="label">Status:</span>
                            <span class="value <%= restaurant.isActive() ? "active" : "inactive" %>">
                                <%= restaurant.isActive() ? "🟢 Active" : "🔴 Inactive" %>
                            </span>
                        </div>
                    </div>
                    <div class="card-actions">
                        <button onclick="editRestaurant(<%= restaurant.getRestaurantId() %>)" class="btn btn-edit">
                            ✏️ Edit
                        </button>
                        <button onclick="deleteRestaurant(<%= restaurant.getRestaurantId() %>)" class="btn btn-delete">
                            🗑️ Delete
                        </button>
                    </div>
                </div>
            </div>
        <% 
            }
        } else { 
            System.out.println("No restaurants found");
        %>
            <div class="empty-state">
                <h2>No Restaurants Found</h2>
                <p>Click on "Add Restaurant" to add new restaurants to the platform.</p>
            </div>
        <% 
        } 
        %>
    </div>

    <script>
        function editRestaurant(restaurantId) {
            window.location.href = `EditRestaurantServlet?id=${restaurantId}`;
        }

        function deleteRestaurant(restaurantId) {
            if (confirm('Are you sure you want to delete this restaurant?')) {
                window.location.href = `DeleteRestaurantServlet?id=${restaurantId}`;
            }
        }

        function showRemoveRestaurantForm() {
            document.getElementById("addRestaurantForm").style.display = "none";
            document.getElementById("removeRestaurantForm").style.display = "grid";  // Changed to grid
            
            // Remove the auto-refresh code
            fetch('AllRestaurantServlet')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    // Don't reload the page, just update the content if needed
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    </script>
</body>
</html>