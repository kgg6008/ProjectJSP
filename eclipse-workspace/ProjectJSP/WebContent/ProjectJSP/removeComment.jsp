<!-- 
This page is delete action free posting board's comments.
return showBoard.jsp where no is request no when this page is finished.
 -->
<%@page import="projectJSP.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="projectJSP.comment.*"%>
<%
   	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="cdto" class="projectJSP.comment.CommentDTO"/>
<jsp:setProperty property="*" name="cdto"/>
<%
	CommentDAO cdao = CommentDAO.getInstance();
	String commentPW = cdao.findPw(cdto.getId());
	if(commentPW.equals(cdto.getPw())&&cdao.deleteCommend(cdto.getId())){
		BoardDAO bdao = BoardDAO.getInstance();
		bdao.minusViews(cdto.getBoardid());
		out.println("<script language='javascript'> alert('삭제되었습니다.'); document.location.href= 'showBoard.jsp?no="+cdto.getBoardid()+"';</script>");
	}
	else{
		out.println("<script language='javascript'>alert('비밀번호를 잘못 입력하셨습니다.');history.go(-1);</script>");
	}
%> 