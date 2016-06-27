package org.cd.weioa.mail;

public class Test {
    public static void main(String[] args) {
        //代理主机-新浪
        String host = "smtp.139.com";
        //帐号-新浪帐号
        String name = "13810377346@139.com";
        //密码-新浪密码
        String password = "654321test";
        //创建发送邮件对象
        HTMLSender mail = new HTMLSender(host,name,password);
        //发邮帐号
        mail.setFrom("13810377346@139.com");
        //收邮帐号
        mail.setTo("caoruitan@126.com");
        //邮件主题
        mail.setSubject("淘兴趣");
        //邮件内容
        mail.setContect("你的好友邀请你来淘兴趣~");
        mail.send();
        System.out.println("发送成功");
    }
}