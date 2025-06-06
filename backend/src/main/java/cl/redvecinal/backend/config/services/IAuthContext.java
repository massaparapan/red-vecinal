package cl.redvecinal.backend.config.services;

import cl.redvecinal.backend.user.model.User;

public interface IAuthContext {
    User getCurrentUser();
}
