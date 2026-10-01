package com.template.service;

import com.template.dao.IShareDao_24110251;
import com.template.dao.IUserDao_24110251;
import com.template.dao.IVideoDao_24110251;
import com.template.dao.ShareDaoImpl_24110251;
import com.template.dao.UserDaoImpl_24110251;
import com.template.dao.VideoDaoImpl_24110251;
import com.template.entity.Share_24110251;
import com.template.entity.User_24110251;
import com.template.entity.Video_24110251;

import java.util.Date;


public class ShareServiceImpl_24110251 implements IShareService_24110251 {

    private IShareDao_24110251 shareDao = new ShareDaoImpl_24110251();
    private IUserDao_24110251 userDao = new UserDaoImpl_24110251();
    private IVideoDao_24110251 videoDao = new VideoDaoImpl_24110251();

    @Override
    public long countByVideoId(String videoId) {
        return shareDao.countByVideoId(videoId);
    }

    @Override
    public boolean shareVideo(String username, String videoId, String emails) {
        User_24110251 user = userDao.findById(username);
        Video_24110251 video = videoDao.findById(videoId);
        if (user != null && video != null) {
            Share_24110251 share = new Share_24110251(emails, new Date(), user, video);
            return shareDao.create(share);
        }
        return false;
    }
}
