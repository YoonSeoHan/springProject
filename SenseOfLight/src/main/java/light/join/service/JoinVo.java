package light.join.service;

import java.util.ArrayList;
import java.util.List;

public class JoinVo {
	private String join_memId;
	private String join_memPw;
	private String memPwchk;
	private String memName;
	private String memPaddr; /*우편번호*/
	private String memDaddr; /*상세주소*/
	private String memRaddr; /*나머지주소*/
	private String memPhone1;
	private String memPhone2;
	private String memPhone3;
	private String memFemail; /*이메일 앞*/
	private String memBemail; /*이메일 뒤*/
	private String memMileage;
	
	
	public String getMemMileage() {
		return memMileage;
	}
	public void setMemMileage(String memMileage) {
		this.memMileage = memMileage;
	}
	public String getMemBemail() {
		return memBemail;
	}
	public void setMemBemail(String memBemail) {
		this.memBemail = memBemail;
	}
	public String getJoin_memId() {
		return join_memId;
	}
	public void setJoin_memId(String join_memId) {
		this.join_memId = join_memId;
	}
	public String getJoin_memPw() {
		return join_memPw;
	}
	public void setJoin_memPw(String join_memPw) {
		this.join_memPw = join_memPw;
	}
	public String getMemPwchk() {
		return memPwchk;
	}
	public void setMemPwchk(String memPwchk) {
		this.memPwchk = memPwchk;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemPaddr() {
		return memPaddr;
	}
	public void setMemPaddr(String memPaddr) {
		this.memPaddr = memPaddr;
	}
	public String getMemDaddr() {
		return memDaddr;
	}
	public void setMemDaddr(String memDaddr) {
		this.memDaddr = memDaddr;
	}
	public String getMemRaddr() {
		return memRaddr;
	}
	public void setMemRaddr(String memRaddr) {
		this.memRaddr = memRaddr;
	}
	public String getMemPhone1() {
		return memPhone1;
	}
	public void setMemPhone1(String memPhone1) {
		this.memPhone1 = memPhone1;
	}
	public String getMemPhone2() {
		return memPhone2;
	}
	public void setMemPhone2(String memPhone2) {
		this.memPhone2 = memPhone2;
	}
	public String getMemPhone3() {
		return memPhone3;
	}
	public void setMemPhone3(String memPhone3) {
		this.memPhone3 = memPhone3;
	}
	public String getMemFemail() {
		return memFemail;
	}
	public void setMemFemail(String memFemail) {
		this.memFemail = memFemail;
	}	
}
