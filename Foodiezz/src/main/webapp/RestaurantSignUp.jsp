<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Sign Up - Foodiezz</title>
<style>
    body {
        margin: 0;
        padding: 0;
        background-image: url('https://media.admiddleeast.com/photos/66a8cd5c062b8b3a02f9430c/16:9/w_1920,c_limit/abu-dhabi-broadway-interior-seating.jpeg');
        background-size: cover;
        background-position: center;
        font-family: Arial, sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .signup-container {
        background-color: rgba(255, 255, 255, 0.9);
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        width: 400px;
    }
    
    h2 {
        text-align: center;
        color: #FA4032;
        margin-bottom: 30px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    label {
        display: block;
        margin-bottom: 5px;
        color: #333;
        font-weight: bold;
    }
    
    input, select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    button {
        width: 100%;
        padding: 12px;
        background-color: #FAB12F;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: background-color 0.3s;
    }
    
    button:hover {
        background-color: #FA4032;
    }
</style>
</head>
<body>
    <div class="signup-container">
        <h2>Restaurant Registration</h2>
        <form action="AddRestaurant" method="post">
            <div class="form-group">
                <label for="name">Restaurant Name</label>
                <input type="text" id="name" name="r_name" placeholder="Enter the restaurant name" required>
            </div>
            
             <div class="form-group">
	            <label for="image">Image URL:</label>
	            <input type="text" id="image" name="image" placeholder="Enter the Image URL" required>
        	</div>
            
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="r_address" placeholder="Enter the restaurant address" required>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="r_phone" required pattern="[0-9]{10}">
            </div>
            
            <div class="form-group">
                <label for="rating">Rating</label>
                <input type="number" id="rating" name="r_rating" min="0" max="5" step="0.1" value="4.0" required>
            </div>
            
            <div class="form-group">
            	<label for="cuisineType">Cuisine Type:</label>
            	<input type="text" id="cuisineType" name="cuisineType" placeholder="Enter the Cuisine Type" required>
        	</div>
            
            <div class="form-group">
                <label for="eta">Estimated Delivery Time (minutes)</label>
                <input type="number" id="eta" name="eta" min="10" max="120" value="30" required>
            </div>
            
            <div class="form-group">
	            <label for="restaurantOwnerId">Restaurant Owner ID:</label>
	            <input type="number" id="restaurantOwnerId" name="restaurantOwnerId" placeholder="Enter the Owner ID" required>
        	</div>
	
			<div class="form-group">
	            <label for="name">Name:</label>
	            <input type="text" id="u_name" name="u_name" placeholder="Enter Your Full Name" required>
        	</div>
        
	        <div class="form-group">
	            <label for="email">Email:</label>
	            <input type="email" id="u_email" name="u_email" placeholder="Enter Your Email Address" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="phone">Phone Number:</label>
	            <input type="text" id="u_phone" name="u_phone" placeholder="Enter Your Phone Number" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="address">City:</label>
	            <input type="text" id="u_address" name="u_address" placeholder="Enter Your City" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="username">Username:</label>
	            <input type="text" id="u_username" name="u_username" placeholder="Choose a Username" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="password">Password:</label>
	            <input type="password" id="u_password" name="u_password" placeholder="Enter Your Password" required>
	        </div>
			
            
            <button type="submit">Register Restaurant</button>
        </form>
    </div>
</body>
</html>