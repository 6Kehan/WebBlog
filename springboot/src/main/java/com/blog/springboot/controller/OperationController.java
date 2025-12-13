package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.Blog;
import com.blog.springboot.model.entity.Comment;
import com.blog.springboot.model.entity.Operation;
import com.blog.springboot.service.BlogService;
import com.blog.springboot.service.CommentService;
import com.blog.springboot.service.OperationService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/operation")
public class OperationController {
    @Resource
    private OperationService operationService;

    @Resource
    private BlogService blogService;

    @PostMapping("/create")
    public Result add(@RequestBody Operation operation) {

        QueryWrapper<Operation> wrapper = new QueryWrapper<Operation>()
                .eq("user_id", operation.getUserId())
                .eq("blog_id",operation.getBlogId())
                .eq("type",operation.getType());
        Operation one = operationService.getOne(wrapper);
        if(one!=null){
            return Result.fail(operation.getType()==1?"收藏过了":"点赞过了");
        }
        operationService.save(operation);
        if(operation.getType()==2){
            Blog blog = blogService.getById(operation.getBlogId());
            blog.setCount(blog.getCount()+1);
            blogService.updateById(blog);
        }
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        operationService.removeById(id);
        return Result.success(null);
    }


    @PostMapping("/getCollectByUserId/{id}")
    public Result getCollectByUserId(@PathVariable Integer id) {
        QueryWrapper<Operation> wrapper = new QueryWrapper<Operation>()
                .eq("user_id", id)
                .eq("type",1);
        return Result.success(operationService.list(wrapper));
    }


}
