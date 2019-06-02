package projectJSP.review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import projectJSP.user.UserDTO;


public class ReviewDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
	String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "madang";
	String passWord = "1234";
	private static ReviewDAO instance = new ReviewDAO();
	private ReviewDAO(){}
	public static ReviewDAO getInstance() {
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
	public boolean insertReview(ReviewDTO dto) {
		boolean isSuccess = false;
		connect();
		String sql = "insert into review(users, star, moviecd, text, id, rdate) values(?, ?, ?, ?, REVIEWSEQ.nextval, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUsers());
			pstmt.setInt(2, dto.getStar());
			pstmt.setInt(3, dto.getMovieCd());
			pstmt.setString(4, dto.getText());
			pstmt.setTimestamp(5, dto.getrDate());
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error occured in ReviewDao.insertReview");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	public ArrayList<ReviewDTO> getReview(int movieCd){
		connect();
		ArrayList<ReviewDTO> rData = new ArrayList<ReviewDTO>();
		String sql = "select * from review where moviecd = ? order by id desc";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setUsers(rs.getString("users"));
				dto.setStar(rs.getInt("star"));
				dto.setText(rs.getString("text"));
				dto.setrDate(rs.getTimestamp("rdate"));
				dto.setId(rs.getInt("id"));
				rData.add(dto);
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured in ReviewDAO.getReview");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return rData;
	}
	public ReviewDTO getReviewByID(int id) {
		connect();
		ReviewDTO dto = new ReviewDTO();
		String sql = "select * from review where id = ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setUsers(rs.getString("users"));
				dto.setStar(rs.getInt("star"));
				dto.setText(rs.getString("text"));
				dto.setrDate(rs.getTimestamp("rdate"));
				dto.setId(rs.getInt("id"));
				dto.setMovieCd(rs.getInt("moviecd"));
			}
			rs.close();
		}catch (SQLException e) {
			System.out.println("Error Occured in ReviewDAO.getReviewByID(id)");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return dto;
	}
	public boolean deleteReview(int id) {
		connect();
		boolean isSuccess = false;
		ReviewDTO dto = new ReviewDTO();
		String sql = "delete from review where id = ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e){
			System.out.println("Error Occured at ReviewDAO.deleteReview");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	public boolean updateReview(ReviewDTO dto) {
		boolean isSuccess = false;
		connect();
		String sql ="update review set star=?, text =?, rDate=? where id = ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStar());
			pstmt.setString(2, dto.getText());
			pstmt.setTimestamp(3, dto.getrDate());
			pstmt.setInt(4, dto.getId());
			pstmt.executeQuery();
			isSuccess=true;
		}catch(SQLException e) {
			System.out.println("Error Occured in ReviewDAO.updateReview.");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	//Star score int to String
	public String scoreToStar(int n) {
		String str = "-";
		switch(n){
		case 1:
			str= "★☆☆☆☆";
			break;
		case 2:
			str= "★★☆☆☆";
			break;
		case 3:
			str= "★★★☆☆";
			break;
		case 4:
			str= "★★★★☆";
			break;
		case 5:
			str = "★★★★★";
			break;
		}
		return str;
	}

}
