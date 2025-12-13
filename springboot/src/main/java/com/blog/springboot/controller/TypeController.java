package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.Type;
import com.blog.springboot.model.entity.User;
import com.blog.springboot.service.TypeService;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/type")
public class TypeController {

    @Resource
    private TypeService typeService;

    @PostMapping("/create")
    public Result add(@RequestBody Type type) {
        typeService.save(type);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        typeService.removeById(id);
        return Result.success(null);
    }

    @PostMapping("/update")
    public Result update(@RequestBody Type type) {
        typeService.updateById(type);
        return Result.success(null);
    }

    @PostMapping("/getType")
    public Result getType() {
        return Result.success(typeService.list());
    }

    @PostMapping("/select")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<Type> userQueryWrapper = new QueryWrapper<Type>()
                .like("name", element);
        return Result.success(200,"查询成功",typeService.list(userQueryWrapper));
    }
}
