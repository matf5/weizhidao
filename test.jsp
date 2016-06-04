<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath(); 
String basePath = request.getScheme() + "://" + request.getServerName() 
                  + ":" + request.getServerPort() + path + "/"; 
String msg=""; 

boolean error=false; 
String s1=request.getParameter("sub"); // value of input(submit) or null 
if (s1!=null){ 
    String num = request.getParameter("num"); 
    String name = request.getParameter("name"); 
    String password = request.getParameter("password");
    String username="";
    out.print(num);
    if(password.isEmpty()){ 
        error=true; msg="密码不能为空!"; 
    }
    
    if(num.isEmpty()){ 
        error=true; msg="学号或用户名不能为空!"; 
    } 
    if(!error){
        try{
            String url="jdbc:mysql://localhost:3306/13354041"
			+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
            String user="user";
            String pwd="123456";
            Class.forName("com.mysql.jdbc.Driver"); // 装入驱动
            Connection con=DriverManager.getConnection(url, user, pwd);//建立连接
            Statement stmt1=con.createStatement(); //建立语句
            ResultSet rs1=stmt1.executeQuery("select * from user where num='"+ num+"'");
            if (rs1.next()){ //非空
            	String pass = rs1.getString("password");
            	if(pass.equals(password))
            	{
            		num = rs1.getString("num");
            		name=rs1.getString("name");
            	%>
            		<jsp:forward page="zhuye.jsp">
            		<jsp:param name="num" value="<%=num%>"/>
            		<jsp:param name="username" value="<%=name%>"/>
            		<jsp:param name="my_question_a" value="0"/>
            		<jsp:param name="my_question_b" value="4"/>
            		<jsp:param name="question_a" value="0"/>
            		<jsp:param name="question_b" value="4"/>
            		</jsp:forward>
            	<%}
            	else
            	{
            		msg = "密码错误!";
            	}
            }
            else
            {
            	msg = "学号或用户名不存在!";
            }
           rs1.close();
           stmt1.close();
           con.close();  
         }catch (Exception e){
              e.printStackTrace();
         }
    }
}
%>

<!DOCTYPE HTML>
<html>
<body style="font-size:20px;text-align:center;white-space:pre">
	<fieldset>
	<legend>用户登录</legend>
	<form action="test.jsp" method="post" name="f">
	 用户: <input type="text" name="num" style="font-size:18px"/><br><br>
	 密码: <input type="password" name="password" style="font-size:18px"/><br>
	<input type="submit" name="sub" value="登录" style="font-size:18px"/><br>
	没有账号？<a href="register.jsp">点击注册</a>
	</form>
	<p><%=msg%></p>
	</fieldset>
</body>
</html>
