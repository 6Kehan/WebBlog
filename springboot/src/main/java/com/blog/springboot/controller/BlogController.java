package com.blog.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.blog.springboot.lang.Result;
import com.blog.springboot.model.entity.Blog;
import com.blog.springboot.model.entity.BlogFile;
import com.blog.springboot.model.entity.User;
import com.blog.springboot.service.BlogImageService;
import com.blog.springboot.service.BlogService;
import com.blog.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/trading")
public class BlogController {
    @Resource
    private BlogService blogService;

    @Resource
    private BlogImageService blogImageService;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public Result add(@RequestBody Blog blog) {
        List<String> imagesList = blog.getImagesList();

        List<String> videosList = blog.getVideosList();

        List<String> docsList = blog.getDocsList();

        blog.setCount(0);
        blogService.save(blog);

        imagesList.forEach(imageUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(imageUrl).type("img").build());
        });
        videosList.forEach(videoUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(videoUrl).type("video").build());
        });
        docsList.forEach(docUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(docUrl).type("doc").build());
        });

        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        blogService.removeById(id);
        return Result.success(null);
    }

    @PostMapping("/update")
    public Result update(@RequestBody Blog blog) {

            blogImageService.remove(new QueryWrapper<BlogFile>().eq("blog_id", blog.getId()));

        List<String> imagesList = blog.getImagesList();

        List<String> videosList = blog.getVideosList();

        List<String> docsList = blog.getDocsList();
        imagesList.forEach(imageUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(imageUrl).type("img").build());
        });
        videosList.forEach(videoUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(videoUrl).type("video").build());
        });
        docsList.forEach(docUrl->{
            blogImageService.save(BlogFile.builder().blogId(blog.getId()).imageUrl(docUrl).type("doc").build());
        });
        blogService.updateById(blog);
        return Result.success(null);
    }

    @PostMapping("/getTrading")
    public Result getTrading() {
        List<Blog> tradingList = blogService.list();
        tradingList.forEach(blog -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
            blog.setRealname(user.getRealname());
            QueryWrapper<BlogFile> queryWrapper2 = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
            List<BlogFile> list = blogImageService.list(queryWrapper2);
            blog.setImagesList(list.stream()
                    .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setVideosList(list.stream()
                    .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setDocsList(list.stream()
                    .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));

        });
        return Result.success(tradingList);
    }

    @PostMapping("/selectBlog")
    public Result getBlog(@RequestParam(defaultValue = "") String type,
                                @RequestParam(defaultValue = "")  String key) {
        QueryWrapper<Blog> queryWrapper=new QueryWrapper<>();
        if (!Objects.equals(type, ""))
            queryWrapper.eq("type",type);
        if (!Objects.equals(key, ""))
            queryWrapper.like("title",key);
        queryWrapper.orderByDesc("create_time");
        List<Blog> tradingList = blogService.list(queryWrapper);
        tradingList.forEach(blog -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
            blog.setRealname(user.getRealname());
            QueryWrapper<BlogFile> queryWrapper2 = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
            List<BlogFile> list = blogImageService.list(queryWrapper2);
            blog.setImagesList(list.stream()
                    .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setVideosList(list.stream()
                    .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setDocsList(list.stream()
                    .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
        });
        return Result.success(tradingList);
    }
    @PostMapping("/selectHeatBlog")
    public Result selectHeatBlog() {
        QueryWrapper<Blog> queryWrapper=new QueryWrapper<>();
        queryWrapper.orderByDesc("count");
        List<Blog> tradingList = blogService.list(queryWrapper);
        tradingList.forEach(blog -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
            blog.setRealname(user.getRealname());
            QueryWrapper<BlogFile> queryWrapper2 = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
            List<BlogFile> list = blogImageService.list(queryWrapper2);
            blog.setImagesList(list.stream()
                    .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setVideosList(list.stream()
                    .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setDocsList(list.stream()
                    .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
        });
        return Result.success(tradingList);
    }


    @PostMapping("/getTradingAll")
    public Result getTradingAll() {
        QueryWrapper<Blog> queryWrapper=new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time");
        queryWrapper.last("LIMIT 5");
        List<Blog> tradingList = blogService.list(queryWrapper);
        tradingList.forEach(blog -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
            blog.setRealname(user.getRealname());
            QueryWrapper<BlogFile> queryWrapper2 = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
            List<BlogFile> list = blogImageService.list(queryWrapper2);
            blog.setImagesList(list.stream()
                    .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setVideosList(list.stream()
                    .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setDocsList(list.stream()
                    .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
        });
        return Result.success(tradingList);
    }

    @PostMapping("/getTradingByUserId/{id}")
    public Result getTradingByUserId(@PathVariable Integer id) {
        QueryWrapper<Blog> wrapper = new QueryWrapper<Blog>().eq("user_id", id);
        List<Blog> tradingList = blogService.list(wrapper);
        tradingList.forEach(blog -> {
            User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
            blog.setRealname(user.getRealname());
            QueryWrapper<BlogFile> queryWrapper = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
            List<BlogFile> list = blogImageService.list(queryWrapper);
            blog.setImagesList(list.stream()
                    .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setVideosList(list.stream()
                    .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
            blog.setDocsList(list.stream()
                    .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                    .map(BlogFile::getImageUrl)
                    .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                    .collect(Collectors.toList()));
        });
        return Result.success(tradingList);
    }

    @PostMapping("/getTradingById/{id}")
    public Result getTradingById(@PathVariable Integer id) {
        QueryWrapper<Blog> wrapper = new QueryWrapper<Blog>().eq("id", id);
        Blog blog = blogService.getOne(wrapper);
        User user = userService.getOne(new QueryWrapper<User>().eq("user_id", blog.getUserId()));
        blog.setRealname(user.getRealname());
        QueryWrapper<BlogFile> queryWrapper = new QueryWrapper<BlogFile>().eq("blog_id", blog.getId());
        List<BlogFile> list = blogImageService.list(queryWrapper);
        blog.setImagesList(list.stream()
                .filter(blogFile -> "img".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                .map(BlogFile::getImageUrl)
                .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                .collect(Collectors.toList()));
        blog.setVideosList(list.stream()
                .filter(blogFile -> "video".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                .map(BlogFile::getImageUrl)
                .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                .collect(Collectors.toList()));
        blog.setDocsList(list.stream()
                .filter(blogFile -> "doc".equals(blogFile.getType()))  // 过滤类型为 image 的对象
                .map(BlogFile::getImageUrl)
                .filter(Objects::nonNull)  // 可选：过滤掉 imageUrl 为 null 的项
                .collect(Collectors.toList()));
        return Result.success( blog);
    }

}
