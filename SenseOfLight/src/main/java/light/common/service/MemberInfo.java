package light.common.service;

import java.time.LocalDate;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberInfo {
	private int memNum;
	private String memId;
	private String memPw;
	private String memName;
	private String memPost;
	private String memAddr1;
	private String memAddr2;
	private String memPhone;
	private String memEmail;
	@DateTimeFormat(pattern="yyyyMMddHH")
	private LocalDate memRegdate;
	private String url;
	private String memMileage;
	
	
	public String getMemMileage() {
		return memMileage;
	}
	public void setMemMileage(String memMileage) {
		this.memMileage = memMileage;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getMemNum() {
		return memNum;
	}
	public void setMemNum(int memNum) {
		this.memNum = memNum;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemPw() {
		return memPw;
	}
	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemPost() {
		return memPost;
	}
	public void setMemPost(String memPost) {
		this.memPost = memPost;
	}
	public String getMemAddr1() {
		return memAddr1;
	}
	public void setMemAddr1(String memAddr1) {
		this.memAddr1 = memAddr1;
	}
	public String getMemAddr2() {
		return memAddr2;
	}
	public void setMemAddr2(String memAddr2) {
		this.memAddr2 = memAddr2;
	}
	public String getMemPhone() {
		return memPhone;
	}
	public LocalDate getMemRegdate() {
		return memRegdate;
	}
	public void setMemRegdate(LocalDate memRegdate) {
		this.memRegdate = memRegdate;
	}
	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}
	public String getMemEmail() {
		return memEmail;
	}
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}
}
