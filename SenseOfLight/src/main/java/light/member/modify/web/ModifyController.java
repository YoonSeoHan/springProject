package light.member.modify.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ModifyController {
	@RequestMapping(value = "/member_Modify.do")
	public String form(){
		return "member_Modify.page";
	}
}
