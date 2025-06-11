package cl.redvecinal.backend.otp.service.impl;

import cl.redvecinal.backend.otp.exception.NoSuccessSendOTP;
import cl.redvecinal.backend.otp.exception.VerifyCodeNotFoundException;
import cl.redvecinal.backend.otp.service.OtpService;
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
            throw new NoSuccessSendOTP("Error al enviar el codigo al telefono: " + phoneNumber);
        }
    }

    public boolean verifyOTP(String phoneNumber, String verificationCode) {
        try {
            VerificationCheck verificationCheck = VerificationCheck.creator(service_sid, verificationCode)
                    .setTo(phoneNumber)
                    .create();
            return verificationCheck.getValid();
        } catch (RuntimeException e) {
            throw new VerifyCodeNotFoundException("Codigo no enviado al telefono: " + phoneNumber);
        }
    }
}
