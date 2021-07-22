package com.zy.crm.workbench.service.impl;

import com.github.pagehelper.PageHelper;
import com.zy.crm.exception.DeleteActivityException;
import com.zy.crm.utils.DateTimeUtil;
import com.zy.crm.utils.UUDIUtil;
import com.zy.crm.vo.Message;
import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.dao.ActivityDao;
import com.zy.crm.workbench.dao.ActivityRemarkDao;
import com.zy.crm.workbench.domain.Activity;
import com.zy.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author zy

    市场活动service类
 */
@Service
public class ActivityServiceImpl implements ActivityService {

    // 市场活动dao
    @Resource
    private ActivityDao activityDao;

    // 市场活动备注dao
    @Resource
    private ActivityRemarkDao activityRemarkDao;

    // 添加市场活动
    @Override
    public Message saveActivity(Activity activity) {
        Message msg = new Message();

        // 创建UUID
        String uuid = UUDIUtil.getUUID();
        activity.setId(uuid);
        // 添加创建时间
        String createTime = DateTimeUtil.getSysTime();
        activity.setCreateTime(createTime);

        // 得到保存信息成功条数
        int result = activityDao.insertActivity(activity);

        // 添加成功
        if(result > 0){
            msg.setSuccess(true);
        //  添加失败
        }else {
            msg.setSuccess(false);
        }

        return msg;
    }

    // 分页查询市场活动
    @Override
    public PaginationVo<Activity> getPageList(String pageNo, String pageSize, Activity activity) {
        PaginationVo<Activity> paginationVo = new PaginationVo<>();
        // 根据页码查询 利用pageHelper进行分页查询
        // 第一个参数是页号 第二个参数是每页的记录条数
        int pageNum = Integer.parseInt(pageNo);
        int pageSizes = Integer.parseInt(pageSize);
        PageHelper.startPage(pageNum,pageSizes);
        List<Activity> activities = activityDao.selectPageList(activity);

        // 查询市场活动总条数
        int totalSize = activityDao.selectTotalSize(activity);

        // 利用vo封装总的记录条数和查询结果集
        paginationVo.setDataList(activities);
        paginationVo.setTotalSize(totalSize);
        return paginationVo;
    }


    // 删除市场活动 可能有多个活动同时删除 所以传入数组 其次每个活动有对应的活动备注 所以要对两个表进行操作
    @Override
    @Transactional
    public Message deleteActivity(String[] ActivityIds) {
        Message msg = new Message();

        // 首先查询出需要删除的市场活动对应的市场活动备注的总条数
        int remarkTotal = activityRemarkDao.selectRemarkSize(ActivityIds);

        // 然后对所有需要删除的市场活动备注进行删除 得到删除的条数
        int remarkResult = 0;
        if(remarkTotal != 0){
            remarkResult = activityRemarkDao.deleteRemark(ActivityIds);
        }

        // 然后对删除数量进行对比 不一样就抛异常 回滚事务 并且利用handler捕捉异常信息
        if(remarkTotal != remarkResult){
            throw new DeleteActivityException("删除市场活动备注失败！");
        }

        // 没有抛出异常则删出市场活动
        // 首先得到出需要删除的市场活动的总条数
        int activityTotal = ActivityIds.length;

        // 然后对需要删除的市场活动进行删除 得到删除条数
        int activityResult = activityDao.deleteActivity(ActivityIds);

        // 比较删除数量 不一样就抛出异常 回滚事务
        if(activityTotal != activityResult){
            throw new DeleteActivityException("删除市场活动失败！");
        }

        // 测试事务注解  调试后发现使用事务注解的时候不要向外部抛出异常 如 throws 否则事务失效
        // 并且捕捉的异常必须继承runtimeException
//        throw new DeleteActivityException("测试的删除失败！");
        // 没有抛出异常代表删除成功
        String result = "成功删除市场活动" + activityResult + "条，成功删除市场活动备注" + remarkResult + "条";
        msg.setSuccess(true);
        msg.setMsg(result);
        return msg;
    }

    @Override
    public Activity  getAcById(String id) {

        // 拿到活动信息
        Activity activity = activityDao.selectActivityById(id);

        return activity;
    }


    @Override
    public Message updateActivityById(Activity activity) {

        Message msg = new Message();

        // 设置修改时间
        activity.setEditTime(DateTimeUtil.getSysTime());

        int result =  activityDao.updateActivityById(activity);

        // 成功修改一条记录表示修改成功
        if(result == 1){
            msg.setSuccess(true);
        }

        return msg;
    }


    // 根据id查询市场活动信息 owner已经转换为名字
    @Override
    public Activity getDetailById(String id) {

        Activity activity = activityDao.selectDetailById(id);

        return activity;
    }


    // 根据线索id查询市场活动
    @Override
    public List<Activity> getAcByClueId(String id) {

        List<Activity> activities = activityDao.selectAcByClueId(id);

        return activities;
    }

    // 根据活动名模糊查询活动信息
    @Override
    public List<Activity> getAcByNameAndNotBind(String name, String clueId) {

        List<Activity> activities = activityDao.selectAcByNameAndNotBind(name,clueId);

        return activities;
    }

    @Override
    public List<Activity> getAcByName(String name) {
        List<Activity> activities = activityDao.selectAcByName(name);
        return activities;
    }
}












