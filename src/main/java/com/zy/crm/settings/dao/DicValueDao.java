package com.zy.crm.settings.dao;

import com.zy.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {

    // 根据code取value
    List<DicValue> getValuesByCode(String code);
}
