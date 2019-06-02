<!-- 
This page is show detail of movie.
 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="projectJSP.movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projectJSP.movie.MovieDTO"%>
<%@page import="projectJSP.review.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");	
%>
<jsp:useBean id="selectedDto" class="projectJSP.movie.MovieDTO" />
<jsp:useBean id="joinUser" class="projectJSP.user.UserDTO" />
<jsp:setProperty property="*" name="selectedDto" />
<%	
	MovieDAO checker = MovieDAO.getInstance();
	if (!checker.isInDB(selectedDto.getMovieCd())) {
%>
<script language="javascript">
	alert("해당 영화가 목록에 존재하지 않습니다.\n추가 요청해 주세요.");
	history.go(-1);
</script>
<%
	}
%>
<!doctype html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
    <link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="hompage.js" type="text/javascript"></script>
    <script src="review.js" type="text/javascript"></script>
    <style>
        #star_R {
            width: 45%;
            height: 2rem;
            text-align: center;
            align-content: center;
            margin-bottom: 10px;
            margin-right: 0px;
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
	<div class="container" align="center">
		<div class="detailinfo" align=center
			style="padding: 2%; background-color: rgba(0, 0, 0, 0.2);">

			<div id="center" align="center" style="margin: 0px;">
				<%
					MovieDAO dao = MovieDAO.getInstance();
					MovieDTO dto = dao.getMovie(selectedDto.getMovieCd());
				%>
				<div class="info" align="center" style="width: 100%">
					<div class="info_movie info" style="width: 50%; text-align: left;">
						<h2><%=dto.getName()%></h2>
						<strong>관람객 평점</strong>:&nbsp;<%=dto.getGradeAud()%><br /> <strong>기자/
							평론가 평점</strong>:&nbsp;
						<%=dto.getGradeRep()%><br /> <strong>네티즌 평점</strong>:&nbsp;
						<%=dto.getGradeNet()%>
						<hr />
						<table style="width: 100%;">
							<tr>
								<th>장르:</th>
								<td colspan="3"><%=dto.getGenre()%></td>
							</tr>
							<tr>
								<th>국가:</th>
								<td><%=dto.getCountry()%></td>
								<th>상영시간:</th>
								<td><%=dto.getRunTime()%></td>
							</tr>
							<tr>
								<th>개봉일:</th>
								<td colspan="3"><%=dto.getrDate()%></td>
							</tr>
							<tr>
								<th>감독:</th>
								<td colspan="3"><%=dto.getDirector()%></td>
							</tr>
							<tr>
								<th>출연:</th>
								<td colspan="3"><%=dto.getActor()%></td>
							</tr>
							<tr>
								<th>등급:</th>
								<td colspan="3"><%=dto.getAgeGrade()%></td>
							</tr>
						</table>
					</div>
					<div class="info_movie poster"
						style="text-align: center; width: 30%">
						<img src=<%=dto.getPoster()%> width="100%"
							onerror="this.src='http://placehold.it/200*287" alt="poster">
					</div>
				</div>
				<div class="link_btn" align="right"
					style="width: 90%; align-content: center;">
					<div class="logo">
						<img
							src="http://mblogthumb2.phinf.naver.net/20160622_73/hhtthh82_1466581509899OrBaG_PNG/%B3%D7%C0%CC%B9%F6-%B7%CE%B0%ED-%B0%ED%C8%AD%C1%FA.png?type=w800"
							width="120px" height="50px" alt="">
					</div>
					<a href=<%=dto.getActorUrl()%> target="_blank"><button class="info_url">배우
							정보</button></a> <a href=<%=dto.getPhotoUrl()%> target="_blank"><button class="info_url">영화
							사진</button></a> <a href=<%=dto.getVideoUrl()%> target="_blank"><button class="info_url">영화
							영상</button></a>
				</div>
				<div class="another" align="center">
					<div class="summary" style="text-align: left; width: 90%;">
						<hr />
						<h4>줄거리</h4>
						<p style="width: 80%"><%=dto.getSummary()%></p>
						<hr />
					</div>

				</div>
				<br />
				<div class="review" style="width: 90%" align="left">
					<strong>리뷰 작성</strong>
					<form action="reviewOk.jsp" name="inputReview" method="post"
						align="right">
						<input type="hidden" name="users" value=<%=id %>> <input
							type="hidden" name="movieCd" value=<%=dto.getMovieCd() %>>
						<hr />
						<table style="width: 100%;">
							<tr>
								<td style="text-align: left;"><select name="star"
									id="star_R" align="center">
										<option value=1>★☆☆☆☆</option>
										<option value=2>★★☆☆☆</option>
										<option value=3>★★★☆☆</option>
										<option value=4>★★★★☆</option>
										<option selected value=5>★★★★★</option>
								</select></td>
								<td><input type="button" value="리뷰 등록" onclick="isOk()"
									style="background-color: rgba(129, 118, 114, 0.85); border: 1px solid black; width: 45%; height: 2rem; border-radius: 8px; color: rgb(244, 243, 238); font-style: oblique; font-weight: bold; margin-bottom: 10px;" />
								</td>
							</tr>
							<tr>
								<td colspan="2"><textarea name="text"
										placeholder="리뷰를 입력하세요. (최대 200자)" rows="6px"
										style="width: 100%; resize: none;"></textarea></td>
							</tr>
						</table>
					</form>
					<hr />
					<br />
					<table id="reviewTable">
						<tr style="border-bottom: 1px solid rgba(129, 118, 114, 0.85);">
							<th>번호</th>
							<th>별점</th>
							<th>리뷰</th>
							<th>작성자·날짜</th>
							<th>&nbsp;</th>
						</tr>
						<%
							ReviewDAO rdao = ReviewDAO.getInstance();
							ArrayList<ReviewDTO> reviewList = rdao.getReview(dto.getMovieCd());
							if(reviewList.size() == 0){						
						%>
						<tr>
							<td colspan="4" style="text-align: center;">등록된 리뷰가 없습니다.</td>
						</tr>
						<%
							} else{
									for(ReviewDTO rdto: reviewList){
										String time = new SimpleDateFormat("yyyy.MM.dd").format(rdto.getrDate());
						%>
						<tr>
							<td><%=rdto.getId() %></td>
							<td><%=rdao.scoreToStar(rdto.getStar()) %></td>
							<td><%=rdto.getText() %></td>
							<td><%=rdto.getUsers() %><br /><%=time %></td>
							<%if ((id != null)&&(rdto.getUsers() != null) && id.equals(rdto.getUsers())){ %>
							<td style="font-size: 10px;"><a href="javascript:checkModify(<%=rdto.getId()%>)">수정</a><br />
							<br />
							<a href="javascript:checkDelete(<%=rdto.getId()%>)">삭제</a></td>
							<%}else if((id != null)&&(rdto.getUsers() != null) && id.equals("admin")){ %>
							<td style="font-size: 12px;">
							<a href="javascript:checkDelete(<%=rdto.getId()%>)">삭제</a></td>
							<%}else{%>
							<td></td>
							<%} %>
						</tr>
						<%
						}
									}
%>
					</table>
					<br /> <br />
				</div>
			</div>
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