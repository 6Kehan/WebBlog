package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Blog;
import com.blog.springboot.dao.BlogMapper;
import com.blog.springboot.service.BlogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;


@Service
public class BlogServiceImpl extends ServiceImpl<BlogMapper, Blog> implements BlogService {

}
