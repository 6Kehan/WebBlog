package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.BlogFile;
import com.blog.springboot.dao.BlogImageMapper;
import com.blog.springboot.service.BlogImageService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2025-04-26
 */
@Service
public class BlogImageServiceImpl extends ServiceImpl<BlogImageMapper, BlogFile> implements BlogImageService {

}
