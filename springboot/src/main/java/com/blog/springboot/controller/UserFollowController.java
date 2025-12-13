package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.Comment;
import com.blog.springboot.model.entity.UserFollow;
import com.blog.springboot.service.UserFollowService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/userFollow")
public class UserFollowController {
    @Resource
    private UserFollowService service;

    @PostMapping("/create")
    public Result add(@RequestBody UserFollow userFollow) {
        UserFollow follow = service.getOne(new QueryWrapper<UserFollow>().eq("user_id", userFollow.getUserId())
                .eq("follow_user_id", userFollow.getFollowUserId()));
        if (follow != null) {
            return Result.fail("已经关注过了");
        }
        userFollow.setCreateTime(new Date());
        service.save(userFollow);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        service.removeById(id);
        return Result.success(null);
    }

    @PostMapping("/update")
    public Result update(@RequestBody UserFollow userFollow) {
        service.updateById(userFollow);
        return Result.success(null);
    }

    @PostMapping("/getType")
    public Result getType() {
        return Result.success(service.list());
    }

    @PostMapping("/getByUserId/{id}")
    public Result getByUserId(@PathVariable Integer id) {
        QueryWrapper<UserFollow> wrapper = new QueryWrapper<UserFollow>().eq("user_id", id);
        List<UserFollow> tradingList = service.list(wrapper);
        return Result.success(tradingList);
    }




    @PostMapping("/select")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<UserFollow> userQueryWrapper = new QueryWrapper<UserFollow>()
                .like("follow_user_name", element);
        return Result.success(200,"查询成功",service.list(userQueryWrapper));
    }
}
