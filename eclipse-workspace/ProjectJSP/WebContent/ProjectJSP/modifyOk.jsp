<!-- 
This page is modify information.
return main.jsp when this page is finished.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="projectJSP.user.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="projectJSP.user.UserDTO" scope="page"/>
<jsp:setProperty name="dto" property = "*"/>
<%
	String id = (String)session.getAttribute("userID");
	dto.setUserID(id);
	UserDAO dao = UserDAO.getInstance();
	boolean isSuccess = dao.updateUser(dto);
	if(isSuccess){
%>
		<script language="javascript">
			alert("정보수정 되었습니다.");
			document.location.href="main.jsp";
		</script>
<%
	}
	else{
%>
		<script language="javascript">
			alert("정보수정 실패하였습니다.");
			history.go(-1);
		</script>
<%
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