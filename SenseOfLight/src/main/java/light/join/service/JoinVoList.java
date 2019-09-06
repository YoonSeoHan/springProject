package light.join.service;

import java.util.ArrayList;
import java.util.List;

public class JoinVoList {
	private List<JoinVo> memberlist = new ArrayList<JoinVo>();

	public List<JoinVo> getMemberlist() {
		return memberlist;
	}

	public void setMemberlist(List<JoinVo> memberlist) {
		this.memberlist = memberlist;
	}

}
