package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Type;
import com.blog.springboot.dao.TypeMapper;
import com.blog.springboot.service.TypeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;


@Service
public class TypeServiceImpl extends ServiceImpl<TypeMapper, Type> implements TypeService {

}
