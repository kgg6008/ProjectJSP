<!-- 
This page is add likes of free posting board.
return showBoard.jsp when this page is finished.
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
	bdao.addLikes(bdto.getNo());
	bdao.minusViews(bdto.getNo());
	request.setAttribute("no", bdto.getNo());
	pageContext.forward("showBoard.jsp");
%>
