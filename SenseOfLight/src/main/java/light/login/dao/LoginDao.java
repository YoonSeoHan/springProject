package light.login.dao;

import java.util.List;

import light.common.service.MemberInfo;

public interface LoginDao {

	public List<MemberInfo> selectLogin(MemberInfo memberInfo);
}
