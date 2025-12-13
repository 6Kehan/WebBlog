package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Comment;
import com.blog.springboot.dao.CommentMapper;
import com.blog.springboot.service.CommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;


@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

}
