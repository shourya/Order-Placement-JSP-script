<html>
<body>
<CENTER><h1>CAFE PETER DONUTS</h1></CENTER>
<hr/>
<center><h2><u>PURCHASE ORDER FORM</u></h2></center>
<br/><br/>


<%@ page import="java.sql.*" %>

<%!
String url ="jdbc:mysql://localhost/shourya";
String user= "root";
String password= "";
String wname;
int flag=0;
%>

<%

	Class.forName("com.mysql.jdbc.Driver");
	Connection con= DriverManager.getConnection(url, user, password);
	Statement smt=con.createStatement();
%>
	
<%
if(flag== 0)
{

out.println("<center><form action ='order.jsp'>Select The Supplier:<select name='wname'>");
String query2="select wname from wtable ";
		ResultSet rs2= smt.executeQuery(query2); 
		while(rs2.next())
		{
		String name=rs2.getString("wname");
		out.println("<option value='"+name+"'>"+name+"</option>");
		}
		flag=1;
	out.println("</select><br/> <input type='submit' ><center></form>")	;
	
}
%>

<%
if(request.getParameter("wname")!= null)
{
%>
<form action="mail.jsp">
<div align="center">
<table>
<tr><td></td><td>
<%
flag=0;
		wname=request.getParameter("wname");
		
		
		
		String query2="select email from wtable where wname='"+wname+"'";
		ResultSet rs2= smt.executeQuery(query2);
		rs2.next();	
		String email=rs2.getString("email");
		
		out.println("<input type='text' name='email' hidden value='"+email+"'>");
		
		String query="select pname,restock-squantity as oquantity from ptable where squantity < cquantity and wid=(select wid from wtable where wname='"+wname+"')";
		ResultSet rs= smt.executeQuery(query);
		
java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
out.println("<div align='right'>Date: <input type='text' name='time' value='"); %>
<%= df.format(new java.util.Date()) %>
<%
out.println("'></td></tr><tr>");

out.println("<td>SUPPLIER NAME:<input type='text' name='wname' value='" +wname+"'disabled > </td><td></td></tr>");

out.println("<td colspan='2'><textarea rows='20' cols='60' name='body' >");
out.println(" Sr.\t \t \tProductName\t \t  Quantity");
out.println("______________________________________________________________");
out.println();

while(rs.next())
		{
			int count =1;
			String pname= rs.getString("pname");
			int oquantity= rs.getInt("oquantity");
			
			out.println(" 0"+count+"\t \t \t"+pname+"\t \t \t \t"+oquantity);
			
			count++;
		}

 out.println("</textarea></td></tr>");
%>
<tr><td colspan="2" align="center"><input type="reset" value ="RESET" > <input type="submit" value="SEND" ><input type="button" value="CANCEL"></td></tr>
</form>
</table>
<%}%>
<hr>
<center>FOOTER INFORMATION</center>

</body>
</html>