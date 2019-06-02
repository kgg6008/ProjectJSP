<!-- 
This page is add action review.
return showDetail.jsp where movieCd is request's movieCd when this page is finished.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="projectJSP.review.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="projectJSP.review.ReviewDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	dto.setrDate(new Timestamp(System.currentTimeMillis()));
	ReviewDAO dao = ReviewDAO.getInstance();
	if (dao.insertReview(dto)) {
%>
	<script language="javascript">
		alert("저장이 완료되었습니다.");
		document.location.href="showDetail.jsp?movieCd="+<%=dto.getMovieCd()%>;
	</script>
<%
	} else {
%>
	<script language="javascript">
		alert("저장에 실패되었습니다.");
		history.back();
	</script>
<%
	}
%>

