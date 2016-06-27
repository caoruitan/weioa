package org.cd.weioa.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class HTMLSender {
    private MimeMessage message;
    private Properties props;
    private Session session;
    private String name = "";
    private String password = "";

    public HTMLSender(String host, String name, String password) {
        this.name = name;
        this.password = password;
        props = System.getProperties();

        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", "true");
        MyAuthenticator auth = new MyAuthenticator(name, password);
        session = Session.getDefaultInstance(props, auth);

        message = new MimeMessage(session);
        new MimeMultipart();
    }

    public void setFrom(String from) {
        try {
            message.setFrom(new InternetAddress(from));
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void setTo(String to) {
        try {
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void setSubject(String subject) {
        try {
            message.setSubject(subject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setContect(String content) {
        try {
            message.setContent(content, "text/html;charset=utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean send() {
        try {
            Transport transport = session.getTransport("smtp");
            transport.connect((String) props.get("mail.smtp.host"), name, password);
            transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
            transport.close();
            return true;
        } catch (NoSuchProviderException e) {
            e.printStackTrace();
            return false;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
