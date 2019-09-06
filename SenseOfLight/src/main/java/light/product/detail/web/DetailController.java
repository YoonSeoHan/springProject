package light.product.detail.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import light.board.service.BoardService;
import light.board.service.BoardVo;
import light.board.service.BoardVoList;
import light.board.service.Criteria;
import light.board.service.PageMaker;
import light.file.service.FileService;
import light.file.service.FileVo;
import light.file.service.FileVoList;
import light.join.service.JoinVoList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class DetailController {
	@Autowired
	FileService fSvc;
	@Autowired
	BoardService bSvc;
	
	PageMaker pageMaker = new PageMaker();
	
	@RequestMapping(value = "/product_Detail.do", method = RequestMethod.GET)
	public String detailForm(HttpServletRequest req, Model model, Criteria criteria)  throws Exception{
		String productNum = req.getParameter("productNum");
		
		try{
			if(!req.getParameter("list").isEmpty()){
				model.addAttribute("list", "list");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		BoardVoList BoardVoList = new BoardVoList();
		
		pageMaker.setCriteria(criteria);

		pageMaker.setTotalCount(bSvc.selectTotalCount(criteria, productNum));
		List<BoardVo> boardList = bSvc.selectBoardList(criteria, productNum);
		
		List<FileVo> fileList = fSvc.getFile(productNum);
		
		BoardVoList.setBoardlist(boardList);
		model.addAttribute("fileVo", fileList);
		model.addAttribute("boardList", BoardVoList);
		model.addAttribute("pageMaker", pageMaker);
		return "product_Detail.page";
	}

	@RequestMapping(value = "/boardList.ajax", method = RequestMethod.GET)
	public void boardList(HttpServletRequest req, Criteria criteria, Model model, HttpServletResponse res) throws Exception {
		String productNum = req.getParameter("productNum");
		JSONArray cell = new JSONArray();
		
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(bSvc.selectTotalCount(criteria, productNum));
		
		List<BoardVo> list = bSvc.selectBoardList(criteria, productNum);
		
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
	        obj.put("boardDate", temp);
	        obj.put("depth", boardVo.getDepth());
	        obj.put("boardOrgContents", boardVo.getBoardOrgContents());
	        if(i ==0){
	        	obj.put("StartPage", pageMaker.getStartPage());
	    	    obj.put("EndPage", pageMaker.getEndPage());
	    	    obj.put("prev", pageMaker.isPrev());
	    	    obj.put("next", pageMaker.isNext());
	        }
	        cell.add(obj);
	    }
	    pageMaker.getStartPage();
	    
	    try {
	        res.setContentType("application/json; charset=UTF-8");
	        PrintWriter pw = res.getWriter();
	        pw.print(cell.toString());
	        pw.flush();
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	@RequestMapping(value="/stockChk.ajax", method = RequestMethod.POST)
	public void stockChk(@RequestBody  Map<String, Object> params, HttpServletResponse res) throws Exception{
		System.out.println("productNum : "+String.valueOf(params.get("productNum")));
		System.out.println("productCount : "+String.valueOf(params.get("productCount")));
		boolean rs = fSvc.stockChk(String.valueOf(params.get("productNum")), String.valueOf(params.get("productCount")));
		JSONObject obj = new JSONObject();
		System.out.println("rs : " + rs);
		obj.put("stockChk", rs);
		try {
			res.setContentType("application/json; charset=UTF-8");
			PrintWriter pw = res.getWriter();
			pw.print(obj.toString());
			pw.flush();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
