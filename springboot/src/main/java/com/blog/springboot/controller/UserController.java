package com.blog.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.User;
import com.blog.springboot.service.UserService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang3.StringUtils;
import org.beetl.ext.fn.StringUtil;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @PostMapping(value = "/login")
    public Result login(@Validated @RequestBody User user) {


        QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>().eq("user_name", user.getUserName());
        userQueryWrapper.eq("role", user.getRole());
        User exsitUser = userService.getOne(userQueryWrapper);
        if (!user.getUserName().isEmpty() && !user.getUserPwd().isEmpty()) {
            if (exsitUser == null) {
                return Result.fail("该用户未注册或者身份认证失败");
            } else if (!exsitUser.getUserPwd().equals(user.getUserPwd())) {
                return Result.fail("密码错误,请重新输入");
            } else {
                return Result.success(200, "身份认证成功", exsitUser);
            }
        } else {
            return Result.fail("后端未接受到参数");
        }
    }

    @ApiOperation(value = "用户注册", notes = "用户注册")
    @PostMapping("/register")
    public Result register(@Validated @RequestBody User user) {
        if (StringUtils.isBlank(user.getUserName()) || StringUtils.isBlank(user.getUserPwd())){
            return Result.fail("用户名或密码不能为空");
        }

        QueryWrapper<User> wrapperUserName = new QueryWrapper<User>().eq("user_name", user.getUserName());
        QueryWrapper<User> wrapperEmail = new QueryWrapper<User>().eq("email", user.getEmail());
        if (userService.getOne(wrapperEmail) != null) {
            return Result.fail("该邮箱已被注册");
        } else if (userService.getOne(wrapperUserName) != null) {
            return Result.fail("该用户名已被注册");
        } else {
            user.setRealname(user.getUserName());
            user.setAvator("http://localhost:8080/file/7350ed7d86504aac96dbea0bbf2a16b7.png");
            user.setRole("普通用户");
            userService.save(user);
            return Result.success("注册成功，可前往登录界面");
        }
    }

    @ApiOperation(value = "查询所有用户", notes = "查询所有用户")
    @PostMapping(value = "/getUsers")
    public Result getUsers(@RequestParam String query) {
        return Result.success(userService.list());
    }

    @ApiOperation(value = "查询单个用户", notes = "查询单个用户")
    @PostMapping(value = "/getUserById")
    public Result getUserById(@RequestParam Integer id) {
        User user = userService.getById(id);
        return Result.success(user);
    }


    @PostMapping(value = "/getUserById/{id}")
    public Result getUser(@PathVariable Integer id) {
        User user = userService.getById(id);
        return Result.success(user);
    }

    @ApiOperation(value = "删除用户", notes = "删除用户")
    @DeleteMapping(value = "/deleteUserById/{id}")
    public Result deleteUserById(@PathVariable @ApiParam("删除的用户ID") Integer id) {
        userService.removeById(id);
        return Result.success("删除成功");
    }

    @PutMapping("/userInfoSet")
    public Result updateUserInfo(@RequestBody User user) {
        userService.updateById(user);
        return Result.success("修改成功");
    }

    @PostMapping("/create")
    public Result create(@RequestBody User user) {
        if (StringUtils.isBlank(user.getUserName()) || StringUtils.isBlank(user.getUserPwd())){
            return Result.fail("用户名或密码不能为空");
        }

        QueryWrapper<User> wrapperUserName = new QueryWrapper<User>().eq("user_name", user.getUserName());
        QueryWrapper<User> wrapperEmail = new QueryWrapper<User>().eq("email", user.getEmail());
        if (userService.getOne(wrapperEmail) != null) {
            return Result.fail("该邮箱已被注册");
        } else if (userService.getOne(wrapperUserName) != null) {
            return Result.fail("该用户名已被注册");
        } else {
            user.setRole("普通用户");
            user.setAvator("dog.png");
            userService.save(user);
            return Result.success("新增，可前往登录界面");
        }
    }


    @ApiOperation(value = "模糊查询用户", notes = "模糊查询用户")
    @PostMapping("/selectUser")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>()
                .like("user_name", element)
                .or().like("user_id", element)
                .or().like("address", element)
                .or().like("realname", element)
                .or().like("tel", element);
        List<User> userList = userService.list(userQueryWrapper);
        return Result.success(200,"查询成功",userList);
    }

}
