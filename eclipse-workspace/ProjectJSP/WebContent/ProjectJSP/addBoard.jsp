<!-- 
This page is add free posting board.
return addBoard.jsp when input values and submit.
 -->

<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="projectJSP.movie.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%
	String ip = null;
	try{
		ip =InetAddress.getLocalHost().getHostAddress();
	}catch(UnknownHostException e){
		e.printStackTrace();
	}
	//To save ip address.
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");
	//Session of login user's info.
%>
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
<script src="boardInsert.js" type="text/javascript"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
<style>
td {
	text-align: right;
}

#center {
	width: 80%;
	padding-top: 1%;
	background:
		url('http://labica.synology.me/media/review/studio_i/note002.png');
	background-size: cover;
	opacity: 0.8;
	font-family: 'Nanum Pen Script', cursive;
	font-size: 25px;
	min-height: 850px;
}

#editor {
	margin-top: 5%;
}

#inputData {
	text-align: center;
	font-size: 25px;
	width: 85%;
}

#inputData th {
	text-align: center;
}

#inputData td {
	text-align: center;
}

.title {
	font-size: 50px;
	font-family: 'Nanum Pen Script', cursive;
}
</style>
<script language="javascript">
	function cancel(){
		var finish = confirm('종료하시겠습니까?')
		if(!finish){
			return;
		}
		history.go(-1);
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
				style="color: rgb(129, 118, 114); text-decoration: none;"><strong>자유
					게시판</strong></a>
		</div>
	</div>
	<div class="container" align="center">
		<div id="center" align="center">
			<div id="design">
				<img
					src="https://cdn.pixabay.com/photo/2013/07/12/14/08/drawing-pin-147814_640.png"
					width="10%" alt="" />
			</div>
			<div class="title" align="left" style="padding-left: 5%;">
				게시글 입력
				<hr style="border-bottom-color: red; width: 80%">
			</div>
			<form action="inputBoard.jsp" method ="post" name="inputBoard">
				<input type="hidden" name="ip" value=<%=ip %>>
				<table id="inputData">
					<tr>
						<th colspan="2">제목</th>
						<td colspan="2" style="padding-right: 2%;"><input type="text"
							maxlength="20" name="title" placeholder="제목을 입력하세요. (최대 20 자)"
							style="width: 85%; max-width: 800px; background-color: rgba(255, 255, 255, 0.2); height: 25px;"></td>
					</tr>
					<tr>
						<td colspan="4">
							<hr style="border-bottom-color: red; width: 90%">
						</td>
					</tr>
					<tr>
						<th colspan="2">내용</th>
					</tr>

					<tr>
						<td colspan="4"
							style="text-align: right; padding-right: 5%; padding-left: 20%;">
							<textarea name="text" maxlength="200" id="summary" rows="25"
								placeholder="내용을 입력하세요. (최대 200 자)"
								style="width: 83%; max-width: 1000px; background-color: rgba(255, 255, 255, 0.2);"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<hr style="border-bottom-color: red; width: 90%">
						</td>
					</tr>
					<tr>
						<th>닉네임:</th>
						<td><input type="text" name="writer"
							placeholder="닉네임을 입력하세요."
							style="background-color: rgba(255, 255, 255, 0.2); height: 25px;"></td>
						<th>비밀번호</th>
						<td style="padding-right: 5%;"><input type="password"
							name="pw" placeholder="비밀번호를 입력하세요."
							style="background-color: rgba(255, 255, 255, 0.2); height: 25px;"></td>
					</tr>
					<tr>
						<td colspan="4">
							<hr style="border-bottom-color: red; width: 90%">
						</td>
					</tr>
					<tr>
						<td colspan="4"
							style="text-align: right; width: 90; padding-right: 5%;"><a
							href="javascript:addBoard()"><img src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Save_font_awesome.svg/512px-Save_font_awesome.svg.png"
								alt="" style="height: 30px"></a> <a href="javascript:cancel()"><img
								src="https://cdn0.iconfinder.com/data/icons/cosmo-symbols/40/cancel_1-512.png"
								alt="" style="height: 30px;"></a></td>
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
							for (MovieDTO dto : rank) {
								if (dto.getRankNO().equalsIgnoreCase("new")) {
						%>
							<li><a href="#"><%=dto.getRank()%>. <%=dto.getName()%>&nbsp;N</a></li>
							<%
								} else {
						%>
							<li><a href="#"><%=dto.getRank()%>. <%=dto.getName()%>&nbsp;-</a></li>
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