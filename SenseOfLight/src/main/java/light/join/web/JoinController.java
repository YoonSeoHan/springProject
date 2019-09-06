package light.join.web;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.concurrent.ListenableFutureTask;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import light.common.service.MemberInfo;
import light.common.service.MemberService;
import light.join.service.*;
import light.join.service.JoinVo;
import light.test.TestVo;
import light.test.TestVoList;

@Controller
public class JoinController {

	@Autowired
	MemberService memSvc;
	@Autowired
	JoinService joinSvc;
	
	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);

	@RequestMapping(value = "/member_Join.do", method= RequestMethod.GET)
	public String form(Model model) throws Exception {
		
		JoinVoList joinVoList = new JoinVoList();
		List<JoinVo> list = new ArrayList<JoinVo>();
		JoinVo joinVo = new JoinVo();
        list.add(joinVo);
        joinVoList.setMemberlist(list);
		model.addAttribute("joinVoList", joinVoList);
		return "member_Join.page";
	}
	
	
	@RequestMapping(value = "/joinAction.do", method = RequestMethod.POST)
	public String joinAction(@ModelAttribute("joinVoList") JoinVoList joinVoList, Model model) throws Exception {
		String url = "redirect:/solhome.do";
		List<JoinVo> list = joinVoList.getMemberlist();
		List<MemberInfo> memVo = memSvc.selectById(list.get(0).getJoin_memId());
		
		try{
			if(memVo.isEmpty()){
				/*동일한 id가 없을 경우 insertAction 진행*/
				int rs = joinSvc.insertJoinAction(list);
			} else{
				model.addAttribute("joinVoList", joinVoList);
				url = "member_Join.page";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
}
