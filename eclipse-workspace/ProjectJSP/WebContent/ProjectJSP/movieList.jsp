<!-- 
This page is show board list.
 -->
<%@page import="projectJSP.movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projectJSP.movie.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");
	final int ROWSIZE = 7; //한 페이지에 보일 게시물 수
	final int BLOCK = 5; //아래에 보일 페이지 최대 개수 ex. 1~5
	int pg = 1; //기본 페이지 값
	if (request.getParameter("page") != null) { //받아온 pg값이 있을 때
		pg = Integer.parseInt(request.getParameter("page")); //pg값을 저장
	}
	MovieDAO dao = MovieDAO.getInstance();
	final int TOTAL = dao.getTotal();
	int totalPage = (int) Math.ceil(1.0 * TOTAL / ROWSIZE);
	if (totalPage < pg) {
		pg = totalPage;
	} else if (pg < 1) {
		pg = 1;
	}
	int start = pg * ROWSIZE - (ROWSIZE - 1);
	int end = pg * ROWSIZE;
	int startPage = ((pg - 1) / BLOCK) * BLOCK + 1;
	int endPage = startPage + BLOCK - 1;
	if (endPage > totalPage) {
		endPage = totalPage;
	}
%>
<!doctype html>
<html>

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
<script src="hompage.js" type="text/javascript"></script>

<style>
td {
	text-align: right;
}

#center {
	width: 80%;
	background-color: rgba(0, 0, 0, 0.2);
	padding-top: 1%;
}
</style>
<script language="javascript">
	function check(movieCd) {
		document.location.href = "showDetail.jsp?movieCd=" + movieCd;
	}
</script>
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
	<div class="container" align="center">
		<div id="center" align="center">
			<table align="center" id="listmovie" style="width: 90%;">
				<%
					ArrayList<MovieDTO> movie = dao.getMovieList(start, end);
					for (MovieDTO dto : movie) {
				%>

				<tr
					style="background-color: rgba(255, 255, 255, 0.5); margin: 15px; border-radius:10px;">
					<td class="movieInfo" style="width: inherit; ">
						<div class="poster" style="width: 30%; float: left;"
							align="center">
							<a href="javascript:check(<%=dto.getMovieCd()%>)"><img
								src=<%=dto.getPoster()%> width="100%"></a>
						</div>
						<div class="info"
							style="width: 70%; text-align: center; margin-left: 5%;">
							<table style="width: 100%;">
								<tr>
									<th colspan="2"><a
										href="javascript:check(<%=dto.getMovieCd()%>)"
										style="color: black; text-decoration: none;"><%=dto.getName()%></a></th>
								</tr>
								<tr>
									<td colspan="2"
										style="border-bottom: 1px solid rgb(129, 118, 114)"><br /></td>
								</tr>
								<tr style="background-color: rgba(129, 118, 114, 0.3)">
									<td>등급</td>

									<td><%=dto.getAgeGrade()%></td>
								</tr>
								<tr>
									<td>장르</td>

									<td><%=dto.getGenre()%></td>
								</tr>
								<tr style="background-color: rgba(129, 118, 114, 0.3)">
									<td>상영시간</td>
									<td><%=dto.getRunTime()%></td>
								</tr>
								<tr>
									<td>개봉일</td>
									<td><%=dto.getrDate()%></td>
								</tr>
								<tr style="background-color: rgba(129, 118, 114, 0.3)">
									<td>감독</td>
									<td><%=dto.getDirector()%></td>
								</tr>
								<tr>
									<td>배우</td>
									<td><%=dto.getActor()%></td>
								</tr>

							</table>
						</div>
					</td>
				</tr>

				<%
					}
				%>

			</table>
			<br /> <br />
			<script language="javascript">
				function pageClick(page) {
					document.location.href = 'movieList.jsp?page=' + page;
					return;
				}
			</script>
			<table class="paging" align="center" style="width: 60%">
				<tr>
					<%
						if (pg == 1) {
					%>
					<td><a href="#" style="color: black; text-decoration: none;"><strong>◀◀&nbsp;first</strong></a></td>
					<%
						} else {
					%>
					<td><a href="javascript:pageClick(1)" style="color: black; text-decoration: none;"><strong>◀◀&nbsp;first</strong></a></td>
					<%
						}
						if (startPage == 1) {
					%>
					<td><a href="#" style="color: black; text-decoration: none;"><strong>◀&nbsp;prev</strong></a></td>
					<%
						} else {
					%>
					<td><a href="javascript:pageClick(<%=(startPage - 1)%>)" style="color: black; text-decoration: none;"><strong>◀&nbsp;prev</strong></a></td>
					<%
						}
						for (int i = startPage; i <= endPage; i++) {
							if (i == pg) {
					%>
					<td><h2><u><%=i%></u></h2></td>
					<%
						} else {
					%>
					<td><a href="javascript:pageClick(<%=i%>)" style="color: black; text-decoration: none;"><strong><%=i%></strong></a></td>
					<%
						}
						}
						if (endPage == totalPage) {
					%>
					<td><a href="#" style="color: black; text-decoration: none;"><strong>next&nbsp;▶</strong></a></td>
					<%
						} else {
					%>
					<td><a href="javascript:pageClick(<%=(endPage + 1)%>)" style="color: black; text-decoration: none;"><strong>next&nbsp;▶</strong></a></td>
					<%
						}
						if (pg == totalPage) {
					%>
					<td><a href="#" style="color: black; text-decoration: none;"><strong>last&nbsp;▶▶</strong></a></td>
					<%
						} else {
					%>
					<td><a href="javascript:pageClick(<%=totalPage%>)" style="color: black; text-decoration: none;"><strong>last&nbsp;▶▶</strong></a></td>
					<%
						}
					%>

				</tr>
			</table>
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
							for (MovieDTO bdto : rank) {
								if (bdto.getRankNO().equalsIgnoreCase("new")) {
						%>
							<li><a href="#"><%=bdto.getRank()%>. <%=bdto.getName()%>&nbsp;N</a></li>
							<%
								} else {
						%>
							<li><a href="#"><%=bdto.getRank()%>. <%=bdto.getName()%>&nbsp;-</a></li>
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