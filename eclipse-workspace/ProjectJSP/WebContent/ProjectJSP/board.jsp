<!-- 
This page is show free posting board.
 -->
<%@page import="projectJSP.comment.CommentDAO"%>
<%@page import="projectJSP.comment.CommentDTO"%>
<%@page import="projectJSP.board.BoardDTO"%>
<%@page import="projectJSP.board.BoardDAO"%>
<%@page import="projectJSP.movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projectJSP.movie.MovieDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("userID");
	final int ROWSIZE = 10; //한 페이지에 보일 게시물 수
	final int BLOCK = 5; //아래에 보일 페이지 최대 개수 ex. 1~5
	int pg = 1; //기본 페이지 값
	if (request.getParameter("page") != null) { //받아온 pg값이 있을 때
		pg = Integer.parseInt(request.getParameter("page")); //pg값을 저장
	}
	BoardDAO dao = BoardDAO.getInstance();
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
    <link href="hompage.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="hompage.js" type="text/javascript"></script>
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

        }


        #editor {
            margin-top: 5%;
        }

        #inputData {
            text-align: center;
            width: 85%;
        }

        #inputData th {
            text-align: center;
            background-color: rgb(101,20,27);
        }

        #inputData td {
            text-align: center;
        }
        #inputData tr:nth-child(odd){
            background-color: rgb(240,176,182);
        }

        .title{
            font-size: 70px;
            font-family: 'Nanum Pen Script', cursive;
        }
    </style>
    <script language="javascript">
    		function checkBoard(no){
    			document.location.href = "showBoard.jsp?no=" + no;
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
            <div id="design">
                <img src="https://cdn.pixabay.com/photo/2013/07/12/14/08/drawing-pin-147814_640.png" width="10%" alt="" />
            </div>
            <div class="title">
                자유 게시판
                <hr style="border-bottom-color: red; width: 80%">
            </div>
            <table id="inputData">
                <tr>
                    <th>번호</th>
                    <th colspan="2">제목</th>
                    <th>글쓴이</th>
                    <th>날짜</th>
                    <th>추천수</th>
                    <th>조회 수</th>
                </tr>
                <%	ArrayList<BoardDTO> board = dao.getBoardList(start, end);
        			CommentDAO cDao = CommentDAO.getInstance();
            		if(board.size() == 0){
            	%>
            	<tr style="background-color:rgba(0,0,0,0);">
                    <td colspan="7" style="text-align: center;">
                    	등록된 글이 없습니다.
                    </td>
                </tr>
            	<%
            		}
                	for(BoardDTO bdto: board){               		
                		String time = new SimpleDateFormat("yyyy.MM.dd").format(bdto.getrDate());
                %>
                <tr>
                    <td><%=bdto.getNo() %></td>
                    <td><a href="javascript:checkBoard(<%=bdto.getNo() %>)" style="font-weight:border; text-decoration: none; color:black;"><%=bdto.getTitle() %></a></td>
                    <td>[<%=cDao.totalOfBoard(bdto.getNo()) %>]</td>
                    <td><%=bdto.getWriter() %></td>
                    <td><%=time %></td>
                    <td><%=bdto.getGood() %></td>
                    <td><%=bdto.getViews() %></td>
                </tr>
                <%
                	}
                %>
                <tr style="background-color:rgba(0,0,0,0);">
                    <td colspan="7" style="text-align: right;">
                    	<a href="addBoard.jsp"><img src="https://svgsilh.com/svg/1727487.svg" alt="" style="height: 15px;"></a>
                    </td>
                </tr>
            </table>
            <div class="page">
                <script language="javascript">
				function pageClick(page) {
					document.location.href = 'board.jsp?page=' + page;
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