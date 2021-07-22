package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryDao {


    // 插入一条交易历史
    int insertTranHistory(TranHistory tranHistory);

    /*
            查询交易历史记录
         */
    List<TranHistory> selectHistoryByTranId(String id);
}
