package com.zy.crm.workbench.service;

import com.zy.crm.exception.DeleteActivityException;
import com.zy.crm.vo.Message;
import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.domain.Activity;

import java.util.List;


public interface ActivityService {
    // 保存一条活动信息
    Message saveActivity(Activity activity);

    // 分页查询市场活动
    PaginationVo<Activity> getPageList(String pageNo, String pageSize, Activity activity);


    // 删除市场活动
    Message deleteActivity(String[] ids) throws DeleteActivityException;

    //根据id查询市场活动
    Activity  getAcById(String id);


    // 根据id修改市场活动
    Message updateActivityById(Activity activity);

    // 根据id查询市场活动信息 owner已经转换为名字
    Activity getDetailById(String id);

    // 根据线索id查询市场活动
    List<Activity> getAcByClueId(String id);

    // 根据活动名模糊查询活动信息并且未关联对应线索
    List<Activity> getAcByNameAndNotBind(String name, String clueId);


    //  根据活动名模糊查询活动信息
    List<Activity> getAcByName(String name);
}
