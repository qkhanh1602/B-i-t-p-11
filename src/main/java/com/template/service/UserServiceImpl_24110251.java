package com.template.service;

import com.template.dao.IUserDao_24110251;
import com.template.dao.UserDaoImpl_24110251;
import com.template.entity.User_24110251;


public class UserServiceImpl_24110251 implements IUserService_24110251 {

    private IUserDao_24110251 userDao = new UserDaoImpl_24110251();

    @Override
    public User_24110251 login(String username, String password) {
        User_24110251 user = userDao.findById(username);
        if (user != null && user.getPassword() != null && user.getPassword().equals(password)) {
            if (Boolean.TRUE.equals(user.getActive())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean register(User_24110251 user) {
        user.setActive(false);
        user.setAdmin(false);
        return userDao.create(user);
    }

    @Override
    public boolean activateUser(String username) {
        User_24110251 user = userDao.findById(username);
        if (user != null) {
            user.setActive(true);
            return userDao.update(user);
        }
        return false;
    }

    @Override
    public User_24110251 findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public User_24110251 findByEmail(String email) {
        return userDao.findByEmail(email);
    }
}
