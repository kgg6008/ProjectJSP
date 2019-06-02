package projectJSP.review;

import java.sql.Timestamp;

public class ReviewDTO {
	private String users;
	private int id;
	private int star;
	private int movieCd;
	private String text;
	private Timestamp rDate;
	public String getUsers() {
		return users;
	}
	public void setUsers(String users) {
		this.users = users;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public int getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(int movieCd) {
		this.movieCd = movieCd;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Timestamp getrDate() {
		return rDate;
	}
	public void setrDate(Timestamp rDate) {
		this.rDate = rDate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
