package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Message;
import com.blog.springboot.dao.MessageMapper;
import com.blog.springboot.service.MessageService;
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
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements MessageService {

}
