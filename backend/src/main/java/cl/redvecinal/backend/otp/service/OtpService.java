package cl.redvecinal.backend.otp.service;

public interface OtpService {
    void sendOTP (String phone);
    boolean verifyOTP (String phone, String validateCode);
}
