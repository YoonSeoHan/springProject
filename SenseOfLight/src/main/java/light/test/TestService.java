package light.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import light.common.service.MemberInfo;

@Repository
public class TestService {
	@Autowired
	SqlSession sqlsession;
	private static final String Namespace = "classpath:/sqlmap/data/loginMap";
	
	
	

}
