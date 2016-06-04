<%@ page language="java" import="java.util.*,java.sql.*"
         contentType="text/html; charset=utf-8"
         import="java.util.Date"
         import ="java.text.SimpleDateFormat"
         %>
<%request.setCharacterEncoding("utf-8");%>
<%! public class Answer {
   private int id;
   private String content;
   private String apply_time;
   private int like;
   private String username;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getApply_time() {
	return apply_time;
}
public void setApply_time(String apply_time) {
	this.apply_time = apply_time;
}
public int getLike() {
	return like;
}
public void setLike(int like) {
	this.like = like;
}
public Answer(int id, String content, String apply_time, int like,String username) {
	super();
	this.id = id;
	this.content = content;
	this.apply_time = apply_time;
	this.like = like;
	this.username=username;
}
   
}
%>
<%!
public class Question {
	private int id;
	
	private String username;
	private String content;
	private String label;
	private String apply_time;
	private String title;
	private int best_ans_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getApply_time() {
		return apply_time;
	}
	public void setApply_time(String apply_time) {
		this.apply_time = apply_time;
	}
	public int getBest_ans_id() {
		return best_ans_id;
	}
	public void setBest_ans_id(int best_ans_id) {
		this.best_ans_id = best_ans_id;
	}
	public Question(int id, String username, String content, String label, String apply_time,String title) {
		super();
		this.id = id;
		this.username = username;
		this.content = content;
		this.label = label;
		this.apply_time = apply_time;
		this.title=title;
	}
	

}%>
<%
int st=0;
int num=0;
if(request.getParameter("st")!=null)
	st=Integer.parseInt(request.getParameter("st"));
else
	st=0;
String s="<p style=\"font-weight:bold;\">所有答案</p>";
 int question_id=Integer.parseInt(request.getParameter("question_id"));
 int user_id=Integer.parseInt(request.getParameter("uid"));
 //String ques="";
 //ques+=
 Connection conn = null;
 boolean flag=true;
 Statement stat=null;
 ResultSet rs=null;
 Question question=null;
 
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
 	if(request.getParameter("ans")!=null){
 		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 		String apply_time = df.format(new Date()).toString();
 		String sql="insert into answer(user_id,question_id,content,apply_time,likes) ";
 		sql += "values(";
 		sql += user_id;
 		sql +=",";
 		
 		sql += question_id;
 		sql +=",\'";
 		sql += request.getParameter("answer");
 		sql += "\',\'";
 		sql += apply_time;
 		sql +="\',";
 		sql +=0;
 		sql +=")";
 		try{
		    stat =conn.createStatement();
		    //out.print(sql);
			stat.executeUpdate(sql);
			//s="发布成功";
		}catch(Exception e){
			
		}
 	}
 	if(request.getParameter("zan_id")!=null){
 		String sql3="select * from liking where user_id="+user_id+" and question_id="+question_id;
 		//out.print(sql3);
 		try{
 	 	 	stat=conn.createStatement();
 	 	 	rs=stat.executeQuery(sql3);
 	 	 	if(!rs.next()){
 	 	 		String sql = "";
 	 	 		sql +="insert into liking(user_id,question_id,answer_id) ";
 	 	 		sql += "values(";
 	 	 		sql += user_id;
 	 	 		sql +=",";
 	 	 		sql += question_id;
 	 	 		sql+=",";
 	 	 		sql += request.getParameter("zan_id");
 	 	 		sql +=")";
 	 	 		//out.print(sql);
 	 	 		try{
 				    stat =conn.createStatement();
 					stat.executeUpdate(sql);
 					//s="发布成功";
 				}catch(Exception e){
 				//out.print(e.getMessage());
 				}
 	 	 		String sql2="update answer set likes=likes+1 where id="+request.getParameter("zan_id");
 	 	 		//out.print(sql2);
 	 	 		try {
 	 				stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
 	 				int cnt = stat.executeUpdate(sql2); // 执行sql语句,返回所影响行记录的个数
 	 			} catch (Exception e) {
 	 				out.print(e.getMessage());
 	 			}
 	 	 	 String sqlSentence="select * from answer where id="+request.getParameter("zan_id");
 	 	 	 try{
 	 	 	 	stat=conn.createStatement();
 	 	 	 	rs=stat.executeQuery(sqlSentence);
 	 	 	 	
 	 	 	 		   while(rs.next()){
 	 	 	 			String sql4="update user set score = score+1 where id="+rs.getInt("user_id");
 	 	 	 		try {
 	 	 				stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
 	 	 				int cnt = stat.executeUpdate(sql4); // 执行sql语句,返回所影响行记录的个数
 	 	 			} catch (Exception e) {
 	 	 				out.print(e.getMessage());
 	 	 			}
 	 	 			    
 	 	 		      
 	 	 	 			}
 	 	 	 		
 	 	 	 		   
 	 	 	 	
 	 	 	 }catch(Exception e){
 	 	 	 	out.print(e.getMessage());
 	 	 	 }
 	 	 		
 	 	 	}
 	 	 			}
 	 	 		
 	 	 		   
 	 	 	
 	 	 catch(Exception e){
 	 	 	out.print(e.getMessage());
 	 	 }
 	}
 	 String sqlSentence="select * from question where id="+question_id;
 	 try{
 	 	stat=conn.createStatement();
 	 	rs=stat.executeQuery(sqlSentence);
 	 	
 	 		   while(rs.next()){
 	 			String sql="select * from user where id="+rs.getInt("user_id");
 	 			Statement stat2=conn.createStatement();
 	 			ResultSet rs2=stat2.executeQuery(sql);
 	 			while(rs2.next()){
 	 			
 	 			question=new Question(rs.getInt("id"),rs2.getString("name"),rs.getString("content"),rs.getString("label"),rs.getString("apply_time"),rs.getString("title"));
 	 			//out.print(question.getContent());
 				//arrayStudent.add(new Student(rs.getInt("id"), rs.getString("num"), rs.getString("name")));
 				//hashStudent.put(rs.getString("num"), new Student(rs.getInt("id"), rs.getString("num"), rs.getString("name")));
 	 			}
 	 		
 	 		   }
 	 	
 	 }catch(Exception e){
 	 	out.print(e.getMessage());
 	 }
 	
 	 ArrayList<Answer> answer = new ArrayList<Answer>();
 	 HashMap<String,Answer> answer_list = new HashMap<String,Answer>();
 	 String sql2="select * from answer where question_id ="+question_id+" order by likes desc"; 
 	 try{
  	 	stat=conn.createStatement();
  	 	rs=stat.executeQuery(sql2);
  	 	
  	 		   while(rs.next()){
  	 			String sql3="select * from user where id="+rs.getInt("user_id");
 	 			Statement stat2=conn.createStatement();
 	 			ResultSet rs2=stat2.executeQuery(sql3);
 	 			
 	 			while(rs2.next())
  	            answer.add(new Answer(rs.getInt("id"),rs.getString("content"),rs.getString("apply_time"),rs.getInt("likes"),rs2.getString("name")));
  	 			
  	 		
  	 		   }
  	 	
  	 }catch(Exception e){
  	 	out.print(e.getMessage());
  	 }
 	String sql3="select * from user where id ="+user_id; 
	 try{
 	 	stat=conn.createStatement();
 	 	rs=stat.executeQuery(sql3);
 	 	
 	 		   while(rs.next()){
 	 	       num=rs.getInt("num");
 	 			
 	 		
 	 		   }
 	 	
 	 }catch(Exception e){
 	 	out.print(e.getMessage());
 	 }
 	 for(int i=st;i<st+4&&i<answer.size();i++){
 		 
 		 s+="<p style=\"white-spqce:pre\"><span style=\"border:solid 1px green\">";
 		 
 		 s+=answer.get(i).getContent();
 		 s+="</span>";
 		s+="<br>";
		 s+="</br>";
		 s+="----";
 		 s+=answer.get(i).getUsername();
 		 s+="     ";
 		 s+=answer.get(i).getApply_time();
 		 
 	
 		s+="<a name=\"zan\" value=\"赞(";
 		s+= answer.get(i).getLike();
 	    s+=")\"";
 		s+="href=\"question.jsp?question_id=";
 		s+=question_id;
 		s+="&&uid=";
 		s+=user_id;
 		s+="&&zan_id=";
 		s+=answer.get(i).getId();
 		s+="&&zan_value=";
 		s+=answer.get(i).getLike();
 		s+="\" ";
 		s+="style=\"border:solid 1px black;color:red\"/>";
 		s+="赞(";
 		s+=answer.get(i).getLike();
 		s+=")";
 		s+="</a>";
 		s+="</p>";
 	 }


 	
 	%>

<!DOCTYPE HTML>
<html>
<body style="font-size:20px;">标题：<%=question.getTitle() %><p style="border:solid 1px blue;font-weight:bold;font-size:25px;"><%=question.getContent() %></p>
<p style="color:grey">问题类别：<span style="color:black"><%=question.getLabel() %></span> 发布者：<span style="color:black"><%=question.getUsername() %></span>  发布时间：<span style="color:black"><%=question.getApply_time() %></span></p>
<form action="question.jsp?question_id=<%=question_id%>&&uid=<%=user_id %>"  method="post" >
<input type="text" name="answer" placeholder="请输入回答内容并点击我要回答按钮" style="font-size:18px;width:80%;"/><br><br> 
<input type="submit" name="ans" style="font-size:18px;" value="我要回答"/>

<div class="allanswer">

<%=s %>
<%
int up=st-4;
int down=st+4;
%>
<% if(up<0){ %>
<a href="question.jsp?question_id=<%=question_id%>&&uid=<%=user_id %>&&st=<%=down%>">
	                   下一页</a>
	                   <%} %>
	                  <% if(down>=answer.size()&&up>=0){ %>
	                  <a href="question.jsp?question_id=<%=question_id%>&&uid=<%=user_id%>&&
	                  st=<%=up %>">
	                   上一页</a><%} %>
	                   <% if(up>=0&&down<answer.size()){ %>             
<a href="question.jsp?question_id=<%=question_id%>&&uid=<%=user_id %>&&st=<%=up %>">
	                    上一页</a>               
<a href="question.jsp?question_id=<%=question_id%>&&uid=<%=user_id %>&&st=<%=down %>">
	                   下一页</a>
	                   <%} %>
	                   <br></br>
	                   <a href="zhuye.jsp?my_question_a=0&my_question_b=4&question_a=0&question_b=4&num=<%=num %>">返回主页</a>
	 
</form>
</div>
</body>
</html>
