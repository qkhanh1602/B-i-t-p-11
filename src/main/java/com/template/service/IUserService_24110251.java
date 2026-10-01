package com.template.service;

import com.template.entity.User_24110251;


public interface IUserService_24110251 {
    User_24110251 login(String username, String password);
    boolean register(User_24110251 user);
    boolean activateUser(String username);
    User_24110251 findById(String username);
    User_24110251 findByEmail(String email);
}
