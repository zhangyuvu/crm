package com.zy.crm.settings.dao;

import com.zy.crm.settings.domain.DicType;

import java.util.List;

public interface DicTypeDao {

    // 查询出所有的类型
    List<DicType> selectAllType();
}
