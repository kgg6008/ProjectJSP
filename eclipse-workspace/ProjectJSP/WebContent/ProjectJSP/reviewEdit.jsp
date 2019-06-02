<!-- 
This page is modify review.
return reviewEditOk.jsp when user modify review info and submit.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="projectJSP.movie.*" %>
<%@ page import="projectJSP.review.*"%>
<%@page import="projectJSP.movie.*"%>
<%@page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");
	int reviewID = Integer.parseInt(request.getParameter("id"));
	ReviewDAO dao = ReviewDAO.getInstance();
	ReviewDTO dto = dao.getReviewByID(reviewID);
%>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
<script src="hompage.js" type="text/javascript"></script>
<script language="javascript">

function isOkUpdate(){
	var finish = confirm('저장하시겠습니까?')
	if(!finish){
		return;
	}
	if(document.inputReview.users.value == "null"){
		alert("로그인 후 이용해 주세요.");
		document.location.href="login.jsp";
		return;
	}
	if(document.inputReview.text.value.length == 0){
		alert("내용을 입력해주세요.");
		review.focus();
		return;
	}
	if(document.inputReview.text.value.length > 200){
		alert("200자 이내로 입력해주세요.");
		review.focus();
		return;
	}
	document.inputReview.submit();
}
</script>
<style>
td {
	text-align: right;
}

#center {
	width: 80%;
	padding-top: 1%;
}

#reviewEdit {
	background:
		url('http://pngimg.com/uploads/sticky_note/sticky_note_PNG18928.png');
	background-size: 300px;
	background-repeat: no-repeat;
	width: 300px;
	padding: 20px;
	padding-top: 70px;
}

#editor {
	margin-top: 5%;
}
</style>

</head>

<body>
	<header align="center">
		<div class="userinfo" style="text-align: right">
			<%
				if (session.getAttribute("ValidMem") != null) {
			%>
			<p>
			<form action="logout.jsp" method="post"><%=name%>
				님 안녕하세요. <input type="submit" value="로그아웃"
					style="background-color: rgba(0, 0, 0, 0.05); border: 1px solid rgba(0, 0, 0, 0.4); font-weight: bold">&nbsp;&nbsp;&nbsp;
				<input type="button" value="정보수정"
					style="background-color: rgba(0, 0, 0, 0.05); border: 1px solid rgba(0, 0, 0, 0.4); font-weight: bold"
					onclick="javascript:window.location='modify.jsp'">
			</form>
			</p>

			<%
				} else {
			%>
			<input type="button" value="로그인"
				style="background-color: rgba(0, 0, 0, 0.05); border: 1px solid rgba(0, 0, 0, 0.4); font-weight: bold"
				onclick="javascript:window.location='login.jsp'">
			<%
				}
			%>

		</div>
		<div id="logo" align="center">
			<img id="pin"
				src="https://st2.depositphotos.com/1340907/6714/v/950/depositphotos_67148329-stock-illustration-map-pin-marker-icon.jpg"
				width=50px;> <img
				src="https://media.istockphoto.com/vectors/film-movie-logo-vector-id1031106106"
				width="200px;">
		</div>
	</header>
	<div id="menubar">
		<div class="menu">
			<a href="main.jsp"
				style="color: rgb(129, 118, 114); text-decoration: none;"><strong>홈</strong></a>
		</div>
		<div class="menu">
			<a href="nowPlaying.jsp"
				style="color: rgb(129, 118, 114); text-decoration: none;"><strong>상영
					영화</strong></a>
		</div>
		<div class="menu">
			<a href="movieList.jsp"
				style="color: rgb(129, 118, 114); text-decoration: none;"><strong>영화
					목록</strong></a>
		</div>
		<div class="menu">
			<a href="board.jsp"
				style="color: rgb(129, 118, 114); text-decoration: none;"><strong>자유 게시판</strong></a>
		</div>
	</div>
	<div class="container" align="center" style="background-color:rgb(0,0,0,0);">

		<div id="center" align="center" style="background-color:rgb(0,0,0,0);">

			<form action="reviewEditOk.jsp" method="post" name="inputReview">
				<input type="hidden" name="users" value=<%=id %>>
				<input type="hidden" name="id" value=<%=reviewID %>>
				<table id="reviewEdit">
					<tr>
						<td><strong>리뷰 수정</strong></td>
					</tr>
					<tr>
						<td style="text-align: left;">작성자 : &nbsp;<%=dto.getUsers()%><br /></td>
					</tr>
					<tr>
                        <td><select name="star" id="star_R" align="center">
                                        <option value="1">★☆☆☆☆</option>
                                        <option value="2">★★☆☆☆</option>
                                        <option value="3">★★★☆☆</option>
                                        <option value="4">★★★★☆</option>
                                        <option selected value="5">★★★★★</option>
                                    </select></td>
                    </tr>
					<tr>
						<td><textarea name="text"
								placeholder="리뷰를 입력하세요. (최대 200자)" rows="6px"
								style="width: 100%; resize: none;"><%=dto.getText() %></textarea></td>
					</tr>
					<tr>
						<td style="font-size: 12px;">작성 시간:&nbsp;<%=dto.getrDate() %></td>
					</tr>
					<tr>
						<td><input type="button" value="저장" onclick="javascript:isOkUpdate()"></td>
					</tr>
				</table>

			</form>
		</div>
		<div class="nav" align="center">
			<div id="content">
				<strong>박스 오피스 순위</strong>
				<hr />
				<dl id="rank-list">
					<dt>박스 오피스 순위</dt>
					<dd>
						<ol>
							<%
							MovieDAO boxOffice = MovieDAO.getInstance();
							ArrayList<MovieDTO> rank = boxOffice.getBoxOffice();
							for (MovieDTO mdto : rank) {
								if (mdto.getRankNO().equalsIgnoreCase("new")) {
						%>
							<li><a href="#"><%=mdto.getRank()%>. <%=mdto.getName()%>&nbsp;N</a></li>
							<%
								} else {
						%>
							<li><a href="#"><%=mdto.getRank()%>. <%=mdto.getName()%>&nbsp;-</a></li>
							<%
								}
							}
						%>
						</ol>
					</dd>
				</dl>
			</div>
			<div id="link" style="background-color: rgba(170, 180, 145, 0)">
				<div class="linkImage">
					<a href="https://movie.naver.com/" target="_blank"><img src=""
						alt=""><img
						src="http://mblogthumb2.phinf.naver.net/20160622_73/hhtthh82_1466581509899OrBaG_PNG/%B3%D7%C0%CC%B9%F6-%B7%CE%B0%ED-%B0%ED%C8%AD%C1%FA.png?type=w800"
						id="naver" width="120px" height="50px" alt=""></a>
				</div>

				<div class="linkImage">
					<a href="https://movie.daum.net/" target="_blank"
						style="color: rgb(244, 243, 238); text-decoration: none; padding: 7px;"><img
						src="http://www.bloter.net/wp-content/uploads/2017/09/daum_logo-800x359.png"
						width="120px" height="50px" alt=""></a>
				</div>

				<div class="linkImage">
					<a href="http://www.cgv.co.kr/" target="_blank"
						style="color: rgb(244, 243, 238); text-decoration: none; padding: 10px;"><img
						src="https://upload.wikimedia.org/wikipedia/ko/3/32/CJ_CGV_logo.jpg"
						width="120px" height="50px" alt=""></a>
				</div>

				<div class="linkImage">
					<a href="http://www.lottecinema.co.kr/" target="_blank"
						style="color: rgb(244, 243, 238); text-decoration: none; padding: 10px;"><img
						src="https://kmug.co.kr/data/file/design/data_logo_1131931451_%EB%B3%B4%EA%B8%B0%EC%9A%A9.jpg"
						width="120px" height="50px;" alt=""></a>
				</div>

				<div class="linkImage">
					<a href="http://www.megabox.co.kr/" target="_blank"
						style="color: rgb(244, 243, 238); text-decoration: none; padding: 4px;"><img
						src="http://photo.jtbc.joins.com/news/2017/02/09/20170209151703130.jpg"
						width="120px" height="50px" alt=""></a>
				</div>


			</div>
		</div>
	</div>
	<footer
		style="background-color: rgba(0, 0, 0, 0.2); text-align: center; font-size: 11px;">
		<br> <br> <br> COPYRIGHT KHH, ALL RIGHT RESERVED
	</footer>

</body>

</html>
