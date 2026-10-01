package com.template.dao;

import com.template.entity.Video_24110251;
import java.util.List;


public interface IVideoDao_24110251 {
    Video_24110251 findById(String id);
    List<Video_24110251> findAll();
    List<Video_24110251> findAllPaginated(int page, int pageSize);
    long countAll();
    List<Video_24110251> findByCategoryId(Integer categoryId, int page, int pageSize);
    long countByCategoryId(Integer categoryId);
    boolean create(Video_24110251 video);
    boolean update(Video_24110251 video);
    boolean delete(String id);
    boolean incrementViews(String id);
}
