package projectJSP.movie;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * Class of manage movie board.
 * This have connection of Oracle DB to movie.
 */

public class MovieDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
	String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "madang";
	String passWord = "1234";
	Process process = null;
	Runtime runtime = Runtime.getRuntime();
	private static MovieDAO instance = new MovieDAO();
	private MovieDAO(){}
	public static MovieDAO getInstance() {
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
		String sql= "select count(*) as total from movieinfo";
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
	public int getNowPlayingTotal() {
		
		connect();
		int total = 0;
		String sql= "select count(*) as total from nowplaying";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
			rs.close();
		}catch(SQLException e) {
			System.out.println("Error Occured at MovieDAO.getNowPlayingTotal");
		}
		finally {
			disconnect();
		}
		return total;
	}
	//Run boxOffice.py to update box office ranking.
	public ArrayList<MovieDTO> getBoxOffice(){
		try {
			String command = "python C:\\Temp\\ProjectJSP\\boxOffice.py";
			process = runtime.exec(command);
			process.waitFor();
			System.out.println("run boxOffice.py");
		}catch(Exception e) {
			System.out.println("Error occured run boxOffice.py");
			e.printStackTrace();
		}
		connect();
		ArrayList<MovieDTO> mData = new ArrayList<MovieDTO>();
		String sql = "SELECT * FROM BOXOFFICE10 order by rank";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setRank(rs.getInt("rank"));
				dto.setRankNO(rs.getString("rankno"));
				dto.setName(rs.getString("name"));
				dto.setAudiChange(rs.getString("audichange"));
				mData.add(dto);
			}
			rs.close();
		}catch(SQLException ex) {
			System.out.println("Error Occured in MovieDAO.getBoxOffice");
			ex.printStackTrace();
		}finally {
			disconnect();
		}
		return mData;
	}
	//Get exist of movie where movie code is 'movieCd'
	public boolean isInDB(int movieCd) {
		boolean isExist = false;
		connect();
		String sql = "SELECT * FROM MOVIEINFO WHERE moviecd= ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			ResultSet rs = pstmt.executeQuery();
			isExist = rs.next();
		}catch(SQLException e) {
			System.out.println("Error Occured MovieDAO.isInDB");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return isExist;

	}
	
	public MovieDTO getMovie(int movieCd) {
		connect();
		String sql = "SELECT * FROM MOVIEINFO WHERE moviecd= ?";
		MovieDTO dto = new MovieDTO();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, movieCd);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setMovieCd(rs.getInt("moviecd"));
			dto.setName(rs.getString("name"));
			dto.setGradeAud(rs.getString("gradeaud"));
			dto.setGradeRep(rs.getString("graderep"));
			dto.setGradeNet(rs.getString("gradenet"));
			dto.setGenre(rs.getString("genre"));
			dto.setCountry(rs.getString("country"));
			dto.setRunTime(rs.getString("runtime"));
			dto.setDirector(rs.getString("director"));
			dto.setActor(rs.getString("actor"));
			dto.setAgeGrade(rs.getString("agegrade"));
			dto.setPoster(rs.getString("poster"));
			dto.setSummary(rs.getString("summary"));
			dto.setActorUrl(rs.getString("actorurl"));
			dto.setPhotoUrl(rs.getString("photourl"));
			dto.setVideoUrl(rs.getString("videourl"));
			dto.setrDate(rs.getString("rdate"));
			rs.close();			
		}catch(SQLException e) {
			System.out.println("Error Occured MovieDAO.getMovie");
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return dto;
	}
	//Run nowPlating.py to update box office ranking.
	public ArrayList<MovieDTO> getNowPlaying(int start, int end){
		try {
			String command = "python C:\\Temp\\ProjectJSP\\nowPlaying.py";
			process = runtime.exec(command);
			process.waitFor();
			System.out.println("Run Naver Clawler now playing.");
		}catch(Exception e) {
			System.out.println("Error occured run nowPlaying.py");
			e.printStackTrace();
		}
		connect();
		ArrayList<MovieDTO> mData = new ArrayList<MovieDTO>();
		String sql = "SELECT B.* "
				+ "from(SELECT ROWNUM as rnum, A.* "
				+ "FROM(SELECT * FROM nowplaying"
				+ " order by rank)A "
				+ "where rownum<=?)B "
				+ "where B.rnum >=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setRank(rs.getInt("rank"));
				dto.setPoster(rs.getString("poster"));
				dto.setName(rs.getString("name"));
				dto.setRate(rs.getString("rate"));
				dto.setAgeGrade(rs.getString("agegrade"));
				dto.setGenre(rs.getString("genre"));
				dto.setRunTime(rs.getString("runtime"));
				dto.setrDate(rs.getString("rdate"));
				dto.setDirector(rs.getString("director"));
				dto.setActor(rs.getString("actor"));
				dto.setMovieCd(rs.getInt("moviecd"));
				mData.add(dto);
			}
			rs.close();
		}catch(SQLException ex) {
			System.out.println("Error Occured in MovieDAO.getBoxOffice");
			ex.printStackTrace();
		}finally {
			disconnect();
		}
		return mData;
	}
	

	public ArrayList<MovieDTO> getMovieList(int start, int end){
		connect();
		ArrayList<MovieDTO> mData = new ArrayList<MovieDTO>();
		String sql = "SELECT B.* "
				+ "from(SELECT ROWNUM as rnum, A.* "
				+ "FROM(SELECT * FROM movieinfo"
				+ " order by name)A "
				+ "where rownum<=?)B "
				+ "where B.rnum >=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setMovieCd(rs.getInt("moviecd"));
				dto.setName(rs.getString("name"));
				dto.setGradeAud(rs.getString("gradeaud"));
				dto.setGradeRep(rs.getString("graderep"));
				dto.setGradeNet(rs.getString("gradenet"));
				dto.setGenre(rs.getString("genre"));
				dto.setCountry(rs.getString("country"));
				dto.setRunTime(rs.getString("runtime"));
				dto.setDirector(rs.getString("director"));
				dto.setActor(rs.getString("actor"));
				dto.setAgeGrade(rs.getString("agegrade"));
				dto.setPoster(rs.getString("poster"));
				dto.setSummary(rs.getString("summary"));
				dto.setActorUrl(rs.getString("actorurl"));
				dto.setPhotoUrl(rs.getString("photourl"));
				dto.setVideoUrl(rs.getString("videourl"));
				dto.setrDate(rs.getString("rdate"));
				mData.add(dto);
			}
			rs.close();
		}catch(SQLException ex) {
			System.out.println("Error Occured in MovieDAO.getBoxOffice");
			ex.printStackTrace();
		}finally {
			disconnect();
		}
		return mData;
	}
	
}
