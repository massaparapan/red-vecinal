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

    /**
     * Sends a One-Time Password (OTP) to the specified phone number via SMS.
     * Uses the Twilio Verify API to create and send the OTP.
     * Throws an exception if the OTP could not be sent successfully.
     *
     * @param phoneNumber the phone number to which the OTP will be sent
     * @throws NoSuccessSendOTP if there is an error sending the OTP
     */
    public void sendOTP(String phoneNumber) {
        try {
            Verification verification = Verification.creator(
                            service_sid,
                            phoneNumber,
                            "sms"
                    )
                    .create();
            System.out.println(verification.getStatus());
        } catch (RuntimeException e) {
            throw new NoSuccessSendOTP("Error al enviar el codigo al telefono: " + phoneNumber);
        }
    }

    /**
     * Verifies the provided OTP for the specified phone number.
     * Uses the Twilio Verify API to check the validity of the OTP.
     * Throws an exception if the verification process fails.
     *
     * @param phoneNumber the phone number associated with the OTP
     * @param verificationCode the OTP to be verified
     * @return true if the OTP is valid, false otherwise
     * @throws VerifyCodeNotFoundException if the OTP verification fails
     */
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
