package light.board.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.cj.result.Field;

import light.board.service.BoardService;
import light.board.service.BoardVo;
import light.product.detail.web.DetailController;

@Controller
public class BoardController {

	@Autowired
	BoardService bSvc;
	@Autowired
	DetailController dCon;

	@RequestMapping(value = "/board_WriteForm.do", method = RequestMethod.GET)
	public String insertForm(Model model, HttpServletRequest req) throws Exception {
		BoardVo BoardVo = new BoardVo();
		BoardVo.setProductNum(Integer.parseInt(req.getParameter("productNum")));
		model.addAttribute("BoardVo", BoardVo);
		model.addAttribute("productNum", req.getAttribute("productNum"));
		model.addAttribute("action", req.getParameter("action"));
		return "board_WriteForm.page";
	}

	@RequestMapping(value = "/board_RepleForm.do", method = RequestMethod.GET)
	public String insertRepleForm(@ModelAttribute("BoardVo") BoardVo boardVo, Model model, HttpServletRequest req) 
			throws Exception {
		boardVo.setProductNum(Integer.parseInt(req.getParameter("productNum")));
		boardVo.setBoardSeq(Integer.parseInt(req.getParameter("boardSeq")));
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("action", req.getParameter("action"));
		return "board_WriteForm.page";
	}
	
	@RequestMapping(value = "/board_UpdateForm.do", method = RequestMethod.GET)
	public String updateForm(@ModelAttribute("BoardVo") BoardVo boardVo, Model model, HttpServletRequest req)
			throws Exception {
		boardVo.setProductNum(Integer.parseInt(req.getParameter("productNum")));
		boardVo.setBoardSeq(Integer.parseInt(req.getParameter("boardSeq")));
		boardVo = bSvc.selectBoard(boardVo);
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("action", req.getParameter("action"));
		return "board_WriteForm.page";
	}
	
	@RequestMapping(value = "/boardPwdChk.ajax", method = RequestMethod.POST)
	@ResponseBody
	public boolean pwdChk (@RequestBody Map<String, Object> params, HttpServletRequest req) throws Exception{
		boolean rs = bSvc.pwdChk(params);
		return rs;
	}
	
	
	@RequestMapping(value = "/insertAction.do", method = RequestMethod.POST)
	public String insertAction(@ModelAttribute("BoardVo") BoardVo boardVo, Model model, HttpServletRequest req)
			throws Exception {
		bSvc.insertBoard(boardVo);
		
		model.addAttribute("list", "list");
		model.addAttribute("productNum", boardVo.getProductNum());
		return "redirect:product_Detail.do";
	}
	
/*	private Model board_common(Model model, BoardVo boardVo){
		model.addAttribute("list", "list");
		model.addAttribute("productNum", boardVo.getProductNum());
		return model;
	}
*/
	
	@RequestMapping(value = "/updateAction.do", method = RequestMethod.POST)
	public String updateAction(@ModelAttribute("BoardVo") BoardVo boardVo, Model model)
			throws Exception {
		bSvc.updateBoard(boardVo);
		model.addAttribute("list", "list");
		model.addAttribute("productNum", boardVo.getProductNum());
		
		return "redirect:product_Detail.do";
	}
	
	@RequestMapping(value = "/deleteAction.do", method = RequestMethod.POST)
	public String deleteAction(@ModelAttribute("BoardVo") BoardVo boardVo, Model model)
			throws Exception {
		bSvc.deleteBoard(boardVo);
		model.addAttribute("list", "list");
		model.addAttribute("productNum", boardVo.getProductNum());
		return "redirect:product_Detail.do";
	}
	
	@RequestMapping(value = "/insertRepleAction.do", method = RequestMethod.POST)
	public String insertRepleAction(@ModelAttribute("BoardVo") BoardVo boardVo, Model model, HttpServletRequest req)
			throws Exception {
		List<BoardVo> list = new ArrayList<BoardVo>();
		list = bSvc.insertRepleBoard(boardVo);
		model.addAttribute("list", "list");
		model.addAttribute("productNum", boardVo.getProductNum());
		return "redirect:product_Detail.do";
	}
	
	
}
