<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Foodiezz</title>
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

        .cart-header {
            position: sticky;
            top: 0;
            background-color: #FA812F;
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
            justify-content: space-between;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 1rem;
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

        .nav-buttons {
            display: flex;
            gap: 1rem;
        }

        .nav-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            background-color: white;
            color: #FA812F;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .nav-btn:hover {
            background-color: #f5f5f5;
        }

        .cart-content {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .cart-item {
            background-color: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .item-name {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: #333;
        }

        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }

        .price {
            font-size: 1.2rem;
            font-weight: 500;
            color: #4C585B;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .quantity-input {
            width: 60px;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            font-size: 1rem;
        }

        .remove-btn, .update-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            color: white;
        }

        .remove-btn {
            background-color: #FA4032;
        }

        .remove-btn:hover {
            background-color: #e53a2c;
        }

        .update-btn {
            background-color: #85A947;
        }

        .update-btn:hover {
            background-color: #738f3c;
        }

        .cart-actions {
            margin-top: 2rem;
            display: flex;
            justify-content: space-between;
            gap: 1rem;
        }

        .add-more-btn, .checkout-btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            text-align: center;
        }

        .add-more-btn {
            background-color: #fff;
            color: #333;
            border: 1px solid #ddd;
        }

        .add-more-btn:hover {
            background-color: #f5f5f5;
        }

        .checkout-btn {
            background-color: #85A947;
            color: white;
        }

        .checkout-btn:hover {
            background-color: #738f3c;
        }

        .empty-cart-msg {
            text-align: center;
            padding: 2rem;
            font-size: 1.2rem;
            color: #666;
        }

        .clear-cart {
            text-align: right;
            padding: 1rem;
        }

        .clear-btn {
            padding: 0.5rem 1rem;
            background-color: #FA4032;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .price-details {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .total-price {
            font-size: 1rem;
            color: #666;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .quantity-form {
            display: inline;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            color: #333;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quantity-btn:hover:not([disabled]) {
            background-color: #f5f5f5;
        }

        .quantity-btn[disabled] {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .quantity {
            font-size: 1.1rem;
            font-weight: 500;
            min-width: 30px;
            text-align: center;
        }

        .cart-summary {
            margin-top: 2rem;
            padding: 1rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .grand-total {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            text-align: right;
        }

        .remove-form {
            margin-left: auto;
        }

        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .empty-cart-msg {
            text-align: center;
            padding: 3rem;
            font-size: 1.2rem;
            color: #666;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <header class="cart-header">
        <div class="header-content">
            <div class="logo-container">
                <div class="logo"><a href="Home.jsp" style="text-decoration: none;">FZ</a></div>
                <h1>Cart</h1>
            </div>
            <div class="nav-buttons">
                <form action="Home.jsp" method="post" style="display: inline;">
                    <button type="submit" class="nav-btn">Home</button>
                </form>
                <form action="Menu" method="post" style="display: inline;">
                    <input type="hidden" name="restaurantId" value="<%=session.getAttribute("restaurantId")%>">
                    <button type="submit" class="nav-btn">Back to Menu</button>
                </form>
            </div>
        </div>
    </header>

    <main class="cart-content">
        <div class="clear-cart">
            <form action="CallingCartServlet" method="post">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="clear-btn">Clear Cart</button>
            </form>
        </div>

        <div class="cart-items">
            <% 
            Cart cart = (Cart) session.getAttribute("cart");
            Integer restaurantId = (Integer)session.getAttribute("restaurantId");
            if (cart != null && !cart.getItems().isEmpty()) {
                for (CartItem item : cart.getItems().values()) {
            %>
            <div class="cart-item">
                <h3 class="item-name"><%=item.getName()%></h3>
                <div class="item-details">
                    <div class="price-details">
                        <div class="price">₹<%=item.getPrice()%></div>
                        <div class="total-price">Total: ₹<%=item.getTotalPrice()%></div>
                    </div>
                    <div class="quantity-controls">
                        <form action="CallingCartServlet" method="post" class="quantity-form">
                            <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="quantity" value="<%=item.getQuantity() - 1%>">
                            <button type="submit" class="quantity-btn" <%=item.getQuantity() <= 1 ? "disabled" : ""%>>-</button>
                        </form>
                        
                        <span class="quantity"><%=item.getQuantity()%></span>
                        
                        <form action="CallingCartServlet" method="post" class="quantity-form">
                            <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="quantity" value="<%=item.getQuantity() + 1%>">
                            <button type="submit" class="quantity-btn">+</button>
                        </form>

                        <form action="CallingCartServlet" method="post" class="remove-form">
                            <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </div>
                </div>
            </div>
            <% 
                }
            %>
            <div class="cart-summary">
                <div class="grand-total">
                    Grand Total: ₹<%=cart.getTotalPrice()%>
                </div>
            </div>
            <%
            } else { 
            %>
            <div class="empty-cart-msg">Your Cart Is Empty</div>
            <% 
            } 
            %>
        </div>

        <div class="cart-actions">
            <form action="Menu" method="post" style="display: inline;">
                <input type="hidden" name="restaurantId" value="<%=session.getAttribute("restaurantId")%>">
                <button type="submit" class="add-more-btn">Add More Items</button>
            </form>
            <% if (cart != null && !cart.getItems().isEmpty()) { %>
            <form action="checkoutservlet" method="post" style="display: inline;">
                <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </form>
            <% } %>
        </div>
    </main>
</body>
</html>