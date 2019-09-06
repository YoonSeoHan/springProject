package light.login.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.common.service.MemberInfo;
import light.login.dao.LoginDao;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDao logindao;
	private static int MEM_LOGIN_SUCCES = 0;
	private static int MEM_LOGIN_FAIL= 1;
	private static int MEM_LOGIN_NOTINFO = 2;
	private static int MEM_LOGIN_FAIL_LOGIC = 3;
	
	@Override
	public int selectLogin(MemberInfo memberInfo) throws Exception {
		List<MemberInfo> list = logindao.selectLogin(memberInfo);
		int rs = MEM_LOGIN_FAIL_LOGIC;
		/*회원 정보 확인*/
		if(list.isEmpty() == true){
			rs = MEM_LOGIN_NOTINFO;
		} else {
			/*아이디 패스워드 일치여부 확인*/
			if(list.get(0).getMemId().equals(memberInfo.getMemId()) && 
					list.get(0).getMemPw().equals(memberInfo.getMemPw())){
				rs = MEM_LOGIN_SUCCES;
			} else {
				rs = MEM_LOGIN_FAIL;
			}
		}
		return rs;
	}

}
