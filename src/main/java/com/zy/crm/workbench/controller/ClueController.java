package com.zy.crm.workbench.controller;

import com.zy.crm.settings.domain.User;
import com.zy.crm.settings.service.UserService;
import com.zy.crm.utils.DateTimeUtil;
import com.zy.crm.utils.UUDIUtil;
import com.zy.crm.vo.Message;
import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.domain.Activity;
import com.zy.crm.workbench.domain.Clue;
import com.zy.crm.workbench.domain.Tran;
import com.zy.crm.workbench.service.ActivityService;
import com.zy.crm.workbench.service.ClueService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author zy
    clue控制层对象
 */

@Controller
@RequestMapping("/workbench/clue")
public class ClueController {

    /*
        clue业务层对象
     */
    @Resource
    private ClueService clueService;

    @Resource
    private UserService userService;

    @Resource
    private ActivityService activityService;


    // 获取所有用户列表
    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List<User> getUserList(){

        List<User> userList = userService.getUserList();

        return userList;
    }


    // 添加一条线索信息
    @RequestMapping("/saveClue.do")
    @ResponseBody
    public Message saveClue(Clue clue){


        Message msg = clueService.saveClue(clue);

        return msg;
    }


    // 拿到一条clue信息后跳转到详细页
    @RequestMapping("/showDetail.do")
    public ModelAndView showDetail(String id){
        ModelAndView mv = new ModelAndView();

        Clue c  = clueService.getClueById(id);

        mv.addObject("clue",c);

        mv.setViewName("/workbench/clue/detail.jsp");
        return mv;
    }



    // 根据clueId 查询与之关联的activity列表
    @RequestMapping("/showActivityByClueId.do")
    @ResponseBody
    public List<Activity> getActivitiesByClueId(String id){

        List<Activity> activities = activityService.getAcByClueId(id);

        return activities;
    }

    // 根据关联表id接触关联
    @RequestMapping("/unBindAC.do")
    @ResponseBody
    public Message unBindAC(String id){

        Message msg = clueService.unBindAC(id);

        return msg;
    }

    // 根据活动名模糊查询活动信息并且未关联
    @RequestMapping("/getAcByNameAndNotBind.do")
    @ResponseBody
    public List<Activity> getAcByName(String name, String clueId){
       List<Activity> activities = activityService.getAcByNameAndNotBind(name,clueId);
        return activities;
    }


    // 根据活动名模糊查询活动信息
    @RequestMapping("/getAcByName.do")
    @ResponseBody
    public List<Activity> getAcByName(String name){
        List<Activity> activities = activityService.getAcByName(name);
        return activities;
    }



    // 根据市场活动id绑定市场活动与线索
    @RequestMapping("/bindAC.do")
    @ResponseBody
    public Message bindAC(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        String clueId = request.getParameter("clueId");
        /*  test
        System.out.println("clueId ======" + clueId);
        System.out.println( "acID ===== " + ids[0]);*/


        Message msg = clueService.bindAC(ids,clueId);

        return msg;
    }


    // 将线索转换为客户和联系人（根据flag判断是否要添加交易）
    @RequestMapping("/convert.do")
    public ModelAndView convert(String clueId, String flag , Tran tran,HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        User user = (User) request.getSession(false).getAttribute("user");
        String createBy = user.getName();
        // flag为0代表不需要添加交易
        // flag为1代表需要添加交易
        if("0".equals(flag)){

            tran = null;

        }
        clueService.convert(clueId,tran,createBy);


        mv.setViewName("/workbench/clue/index.jsp");
        return mv;
    }



}
















