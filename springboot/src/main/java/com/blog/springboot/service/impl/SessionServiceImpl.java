package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Session;
import com.blog.springboot.dao.SessionMapper;
import com.blog.springboot.service.SessionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2025-04-27
 */
@Service
public class SessionServiceImpl extends ServiceImpl<SessionMapper, Session> implements SessionService {

}
