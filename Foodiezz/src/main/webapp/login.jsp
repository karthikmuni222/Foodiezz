<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Foodiezz</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins",sans-serif;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
			background: url("https://t3.ftcdn.net/jpg/02/52/38/80/240_F_252388016_KjPnB9vglSCuUJAumCDNbmMzGdzPAucK.jpg") no-repeat;            background-size: cover;
            background-position: center;
        }

        .wrapper {
            width: 420px;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            color: #ffff;
            border-radius: 10px;
            padding: 30px 40px;
        }

        .wrapper h1 {
            font-size: 36px;
            text-align: center;
        }

        .wrapper .input-box {
            position: relative;
            width: 100%;
            height: 50px;
            margin: 30px 0;
        }

        .input-box input {
            width: 100%;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 40px;
            font-size: 14px;
            color: #ffff;
            padding: 20px 45px 20px 20px; 
        }

        .input-box input::placeholder {
            color: #ffff;
        }

        .input-box i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
        }

        .wrapper .remember-forgot {
            display: flex;
            justify-content: space-between;
            margin: -15px 0 15px;
        }

        .remember-forgot label input {
            accent-color: #ffff;
            margin-right: 3px;
        }

        .remember-forgot a {
            color: #ffff;
            text-decoration: none;
        }

        .remember-forgot a:hover {
            text-decoration: underline;
        }

        .wrapper .btn {
            width: 100%;
            height: 40px;
            background: #ffff;
            border: none;
            outline: none;
            border-radius: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            font-size: 16px;
            color: black;
            font-weight: 600;
        }

        .wrapper .register-Link {
            font-size: 15px;
            text-align: center;
            margin: 20px 0px 15px;
        }

        .wrapper .register-Link p a {
            color: #ffff;
            text-decoration: none;
            font-weight: 600;
        }

        .wrapper .register-Link p a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff3333;
            text-align: center;
            margin-bottom: 15px;
            background: rgba(255, 51, 51, 0.1);
            padding: 10px;
            border-radius: 5px;
            display: none;
        }

        .error-message.show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <form action="login" method="post">
            <h1>Login</h1>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message show">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <div class="input-box">
                <input type="text" placeholder="username" name="username" required>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="password" placeholder="Password" name="password" required>
                <i class='bx bxs-lock'></i>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" name="remember">Remember me</label>
                <a href="forgotPassword.jsp">Forgot password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="register-Link">
                <p>Don't have an account? <a href="SignUp.jsp">Register</a></p>
            </div>
        </form>
    </div>
</body>
</html>