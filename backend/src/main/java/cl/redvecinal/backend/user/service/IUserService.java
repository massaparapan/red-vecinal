package cl.redvecinal.backend.user.service;

public interface IUserService {
    boolean isUserRegistered(String phoneNumber);
    void resetPassword(String phoneNumber, String password);
}
