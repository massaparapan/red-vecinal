package cl.redvecinal.backend.user.service;

public interface UserService {
    boolean isUserRegistered(String phoneNumber);
    void resetPassword(String phoneNumber, String password);
}
