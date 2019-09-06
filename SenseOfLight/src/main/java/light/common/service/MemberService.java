package light.common.service;

import java.util.List;

import javax.inject.Inject;

import light.common.dao.MemberDao;

public interface MemberService {
	
	
	public List<MemberInfo> selectById(String memId) throws Exception;
	
}
