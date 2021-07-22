package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface ActivityDao {

    // 插入一条activity记录
    int insertActivity(Activity activity);

    // 查询市场活动所有记录
    List<Activity> selectPageList(Activity activity);

    // 查询市场活动总条数
    int selectTotalSize(Activity activity);

    // 删除市场活动 参数是市场活动id的数组
    int deleteActivity(String[] id);


    // 根据id查找市场活动
    Activity selectActivityById(String id);


    // 根据id修改市场活动
    int updateActivityById(Activity activity);

    // 根据id查询市场活动信息 owner已经转换为名字
    Activity selectDetailById(String id);

    // 根据线索id查询市场活动
    List<Activity> selectAcByClueId(String id);

    // 根据活动名模糊查询活动信息并且未与对应线索id绑定
    List<Activity> selectAcByNameAndNotBind(@Param("name") String name, @Param("clueId") String clueId);


    // 根据活动名模糊查询活动信息
    List<Activity> selectAcByName(String name);

}
