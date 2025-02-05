<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodiezz - Food Delivery App</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Open+Sans:wght@400;500;600&family=Poppins:wght@400;500;600&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', 'Poppins', 'Open Sans', 'Montserrat', sans-serif;
            background-color: #F5F5F5;
        }

        /* Header Styles */
        .header {
            position: sticky;
            top: 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            padding: 0.25rem 0;
        }

        .navbar {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0.5rem 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-container a {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #000;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            background-color: #FA4032;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            font-size: 1.2rem;
        }

        .brand-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: #FF8000;
        }

        .nav-items {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .location {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem;
            position: relative;
        }

        .search-box {
            position: relative;
            width: 300px;
        }

        .search-box input {
            width: 100%;
            padding: 0.5rem 2rem 0.5rem 1rem;
            border: 1px solid #ddd;
            border-radius: 14px;
        }

        .search-box i {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
        }

        .nav-link {
            text-decoration: none;
            color: #333;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.3s ease;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
        }

        .nav-link:not(.cart):hover {
            background-color: #FEF3E2;
            color: #FAB12F;
        }

        /* Main Content Styles */
        .main-content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .restaurants-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }

        .restaurant-card {
            border: none;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s ease;
            background-color: #fff;
            max-width: 100%;
        }

        .restaurant-card:hover {
            transform: translateY(-5px);
            border: 1px solid #eee;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .restaurant-image {
            width: 100%;
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .restaurant-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .restaurant-card:hover .restaurant-image img {
            transform: scale(1.05);
        }

        .restaurant-info {
            padding: 0.75rem;
        }

        .restaurant-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .restaurant-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.4rem;
        }

        .rating {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            background-color: #FA812F;
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
        }

        .food-type {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            margin-left: auto;
        }

        .veg-icon {
            color: #48c479;
        }

        .non-veg-icon {
            color: #e43b4f;
        }

        .restaurant-location {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 0.75rem;
        }

        .restaurant-status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .eta {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #666;
        }

        .eta i {
            color: #FAB12F;
        }

        .active-status {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.85rem;
        }

        .active-status.active {
            color: #48c479;
        }

        .active-status.inactive {
            color: #e43b4f;
        }

        .active-status i {
            font-size: 0.6rem;
        }

        .view-menu-btn {
            display: block;
            width: 100%;
            padding: 0.5rem 1rem;
            background-color: #FAB12F;
            color: white;
            border: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            text-align: center;
            cursor: pointer;
            font-family: inherit;
            font-size: inherit;
        }

        .view-menu-btn:hover {
            background-color: #e59f1f;
        }

        form {
            margin-bottom: 0;
        }

        /* Footer Styles */
        .footer {
		    background-color: #2A3335;
		    padding: 2rem 0;
		    margin-top: 2rem;
		    color: #fff;
		    border-top: 1px solid #FAB12F;  /* Moved border here */
		}

		.footer-content {
		    max-width: 1200px;
		    margin: 0 auto;
		    padding: 0 1rem;
		    display: flex;
		    flex-direction: column;
		    gap: 1rem;
		    width: 100%;
		}

		.footer-top {
		    padding-bottom: 1rem;  /* Removed border from here */
		}

        .footer-links {
            display: flex;
            justify-content: space-between;  /* Changed to space-between */
            align-items: flex-start;  /* Added to align items at top */
            gap: 2rem;  /* Reduced gap */
            margin-bottom: 1rem;
        }

        .footer-brand {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }

        .footer-logo {
            width: 50px;
            height: 50px;
            background-color: #FA4032;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            font-size: 1.5rem;
        }

        .footer-brand-name {
            color: #FF8000;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .footer-middle-sections {
            display: flex;
            justify-content: center;  /* Center the middle sections */
            gap: 4rem;  /* Space between middle sections */
            flex: 1;  /* Take available space */
            margin: 0 2rem;  /* Add margin on sides */
        }

        .footer-section {
            text-align: center;  /* Center align text */
        }

        .footer-section h3 {
            color: #fff;
            margin-bottom: 0.75rem;
            font-size: 1.2rem;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 0.4rem;
        }

        .footer-section ul li a {
            text-decoration: none;
            color: #ccc;
            transition: color 0.3s ease;
        }

        .footer-section ul li a:hover {
            color: #FAB12F;
        }

        .footer-app-section {
    	text-align: left;
		}
		
		.footer-app-section h3 {
		    color: #fff;
		    margin-bottom: 0.75rem;
		    font-size: 1.2rem;
		}
		
		.app-links {
		    display: flex;
		    flex-direction: column;
		    gap: 0.5rem;
		}
		
		.app-link img {
		    width: 140px;  /* Adjusted width */
		    height: 40px;  /* Adjusted height */
		    object-fit: contain;
		}

        .footer-bottom {
            width: 100%;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #3a4446;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }

        .social-links {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3a4446;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            background-color: #FA4032;
            transform: translateY(-3px);
        }

        .copyright {
            color: #ccc;
            font-size: 0.9rem;
            padding: 0.5rem 0;
        }

        .no-restaurants {
            grid-column: 1 / -1;
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        
        .banner {
		    background-color: #FF8000; /* A bright orange background */
		    color: white; /* White text color for contrast */
		    text-align: center; /* Center the text */
		    padding: 1rem 0; /* Padding for aesthetics */
		    font-size: 1.2rem; /* Larger font for visibility */
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
		    z-index: 999; /* Ensure it is below the navbar */
		}

		.main-content {
			max-width: 1200px;
	    	margin: 2rem auto;
	    	padding: 0 1rem;
	    	padding-top: 1rem; /* Add padding-top to avoid the banner overlap */
		}
        
    </style>
</head>
<body>
    <!-- Header section remains the same -->
    <header class="header">
        <nav class="navbar">
            <div class="logo-container">
                <a href="Home.jsp">
                    <div class="logo">FZ</div>
                    <span class="brand-name">Foodiezz</span>
                </a>
            </div>
            <div class="nav-items">
                <div class="location">
                    <i class="fas fa-map-marker-alt"></i>
                    <select>
                        <option selected>Bengaluru, Karnataka</option>
                        <option>Mumbai, Maharashtra</option>
                        <option>Delhi, NCR</option>
                        <option>Chennai, Tamil Nadu</option>
                    </select>
                </div>
                <div class="search-box">
                    <input type="text" placeholder="Search for food...">
                    <i class="fas fa-search"></i>
                </div>
                <a href="offers.jsp" class="nav-link"><i class="fas fa-percent"></i> Offers</a>
                <a href="help.jsp" class="nav-link"><i class="fas fa-question-circle"></i> Help</a>
                <a href="#" class="nav-link"><i class="fas fa-user"></i> Profile</a>
                <a href="cart.jsp" class="nav-link cart"><i class="fas fa-shopping-cart"></i> Cart</a>
                <% 
                User user = (User) session.getAttribute("user");
                if(user != null) { 
                %>
                    <a href="OrderHistory" class="nav-link">Order History</a>
                    <a href="logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="nav-link">Login</a>
                <% } %>
            </div>
        </nav>
    </header>

    <main class="main-content">
        <div class="restaurants-grid">
            <% 
            List<Restaurant> restaurants = (List<Restaurant>)session.getAttribute("RestaurantList");
            if(restaurants != null && !restaurants.isEmpty()) {
                for(Restaurant r : restaurants) { 
            %>
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <img src="<%= r.getImagePath() %>" 
                             alt="<%= r.getName() %>"/>
                    </div>
                    <div class="restaurant-info">
                        <h3 class="restaurant-name"><%= r.getName() %></h3>
                        <div class="restaurant-meta">
                            <span class="rating">
                                <i class="fas fa-star"></i>
                                <%= r.getRating() %>
                            </span>
                            <span class="food-type">
                                <i class="fas fa-circle <%= r.getCuisisneType().toLowerCase().contains("veg") ? "veg-icon" : "non-veg-icon" %>"></i>
                                <%= r.getCuisisneType() %>
                            </span>
                        </div>
                        <p class="restaurant-location"><%= r.getAddress() %></p>
                        <div class="restaurant-status">
                            <div class="eta">
                                <i class="fas fa-clock"></i>
                                <span><%= r.getEstimatedTimeArrival() %> min</span>
                            </div>
                            <span class="active-status <%= r.isActive() ? "active" : "inactive" %>">
                                <i class="fas fa-circle"></i>
                                <%= r.isActive() ? "Open Now" : "Closed" %>
                            </span>
                        </div>
                        <form action="Menu" method="post">
                            <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">
                            <button type="submit" class="view-menu-btn">
                                <span>View Menu</span>
                            </button>
                        </form>
                    </div>
                </div>
            <% 
                }
            } else { 
            %>
                <div class="no-restaurants">
                    <p>No restaurants found.</p>
                </div>
            <% } %>
        </div>
    </main>

    <!-- Footer section remains the same -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-top">
                <div class="footer-links">
                    <div class="footer-brand">
                        <div class="footer-logo">FZ</div>
                        <span class="footer-brand-name">Foodiezz</span>
                    </div>
                    
                    <div class="footer-middle-sections">
                        <div class="footer-section">
                            <h3>Company</h3>
                            <ul>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Team</a></li>
                                <li><a href="#">Careers</a></li>
                                <li><a href="#">Blog</a></li>
                            </ul>
                        </div>
                        <div class="footer-section">
                            <h3>Contact Us</h3>
                            <ul>
                                <li><a href="#">Ride with us</a></li>
                                <li><a href="#">Partner with us</a></li>
                                <li><a href="#">Help & Support</a></li>
                            </ul>
                        </div>
                        <div class="footer-section">
                            <h3>Legal</h3>
                            <ul>
                                <li><a href="#">Terms & Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Cookie Policy</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="footer-section footer-app-section">
                        <h3>Download Our App</h3>
                        <div class="app-links">
                            <a href="#" class="app-link">
                                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_200,h_65/icon-AppStore_lg30tv" 
                                     alt="App Store">
                            </a>
                            <a href="#" class="app-link">
                                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_200,h_65/icon-GooglePlay_1_zixjxl" 
                                     alt="Google Play">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="social-links">
                    <a href="#" class="social-link">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
                <div class="copyright">
                    <p>&copy; 2024 Foodiezz. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>