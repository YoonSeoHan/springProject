package light.mypage.orderStatus.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class orderStatusController {

	@RequestMapping(value="/order_Status.do")
	public String form(){
		
		return "order_Status.page";
	}
}
