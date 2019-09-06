package light.login.service;

import java.util.List;

import light.common.service.MemberInfo;

public interface LoginService {
	
	public int selectLogin(MemberInfo memberInfo) throws Exception;
	
}
