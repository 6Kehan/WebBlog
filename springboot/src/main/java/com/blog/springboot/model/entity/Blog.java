package com.blog.springboot.model.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 *
 * </p>
 *

 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Blog implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String images;

    private String title;

    private String content;

    private Integer userId;

    private String username;

    @TableField(exist = false)
    private String realname;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    private Integer count;

    private String type;

    @TableField(exist = false)
    private List<String> imagesList;

    @TableField(exist = false)
    private List<String> videosList;

    @TableField(exist = false)
    private List<String> docsList;
}
