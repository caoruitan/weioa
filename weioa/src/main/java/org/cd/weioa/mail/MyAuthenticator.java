package org.cd.weioa.mail;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator {

    String name;
    
    String password;
    
    public MyAuthenticator(String name, String pasword) {
        this.name = name;
        this.password = pasword;
        getPasswordAuthentication();
    }
    
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(name, password);
    }
    
}
