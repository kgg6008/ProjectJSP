package projectJSP.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 * Class of manage free posting board.
 * This have connection of Oracle DB to free posting board.
 */
public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
	String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "madang";
	String passWord = "1234";
	
	//Make instance of Board DO because of probability of impulse.
	private static BoardDAO instance = new BoardDAO();
	private BoardDAO(){}
	public static BoardDAO getInstance() {
		return instance;
	}
	//Connect Oracle DB
	void connect() {
		try{
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(jdbcURL,user,passWord);
			System.out.println("Connected class.");
		}catch(Exception e){
			System.out.println("Cannot connect class.");
		}
	}
	//Disconnect Oracle DB
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
	//Get total number of row in board.
	public int getTotal() {
		connect();
		int total = 0;
		String sql= "select count(*) as total from board";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured at MovieDAO.getTotal");
		}
		finally {
			disconnect();
		}
		return total;
	}
	//Get board list between start to end.
	public ArrayList<BoardDTO> getBoardList(int start, int end){
		connect();
		ArrayList<BoardDTO> bData = new ArrayList<BoardDTO>();
		String sql = "SELECT B.* "
				+ "from(SELECT ROWNUM as rnum, A.* "
				+ "FROM(SELECT * FROM board"
				+ " order by rDate desc)A "
				+ "where rownum<=?)B "
				+ "where B.rnum >=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNo(rs.getInt("no"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setrDate(rs.getTimestamp("rdate"));
				dto.setGood(rs.getInt("good"));
				dto.setViews(rs.getInt("views"));
				bData.add(dto);
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured in BoardDAO.getBoardList()");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return bData;
	}
	//Get one board info where board no is 'no'.
	public BoardDTO getBoard(int no) {
		connect();
		BoardDTO dto = new BoardDTO();
		String sql = "select * from board where no = ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setText(rs.getString("text"));
				dto.setrDate(rs.getTimestamp("rdate"));
				dto.setGood(rs.getInt("good"));
				dto.setViews(rs.getInt("views") + 1);
				dto.setIp(rs.getString("ip"));
			}
			rs.close();
		}catch (SQLException e) {
			System.out.println("Error Occured in BoardDAO.getBoard(id)");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return dto;
	}
	//Delete board info where board no is 'no'.
	public boolean deleteBoard(int no) {
		connect();
		boolean isSuccess = false;
		String sql = "delete from board where no=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,no);
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error Occured in deleteBoard");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	// Views count up when user enter at board.
	public void addViews(int no) {
		connect();
		String sql = "update board set views=? where no =?";
		String sql2= "select views from board where no =?";
		try {
			int views = 0;
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				views = rs.getInt("views");
			}
			disconnect();
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, views+1);
			pstmt.setInt(2, no);
			pstmt.executeQuery();
		}catch (SQLException e) {
			System.out.println("Error Occured at BoardDAO.addViews");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
	}
	//If user push like button then likes count up.
	public void addLikes(int no) {
		connect();
		String sql = "update board set good=? where no =?";
		String sql2= "select good from board where no =?";
		try {
			int like = 0;
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				like = rs.getInt("good");
			}
			disconnect();
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like+1);
			pstmt.setInt(2, no);
			pstmt.executeQuery();
		}catch (SQLException e) {
			System.out.println("Error Occured at BoardDAO.addViews");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
	}
	//Add board info to board DB.
	public boolean insertBoard(BoardDTO dto) {
		boolean isSuccess = false;
		connect();
		String sql = "insert into board values(board_seq.nextval, ?, ?, ?, ?, ?, 0, 0, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getText());
			pstmt.setTimestamp(5, dto.getrDate());
			pstmt.setString(6, dto.getIp());
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error Occured in BoardDAO.inseartBoard");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	// Get pw to delete board.
	public String findPw(int no) {
		String pw = null;
		connect();
		String sql = "select pw from board where no=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
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
	/*
	 * If user pushed likes button then page is reloading.
	 * It makes board's views up. So it have to  minus 1 of views.
	 */
	public void minusViews(int no) {
		connect();
		String sql = "update board set views=? where no =?";
		String sql2= "select views from board where no =?";
		try {
			int views = 0;
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				views = rs.getInt("views");
			}
			disconnect();
			connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, views-1);
			pstmt.setInt(2, no);
			pstmt.executeQuery();
		}catch (SQLException e) {
			System.out.println("Error Occured at BoardDAO.minusViews");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
	}
}
