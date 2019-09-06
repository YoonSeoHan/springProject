package light.home.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import light.common.service.Token;
@Controller
public class HomeController {
	
    /**
     * Tiles를 사용하지 않은 일반적인 형태
     */    
    @RequestMapping("/test.do")
    public String test() {
        return "test";
    }
    
    @RequestMapping("/layout/layout_test.do")
    public String test6() {
        return "layout/layout_test";
    }
    
    @RequestMapping("/layout/layout_test2.do")
    public String test7() {
        return "layout/layout_test2";
    }
    
    
    /**
     * Tiles를 사용(header, left, footer 포함)
     */        
    @RequestMapping("/testPage.do")
    public String testPage() {
        return "test.page";
    }
    
    
    /**
     * Tiles를 사용(header, left, footer 제외)
     */    
    @RequestMapping("/testPart.do")
    public String testPart() {
        return "test.part";
    }
    
    /*홈 화면*/
    @RequestMapping(value="/solhome.do")
    public String solHome(){
    	
    	return "home.page";
    }
    
    /*Token 체크*/
    @RequestMapping(value = "/Token.ajax", method=RequestMethod.POST)
    public void tokenChk(HttpServletRequest req){
    	/*System.out.println(req.getAttribute("TOKEN_KEY"));
    	req.setAttribute("TOKEN_KEY", "뭘까요");*/
    	
    	/*if (Token.isValid(req)) {
			Token.set(req);
    	}*/
    }

}
