package com.template.dao;

import com.template.entity.Share_24110251;


public interface IShareDao_24110251 {
    long countByVideoId(String videoId);
    boolean create(Share_24110251 share);
}
