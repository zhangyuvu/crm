package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    // 插入一条交易记录
    int insertTran(Tran tran);


    /*
        id对应的交易记录的详细信息
     */
    Tran selectDetail(String id);

    /*
        更新交易阶段
     */
    int updateStage(Tran tran);

    /*
            获取交易阶段漏斗图
     */
    List<Map<String, Integer>> selectStageSize();

    // 获取记录总条数
    int getTotalSize();
}
