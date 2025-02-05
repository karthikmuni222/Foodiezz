<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Orders, java.util.List, com.tap.model.Restaurant, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Arial', sans-serif;
        background-color: #f5f5f5;
        color: #333;
        line-height: 1.6;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .header {
        background-color: #1a1a1a;
        color: white;
        padding: 20px 0;
        margin-bottom: 30px;
        text-align: center;
    }

    .header h1 {
        font-size: 2em;
        margin-bottom: 10px;
    }

    .orders-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        padding: 20px;
    }

    .order-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 20px;
        transition: transform 0.3s ease;
    }

    .order-card:hover {
        transform: translateY(-5px);
    }

    .order-header {
        border-bottom: 2px solid #f0f0f0;
        padding-bottom: 10px;
        margin-bottom: 15px;
    }

    .order-header h2 {
        color: #1a1a1a;
        font-size: 1.5em;
    }

    .order-details {
        margin-bottom: 15px;
    }

    .order-details p {
        margin: 8px 0;
        color: #666;
    }

    .status-badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        font-weight: bold;
        text-transform: uppercase;
        font-size: 0.8em;
    }

    .status-pending {
        background-color: #ffd700;
        color: #000;
    }

    .status-completed {
        background-color: #4CAF50;
        color: white;
    }

    .status-cancelled {
        background-color: #f44336;
        color: white;
    }

    .back-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #1a1a1a;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        margin: 20px;
        transition: background-color 0.3s ease;
    }

    .back-button:hover {
        background-color: #333;
    }

    .no-orders {
        text-align: center;
        padding: 50px;
        font-size: 1.2em;
        color: #666;
    }
</style>
</head>
<body>
    <div class="header">
        <h1>Your Order History</h1>
        <p>View all your past orders</p>
    </div>

    <a href="Home.jsp" class="back-button">← Back to Home</a>

    <div class="container">
        <div class="orders-container">
            <% 
            List<Orders> ordersList = (List<Orders>) request.getAttribute("orders");
            if(ordersList != null && !ordersList.isEmpty()) {
                for(Orders order : ordersList) {
                    Restaurant restaurant = null;
                    try {
                        restaurant = order.getRestaurant();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
            %>
                <div class="order-card">
                    <div class="order-header">
                        <h2><%= restaurant != null ? restaurant.getName() : "Restaurant Name Not Available" %></h2>
                        <p>Order #<%= order.getOrderId() %></p>
                    </div>
                    <div class="order-details">
                        <p><strong>Date:</strong> <%= order.getOrderdate() != null ? new SimpleDateFormat("dd MMM yyyy, HH:mm").format(order.getOrderdate()) : "N/A" %></p>
                        <p><strong>Total Amount:</strong> ₹<%= order.getTotalAmount() %></p>
                        <p><strong>Payment Mode:</strong> <%= order.getPaymentMode() %></p>
                        <p><strong>Status:</strong> 
                            <span class="status-badge status-<%= order.getStatus().toLowerCase() %>">
                                <%= order.getStatus() %>
                            </span>
                        </p>
                    </div>
                </div>
            <% 
                }
            } else {
            %>
                <div class="no-orders">
                    <h2>No orders found</h2>
                    <p>You haven't placed any orders yet.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>