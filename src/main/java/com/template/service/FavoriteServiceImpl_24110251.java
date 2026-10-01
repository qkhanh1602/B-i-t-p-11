package com.template.service;

import com.template.dao.FavoriteDaoImpl_24110251;
import com.template.dao.IFavoriteDao_24110251;
import com.template.dao.IUserDao_24110251;
import com.template.dao.IVideoDao_24110251;
import com.template.dao.UserDaoImpl_24110251;
import com.template.dao.VideoDaoImpl_24110251;
import com.template.entity.Favorite_24110251;
import com.template.entity.User_24110251;
import com.template.entity.Video_24110251;

import java.util.Date;


public class FavoriteServiceImpl_24110251 implements IFavoriteService_24110251 {

    private IFavoriteDao_24110251 favoriteDao = new FavoriteDaoImpl_24110251();
    private IUserDao_24110251 userDao = new UserDaoImpl_24110251();
    private IVideoDao_24110251 videoDao = new VideoDaoImpl_24110251();

    @Override
    public long countByVideoId(String videoId) {
        return favoriteDao.countByVideoId(videoId);
    }

    @Override
    public boolean isLiked(String username, String videoId) {
        return favoriteDao.findByUserAndVideo(username, videoId) != null;
    }

    @Override
    public boolean toggleLike(String username, String videoId) {
        Favorite_24110251 existing = favoriteDao.findByUserAndVideo(username, videoId);
        if (existing != null) {
            return favoriteDao.delete(existing.getFavoriteId());
        } else {
            User_24110251 user = userDao.findById(username);
            Video_24110251 video = videoDao.findById(videoId);
            if (user != null && video != null) {
                Favorite_24110251 fav = new Favorite_24110251(new Date(), user, video);
                return favoriteDao.create(fav);
            }
        }
        return false;
    }
}
