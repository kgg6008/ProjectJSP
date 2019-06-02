<!-- 
This page is login page
return loginOk.jsp when this page is finished.
if user was having login then it return main.jsp.
 -->
<%@page import="projectJSP.movie.*"%>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%if(session.getAttribute("ValidMem")!= null){ %>
<!-- 로그인 유무 판단 -->
	<jsp:forward page="main.jsp"/>
<%} %>
<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
    <link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="hompage.js" type="text/javascript"></script>
    <style>
        td {
            text-align: right;
        }

        #center {
            width: 80%;
            padding-top: 1%;
        }

        #login {
            background: url('http://pngimg.com/uploads/sticky_note/sticky_note_PNG18928.png');
            background-size: 300px;
            background-repeat: no-repeat;
            width: 300px;
            height: 700px;
            padding: 20px;
            padding-top: 100px;

        }

        #editor {
            margin-top: 5%;
        }

    </style>

</head>

<body>
    <header align="center">
		<div class="userinfo" style="text-align: right">
			
			<input type="button" value="로그인"
				style="background-color: rgba(0, 0, 0, 0.05); border: 1px solid rgba(0, 0, 0, 0.4); font-weight: bold"
				onclick="javascript:window.location='login.jsp'">
			
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

            <form method="post" action="loginOk.jsp">
            <table align="center" id="login">
                <tr>
                    <td colspan="2" align="center"><h2>로그인</h2></td>
                </tr>
                <tr>
                    <th>아이디:</th>
                    <td><input type="text" name="userID" style="background-color: rgba(255, 255, 255, 0.2); height: 25px;" placeholder="아이디를 입력해 주세요." size ="15" value = <% if(session.getAttribute("userID") != null) out.println(session.getAttribute("userID")); %>  >
                    </td>
                </tr>
                <tr>
                    <th>비밀번호:</th>
                    <td><input type="password" name="pw" size="15" placeholder="비밀번호를 입력해 주세요." style="background-color: rgba(255, 255, 255, 0.2); height: 25px;"></td>
                </tr>
                <tr>
                	<td colspan="2">
                		<br/>
                	</td>
                </tr>
                <tr>
                    <td colspan="2" align = "center">
                        <input type="submit" value="로그인">
                        <input type="button" value="회원가입" onclick="javascript:window.location='join.jsp'">
                    </td>
                </tr>
                <tr>
                	<td style="height: 400px;"><br/><td>
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
    <footer style="background-color: rgba(0,0,0,0.2);text-align: center; font-size: 11px;">
        <br>
        <br>
        <br>
        COPYRIGHT KHH, ALL RIGHT RESERVED
    </footer>

</body>

</html>
