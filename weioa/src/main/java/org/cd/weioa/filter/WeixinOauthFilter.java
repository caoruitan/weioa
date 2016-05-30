package org.cd.weioa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cd.weioa.weinxin.AccessTokenHolder;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;

public class WeixinOauthFilter implements Filter {

    @Override
    public void destroy() {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(true);
        
        boolean isAuth = false;
        
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        if(userInfo != null) {
            isAuth = true;
        } else {
            String paramState = httpRequest.getParameter("state");
            String paramCode = httpRequest.getParameter("code");
            if(paramState != null && paramCode != null && !paramState.equals("") && !paramCode.equals("")) {
                if(paramState.equals("weioa")) {
                    userInfo = WeixinUtil.getUserInfo(paramCode);
                    session.setAttribute("userInfo", userInfo);
                    isAuth = true;
                }
            }
        }
        
        if(isAuth) {
            chain.doFilter(httpRequest, httpResponse);
        } else {
            StringBuffer url = httpRequest.getRequestURL();
            if (httpRequest.getQueryString() != null) {
                url.append('?');
                url.append(httpRequest.getQueryString());
            }
            httpResponse.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx12bfbc7b7f11c4ee&redirect_uri=" + url.toString() + "&response_type=code&scope=snsapi_base&state=weioa#wechat_redirect");
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        AccessTokenHolder.getAccessToken();
        System.out.println("AccessTokenHolder:getAccessToken");
    }

}
