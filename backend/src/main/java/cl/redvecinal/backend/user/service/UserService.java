package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.dto.request.UpdateProfileDto;
import cl.redvecinal.backend.user.dto.response.UserMyProfileDto;
import cl.redvecinal.backend.user.dto.response.UserProfileDto;

public interface UserService {
    boolean isUserRegistered(String phoneNumber);
    void resetPassword(String phoneNumber, String password);
    UserMyProfileDto showMyProfile();
    UserProfileDto showProfileUser(Long id);
    void updateMyProfile(UpdateProfileDto request);
}
