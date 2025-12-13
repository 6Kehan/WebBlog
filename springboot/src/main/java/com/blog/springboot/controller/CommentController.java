package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.Blog;
import com.blog.springboot.model.entity.Comment;
import com.blog.springboot.model.entity.Type;
import com.blog.springboot.service.BlogService;
import com.blog.springboot.service.CommentService;
import com.blog.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


@RestController
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public Result add(@RequestBody Comment comment) {
        comment.setCreateTime(new Date());
        commentService.save(comment);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        commentService.removeById(id);
        return Result.success(null);
    }

    @PostMapping("/update")
    public Result update(@RequestBody Comment comment) {
        commentService.updateById(comment);
        return Result.success(null);
    }

    @PostMapping("/list")
    public Result get() {
        return Result.success(commentService.list());
    }

    @PostMapping("/getByUserId/{id}")
    public Result getByUserId(@PathVariable Integer id) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<Comment>().eq("user_id", id);
        List<Comment> tradingList = commentService.list(wrapper);
        return Result.success(tradingList);
    }

    @PostMapping("/getByBlogId/{id}")
    public Result getByBlogId(@PathVariable Integer id) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<Comment>().eq("blog_id", id);
        List<Comment> tradingList = commentService.list(wrapper);

        tradingList.forEach(comment -> {
            comment.setAvatar(userService.getById(comment.getUserId()).getAvator());
        });
        return Result.success(tradingList);
    }


    @PostMapping("/select")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<Comment> userQueryWrapper = new QueryWrapper<Comment>()
                .like("username", element).or().like("content", element);
        return Result.success(200,"查询成功",commentService.list(userQueryWrapper));
    }

}
