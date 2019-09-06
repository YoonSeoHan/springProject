package light.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonFormat;

import light.board.service.BoardService;
import light.board.service.BoardVo;
import light.board.service.Criteria;
import light.domain.*;
import light.board.service.PageMaker;
import light.domain.SessionGenerator;
import light.join.service.JoinVo;
import light.join.service.JoinVoList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class TestController {
	@Autowired
	TestService svc;
	@Autowired
	BoardService bSvc;
	@Autowired
	SessionGenerator ssnGeneraotr;
	
	
	
	
	@RequestMapping(value="/TestView.do", method= RequestMethod.GET)
	public String form1(@ModelAttribute("TestVo") TestVo testVo, HttpServletRequest req, Model model) throws Exception{
		List<TestVo> list = new ArrayList<TestVo>();
		testVo.setTest1("리스트 퍼스트라운드1");
		testVo.setTest2("리스트 퍼스트라운드2");
		testVo.setTest3("리스트 퍼스트라운드3");
		list.add(0, testVo);
		testVo = new TestVo();
		testVo.setTest1("리스트 세컨드라운드1");
		testVo.setTest2("리스트 세컨드라운드2");
		testVo.setTest3("리스트 세컨드라운드3");
		list.add(1, testVo);
		TestVoList testList = new TestVoList();

		
		testList.setMemberlist(list);
		
		model.addAttribute("testList", testList);
		
		return "TestView.part";
	}
	
	@RequestMapping(value="/ViewTest.do", method= RequestMethod.POST)
	public String form(@RequestParam Map<String, Object> test, HttpServletRequest req,HttpSession ssn) throws Exception{
		Enumeration params = req.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +req.getParameter(name));
		}
		System.out.println("----------------------------");
		
		
		
		/*System.out.println(testVo.length);*/
		
		return "ViewTest.part";
	}
	
	@RequestMapping(value="/testAction.do", method= RequestMethod.GET)
	public String Action(@ModelAttribute("TestVo") TestVo testVo, HttpServletRequest req, Model model){
		
		
		return "TestView.part";
	}
	
	
	
	@RequestMapping(value = "test.ajax", method = RequestMethod.GET)
	public void ajaxAction(HttpServletRequest req, Criteria criteria, Model model, HttpServletResponse res) throws Exception {
		
		String productNum = req.getParameter("productNum");
		int page = Integer.parseInt(req.getParameter("page"));
		System.out.println("product : " + productNum);
		System.out.println("criteria : " + criteria.getPage());
		System.out.println("page : " + page);
		
		
		
		List<BoardVo> list = bSvc.selectBoardList(criteria, productNum);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(ToStringBuilder.reflectionToString(list.get(i), ToStringStyle.MULTI_LINE_STYLE));
		}
		
		JSONObject jsonObject = new JSONObject();
	    JSONArray cell = new JSONArray();
	    for(int i=0 ; i<list.size() ; i++){
	    	BoardVo boardVo = list.get(i);
	        JSONObject obj = new JSONObject();
	        obj.put("boardNum", boardVo.getBoardNum());
	        obj.put("boardSeq", boardVo.getBoardSeq());
	        obj.put("boardSubject", boardVo.getBoardSubject());
	        obj.put("boardContents", boardVo.getBoardContents());
	        obj.put("boardCnt", boardVo.getBoardCnt());
	        obj.put("boardWriter", boardVo.getBoardWriter());
	        obj.put("boardFemail", boardVo.getBoardFemail());
	        obj.put("boardBemail", boardVo.getBoardBemail());
	        obj.put("boardEmail", boardVo.getBoardEmail());
	        obj.put("productNum", boardVo.getProductNum());
	        String temp = String.valueOf(boardVo.getBoardDate());
	        System.out.println("temp : " + temp);
	        obj.put("boardDate", temp);
	        cell.add(obj);
	    }
	    
	    jsonObject.put("rows", cell);
	    System.out.println(cell);
	    System.out.println(jsonObject);

	    try {
	        res.setContentType("application/json; charset=UTF-8");
	        PrintWriter pw = res.getWriter();
	        /*pw.print(jsonObject.toString());*/
	        pw.print(cell.toString());
	        pw.flush();
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    } 
	    
		
	}
}
