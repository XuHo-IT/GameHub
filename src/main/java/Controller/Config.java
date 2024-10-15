package Controller;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TimeZone;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;

public class Config {
    public static String vnp_TmnCode = "792CIWPF";
    public static String vnp_HashSecret = "9T97RKKUE11F70PAIYAVYU1M5MPAKXRH";
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8080/Web_Trading_Game/bill-detail.jsp";
    public static String vnp_ApiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

   public static String getReturnUrl() {
        return vnp_ReturnUrl;
    }

    // Get current date in the required format for VNPay
    public static String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7")); // Set timezone to GMT+7 for VNPay
        return sdf.format(new Date());
    }
    public static String md5(String message) {
        return hashWithAlgorithm("MD5", message);
    }

    public static String sha256(String message) {
        return hashWithAlgorithm("SHA-256", message);
    }
    public static String getSecureHash(SortedMap<String, String> params, String secretKey) {
        StringBuilder hashData = new StringBuilder();
        
        // Sort the parameters
        params = new TreeMap<>(params);
        
        // Build the hash string
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (!entry.getKey().equals("vnp_SecureHash") && entry.getValue() != null) {
                hashData.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
            }
        }
        
        // Append the secret key
        hashData.append("vnp_HashSecret=").append(secretKey);
        
        // Generate the hash
        return getMD5(hashData.toString()).toUpperCase();
    }

    private static String getMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private static String hashWithAlgorithm(String algorithm, String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance(algorithm);
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            Mac hmacSha512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmacSha512.init(secretKeySpec);
            byte[] hash = hmacSha512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hash);  // Convert byte array to hex string
        } catch (Exception e) {
            throw new RuntimeException("Error while hashing", e);
        }
    }

    // Utility method to convert byte array to hex string
    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress;
        try {
            ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAddress = "Invalid IP: " + e.getMessage();
        }
        return ipAddress;
    }

    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(rnd.nextInt(10)); // Generates a digit from 0-9
        }
        return sb.toString();
    }
}
