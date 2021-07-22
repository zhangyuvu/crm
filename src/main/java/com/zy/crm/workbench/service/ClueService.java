package com.zy.crm.workbench.service;

import com.zy.crm.vo.Message;
import com.zy.crm.workbench.domain.Activity;
import com.zy.crm.workbench.domain.Clue;
import com.zy.crm.workbench.domain.Tran;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ClueService {

    // 插入一条线索信息
    Message saveClue(Clue clue);

    // 查询一条clue信息
    Clue getClueById(String id);

    // 根据关联表id解除关联
    Message unBindAC(String id);

    // 根据市场活动id绑定市场活动与线索
    Message bindAC(String[] ids, String clueId);


    // 根据线索信息转换为客户和联系人
    void convert(String clueId, Tran tran,String createBy);
}
