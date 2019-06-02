<!-- 
This page is add free posting board's comments.
return showBoard.jsp where boardId is requests boardID when this page is finished.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="projectJSP.comment.*"%>
<%@ page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="cdto" class="projectJSP.comment.CommentDTO" />
<jsp:setProperty property="*" name="cdto" />
<%
	cdto.setrDate(new Timestamp(System.currentTimeMillis()));
	CommentDAO cdao = CommentDAO.getInstance();
	if (cdao.insertComment(cdto)) {
%>
	<script language="javascript">
		alert("저장이 완료되었습니다.");
		document.location.href = "showBoard.jsp?no="+<%=cdto.getBoardid()%>
	</script>
<%
	} else {
%>
	<script language="javascript">
		alert("저장에 실패되었습니다.");
		history.back(-1);
	</script>
<%
	}
%>