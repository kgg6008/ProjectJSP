<!-- 
This page is delete action free posting board.
return Board.jsp when this page is finished.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="projectJSP.board.*"%>
<%
   	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bdto" class="projectJSP.board.BoardDTO"/>
<jsp:setProperty property="*" name="bdto"/>
<%
	BoardDAO bdao = BoardDAO.getInstance();
	String boardPW = bdao.findPw(bdto.getNo());
	if(boardPW.equals(bdto.getPw())){
		bdao.deleteBoard(bdto.getNo());
		out.println("<script language='javascript'> alert('삭제되었습니다.'); document.location.href= 'board.jsp';</script>");
	}
	else{
		out.println("<script language='javascript'>alert('비밀번호를 잘못 입력하셨습니다.');history.go(-1);</script>");
	}
%> 