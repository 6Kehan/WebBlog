package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.User;
import com.blog.springboot.dao.UserMapper;
import com.blog.springboot.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *

 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
