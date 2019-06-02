<!-- 
This page is modify user info.
return modifyOk.jsp when user modified info and submit.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="projectJSP.user.UserDAO" %>
<%@page import="projectJSP.user.UserDTO" %>
<%@page import="projectJSP.movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projectJSP.movie.MovieDTO"%>
<%	
	String name = (String) session.getAttribute("name");

	String userID = (String) session.getAttribute("userID");
	UserDAO dao= UserDAO.getInstance();
	UserDTO dto = dao.getUser(userID);
%>
<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
    <link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="hompage.js" type="text/javascript"></script>
    <script language="JavaScript" src="user.js" ></script>
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <style>
        td {
            text-align: right;
        }

        #center {
            width: 80%;
            padding-top: 1%;
            background: url('http://labica.synology.me/media/review/studio_i/note002.png');
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
            <div id="design">
                <img src="https://cdn.pixabay.com/photo/2013/07/12/14/08/drawing-pin-147814_640.png" width="10%" alt="" />
            </div>
            <div class="title" align="left" style="padding-left: 5%;">
                Modify
                <hr style="border-bottom-color: red; width: 90%">
            </div>
            <form action="modifyOk.jsp" method="post" name="reg_frm">
            <table id="inputData">
                <tr>
                    <th >ID</th>
                    <td colspan="3" style="text-align: center;"> <%=dto.getUserID()%> </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <th>PW</th>
                    <td colspan="3"><input type="password" name="pw" style="width:85%; max-width: 800px;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <th>confirm<br>PW</th>
                    <td colspan="3"><input type="password" name="pw_check" style="width:85%; max-width: 800px;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <th >Name</th>
                    <td colspan="3" style="text-align: center;"><%=dto.getName() %></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                   <th>Age</th>
                   <td><input type="number" name ="age"></td>
                   <th>gender</th>
                   <td style="padding-right: 5%; text-align: center;">
                       <%if(dto.getSex() == 1){
					out.print("남");	
				}else{
					out.print("여");
				}%><br />
                   </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <th >Email</th>
                    <td colspan="3"><input type="email" name="email" style="width:85%; max-width: 800px;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <th >JoinDate</th>
                    <td colspan="3" style="text-align: center;"><%= dto.getRdate() %></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <hr style="border-bottom-color: red; width: 90%">
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: right; width: 90; padding-right: 5%;">
                    <input type="button" value="수정" onclick="updateInfoConfirm()">&nbsp;&nbsp;&nbsp; <input type="reset" value="취소" onclick="javascript:window.location='login.jsp'">
                    </td>
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

    <footer style="background-color: rgba(0,0,0,0.2);text-align: center; font-size: 11px;">
        <br>
        <br>
        <br>
        COPYRIGHT KHH, ALL RIGHT RESERVED
    </footer>

</body>

</html>