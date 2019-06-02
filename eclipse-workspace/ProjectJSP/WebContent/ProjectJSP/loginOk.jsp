<!-- 
This page is login user.
return main.jsp when this page is finished.
else login.jsp.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="projectJSP.user.UserDAO"%>
<%@page import="projectJSP.user.UserDTO"%>
<%
	request.setCharacterEncoding("utf-8");
	String userID = request.getParameter("userID");
	String pw = request.getParameter("pw");
	UserDAO dao = UserDAO.getInstance();
	boolean[] checkLogin = dao.userCheck(userID, pw);
	if(checkLogin[0]){
		if(checkLogin[1]) {
			UserDTO dto = dao.getUser(userID);
			if(dto == null){
%>
			<script language="javascript">
				alert("존재하지 않는 회원 입니다.");
				history.go(-1);
			</script>
<%
			}
			else{
				String name = dto.getName();
				session.setAttribute("userID", userID);
				session.setAttribute("name", name);
				session.setAttribute("pw", dto.getPw());
				session.setAttribute("ValidMem", "yes");
				response.sendRedirect("main.jsp");
			}
		}else{
%>		
			<script language="javascript">
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
<%
		}
	}
	else{
%>
		<script language="javascript">
			alert("존재하지 않는 아이디 입니다.");
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