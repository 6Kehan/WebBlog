package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.SessionDTO;
import com.blog.springboot.model.entity.Session;
import com.blog.springboot.model.entity.User;
import com.blog.springboot.model.entity.UserFollow;
import com.blog.springboot.service.SessionService;
import com.blog.springboot.service.UserFollowService;
import com.blog.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
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
@RequestMapping("/session")
public class SessionController {
    @Resource
    private SessionService service;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public Result add(@RequestBody Session session) {
        if (Objects.equals(session.getUser1Id(), session.getUser2Id())){
            return Result.fail("不能和自己建立私信");
        }

        Session serviceOne = service.getOne(new QueryWrapper<Session>().eq("user1_id", session.getUser1Id()).eq("user2_id", session.getUser2Id()));
        Session serviceOne2 = service.getOne(new QueryWrapper<Session>().eq("user1_id", session.getUser2Id()).eq("user2_id", session.getUser1Id()));
        if (serviceOne != null || serviceOne2 != null) {
            return Result.fail("已经建立过私信了");
        }

        service.save(session);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        service.removeById(id);
        return Result.success(null);
    }

    @PostMapping("/update")
    public Result update(@RequestBody Session session) {
        service.updateById(session);
        return Result.success(null);
    }


    @PostMapping("/getByUserId/{id}")
    public Result getByUserId(@PathVariable Integer id) {
        QueryWrapper<Session> wrapper = new QueryWrapper<Session>().eq("user1_id", id).or().eq("user2_id", id);
        List<Session> sessionList = service.list(wrapper);
        List<SessionDTO> sessionDTOList = new ArrayList<>();
        sessionList.forEach(session -> {
            User user ;
            if (Objects.equals(session.getUser1Id(), id)){
                user = userService.getOne(new QueryWrapper<User>().eq("user_id", session.getUser2Id()));
            }else {
                user = userService.getOne(new QueryWrapper<User>().eq("user_id", session.getUser1Id()));
            }

            sessionDTOList.add(SessionDTO.builder().sessionId(session.getId()).userid(user.getUserId())
                    .username(user.getRealname()).avatar(user.getAvator()).build());
        });

        return Result.success(sessionDTOList);
    }


    @PostMapping("/select")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<Session> userQueryWrapper = new QueryWrapper<Session>()
                .like("follow_user_name", element);
        return Result.success(200,"查询成功",service.list(userQueryWrapper));
    }
}
