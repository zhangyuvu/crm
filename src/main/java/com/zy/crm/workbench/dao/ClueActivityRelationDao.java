package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.ClueActivityRelation;

import java.util.List;
import java.util.Map;

public interface ClueActivityRelationDao {

    // 根据关联表id解除关联
    int deleteACRelation(String id);

    // 根据市场活动id绑定市场活动与线索
    int insertACRelation(Map<String, String> map);

    //根据clueId查询出所有的关联记录
    List<ClueActivityRelation> selectRelationByClueId(String clueId);
}
