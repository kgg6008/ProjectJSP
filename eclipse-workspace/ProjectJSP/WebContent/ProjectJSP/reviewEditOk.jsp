<!-- 
This page is modify action review.
return showDetail.jsp where movieCd is request's movieCd when this page is finished.
 -->
<%@page import="projectJSP.review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="projectJSP.review.ReviewDAO"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dto" class="projectJSP.review.ReviewDTO" scope="page" />
<jsp:setProperty name="dto" property="*" />
<%
	dto.setrDate(new Timestamp(System.currentTimeMillis()));
	ReviewDAO dao = ReviewDAO.getInstance();
	boolean isSuccess = dao.updateReview(dto);
	dto = dao.getReviewByID(Integer.parseInt(request.getParameter("id")));
	if (isSuccess) {
%>
<script language="javascript">
	alert("리뷰가 수정 되었습니다.");
	var movieCd = <%=dto.getMovieCd()%>;
	document.location.href = "showDetail.jsp?movieCd="+ movieCd;
</script>
<%
	} else {
%>
<script language="javascript">
	alert("수정 중 오류가 발생되었습니다.");
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