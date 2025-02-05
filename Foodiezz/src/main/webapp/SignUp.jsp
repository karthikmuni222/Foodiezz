<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>SignUp</title>
		<style>
			body {
				font-family: Roboto, sans-serif;
				font-family: Arial, sans-serif;
				background-color: #e0f7fa;
				margin: 0;
				padding: 0;
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
				background-image: url('https://images.pexels.com/photos/326333/pexels-photo-326333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
				background-size: cover;
				background-position: center;
				background-repeat: no-repeat;
				min-height: 100vh;
			}
			
			
			form {
				background-color: #ffffff;
				border-radius: 7px;
				box-shadow: 0 0 100px rgba(0, 0, 0, 0.1);
				padding: 25px;
				width: 450px;
			}
			
			h2 {
				margin-top: 50px; 
				text-align: center;
				color: #FF8000;
			}
			
			h5, h6 {
				text-align: left;
				color: #00796b;
			}
			
			h5 a {
				text-align: left;
				color: #ff7043;
			}
			
			label {
				display: block;
				margin-bottom: 5px;
				color: #37474f;
			}
			
			input[type="text"], input[type="email"], input[type="password"], input[type="tel"],
				input[type="submit"] {
				width: 100%;
				padding: 8px;
				margin-bottom: 10px;
				border: 2px solid #b0bec5;
				border-radius: 4px;
				box-sizing: border-box;
				font-size: 16px;
			}
			
			select {
				-webkit-appearance: none;
				-moz-appearance: none;
				appearance: none;
				padding: 10px;
				border: 1px solid #b0bec5;
				border-radius: 5px;
				background-color: #ffffff;
				cursor: pointer;
			}
			
			select:hover {
				background-color: #e0f2f1;
			}
			
			select:focus {
				outline: none;
				border-color: #004d40;
			}
			
			input[type="submit"] {
				background-color: #00796b;
				color: white;
				border: none;
				cursor: pointer;
			}
			
			#seller {
				background-color: #FAB12F;
				color: white;
				border: none;
				cursor: pointer;
				padding: 8px;
				margin-bottom: 10px;
				border: 2px solid #b0bec5;
				border-radius: 4px;
				box-sizing: border-box;
				font-size: 16px;
				text-decoration: none;
			}
			
			button a {
				color: white;
			}
			
			#seller:hover {
				background-color: #004d40;
			}
			
			input[type="submit"]:hover {
				background-color: #004d40;
			}
			
			a {
				color: #00796b;
				text-decoration: none;
			}
			
			a:hover {
				text-decoration: underline;
			}
			
			button a:hover {
				text-decoration: none;
			}
			
			.terms {
				font-size: 12px;
				color: #607d8b;
			}
			
			@media only screen and (max-width: 600px) {
				form {
					width: 80%;
				}
			}
			
			.container {
				background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
				padding: 20px;
				border-radius: 8px;
				margin-top: 20px;
			}
			</style>
	</head>
	<body>
	<form action="SignUp" method="post">

		<h2>Sign up</h2>
		<label for="name">Name:</label> 
			<input type="text" id="name" name="name" placeholder="Enter the Name" required></input> 
		<label for="email">Email:</label> 
			<input type="text" id="email" name="email" placeholder="Enter the Email" required></input> 
		<label for="phone">PhoneNo:</label>
			<input type="text" id="phone" name="phone" placeholder="Enter the PhoneNo"></input> 
		<label for="address">Address:</label>
			<input type="text" id="address" name="address" placeholder="Enter the city name" required></input>
		<label for="username">UserName:</label> 
			<input type="text" id="username" name="username" placeholder="Enter the Usernane" required></input> 
		<label for="password">Password:</label> 
			<input type="password" id="password" name="password" placeholder="Enter the Password" required></input>
		<h6 class="terms">
			By creating an account, I accept the <a href="#">Terms and
				Conditions</a> and <a href="#"> Privacy Policy</a>
		</h6>
		<input type="submit" value="Sign Up"></input>
		<h5>
			Already have an account? <a href="login.jsp">Login to your
				account </a>
			<button id="seller">
				<a href="RestaurantSignUp.jsp">🏛️Become a Seller</a>
			</button>
			<button id="seller">
				<a href="AgentSignUp.jsp">👨🏻‍💼Delivery Agent</a>
			</button>
		</h5>
	</form>

</body>
</html>