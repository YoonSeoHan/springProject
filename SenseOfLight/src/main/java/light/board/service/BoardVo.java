package light.board.service;

import java.time.LocalDate;
import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardVo {
	private int boardNum;
	private int productNum;
	private int boardCnt;
	private int boardSeq;
	private String boardSubject;
	private String boardContents;
	private String boardOrgContents;
	private String boardWriter;
	private String boardFemail;
	private String boardBemail;
	private String boardEmail;
	private String boardPwd;
	private int firstReple;
	
	/*댓글*/
	private int grpno;
	private int grpord;
	private int depth;
	
	/*@DateTimeFormat (pattern = "yyyy-MM-dd")*/
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private LocalDate boardDate;

	public String getBoardPwd() {
		return boardPwd;
	}
	public void setBoardPwd(String boardPwd) {
		this.boardPwd = boardPwd;
	}
	public String getBoardOrgContents() {
		return boardOrgContents;
	}
	public void setBoardOrgContents(String boardOrgContents) {
		this.boardOrgContents = boardOrgContents;
	}
	public int getFirstReple() {
		return firstReple;
	}
	public void setFirstReple(int firstReple) {
		this.firstReple = firstReple;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardSubject() {
		return boardSubject;
	}
	public void setBoardSubject(String boardSubject) {
		this.boardSubject = boardSubject;
	}
	public String getBoardContents() {
		return boardContents;
	}
	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardFemail() {
		return boardFemail;
	}
	public void setBoardFemail(String boardFemail) {
		this.boardFemail = boardFemail;
	}
	public String getBoardBemail() {
		return boardBemail;
	}
	public void setBoardBemail(String boardBemail) {
		this.boardBemail = boardBemail;
	}
	public String getBoardEmail() {
		return boardEmail;
	}
	public void setBoardEmail(String boardEmail) {
		this.boardEmail = boardEmail;
	}
	public LocalDate getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(LocalDate boardDate) {
		this.boardDate = boardDate;
	}
	
	
	public int getGrpno() {
		return grpno;
	}
	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}
	public int getGrpord() {
		return grpord;
	}
	public void setGrpord(int grpord) {
		this.grpord = grpord;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
	
}
