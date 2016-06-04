<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
         import="java.sql.*"
         import="java.util.*"
         import="java.util.Date"
         import ="java.text.SimpleDateFormat"%>
<%request.setCharacterEncoding("utf-8");%>
<%!
public class Rank {
private String username;
private int count;
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
public Rank(String username, int count) {
	super();
	this.username = username;
	this.count = count;
}

}
%>
<%
Connection conn = null;
boolean flag=true;
Statement stat=null;
ResultSet rs=null;
String num=request.getParameter("num");
int st=Integer.valueOf(request.getParameter("st"));
String ss="<table border='1' width='100%' style='float:left'>"+"<tr>"+"<td>名次</td>"+"<td>姓名</td><td>获赞数</td>"+"</tr>";
String connectString = "jdbc:mysql://localhost:3306/13354041"
 			+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
 	try {
 		Class.forName("com.mysql.jdbc.Driver");
 		conn = DriverManager.getConnection(connectString, "user", "123456");
 		flag=true;
 	} catch (Exception e) {
 		out.print(e.getMessage());
 		flag=false;
 	}
 	String sql6="select * from user order by score desc";
    Statement stat5 = conn.createStatement();
    ResultSet rs6=stat5.executeQuery(sql6);
    ArrayList<Rank> rank = new ArrayList<Rank>();
    while(rs6.next()){
    	rank.add(new Rank(rs6.getString("name"),rs6.getInt("score")));
    }
    int up=st-10;
    int down=st+10;
    for(int i=st;i<rank.size()&&i<st+10;i++){
    	ss+="<tr>";
    	ss+="<td>";
    	ss +=i+1;
    	ss +="</td>";
    	ss+="<td>";
    	ss += rank.get(i).getUsername();
    	ss +="</td>";
    	ss+="<td>";
    	ss +=rank.get(i).getCount();
    	ss +="</td>";
    	ss+="</tr>";
    	
    	
    	
    }
    ss+="</table>";
 	
 	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rank</title>
</head>
<body>
<%=ss  %>
<% if(up<0){ %>

<a href="rank.jsp?st=<%=down%>&&num=<%=num %>">
	                   下一页</a>
	                   <%} %>
	                  <% if(down>=rank.size()&&up>=0){ %>
	                  <a href="rank.jsp?st=<%=up %>">
	                   上一页</a>
	                   <%} %>
	                   <% if(up>=0&&down<rank.size()){ %>             
<a href="rank.jsp?st=<%=up %>&&num=<%=num %>">
	                    上一页</a>               
<a href="rank.jsp?st=<%=down %>&&num=<%=num %>">
	                   下一页</a>
	                   <%} %>
	                   <br></br>
	                   <a href="zhuye.jsp?my_question_a=0&my_question_b=4&question_a=0&question_b=4&num=<%=num %>">返回主页</a>
</body>
</html>