<!-- 
This page is add action free posting board.
return Board.jsp when this page is finished.
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="projectJSP.board.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bdto" class="projectJSP.board.BoardDTO" />
<jsp:setProperty property="*" name="bdto" />
<%
	bdto.setrDate(new Timestamp(System.currentTimeMillis()));
	BoardDAO bdao = BoardDAO.getInstance();
	if (bdao.insertBoard(bdto)) {
%>
	<script language="javascript">
		alert("저장이 완료되었습니다.");
		document.location.href = "board.jsp"
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