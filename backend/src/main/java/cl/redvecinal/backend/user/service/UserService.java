package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.dto.UserDto;

public interface UserService {
    UserDto getUserById();
    boolean isUserRegistered(String phoneNumber);
}
