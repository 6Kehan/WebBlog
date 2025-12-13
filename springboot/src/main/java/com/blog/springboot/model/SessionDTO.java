package com.blog.springboot.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SessionDTO {

    private Integer sessionId;

    private Integer userid;

    private String username;

    private String avatar;
}
