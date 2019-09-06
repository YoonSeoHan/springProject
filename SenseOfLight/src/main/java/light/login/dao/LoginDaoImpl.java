package light.login.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import light.common.service.MemberInfo;
import light.login.service.LoginVo;

@Repository
public class LoginDaoImpl implements LoginDao{
	
	@Autowired
	SqlSession sqlsession;
	private static final String Namespace = "classpath:/sqlmap/data/loginMap";
	
	
	@Override
	public List<MemberInfo> selectLogin(MemberInfo memberInfo) {
		
		return  sqlsession.selectList(Namespace+".selectLogin", memberInfo);
	}
	
}
