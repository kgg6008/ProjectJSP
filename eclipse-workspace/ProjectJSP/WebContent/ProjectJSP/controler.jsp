<!-- 
This page is add review of board.
return showDetail.jsp where boardId is requests boardID when this page is finished.
 -->
<%@page import="projectJSP.movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projectJSP.movie.MovieDTO"%>
<%@page import="projectJSP.review.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");
	String pw = (String) session.getAttribute("pw");
	System.out.println(name);
%>
<jsp:useBean id="dto" class="projectJSP.review.ReviewDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String action = request.getParameter("action");
	if(action.equalsIgnoreCase("delete")){
		ReviewDAO rdao = ReviewDAO.getInstance();
		if(!request.getParameter("pw").equals(pw)){
			out.println("<script>alert('비밀번호가 틀렸습니다.'); history.go(-1);" +
					"</script>");
		}
		else{
			
			int reviewID = Integer.parseInt(request.getParameter("id"));
			ReviewDTO rdto = rdao.getReviewByID(reviewID);
			if(rdao.deleteReview(reviewID)){
				
				System.out.println(rdto.getMovieCd());
				out.println("<script>alert('삭제 완료 되었습니다.'); document.location.href='showDetail.jsp?movieCd="+rdto.getMovieCd()+"'</script>");
			}
			else{

				out.println("<script>alert('삭제 실패하였습니다. 다시 실행해 주세요.'); document.location.href='showDetail.jsp?movieCd="+rdto.getMovieCd()+"'</script>");
			}
		}
	}
	else if(action.equalsIgnoreCase("edit")){
		ReviewDAO rdao = ReviewDAO.getInstance();
		if(!request.getParameter("pw").equals(pw)){
			out.println("<script>alert('비밀번호가 틀렸습니다.'); history.go(-1);" +
					"</script>");
		}
		else{
			int reviewID = Integer.parseInt(request.getParameter("id"));
			out.println("<script> document.location.href='reviewEdit.jsp?id="+reviewID+"'</script>");
		}
	}
%>