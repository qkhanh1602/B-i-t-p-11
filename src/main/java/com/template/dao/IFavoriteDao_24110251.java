package com.template.dao;

import com.template.entity.Favorite_24110251;


public interface IFavoriteDao_24110251 {
    long countByVideoId(String videoId);
    Favorite_24110251 findByUserAndVideo(String username, String videoId);
    boolean create(Favorite_24110251 favorite);
    boolean delete(Integer favoriteId);
}
