package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    // 根据线索id 查出线索备注
    List<ClueRemark> selectClueRemarkByClueId(String clueId);

    // 删除线索备注
    int deleteClueRemark(String id);
}
