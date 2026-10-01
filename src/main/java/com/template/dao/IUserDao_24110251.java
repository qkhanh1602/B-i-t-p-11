package com.template.dao;

import com.template.entity.User_24110251;
import java.util.List;


public interface IUserDao_24110251 {
    User_24110251 findById(String username);
    User_24110251 findByEmail(String email);
    List<User_24110251> findAll();
    boolean create(User_24110251 user);
    boolean update(User_24110251 user);
    boolean delete(String username);
}
