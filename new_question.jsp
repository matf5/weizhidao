<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
         import="java.sql.*"
         import="java.util.*"
         import="java.util.Date"
         import ="java.text.SimpleDateFormat"%>
<%request.setCharacterEncoding("utf-8");%>
<%
String s= "";
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String apply_time = df.format(new Date()).toString();
int user_id =Integer.valueOf(request.getParameter("user_id"));
int number = Integer.valueOf(request.getParameter("num"));
if(request.getParameter("sub")!=null){
	Connection conn = null;
	Statement stat = null;
	String sql = "";
	
	sql +="insert into question(user_id,content,apply_time,label,title) ";
	sql += "values(";
	sql += user_id;
	sql +=",\'";
	sql += request.getParameter("question");
	sql +="\',\'";
	sql +=apply_time;
	sql +="\',\'";
	sql += request.getParameter("label");
	sql += "\',\'";
	sql += request.getParameter("title");
	sql +="\')";
	
	//out.print(sql);

	boolean flag=true;
	String connectString = "jdbc:mysql://localhost:3306/13354041"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "user", "123456");
			flag=true;
		} catch (Exception e) {
			//out.print(e.getMessage());
			flag=false;
		}
		if(flag){
			try{
			    stat =conn.createStatement();
				stat.executeUpdate(sql);
				s="发布成功";
			}catch(Exception e){
				//s+=sql;
				//out.print(s);
				//out.print(e.getMessage());
				//s+= e.getMessage();
			}
		}
}


%>
<!DOCTYPE HTML>
<html>
<head>
   <title>发布问题</title>
   <style>
      a:link,a:visited {color:blue}
      .container{  
    	margin:0 auto; 
    	width:500px;  
    	text-align:center;  
      } 
   </style>
</head> 
<body>
 <div class="container">
	<h1>发布问题</h1>
	<form action="new_question.jsp?num=<%=number %>&&user_id=<%=user_id %>"  method="post" >
		<input type="text" name="title" placeholder="请输入问题标题"> <br></br>
		<textarea rows="8" cols="80"name="question" placeholder="请输入问题内容"></textarea>
		                     		 <br/><br/>
		label:<span>计算机类<input type="radio" value="programming" name="label"/></span>
  			<span>经济学类<input type="radio" value="economic" name="label"/></span>
  			<span>文学类<input type="radio" value="literature" name="label"/></span>
  			<span>数学类<input type="radio" value="math" name="label"/></span>
  			<br/><br/>  		 
	
	<input type="submit" name="sub" value="提交问题"/>
	</form>
	<a href="zhuye.jsp?my_question_a=0&my_question_b=4&question_a=0&question_b=4&num=<%=number %>"><input type="submit" value="返回主页"/></a>
  </div>
  <div style="text-align:center;color:red">
  <%=s %>
  </div>
</body>
</html>

