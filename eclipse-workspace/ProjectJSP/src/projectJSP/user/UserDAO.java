package projectJSP.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
	String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "madang";
	String passWord = "1234";
	private static UserDAO instance = new UserDAO();
	private UserDAO(){}
	public static UserDAO getInstance() {
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
	public boolean insertUser(UserDTO dto) {
		boolean isSuccess = false;
		connect();
		String sql = "insert into users(name, id, pw, age, sex, email, rdate)"
				+ "values(?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getUserID());
			pstmt.setString(3, dto.getPw());
			pstmt.setInt(4,  dto.getAge());
			pstmt.setInt(5, dto.getSex());
			pstmt.setString(6, dto.getEmail());
			pstmt.setTimestamp(7, dto.getRdate());
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e) {
			System.out.println("Error Occured in UserDAO.insertUser");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isSuccess;
	}
	//Confirm duplication of ID.
	public boolean confirmUserID(String id) {
		boolean isExist = false;
		connect();
		String sql = "select id from users where id= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				isExist = true;
			}else {
				isExist = false;
			}
		}catch(SQLException e) {
			System.out.println("Error occured in UserDAO.confirmUserID");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return isExist;
	}
	/*
	 * canLogin[0] means id, canLogin[1] means pw.
	 * If canLogin[0] is false then ID is wrong.
	 * else is ID is correct.
	 * And if canLogin[1] is false then pw is wrong. 
	 */
	public boolean[] userCheck(String id, String pw) {
		boolean[] canLogin = {false, false};
		String dbPw;
		connect();
		String sql = "select pw from users where id= ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				canLogin[0] = true;
				dbPw = rs.getString("pw");
				if(dbPw.equals(pw)) {
					canLogin[1] = true;
				}
			}
		}catch(SQLException e) {
			System.out.println("Error occured in UserDAO.userCheck");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return canLogin;
	}
	
	public UserDTO getUser(String id) {
		UserDTO dto= null;
		connect();
		String sql = "select * from users where id= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new UserDTO();
				dto.setUserID(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setAge(rs.getInt("age"));
				dto.setSex(rs.getInt("sex"));
				dto.setEmail(rs.getString("email"));
				dto.setRdate(rs.getTimestamp("rdate"));
			}
		}catch(SQLException e) {
			System.out.println("Error occured at UserDAO.getUser");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return dto;
	}
	public boolean updateUser(UserDTO dto) {
		boolean isSuccess = false;
		connect();
		String sql ="update users set pw=?, age=?, email=? where id =?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setInt(2, dto.getAge());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getUserID());
			pstmt.executeUpdate();
			isSuccess = true;
		}catch(SQLException e){
			System.out.println("Error occured in UserDAO.updateUser");
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return isSuccess;
	}
	

}
