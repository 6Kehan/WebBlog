package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.MessageDTO;
import com.blog.springboot.model.SessionDTO;
import com.blog.springboot.model.entity.Message;
import com.blog.springboot.model.entity.Session;
import com.blog.springboot.model.entity.User;
import com.blog.springboot.service.MessageService;
import com.blog.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService service;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public Result add(@RequestBody Message message) {
        message.setCreateTime(new Date());
        service.save(message);
        return Result.success(null);
    }

    @PostMapping("/getById/{id}")
    public Result getByUserId(@PathVariable Integer id) {
        QueryWrapper<Message> wrapper = new QueryWrapper<Message>().eq("session_id", id);
        List<Message> sessionList = service.list(wrapper);

        List<MessageDTO> messageDTOList = new ArrayList<>();
        sessionList.forEach(session -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", session.getMessageUserId()));
            messageDTOList.add(MessageDTO.builder().id(session.getId()).sender(session.getMessageUserId()).content(session.getContent())
                    .time(session.getCreateTime()).avatar(user.getAvator()).build());
        });

        return Result.success(messageDTOList);
    }
}
