package com.zy.crm.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {


        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        // 拿到访问的uri
        String uri = request.getRequestURI();
        // 拿到项目名
        String path = request.getContextPath();

        // 如果访问的是默认欢迎文件 或者是login的文件 则允许访问
        if(uri.contains("login")){
            chain.doFilter(req,resp);
            return;
        }

        // 会话作用域对象中已经存在user了 那么也可以访问
        HttpSession session = request.getSession(false);
        if(session.getAttribute("user") != null) {
            chain.doFilter(req,resp);
            return;
        }

        // 都不满足则重定向到登录页面
        response.sendRedirect( path + "/login.jsp");
    }


}
