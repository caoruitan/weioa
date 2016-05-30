package org.cd.weioa.weinxin;

import org.cd.weioa.http.HttpHelper;

import net.sf.json.JSONObject;

public class AccessTokenHolder extends Thread {
    
    static {
        new AccessTokenHolder().start();
    }

    private static String accessToken;
    
    private static String jsapiTicket;
    
    private static String groupTicket;
    
    private static String groupId;
    
    @Override
    public void run() {
        super.run();
        while(true) {
            String tokenJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wx12bfbc7b7f11c4ee&corpsecret=jzOHg281M7DP6sz4qvmBNYPQTDIxXMtSsrNKxb1dsFbfY-fF3pjoUjbdg0PeLKIK").get();
            JSONObject tokenObj = JSONObject.fromObject(tokenJson);
            accessToken = tokenObj.getString("access_token");
            System.out.println("AccessTokenHolder:accessToken=" + accessToken);
            
            String ticketJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=" + accessToken).get();
            JSONObject ticketObj = JSONObject.fromObject(ticketJson);
            jsapiTicket = ticketObj.getString("ticket");
            System.out.println("AccessTokenHolder:jsapiTicket=" + jsapiTicket);
            
            String groupTicketJson = HttpHelper.getInstance().setUrl("https://qyapi.weixin.qq.com/cgi-bin/ticket/get?access_token=" + accessToken + "&type=contact").get();
            JSONObject groupTicketObj = JSONObject.fromObject(groupTicketJson);
            groupTicket = groupTicketObj.getString("ticket");
            groupId = groupTicketObj.getString("group_id");
            System.out.println("AccessTokenHolder:groupTicket=" + groupTicket);
            System.out.println("AccessTokenHolder:groupId=" + groupId);
            try {
                Thread.sleep(3600000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static String getAccessToken() {
        return accessToken;
    }
    
    public static String getJsapiTicket() {
        return jsapiTicket;
    }
    
    public static String greGroupTicket() {
        return groupTicket;
    }
    
    public static String getGroupId() {
        return groupId;
    }
}
