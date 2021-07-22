package com.zy.crm.handler;

import com.zy.crm.exception.*;
import com.zy.crm.vo.Message;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zy
 */

// 控制增强 异常捕捉类

@ControllerAdvice
public class GlobalExceptionHandler {

    // 登录信息异常捕捉方法
    @ExceptionHandler(value = LoginFailException.class)
    // 将结果以ajax的形式写入响应体传回给login.jsp
    @ResponseBody
    public Object doLoginFailException(Exception exception){

        // 拿到错误消息
        String msg = exception.getMessage();
        // 设置success为false
        boolean success = false;

        // 创建map 返回json数据格式
        Message message = new Message();
        message.setSuccess(false);
        message.setMsg(msg);

        return message;
    }

    // 删除市场活动异常捕捉方法
    @ExceptionHandler(value = DeleteActivityException.class)
    @ResponseBody
    public Object doDeleteActivityException(Exception e){
        // 拿到错误消息
        String msg = e.getMessage();

        Message message = new Message();
        message.setSuccess(false);
        message.setMsg(msg);
        return message;
    }

    // 绑定市场活动和线索异常捕捉方法
    @ExceptionHandler(value = BindException.class)
    @ResponseBody
    public Object doBindException(Exception e){
        Message message = new Message();

        String msg = e.getMessage();

        message.setSuccess(false);
        message.setMsg(msg);
        return message;
    }


    @ExceptionHandler(value = ConvertException.class)
    public ModelAndView doConvertException(Exception e){

        ModelAndView mv = new ModelAndView();

        mv.addObject("msg",e.getMessage());
        System.out.println("==========="+e.getMessage());
        mv.setViewName("/workbench/clue/convert.jsp");
        return mv;
    }

    @ExceptionHandler(value = TranSaveException.class)
    public ModelAndView doTranSaveException(Exception e){
        ModelAndView mv = new ModelAndView();

        mv.addObject("msg",e.getMessage());
        System.out.println("==========="+e.getMessage());
        mv.setViewName("/workbench/transaction/save.jsp");
        return mv;
    }

    @ExceptionHandler(value = ChangeStageException.class)
    @ResponseBody
    public Map<String , Object> doChangeStageException(Exception e){
        Map<String , Object> map = new HashMap<>();
        Message message = new Message();

        message.setMsg(e.getMessage());
        message.setSuccess(false);

        map.put("msg",message);
        return map;
    }
}






