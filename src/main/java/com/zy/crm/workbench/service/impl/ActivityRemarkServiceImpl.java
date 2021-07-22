package com.zy.crm.workbench.service.impl;

import com.zy.crm.utils.DateTimeUtil;
import com.zy.crm.utils.UUDIUtil;
import com.zy.crm.vo.Message;
import com.zy.crm.workbench.dao.ActivityRemarkDao;
import com.zy.crm.workbench.domain.ActivityRemark;
import com.zy.crm.workbench.service.ActivityRemarkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zy
 */
@Service
public class ActivityRemarkServiceImpl implements ActivityRemarkService {

    @Resource
    private ActivityRemarkDao activityRemarkDao;


    // 根据活动id查找活动备注
    @Override
    public List<ActivityRemark> getRemarkByAcId(String id) {
        List<ActivityRemark> remark = activityRemarkDao.selectRemarkByAcId(id);
        return remark;
    }

    // 删除remark 根据remarkId
    @Override
    public Message deleteRemarkById(String id) {
        Message msg = new Message();
        int result =  activityRemarkDao.deleteRemarkById(id);

        if(result == 1){
            msg.setSuccess(true);
        }

        return msg;
    }

    // 插入一条remark记录
    @Override
    public Message saveRemark(ActivityRemark remark) {
        Message msg = new Message();
       // 添加创建时间
       remark.setCreateTime(DateTimeUtil.getSysTime());

       // 设置修改标记
       remark.setEditFlag("0");

       // 设置id
        String uuid = UUDIUtil.getUUID();
        remark.setId(uuid);

        // 还有一种实现方式是直接用map把赋值完成的remark和result回传给controller
        // 不用再走一边dao层 因为添加进数据库中的数据就是remark中的数据 

        int result =  activityRemarkDao.insertRemark(remark);

        msg.setSuccess(result == 1);
        msg.setMsg(uuid);
        return msg;
    }

    // 查询出一条备注记录
    @Override
    public ActivityRemark getRemarkById(String id) {

        ActivityRemark remark = activityRemarkDao.selectRemarkById(id);

        return remark;
    }

    @Override
    public Map<String, Object> updateRemark(ActivityRemark remark) {
        // 设置属性值
        remark.setEditFlag("1");
        remark.setEditTime(DateTimeUtil.getSysTime());
        Map<String , Object> map = new HashMap<>();
        boolean flag = false;

        int result = activityRemarkDao.updateRemark(remark);


        if (result == 1){
            flag = true;
            map.put("remark",remark);
        }

        map.put("success",flag);

        return map;
    }


}

