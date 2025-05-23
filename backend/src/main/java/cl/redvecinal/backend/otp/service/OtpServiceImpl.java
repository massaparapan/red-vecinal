package cl.redvecinal.backend.otp.service;

import cl.redvecinal.backend.otp.exception.VerifyCodeNotFoundException;
import com.twilio.Twilio;
import com.twilio.rest.verify.v2.service.Verification;
import com.twilio.rest.verify.v2.service.VerificationCheck;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;

@org.springframework.stereotype.Service
public class OtpServiceImpl implements OtpService {
    @Value("${twilio.account.sid}")
    private String account_sid;
    @Value("${twilio.auth.token}")
    private String auth_token;
    @Value("${twilio.service.sid}")
    private String service_sid;

    @PostConstruct
    public void init() {
        Twilio.init(account_sid, auth_token);
    }

    public void sendOTP (String phoneNumber) {
        Verification verification = Verification.creator(
                service_sid,
                phoneNumber,
                "sms"
        )
                .create();
    }

    public boolean verifyOTP (String phoneNumber, String verificationCode) {
        try {
            VerificationCheck verificationCheck = VerificationCheck.creator(service_sid, verificationCode)
                    .setTo(phoneNumber)
                    .create();

            return verificationCheck.getValid();
        } catch (RuntimeException e) {
            throw new VerifyCodeNotFoundException("Validate code not found for phone: " + phoneNumber);
        }
    }
}
