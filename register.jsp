<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.io.*" contentType="text/html;charset=utf-8" import="javax.servlet.http.HttpServletRequest" pageEncoding="utf-8" %>
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
        String school = request.getParameter("school"); 
        String password = request.getParameter("password");
        String checkpassword = request.getParameter("checkpassword");
        String sex = request.getParameter("sex");

        if(num.isEmpty()){ 
            error=true; msg="学号不能为空!"; 
        } 
        if(name.isEmpty()){ 
            error=true; msg="用户名不能为空!"; 
        }
        if(password.isEmpty()){ 
            error=true; msg="密码不能为空!"; 
        }
        if(checkpassword.isEmpty()){ 
            error=true; msg="确认密码不能为空!"; 
        }
        if(!password.equals(checkpassword)){
        	error=true; msg="密码不对应!";
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
                ResultSet rs1=stmt1.executeQuery("select * from user where num='"+ num+"';");
                Statement stmt2=con.createStatement(); //建立语句
                ResultSet rs2=stmt2.executeQuery("select * from user where name='"+ name+"';");

                if (rs1.next()){ //非空
                    msg="学号已被注册!";
                    error=true;
                }
                if (rs2.next()){ //非空
                    msg="用户名已被注册!";
                    error=true;
                }
                
                if(!error){
                    String sql="insert into user(num,school,name,password,sex,score) values('" + num + "','"+ school+"','"+ name+"','"+ password+"','"+ sex+"',0)";
                    Statement stmt=con.createStatement();
                    int cnt=stmt.executeUpdate(sql); //return: count of updated records
                    if(cnt>0){
                        msg="注册成功!";
                    }
                    else{
                        msg="注册失败!";
                    }
                    stmt.close();
                }
               rs1.close();
               rs2.close();
               stmt1.close();
               stmt2.close();
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
	<legend>用户注册</legend>
	<form action="register.jsp" method="post" name="f">
 账号（学号）: <input type="text" name="num" style="font-size:18px"/><br>
	          姓名: <input type="text" name="name" style="font-size:18px"/><br>
	          学院: <input type="text" name="school" style="font-size:18px"/><br>
	          密码: <input type="password" name="password" style="font-size:18px"/><br>
           确认密码: <input type="password" name="checkpassword" style="font-size:18px"/><br>      
	          性别: <input type="radio" name="sex" value="男"/>男   <input type="radio" name="sex" value="女"/>女<br>
	               <input type="submit" name="sub" value="提交"> <input type="reset" name="rset" value="复位"> <a href="test.jsp">立即登录</a>
	          <br/>
	          <p><%=msg%></p>
	</form>
	</fieldset>
</body>	
</html>