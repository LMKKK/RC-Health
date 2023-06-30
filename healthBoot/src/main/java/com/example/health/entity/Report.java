package com.example.health.entity;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class Report {

    private User user;

    private List<Map> resMap;

}
