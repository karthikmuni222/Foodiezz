<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Menu" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Foodiezz</title>
    <link rel="stylesheet" href="main.css">
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

.menu-header {
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

.menu-header h1 {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    font-size: 1.8rem;
    font-weight: 600;
}

.menu-content {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1rem;
}

.dishes-grid {
    display: flex;
    flex-direction: column;
    gap: 2rem;
    max-width: 900px;
    margin: 0 auto;
    position: relative;
    padding-bottom: 20px;
}

.dish-card {
    display: flex;
    flex-direction: row-reverse;
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
}

.dish-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.dish-image {
    width: 250px;
    height: 200px;
    flex-shrink: 0;
    position: relative;
}

.dish-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.dish-info {
    flex: 1;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.dish-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.dish-name {
    font-size: 1.2rem;
    font-weight: 600;
    color: #333;
}

.dish-rating {
    display: flex;
    align-items: center;
    gap: 0.25rem;
    color: #FA812F;
    margin-bottom: 1rem;
}

.dish-description {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
    line-height: 1.4;
}

.dish-footer {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
}

.left-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.quantity-control {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.quantity-input {
    width: 60px;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
    text-align: center;
}

.quantity-btn {
    display: none;
}

/* Add responsive design */
@media (max-width: 768px) {
    .dishes-grid {
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    }
}

/* Add new styles for the add button */
.add-btn {
    padding: 8px 24px;
    background-color: #B6CBBD;
    color: black;
    border: 1px solid #ddd;
    border-radius: 10px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    height: 38px;
    margin-left: 1rem;
}

.add-btn:hover {
    background-color: #e57428;
    color: white;
    border-color: #e57428;
}

/* Add new styles for the sticky cart button */
.view-cart-container {
    position: sticky;
    bottom: 20px;
    width: 100%;
    max-width: 900px;
    margin: 0 auto;
    margin-bottom: 0;
}

.view-cart-btn {
    width: 100%;
    padding: 1rem;
    background-color: #85A947;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.view-cart-btn:hover {
    background-color: #738f3c;
}

/* Remove the button from image */
.dish-image .add-btn {
    display: none;
}
		
	</style>
	
</head>
<body>
    <header class="menu-header">
        <div class="header-content">
            <div class="logo-container">
                <div class="logo"><a href="Home.jsp" style="text-decoration: none;">FZ</a></div>
            </div>
            <h1>Menu</h1>
        </div>
    </header>

    <main class="menu-content">
        <div class="dishes-grid">
            <%
            	List<Menu> menuList = (List<Menu>)request.getAttribute("Menus");
            	for( Menu m : menuList){
            %>
            <div class="dish-card">
                <div class="dish-image">
                    <img src="<%=m.getImagePath()%>" alt="<%=m.getItemName()%>">
                    <button class="add-btn">Add to Cart</button>
                </div>
                <div class="dish-info">
                    <div>
                        <div class="dish-header">
                            <h3 class="dish-name"><%= m.getItemName() %></h3>
                        </div>
                        <p class="dish-description"><%= m.getDescription() %></p>
                        <div class="dish-rating">
                            <i class="fas fa-star"></i>
                            <span><%=m.getRatings()%></span>
                        </div>
                    </div>
                    <div class="dish-footer">
                        <div class="left-section">
                            <div class="price">Price: ₹<%=m.getPrice()%></div>
                            <div class="quantity-controls">
                                <div class="quantity-control">
                                	<form action="CallingCartServlet" method="post">
                                    	<input type="hidden" name="restaurantId" value="<%= request.getParameter("restaurantId") %>">
                                    	<input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                                    	<input type="number" name="quantity" value="1" min="1">
                                    	<input type="hidden" name="action" value="add">
                                    	<button class="add-btn">Add to Cart</button>
                                	</form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			<%
            	}
            %>
            <!-- Add the view cart button as the last item in the grid -->
            <div class="view-cart-container">
                <button class="view-cart-btn">
                    View Cart
                </button>
            </div>
            
        </div>
    </main>
</body>
</html>
