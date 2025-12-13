package com.blog.springboot.service.impl;

import com.blog.springboot.model.entity.Operation;
import com.blog.springboot.dao.OperationMapper;
import com.blog.springboot.service.OperationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author author
 * @since 2024-06-01
 */
@Service
public class OperationServiceImpl extends ServiceImpl<OperationMapper, Operation> implements OperationService {

}
