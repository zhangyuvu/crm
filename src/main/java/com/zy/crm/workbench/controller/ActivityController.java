package com.zy.crm.workbench.controller;

import com.zy.crm.settings.domain.User;
import com.zy.crm.settings.service.UserService;
import com.zy.crm.vo.Message;
import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.domain.Activity;
import com.zy.crm.workbench.domain.ActivityRemark;
import com.zy.crm.workbench.service.ActivityRemarkService;
import com.zy.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zy
 */
// 市场模块的controller类
@Controller
//@RequestMapping("/workbench/activity")
public class ActivityController {

    @Resource
    private UserService userService;

    @Resource
    private ActivityService activityService;

    @Resource
    private ActivityRemarkService activityRemarkService;

    @RequestMapping("/workbench/activity/getUserList.do")
    @ResponseBody
    public List<User> getUserList(){
        // 查询用户的所有信息
        List<User> users = userService.getUserList();

        return users;
    }

    // 保存一条活动信息
    @RequestMapping("/workbench/activity/saveActivity.do")
    @ResponseBody
    public Object saveActivity(Activity activity){

        // 得到保存结果
        Message msg = activityService.saveActivity(activity);

        return msg;
    }

    @RequestMapping("/workbench/activity/pageList.do")
    @ResponseBody
    // 拿到页码和页面记录条数
    public Object getPageList(String pageNo, String pageSize,Activity activity){
        // 得到分页完成的市场活动列表和总记录条数的分装类
        PaginationVo<Activity> paginationVo = activityService.getPageList(pageNo,pageSize,activity);

        return paginationVo;
    }

    // 删除市场活动
    @RequestMapping("/workbench/activity/delete.do")
    @ResponseBody
    public Message deleteActivity(HttpServletRequest request) {

        // 拿到ActivityId数组
        String ActivityIds[] = request.getParameterValues("id");

        // 根据id数组删除市场活动
        Message msg = activityService.deleteActivity(ActivityIds);

        return msg;
    }



    // 根据id查询市场活动
    @RequestMapping("/workbench/activity/getAcById.do")
    @ResponseBody
    public Map<String , Object> getAcById(String id){
        Map<String , Object> map = new HashMap<>();
        // 查询到市场活动信息
        Activity activity = activityService.getAcById(id);

        // 拿到所有的用户
        List<User> userList = userService.getUserList();

        // 封装入map
        map.put("activity",activity);
        map.put("userList",userList);

        return  map;
    }


    // 修改市场活动根据id
    @RequestMapping("/workbench/activity/updateActivity.do")
    @ResponseBody
    public Message updateActivityById(Activity activity){
        Message msg = activityService.updateActivityById(activity);
        return msg;

    }

    // 显示市场活动detail.jsp页面
    @RequestMapping("/workbench/activity/showDetail.do")
    public ModelAndView showDetail(String id){
        ModelAndView mv = new ModelAndView();
        // 根据id获取activity
        Activity activity = activityService.getDetailById(id);
        mv.addObject("activity",activity);
        mv.setViewName("/workbench/activity/detail.jsp");
        return mv;
    }


    // 根据市场活动id取得备注信息列表

    @RequestMapping("/workbench/activity/getRemark.do")
    @ResponseBody
    public List<ActivityRemark> getRemarkByAcId(String activityId){

        List<ActivityRemark> remarks =  activityRemarkService.getRemarkByAcId(activityId);

        return remarks;
    }


    // 根据remarkId删除remark
    @RequestMapping("/workbench/activity/deleteRemark.do")
    @ResponseBody
    public Message deleteRemarkById(String id){

        Message msg = activityRemarkService.deleteRemarkById(id);

        return msg;

    }

    // 添加一条remark
    @RequestMapping("/workbench/activity/saveRemark.do")
    @ResponseBody
    public Map<String,Object> saveRemark(ActivityRemark remark){
        Map<String,Object> map = new HashMap<>();
        Message msg = activityRemarkService.saveRemark(remark);
        // 此msg中保存的是刚刚添加的备注的id
        ActivityRemark remark1 = activityRemarkService.getRemarkById(msg.getMsg());
        map.put("success",msg.getSuccess());
        map.put("remark",remark1);
        return map;
    }


    // 修改一条备注
    @RequestMapping("/workbench/activity/updateRemark.do")
    @ResponseBody
    public Map<String , Object> updateRemark(ActivityRemark remark){

        Map<String , Object> map = activityRemarkService.updateRemark(remark);

        return map;
    }

}


















