package light.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class Session {
	public  String sessionChk(){
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		HttpSession session = req.getSession(true);
		String user = (String) session.getAttribute("user");

		if (user == null)
			user = "nonMember";
		
		return user;
	}
}
