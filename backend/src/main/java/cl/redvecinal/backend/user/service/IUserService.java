package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.dto.response.UserMyProfileDto;
import cl.redvecinal.backend.user.dto.response.UserProfileDto;

public interface IUserService {
    boolean isUserRegistered(String phoneNumber);
    void resetPassword(String phoneNumber, String password);
    UserMyProfileDto showMyProfile();
    UserProfileDto showProfileUser(Long id);
}
