<%@ page language="java" import="java.util.*" import="java.sql.*" pageEncoding="utf-8" %>
<%!
int my_question_a = 0;
int my_question_b = 4;
int question_a = 0; 
int question_b = 4;
%>
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
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num");
int uid=0;
String tmpa = request.getParameter("my_question_a");
String tmpb = request.getParameter("my_question_b");
String ss="";
if(tmpa==null){
	tmpa = "0";
	tmpb = "4";
}
my_question_a = Integer.parseInt(tmpa);
my_question_b = Integer.parseInt(tmpb);

String tempa = request.getParameter("question_a");
String tempb = request.getParameter("question_b");
if(tempa==null){
	tempa = "0";
	tempb = "4";
}
question_a = Integer.parseInt(tempa);
question_b = Integer.parseInt(tempb);

try{
    String url="jdbc:mysql://localhost:3306/13354041"
	+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user="user";
    String pwd="123456";
    Class.forName("com.mysql.jdbc.Driver"); // 装入驱动
    Connection con=DriverManager.getConnection(url, user, pwd);//建立连接
    
    Statement stmt=con.createStatement(); //建立语句
    ResultSet rs=stmt.executeQuery("select * from user where num='"+ num+"';");
    rs.next();
    String name = rs.getString("name");
    int userid=rs.getInt("id");
    //out.print(rs.getInt("id"));
    Statement stmt1=con.createStatement(); //建立语句
    String sql1=String.format("select * from question where user_id="+rs.getInt("id"));
    ResultSet rs1=stmt1.executeQuery(sql1);
    int rs1sum = 0;
    rs1.last();
    rs1sum = rs1.getRow();
    sql1=String.format("select * from question where user_id='"+rs.getInt("id")+"' order by id desc limit %d,%d",my_question_a, my_question_b);    
    rs1=stmt1.executeQuery(sql1);
    uid=rs.getInt("id");
    Statement stmt2=con.createStatement(); //建立语句
    String sql2=String.format("select * from question");    
    ResultSet rs2=stmt2.executeQuery(sql2);
    int rs2sum = 0;
    rs2.last();
    rs2sum = rs2.getRow();  
    sql2=String.format("select * from question order by id desc limit %d,%d",question_a, question_b); 
    rs2=stmt2.executeQuery(sql2);
    String sql6="select * from user order by score desc";
    Statement stat5 = con.createStatement();
    ResultSet rs6=stat5.executeQuery(sql6);
    ArrayList<Rank> rank = new ArrayList<Rank>();
    while(rs6.next()){
    	rank.add(new Rank(rs6.getString("name"),rs6.getInt("score")));
    }
    for(int i=0;i<rank.size()&&i<10;i++){
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
    
%>
<!DOCTYPE HTML>
<html>
<body style="font-size:20px;text-align:center;">
<p style="font-size:15px;text-align:left;">用户: <%=num%> <%=name%> <a href="test.jsp">登出</a><p>
<p style="font-size:30px;font-weight:bold">中大微知道</p>


<a href="new_question.jsp?user_id=<%=userid %>&&num=<%=num %>">发布问题</a>
<p style="font-size:25px;font-weight:bold;font-style:italic;text-align:center">精彩从这里开始</p>

   <div class="myquestion" style="float:left;width:60%;height:100%;text-align:center;">
    <fieldset>
	<legend>我的问题</legend>
	<center>
	<table border="1" cellspacing="0" width="80%"> 
	<tr>
	<td align="center">问题id</td>
	<td align="center">题目</td>
	<td align="center">发布时间</td>
	</tr>
<%    
    if(rs1.next()){
	do{
		int my_question_id = rs1.getInt("id");
		String my_question_content = rs1.getString("title");
		String my_question_time = rs1.getString("apply_time");
%>
		<tr>
		<td align="center"><%=my_question_id%></td>
		<td align="center"><a href="question.jsp?question_id=<%=my_question_id%>&&uid=<%=uid%>"><%=my_question_content%></a></td>
		<td align="center"><%=my_question_time%></td>
		</tr>
<%	
	}while(rs1.next());}
	rs1.close();
	stmt1.close();
%>
</table>	
<% 
	if(my_question_a==0&&my_question_a+my_question_b<rs1sum){
%>		
	<a href="zhuye.jsp?my_question_a=<%=my_question_a+4%>&my_question_b=4&question_a=<%=question_a%>&question_b=4&num=<%=num%>">下一页</a>
<% 
	}
	if(my_question_a!=0&&my_question_a+my_question_b<rs1sum){
%>		
		<a href="zhuye.jsp?my_question_a=<%=my_question_a-4%>&my_question_b=4&question_a=<%=question_a%>&question_b=4&num=<%=num%>">上一页</a>
		<a href="zhuye.jsp?my_question_a=<%=my_question_a+4%>&my_question_b=4&question_a=<%=question_a%>&question_b=4&num=<%=num%>">下一页</a>
<%	}	
	if(my_question_a!=0&&my_question_a+my_question_b>=rs1sum){
%>		
	<a href="zhuye.jsp?my_question_a=<%=my_question_a-4%>&my_question_b=4&question_a=<%=question_a%>&question_b=4&num=<%=num%>">上一页</a>
<% }%>
</center>
</fieldset>
</div>

<div class="rank" style="float:right;width:30%;height:100%">
<fieldset>
	<legend>排行榜</legend>
	
	<%//直接显示排行 
	    String bb="<a href=\"rank.jsp?st=0&&num="+num+"\">查看更多></a>";
		out.print("<table border='1' width='100%' style='float:left'>"+"<tr>"+"<td>名次</td>"+"<td>姓名</td><td>获赞数</td>"+"</tr>"+ss+"</table>"+bb+"\n");
        
	%>
	<!--  <p> 用户名                获得赞数</p>-->
</fieldset>
</div>

<div class="allquestion" style="float:left;width:60%;text-align:left">
<fieldset>
	<legend>所有问题</legend>
	<center>
	<table border="1" cellspacing="0" width="80%"> 
	<tr>
	<td align="center">问题id</td>
	<td align="center">题目</td>
	<td align="center">发布时间</td>
	</tr>
<%    
	if(rs2.next()){
	do{
		int question_id = rs2.getInt("id");
		String question_content = rs2.getString("title");
		String question_time = rs2.getString("apply_time");
%>
		<tr>
		<td align="center"><%=question_id%></td>
		<td align="center"><a href="question.jsp?question_id=<%=question_id%>&&uid=<%=uid%>"><%=question_content%></a></td>
		<td align="center"><%=question_time%></td>
		</tr>
<%	
	}while(rs2.next());}
	rs2.close();
	stmt2.close();

%>
</table>
<% 
	if(question_a==0&&question_a+question_b<rs2sum){
%>		
	<a href="zhuye.jsp?my_question_a=<%=my_question_a%>&my_question_b=4&question_a=<%=question_a+4%>&question_b=4&num=<%=num%>">下一页</a>
<% 
	}
	if(question_a!=0&&question_a+question_b<rs2sum){
%>		
		<a href="zhuye.jsp?my_question_a=<%=my_question_a%>&my_question_b=4&question_a=<%=question_a-4%>&question_b=4&num=<%=num%>">上一页</a>
		<a href="zhuye.jsp?my_question_a=<%=my_question_a%>&my_question_b=4&question_a=<%=question_a+4%>&question_b=4&num=<%=num%>">下一页</a>
<%	}	
	if(question_a!=0&&question_a+question_b>=rs2sum){
%>		
	<a href="zhuye.jsp?my_question_a=<%=my_question_a%>&my_question_b=4&question_a=<%=question_a-4%>&question_b=4&num=<%=num%>">上一页</a>
<% }%>
</center>
</fieldset>
</div>
<%
con.close();
}catch (Exception e){
	e.printStackTrace();
}
%>
</body>
</html>
