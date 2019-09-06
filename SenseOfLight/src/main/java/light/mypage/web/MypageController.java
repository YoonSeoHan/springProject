package light.mypage.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MypageController {
	
	@RequestMapping(value = "/myPage.do")
	public String form(){
		
		
		return "myPage.page";
	}
}
