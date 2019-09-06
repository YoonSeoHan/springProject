package light.product.list.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import light.file.service.FileService;
import light.file.service.FileVo;
import light.file.service.FileVoList;

@Controller
public class ListController {
	
	@Autowired
	FileService fSvc;
	
	@RequestMapping(value="/product_List.do", method=RequestMethod.GET)
	public String form(Model model, HttpServletRequest req){
		FileVoList FileVoList = new FileVoList();
		List<FileVo> list = new ArrayList<FileVo>();

		try {
			list = fSvc.getFile(req.getParameter("product"));
			FileVoList.setFilelist(list);
			model.addAttribute("fileList", FileVoList);
			String sort[] = req.getParameter("product").split(",");
			String[] product = list.get(0).getCodeValue().split("_");
			if(sort.length > 1){
				model.addAttribute("product", product[0]);
			} else{
				model.addAttribute("product", product[1]);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "product_List.page";
	}
	
}
