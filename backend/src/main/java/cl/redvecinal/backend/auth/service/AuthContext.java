package cl.redvecinal.backend.auth.service;

import cl.redvecinal.backend.user.model.User;

public interface AuthContext {
    User getCurrentUser();
}
