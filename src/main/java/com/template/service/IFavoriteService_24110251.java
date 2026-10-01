package com.template.service;


public interface IFavoriteService_24110251 {
    long countByVideoId(String videoId);
    boolean isLiked(String username, String videoId);
    boolean toggleLike(String username, String videoId);
}
