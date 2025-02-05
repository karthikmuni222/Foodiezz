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
    <title>Order Confirmation - Foodiezz</title>
    <style>
        :root {
            --primary-color: #FAB12F;
            --primary-dark: #e59f1f;
            --background-color: #f9f9f9;
            --surface-color: #ffffff;
            --text-color: #333;
            --header-color: #FA4032;
            --header-text-color: #fff;
            --border-color: #ddd;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            background-color: #0f172a;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 500px;
            margin: 40px auto;
            padding: 20px;
        }

        .content {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        header {
            background-color: var(--header-color);
            color: var(--header-text-color);
            padding: 20px 0;
            text-align: center;
            box-shadow: var(--shadow);
        }

        header h1 {
            font-size: 2rem;
            font-weight: 600;
        }

        .confirmation-message {
            text-align: center;
            padding: 20px;
            margin-bottom: 30px;
        }

        .confirmation-message h2 {
            color: #FAB12F;
            font-size: 24px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .checkmark {
            width: 20px;
            height: 20px;
            margin: 15px auto;
        }
        
        .checkmark__circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 2;
            stroke-miterlimit: 10;
            stroke: #4CAF50;
            fill: none;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
        }
        
        .checkmark__check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            stroke: #4CAF50;
            stroke-width: 3;
            animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
        }

        .thank-you {
            font-size: 18px;
            color: #333;
            margin: 15px 0;
            font-weight: 500;
        }

        .order-message {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin: 10px 0;
            max-width: 600px;
            margin: 0 auto;
        }

        @keyframes stroke {
            100% {
                stroke-dashoffset: 0;
            }
        }

        .loading-bar {
            width: 0%;
            height: 3px;
            background-color: #4CAF50;
            border-radius: 2px;
            margin: 15px auto;
            animation: load 60s linear forwards;
        }

        @keyframes load {
            to {
                width: 100%;
            }
        }

        .order-details {
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f8f8f8;
            border-radius: 8px;
        }

        .order-summary {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .order-summary th, .order-summary td {
            padding: 12px;
            border: 1px solid var(--border-color);
        }

        .order-summary th {
            background-color: var(--primary-color);
            color: #fff;
            font-weight: 600;
            text-align: left;
        }

        .order-summary tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .total-price {
            margin-top: 20px;
            text-align: right;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 20px;
        }

        .home-btn {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .home-btn:hover {
            background-color: var(--primary-dark);
        }

        .video-background {
            position: fixed;
            right: 0;
            bottom: 0;
            min-width: 100%;
            min-height: 100%;
            width: auto;
            height: auto;
            z-index: -1;
        }

        /* Add an overlay to improve text readability */
        .content-overlay {
            position: relative;
            z-index: 1;
            background-color: rgba(255, 255, 255, 0.8); /* semi-transparent white */
            padding: 20px;
            border-radius: 8px;
        }

    </style>
</head>
<body>
    <video autoplay muted loop class="video-background">
        <source src="https://marketplace.canva.com/EAFA7Zl1wfs/1/0/800w/canva-pastel-red-green-illustrative-element-centric-video-background-xERo9kTCQgI.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="container">
        <div class="content">
            <div class="confirmation-message">
                <h2>🌟Order Confirmed🌟</h2>
                <div class="checkmark">
                    <svg class="checkmark__circle" height="20" viewBox="0 0 52 52" width="20" xmlns="http://www.w3.org/2000/svg">
                        <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                        <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>
                </div>
                <div class="loading-bar"></div>
                <p class="thank-you">Thank you for choosing us! 🎉</p>
                <p class="order-message">Your scrumptious meal is now being carefully prepared with the finest ingredients and utmost love by our expert chefs.</p>
            </div>
    
            <div class="button-container">
                <a href="Home.jsp" class="home-btn">Back to Home</a>
            </div>
        </div>
    </div>

</body>
</html>