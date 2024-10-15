<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .thank-you-container {
            text-align: center;
            margin: 50px auto;
            padding: 20px;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 50%;
        }
        .btn-back {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="thank-you-container">
        <h1>Thank You for Your Payment!</h1>
        <p>Your payment was successful. Here are the details:</p>

        <%
            String orderInfo = request.getParameter("vnp_OrderInfo");
            String amount = request.getParameter("vnp_Amount");
            String transactionID = request.getParameter("vnp_TransactionNo");
            String responseCode = request.getParameter("vnp_ResponseCode");
            String postId = request.getParameter("vnp_TxnRef");

            // Get the game link from the request
            String linkGame = request.getParameter("link"); // Correct parameter name
          
            // Display values or default message
            String displayOrderInfo = (orderInfo != null) ? orderInfo : "N/A";
            String displayAmount = (amount != null) ? amount : "N/A";
            String displayTransactionID = (transactionID != null) ? transactionID : "N/A";
            String displayResponseCode = (responseCode != null) ? responseCode : "N/A";

            // Format amount to VND
            if (!displayAmount.equals("N/A")) {
                displayAmount = String.format("%,.0f VND", Double.parseDouble(displayAmount) / 100);
            }
        %>

        <p><strong>Order Information:</strong> <%= displayOrderInfo %></p>
        <p><strong>Amount Paid:</strong> <%= displayAmount %></p>
        <p><strong>Transaction ID:</strong> <%= displayTransactionID %></p>
        <p><strong>Response Code:</strong> <%= displayResponseCode %></p>
        <p><strong>Link of the Game:</strong> <a href="<%= linkGame %>" target="_blank">Download Game</a></p>

        <a href="http://localhost:8080/Web_Trading_Game/ReadGameHomeController" class="btn btn-primary btn-back">Return to Home</a>
    </div>
</body>
</html>
