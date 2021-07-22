package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.Clue;

public interface ClueDao {

    // 插入一条线索信息
    int insertClue(Clue clue);

    // 查询一条线索信息
    Clue selectClueById(String id);

    // 查询一条线索信息 完整的 不改owner的
    Clue selectClueByIds(String Id);

    // 删除一条线索记录
    int deleteClueById(String Id);
}
