package com.template.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.security.SecureRandom;
import java.util.Properties;

public class EmailUtil_24110251 {

    private static final String EMAIL_ADDRESS = "quockhanhn959@gmail.com";
    private static final String EMAIL_PASSWORD = "nugd bztc eroh bnnj";
    private static final SecureRandom random = new SecureRandom();

    public static String generateOtp() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static boolean sendOtpEmail(String toEmail, String otp) {
        System.out.println("[OTP SYSTEM] Generated OTP: " + otp + " for " + toEmail);

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_ADDRESS, EMAIL_PASSWORD.replace(" ", ""));
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_ADDRESS, "VideoHub"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("[VideoHub] Ma OTP kich hoat tai khoan");

            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; max-width: 500px;'>"
                    + "<h2 style='color: #0d6efd;'>VideoHub - Xac thuc tai khoan</h2>"
                    + "<p>Xin chao ban,</p>"
                    + "<p>Cam on ban da dang ky tai khoan tai VideoHub. Ma OTP xac thuc cua ban la:</p>"
                    + "<div style='text-align: center; margin: 20px 0;'>"
                    + "<span style='font-size: 28px; font-weight: bold; letter-spacing: 5px; color: #dc3545; background-color: #f8f9fa; padding: 10px 20px; border: 2px dashed #dc3545; border-radius: 6px;'>"
                    + otp + "</span>"
                    + "</div>"
                    + "<p>Ma OTP nay co hieu luc trong 5 phut. Vui long khong chia se ma nay cho bat ky ai.</p>"
                    + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>"
                    + "<p style='font-size: 12px; color: #6c757d;'>MSSV: 24110251 - De thi So 03 - ThS. Nguyen Huu Trung</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("[OTP SYSTEM] Email sent successfully to: " + toEmail);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
