<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Details</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Sixtyfour+Convergence&display=swap" rel="stylesheet">
        <link href="img/favicon.ico" rel="shortcut icon"/>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .thank-you-container {
                text-align: center;
                margin: 50px auto;
                padding: 20px;
                border-radius: 20px;
                background-color: #fff;
                border: 2px solid black;
                box-shadow: 0 4px 8px rgb(67 67 255 / 50%);
                width: 50%;
            }
            .btn-back {
                margin-top: 20px;
            }
        </style>
    </head>
    <body style="background: url('img/bg-bill.jpg');
          background-size: 100%;
          background-repeat: no-repeat;
          background-position: top;">
        <div class="thank-you-container">
            <h1>Thank You for Your Payment This Game!</h1>
            <p>Your payment was successful. Here are the details:</p>

            <%
                String orderInfo = request.getParameter("vnp_OrderInfo");
                String amount = request.getParameter("vnp_Amount");
                String transactionID = request.getParameter("vnp_TransactionNo");
                String responseCode = request.getParameter("vnp_ResponseCode");
                String postId = request.getParameter("vnp_TxnRef");
                String userId = request.getParameter("adminId");

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

            <p><strong>Order Information:</strong> <%= displayOrderInfo%></p>
            <p><strong>Amount Paid:</strong> <%= displayAmount%></p>
            <p><strong>Transaction ID:</strong> <%= displayTransactionID%></p>
            <p><strong>Response Code:</strong> <%= displayResponseCode%></p>
            <p><strong>Link of the Game:</strong> <a href="<%= linkGame%>" target="_blank">Download Game</a></p>

           <a href="http://localhost:8080/Web_Trading_Game/ReadGameHome" class="btn btn-primary btn-back">Return to Home</a>

        </div>
    </body>
</html>
