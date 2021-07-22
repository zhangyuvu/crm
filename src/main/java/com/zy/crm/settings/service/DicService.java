package com.zy.crm.settings.service;

import com.zy.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {

    // 获取所有的数据字典值 类型为key 值的集合为value
    Map<String, List<DicValue>> getDicValue();
}
