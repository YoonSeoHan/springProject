package light.join.dao;

import java.util.HashMap;
import java.util.List;

import light.common.service.MemberInfo;
import light.join.service.JoinVo;


public interface JoinDao {
	/*public int findmember(String mem_name);*/

	public int insertJoinAction(MemberInfo memVo) throws Exception;
	
	
}
