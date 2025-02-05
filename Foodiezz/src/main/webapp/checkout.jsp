<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.daoImplementation.OrderItemDAOImpl"%>
<%@ page import="com.tap.model.OrderItem"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Foodiezz</title>
    <link rel="stylesheet" href="check.css">
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
    background-color: #f8f8f8;
}

.checkout-header {
    position: sticky;
    top: 0;
    background-color: #FAB12F;
    color: white;
    padding: 1rem 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    z-index: 1000;
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
    display: flex;
    align-items: center;
}

.logo-container {
    margin-right: auto;
}

.logo {
    width: 40px;
    height: 40px;
    background-color: #FA4032;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    color: white;
    font-size: 1.2rem;
}

.checkout-header h1 {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    font-size: 1.8rem;
    font-weight: 600;
}

.checkout-content {
    max-width: 500px;
    margin: 3rem auto;
    padding: 0 1rem;
}

.checkout-form {
    background-color: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: #333;
    font-weight: 500;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
    font-family: inherit;
    background-color: #F5F7F8;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #FAB12F;
    background-color: #F5F7F8;
}

.confirm-btn {
    width: 100%;
    padding: 1rem;
    background-color: #FAB12F;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.confirm-btn:hover {
    background-color: #e59f1f;
}

.checkout-container {
    max-width: 800px;
    margin: 40px auto;
    display: flex;
    flex-direction: column;
    gap: 30px;
    padding: 20px;
}

.order-summary {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.order-summary h3 {
    color: #333;
    font-size: 24px;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid #FAB12F;
}

.order-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin: 20px 0;
}

.order-table th {
    background-color: #FAB12F;
    color: white;
    padding: 15px;
    text-align: left;
    font-weight: 600;
    font-size: 16px;
}

.order-table th:first-child {
    border-top-left-radius: 10px;
}

.order-table th:last-child {
    border-top-right-radius: 10px;
}

.order-table td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    color: #444;
}

.order-table tr:last-child td {
    border-bottom: none;
}

.order-table tr:hover td {
    background-color: #f8f8f8;
    transition: background-color 0.3s ease;
}

.order-table .item-name {
    font-weight: 500;
    color: #333;
}

.order-table .price {
    color: #666;
}

.order-table .quantity {
    text-align: center;
}

.order-table .total {
    font-weight: 600;
    color: #FAB12F;
}

.grand-total-row td {
    background-color: #f9f9f9 !important;
    font-weight: 600;
    font-size: 18px;
}

.grand-total-row .total {
    color: #FA4032;
}

.checkout-form {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-weight: 500;
}

.form-group input,
.form-group textarea,
.form-group select {
    width: 100%;
    padding: 12px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 16px;
    transition: all 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    border-color: #FAB12F;
    outline: none;
    box-shadow: 0 0 0 3px rgba(250, 177, 47, 0.1);
}

.submit-btn {
    width: 100%;
    padding: 15px;
    background-color: #FAB12F;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
}

.submit-btn:hover {
    background-color: #e59f1f;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(250, 177, 47, 0.2);
}
	</style>
</head>
<body>
    <header class="checkout-header">
        <div class="header-content">
            <div class="logo-container">
                <div class="logo"><a href="Home.jsp" style="text-decoration: none;">FZ</a></div>
            </div>
            <h1>Checkout</h1>
        </div>
    </header>
	
	 <div class="checkout-container">
        <div class="order-summary">
            <h3>Order Summary</h3>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<CartItem> orderItems = (List<CartItem>) session.getAttribute("orderItems");
                    if (orderItems != null && !orderItems.isEmpty()) {
                        for (CartItem item : orderItems) {
                    %>
                    <tr>
                        <td class="item-name"><%= item.getName() %></td>
                        <td class="price">₹<%= item.getPrice() %></td>
                        <td class="quantity"><%= item.getQuantity() %></td>
                        <td class="total">₹<%= item.getTotalPrice() %></td>
                    </tr>
                    <% 
                        }
                    %>
                    <tr class="grand-total-row">
                        <td colspan="3" style="text-align: right;">Grand Total:</td>
                        <td class="total">₹<%= session.getAttribute("orderTotal") %></td>
                    </tr>
                    <% } else { %>
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 20px;">
                            No items in cart
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
		<center><h3>Billing Details</h3></center>
        <div class="checkout-form">
            
            <form action="orderConfirmation.jsp" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <textarea id="address" name="address" rows="3" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="payment">Mode of Payment</label>
                    <select id="payment" name="payment" >
                        <!-- <option value="">Select payment method</option> -->
                        <option value="cod">Cash on delivery</option>
                        <option value="debit">Debit Card</option>
                        <option value="credit">Credit Card</option>
                        <option value="upi">UPI</option>
                    </select>
                </div>
                
                <button type="submit" class="submit-btn">Place Order</button>
                
            </form>
        </div>
    </div>
</body>
</html>