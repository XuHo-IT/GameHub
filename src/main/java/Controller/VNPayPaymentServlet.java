package Controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/vnpay-payment")
public class VNPayPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve required parameters for the payment
        String orderType = request.getParameter("vnp_OrderType");
        String amount = request.getParameter("vnp_Amount");
        String orderId = Config.getRandomNumber(8); // Generate random order ID
        String bankCode = request.getParameter("bankCode");
        String linkValue = request.getParameter("vnp_Link"); // Get the link value

        // Set transaction details
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", Config.vnp_TmnCode); // Your terminal code
        vnp_Params.put("vnp_Amount", String.valueOf(Long.parseLong(amount) * 100)); // Amount in VND
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", orderId);
        vnp_Params.put("vnp_OrderInfo", "Payment for order " + orderId);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");

        // Construct the return URL with the linkValue as a query parameter
        String returnUrl = Config.getReturnUrl();
        if (linkValue != null && !linkValue.isEmpty()) {
            returnUrl += "?link=" + URLEncoder.encode(linkValue, StandardCharsets.UTF_8); // Append the linkValue
        }
        vnp_Params.put("vnp_ReturnUrl", returnUrl); // Use the modified return URL
        vnp_Params.put("vnp_IpAddr", Config.getIpAddress(request)); // Get client IP address
        vnp_Params.put("vnp_CreateDate", Config.getCurrentDate());

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }

        // Step 1: Sort parameters by key
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        // Step 2: Build the hash data
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                query.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                query.append('&');  // Append '&' for query string
                hashData.append('&'); // Append '&' for hash data
            }
        }

        // Remove the trailing '&' for hashData and query
        if (hashData.length() > 0) {
            hashData.setLength(hashData.length() - 1);
        }
        if (query.length() > 0) {
            query.setLength(query.length() - 1);
        }

        // Step 3: Generate secure hash
        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        vnp_Params.put("vnp_SecureHash", vnp_SecureHash);

        // Step 4: Build the full query URL
        String paymentUrl = Config.vnp_PayUrl + "?" + query.toString() + "&vnp_SecureHash=" + vnp_SecureHash;

        // Redirect the user to VNPay payment URL
        response.sendRedirect(paymentUrl);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

