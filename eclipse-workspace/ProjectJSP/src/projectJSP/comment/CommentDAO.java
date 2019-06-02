package projectJSP.comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 * Class of manage free posting board's comments.
 * This have connection of Oracle DB to free posting board's comments.
 */

public class CommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
	String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "madang";
	String passWord = "1234";
	//Reason is same with BoardDAO's instance.
	private static CommentDAO instance = new CommentDAO();
	private CommentDAO(){}
	public static CommentDAO getInstance() {
		return instance;
	}
	void connect() {
		try{
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(jdbcURL,user,passWord);
			System.out.println("Connected class.");
		}catch(Exception e){
			System.out.println("Cannot connect class.");
		}
	}

	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public int getTotal() {
		connect();
		int total = 0;
		String sql= "select count(*) as total from boardcomment";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured at CommentDAO.getTotal");
		}
		finally {
			disconnect();
		}
		return total;
	}
	//Get number of comments where board id is 'boardId'.
	public int totalOfBoard(int boardId) {
		connect();
		int total = 0;
		String sql= "select count(*) as total from boardcomment where boardid= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured at CommentDAO.totalOfTotal");
		}
		finally {
			disconnect();
		}
		return total;
	}
	
	public boolean insertComment(CommentDTO dto) {
		connect();
		boolean isSuccess = false;
		String sql= "insert into boardcomment values(comment_seq.nextval, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickName());
			System.out.println(1 + " done");
			pstmt.setString(2, dto.getPw());
			System.out.println(2 + " done");
			pstmt.setString(3, dto.getIP());
			System.out.println(3 + " done");
			pstmt.setString(4, dto.getText());
			System.out.println(4 + " done");
			pstmt.setInt(5, dto.getBoardid());
			System.out.println(5 + " done");
			pstmt.setTimestamp(6, dto.getrDate());
			System.out.println(6 + " done");
			pstmt.executeQuery();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error Occured at CommentDAO.insertCommend");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;		
	}
	public boolean deleteCommend(int id) {
		connect();
		boolean isSuccess = false;
		String sql = "delete from boardcomment where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error Occured in CommentDAO.deleteBoard");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	//Get ArrayList of comment info where board id is 'boardId' between start and end.
	public ArrayList<CommentDTO> getCommentList(int start, int end, int boardID){
		connect();
		ArrayList<CommentDTO> cData = new ArrayList<CommentDTO>();
		String sql = "SELECT B.* "
				+ "from(SELECT ROWNUM as rnum, A.* "
				+ "FROM(SELECT * FROM boardComment where boardid= ?"
				+ " order by rDate desc)A "
				+ "where rownum<=?)B "
				+ "where B.rnum >=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardID);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setId(rs.getInt("id"));
				dto.setNickName(rs.getString("nickname"));
				dto.setPw(rs.getString("pw"));
				dto.setText(rs.getString("text"));
				dto.setIP(rs.getString("ip"));
				dto.setBoardid(rs.getInt("boardid"));
				dto.setrDate(rs.getTimestamp("rdate"));
				cData.add(dto);
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured in BoardDAO.getBoardList()");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return cData;
	}
	public String findPw(int id) {
		String pw = null;
		connect();
		String sql = "select pw from BOARDCOMMENT where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured in BoardDAO.findPw");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return pw;
	}
	
		
}
