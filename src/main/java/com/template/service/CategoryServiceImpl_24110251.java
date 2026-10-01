package com.template.service;

import com.template.dao.CategoryDaoImpl_24110251;
import com.template.dao.ICategoryDao_24110251;
import com.template.entity.Category_24110251;

import java.util.List;


public class CategoryServiceImpl_24110251 implements ICategoryService_24110251 {

    private ICategoryDao_24110251 categoryDao = new CategoryDaoImpl_24110251();

    @Override
    public Category_24110251 findById(Integer id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category_24110251> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public boolean create(Category_24110251 category) {
        return categoryDao.create(category);
    }

    @Override
    public boolean update(Category_24110251 category) {
        return categoryDao.update(category);
    }

    @Override
    public boolean delete(Integer id) {
        return categoryDao.delete(id);
    }
}
