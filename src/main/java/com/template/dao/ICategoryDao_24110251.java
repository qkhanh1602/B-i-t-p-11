package com.template.dao;

import com.template.entity.Category_24110251;
import java.util.List;


public interface ICategoryDao_24110251 {
    Category_24110251 findById(Integer id);
    List<Category_24110251> findAll();
    boolean create(Category_24110251 category);
    boolean update(Category_24110251 category);
    boolean delete(Integer id);
}
