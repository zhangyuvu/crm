package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.ActivityRemark;

import java.util.List;

/**
 * @author zy
 */
public interface ActivityRemarkDao {
    // 查询需要删除的市场活动备注的条数
    int selectRemarkSize(String[] ids);

    // 根据市场活动id删除市场活动备注
    int deleteRemark(String[] ids);

    // 根据市场活动id查询市场活动备注
    List<ActivityRemark> selectRemarkByAcId(String id);


    // 根据remarkId删除remark
    int deleteRemarkById(String id);

    // 插入一条记录
    int insertRemark(ActivityRemark remark);

    // 查询一条备注记录
    ActivityRemark selectRemarkById(String uuid);


    // 修改一条备注记录
    int updateRemark(ActivityRemark remark);
}
