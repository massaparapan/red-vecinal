package cl.redvecinal.backend.otp.service.impl;

import cl.redvecinal.backend.common.exception.ConflictException;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.otp.service.OtpService;
import com.twilio.Twilio;
import com.twilio.rest.verify.v2.service.Verification;
import com.twilio.rest.verify.v2.service.VerificationCheck;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;

/**
 * Implementation of the OtpService interface for handling OTP (One-Time Password) operations.
 * This service uses Twilio's Verify API to send and verify OTPs.
 */
@org.springframework.stereotype.Service
public class OtpServiceImpl implements OtpService {
    @Value("${twilio.account.sid}")
    private String account_sid;
    @Value("${twilio.auth.token}")
    private String auth_token;
    @Value("${twilio.service.sid}")
    private String service_sid;

    /**
     * Initializes the Twilio client with the account SID and authentication token.
     * This method is executed after the bean's properties have been set.
     */
    @PostConstruct
    public void init() {
        Twilio.init(account_sid, auth_token);
    }

    /**
     * Sends an OTP to the specified phone number using Twilio's Verify API.
     *
     * @param phoneNumber the phone number to which the OTP will be sent
     */
    public void sendOTP(String phoneNumber) {
        try {
            Verification verification = Verification.creator(
                            service_sid,
                            phoneNumber,
                            "sms"
                    )
                    .create();
            System.out.println("OTP enviado a: " + phoneNumber + " con SID: " + verification.getStatus());
        } catch (RuntimeException e) {
            throw new ConflictException("Error al enviar el codigo al telefono: " + phoneNumber);
        }
    }

    /**
     * Verifies the OTP for the specified phone number using Twilio's Verify API.
     *
     * @param phoneNumber the phone number associated with the OTP
     * @param verificationCode the OTP to be verified
     * @return true if the OTP is valid, false otherwise
     */
    public boolean verifyOTP(String phoneNumber, String verificationCode) {
        try {
            VerificationCheck verificationCheck = VerificationCheck.creator(service_sid, verificationCode)
                    .setTo(phoneNumber)
                    .create();
            return verificationCheck.getValid();
        } catch (RuntimeException e) {
            throw new NotFoundException("Codigo no enviado al telefono: " + phoneNumber);
        }
    }
}
