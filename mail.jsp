//This is where real action is happening

<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
final String username = "<username>";		//change to your gmail username
final String password = "<password>";		//gmail password
String email=request.getParameter("email");
String mailSub="<Subject>"; 			//Subject of the mail
String mailBody=request.getParameter("body");


//chage these to use some other mail service
Properties props = new Properties();
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");

Session s = Session.getInstance(props,
        new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

try {

    Message message = new MimeMessage(s);
    message.setFrom(new InternetAddress(username));
    message.setRecipients(Message.RecipientType.TO,
            InternetAddress.parse(email));
    message.setSubject(mailSub);
    message.setText(mailBody);

    Transport.send(message);

    System.out.println("Done");
	response.sendRedirect("order.jsp");

} catch (MessagingException e) {
    throw new RuntimeException(e);
}
%>
