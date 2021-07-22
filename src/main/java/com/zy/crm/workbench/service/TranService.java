package com.zy.crm.workbench.service;


import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.domain.Tran;
import com.zy.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranService {

    // 插入一条tran记录
    int saveTran(Tran tran, String customerName);


    // 详细信息页的tran信息
    Tran detail(String id);


    /*
        查询交易历史记录
     */
    List<TranHistory> getHistoryListByTranId(String id);


    // 更新交易阶段
    Tran updateStage(Tran tran);

    /*
            获取交易阶段漏斗图
    */
    PaginationVo<Map<String, Integer>> getCharts();
}
