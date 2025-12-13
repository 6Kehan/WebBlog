package com.blog.springboot.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.blog.springboot.model.entity.Files;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface FileMapper extends BaseMapper<Files> {

}
