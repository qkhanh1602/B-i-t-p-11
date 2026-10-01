package com.template.service;

import com.template.dao.IVideoDao_24110251;
import com.template.dao.VideoDaoImpl_24110251;
import com.template.entity.Video_24110251;

import java.util.List;


public class VideoServiceImpl_24110251 implements IVideoService_24110251 {

    private IVideoDao_24110251 videoDao = new VideoDaoImpl_24110251();

    @Override
    public Video_24110251 findById(String id) {
        return videoDao.findById(id);
    }

    @Override
    public List<Video_24110251> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video_24110251> findAllPaginated(int page, int pageSize) {
        return videoDao.findAllPaginated(page, pageSize);
    }

    @Override
    public long countAll() {
        return videoDao.countAll();
    }

    @Override
    public List<Video_24110251> findByCategoryId(Integer categoryId, int page, int pageSize) {
        return videoDao.findByCategoryId(categoryId, page, pageSize);
    }

    @Override
    public long countByCategoryId(Integer categoryId) {
        return videoDao.countByCategoryId(categoryId);
    }

    @Override
    public boolean create(Video_24110251 video) {
        return videoDao.create(video);
    }

    @Override
    public boolean update(Video_24110251 video) {
        return videoDao.update(video);
    }

    @Override
    public boolean delete(String id) {
        return videoDao.delete(id);
    }

    @Override
    public boolean incrementViews(String id) {
        return videoDao.incrementViews(id);
    }
}
