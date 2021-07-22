package com.zy.crm.workbench.service;

import com.zy.crm.vo.Message;
import com.zy.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

/**
 * @author zy
 */
public interface ActivityRemarkService {

    // 根据市场活动id得到市场活动评论
    List<ActivityRemark> getRemarkByAcId(String id);

    // 根据remarkID删除remark
    Message deleteRemarkById(String id);


    // 插入一条remark记录
    Message saveRemark(ActivityRemark remark);

    // 根据id得到市场活动评论
    ActivityRemark getRemarkById(String id);

    // 修改一条备注
    Map<String, Object> updateRemark(ActivityRemark remark);
}
