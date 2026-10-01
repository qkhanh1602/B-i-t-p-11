package com.template.service;


public interface IShareService_24110251 {
    long countByVideoId(String videoId);
    boolean shareVideo(String username, String videoId, String emails);
}
