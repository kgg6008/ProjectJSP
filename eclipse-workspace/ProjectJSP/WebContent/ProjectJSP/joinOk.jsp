<!-- 
This page is join user.
return login.jsp when this page is finished.
else prev page.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "projectJSP.user.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="projectJSP.user.UserDTO"/>
<jsp:setProperty name="dto" property ="*"/>
<%
	dto.setRdate(new Timestamp(System.currentTimeMillis()));
	UserDAO dao = UserDAO.getInstance();
	if(dao.confirmUserID(dto.getUserID())){
%>
		<script language="javascript">
			alert("아이디가 이미 존재 합니다.");
			history.back();
		</script>
<%	}else{
	if(dao.insertUser(dto)){
		session.setAttribute("userID", dto.getUserID());
%>
		<script language="javascript">
			alert("회원가입을 축하합니다!!");
			document.location.href="login.jsp";
		</script>
<%
	}else{
%>
		<script language="javascript">
			alert("회원가입에 실패했습니다.");
			document.location.href="login.jsp";
		</script>
<%
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>