package light.common.dao;

import java.util.List;

import light.common.service.MemberInfo;

public interface MemberDao {

	public List<MemberInfo> selectById(String memId) throws Exception;

}
