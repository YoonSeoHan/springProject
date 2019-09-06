package light.login.web;

import java.lang.ProcessBuilder.Redirect;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import light.common.service.MemberInfo;
import light.join.web.JoinController;
import light.login.service.LoginService;
import light.login.service.LoginVo;



@Controller
public class LoginController {
	
	@Autowired
	LoginService loginSvc;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(value="/loginAction.do")
	@ResponseBody
	public String selectLoginAction (MemberInfo memVo, HttpSession session) throws Exception{
		int rs = loginSvc.selectLogin(memVo);
		/*redirect를 위한 url 작업 (뒤에 페이지명만 따로 출력)*/
		String url = memVo.getUrl().substring(memVo.getUrl().lastIndexOf("/"), memVo.getUrl().length());
		Cookie cookie = null;
		if(rs == 1){
			/*로그인 성공*/
			session.setAttribute("user", memVo.getMemId());
			return url;
		} else if(rs == 0){
			/*로그인 실패*/
			
		} else{
			/*정보 없음*/
		}
		return "solhome.do";
	}
	
	
	
	

}
