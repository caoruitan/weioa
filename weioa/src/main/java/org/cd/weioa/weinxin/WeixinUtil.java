package org.cd.weioa.weinxin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.cd.weioa.http.HttpHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class WeixinUtil {
    
    public static UserInfo getUserInfo(String code) {
        if(code != null) {
            String token = AccessTokenHolder.getAccessToken();
            
            String userJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=" + token + "&code=" + code).get();
            JSONObject userObj = JSONObject.fromObject(userJson);
            String userId = userObj.getString("UserId");
            
            String userInfoJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=" + token + "&userid=" + userId).get();
            JSONObject userInfoObj = JSONObject.fromObject(userInfoJson);
            UserInfo userInfo = new UserInfo();
            userInfo.setUserId(userId);
            userInfo.setName(userInfoObj.getString("name"));
            List<String> departments = new ArrayList<String>();
            JSONArray deptArray = userInfoObj.getJSONArray("department");
            for(int i = 0; i < deptArray.size(); i ++) {
                departments.add(deptArray.get(i).toString());
            }
            try {
                userInfo.setDepartments(departments);
                userInfo.setEmail(userInfoObj.getString("email"));
                userInfo.setGender(userInfoObj.getString("gender"));
                userInfo.setMobile(userInfoObj.getString("mobile"));
                userInfo.setPhoto(userInfoObj.getString("avatar"));
                userInfo.setWeixinid(userInfoObj.getString("weixinid"));
            } catch (Exception e) {}
            return userInfo;
        }
        return null;
    }
    
    public static UserInfo getUserInfoByUserId(String userId) {
        if(userId != null) {
            String token = AccessTokenHolder.getAccessToken();
            
            String userInfoJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=" + token + "&userid=" + userId).get();
            JSONObject userInfoObj = JSONObject.fromObject(userInfoJson);
            UserInfo userInfo = new UserInfo();
            userInfo.setUserId(userId);
            userInfo.setName(userInfoObj.getString("name"));
            List<String> departments = new ArrayList<String>();
            JSONArray deptArray = userInfoObj.getJSONArray("department");
            for(int i = 0; i < deptArray.size(); i ++) {
                departments.add(deptArray.get(i).toString());
            }
            try {
                userInfo.setDepartments(departments);
                userInfo.setEmail(userInfoObj.getString("email"));
                userInfo.setGender(userInfoObj.getString("gender"));
                userInfo.setMobile(userInfoObj.getString("mobile"));
                userInfo.setPhoto(userInfoObj.getString("avatar"));
                userInfo.setWeixinid(userInfoObj.getString("weixinid"));
            } catch (Exception e) {}
            return userInfo;
        }
        return null;
    }
    
    @SuppressWarnings("deprecation")
    public static String getJsapiSignature(String jsapiTicket, String noncestr, String timestamp, String url) {
        StringBuilder sb = new StringBuilder("");
        sb.append("jsapi_ticket=").append(jsapiTicket)
            .append("&noncestr=").append(noncestr)
            .append("&timestamp=").append(timestamp)
            .append("&url=").append(url);
        String signature = DigestUtils.shaHex(sb.toString());
        System.out.println(sb.toString());
        System.out.println(signature);
        return signature;
    }
    
    @SuppressWarnings("deprecation")
    public static String getGroupSignature(String groupTicket, String noncestr, String timestamp, String url) {
        StringBuilder sb = new StringBuilder("");
        sb.append("group_ticket=").append(groupTicket)
            .append("&noncestr=").append(noncestr)
            .append("&timestamp=").append(timestamp)
            .append("&url=").append(url);
        String signature = DigestUtils.shaHex(sb.toString());
        System.out.println(sb.toString());
        System.out.println(signature);
        return signature;
    }
    
    public static void sendMessage(String to, String agentid, String content) {
        String token = AccessTokenHolder.getAccessToken();
        Map<String, String> params = new HashMap<String, String>();
        params.put("access_token", token);
        HttpHelper httpHelper = HttpHelper.getInstance();
        httpHelper.setUrl("https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=" + token);
        httpHelper.setParam(params);
        httpHelper.post("{" + to + ", \"msgtype\":\"text\", \"agentid\":" + agentid + ", \"text\":{\"content\":\"" + content + "\"}, \"safe\":\"1\"}");
    }
}
