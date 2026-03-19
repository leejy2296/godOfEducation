package com.virtual.geo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {

    private String userId;
    private String password;
    private String email;
    private String userNick;
    private String soopNick;
    private String streamerYn;
    private String soopAddr;
    private String teacher;

    private String useYn;
    private String deleteYn;
}