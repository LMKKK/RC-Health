package com.example.health.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @version 1.0
 * @Description 默认密码枚举
 */
@Getter
@AllArgsConstructor
public enum PwdEnum {

    /**
     * 默认密码
     */
    PASSWORD("123");

    private final String password;
}
