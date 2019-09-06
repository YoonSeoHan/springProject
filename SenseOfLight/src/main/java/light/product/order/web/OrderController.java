package light.product.order.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.codec.json.Jackson2CodecSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.mysql.cj.xdevapi.JsonArray;

import light.board.service.Criteria;
import light.board.service.PageMaker;
import light.common.service.MemberInfo;
import light.common.service.MemberInfoChange;
import light.common.service.MemberService;
import light.common.service.Reflect_Method;
import light.common.service.Session;
import light.file.service.FileService;
import light.join.service.JoinVo;
import light.order.service.OrderService;
import light.order.service.OrderVo;
import light.order.service.OrderVoList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import org.json.simple.*;
import org.json.*;

@Controller
public class OrderController {
	@Autowired
	FileService fSvc;
	@Autowired
	MemberService mSvc;
	@Autowired
	OrderService oSvc;
	@Autowired
	Session ssn;
	@Autowired
	private MemberInfoChange memInfoSvc;

	@RequestMapping(value = "/product_Order.do")
	public String orderForm(Model model, HttpServletRequest req) throws Exception {

		OrderVoList orderVoList = new OrderVoList();
		List<OrderVo> list = new ArrayList<OrderVo>();
		list = oSvc.selectOrderList();
		
		orderVoList.setOrderlist(list);

		model.addAttribute("orderVoList", orderVoList);
		return "product_Order.page";
	}

	@RequestMapping(value = "/OrderBuyList.ajax", method = RequestMethod.POST)
	public void orderBuyList(String fromDate, HttpServletResponse res) throws Exception {
		Criteria criteria = new Criteria();
		criteria.setFromDate(fromDate);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		/*해당 날짜의 개수를 구함*/
		int test = oSvc.selectTotalCount(criteria);
		pageMaker.setTotalCount(test);
		/*해당 날짜의 정보를 구함*/
		List<OrderVo> list = new ArrayList<OrderVo>();
		list = oSvc.selectOrdeyBuyList(fromDate);	
	
		JSONArray cell = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i = 0; i < list.size(); i++){
			obj.put("orderNum", list.get(i).getOrderNum());
			obj.put("orderDtlnum", list.get(i).getOrderDtlnum());
			obj.put("productNum", list.get(i).getProductNum());
			obj.put("productCount", list.get(i).getProductCount());
			obj.put("productName", list.get(i).getProductName());
			obj.put("productAccount", list.get(i).getProductAccount());
			obj.put("productOption1", list.get(i).getProductOption1());
			obj.put("productOption2", list.get(i).getProductOption2());
			obj.put("productPrice", list.get(i).getProductPrice());
			obj.put("imgList", list.get(i).getImgList());
			obj.put("codeValue", list.get(i).getCodeValue());
			if(i ==0){
	        	obj.put("StartPage", pageMaker.getStartPage());
	    	    obj.put("EndPage", pageMaker.getEndPage());
	    	    obj.put("prev", pageMaker.isPrev());
	    	    obj.put("next", pageMaker.isNext());
	        }
			cell.add(obj);
		}
			
		try {
			res.setContentType("application/json; charset=UTF-8");
			PrintWriter pw = res.getWriter();
			pw.print(cell.toString());
			pw.flush();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/MemberList.ajax", method = RequestMethod.POST)
	public void memberList(HttpServletResponse res) throws Exception {
		String memId = ssn.sessionChk();

		List<MemberInfo> list = mSvc.selectById(memId);
		JSONArray cell = new JSONArray();

		JoinVo joinVo = memInfoSvc.ChangeInfoServiceOrigin(list);

		JSONObject obj = new JSONObject();
		obj.put("memId", joinVo.getJoin_memId());
		obj.put("memName", joinVo.getMemName());
		obj.put("memPaddr", joinVo.getMemPaddr());
		obj.put("memDaddr", joinVo.getMemDaddr());
		obj.put("memRaddr", joinVo.getMemRaddr());
		obj.put("memPhone1", joinVo.getMemPhone1());
		obj.put("memPhone2", joinVo.getMemPhone2());
		obj.put("memPhone3", joinVo.getMemPhone3());
		obj.put("memFemail", joinVo.getMemFemail());
		obj.put("memBemail", joinVo.getMemBemail());
		obj.put("memMileage", joinVo.getMemMileage());
		cell.add(obj);
		try {
			res.setContentType("application/json; charset=UTF-8");
			PrintWriter pw = res.getWriter();
			pw.print(cell.toString());
			pw.flush();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/orderAction.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void orderAction(@RequestBody List<Map<String, Object>> json, HttpServletResponse res,
			HttpServletRequest req) throws Exception {
		int rs = oSvc.insertOrder(json);
		
		if(rs >= 1){
			/*성공*/
			/*주문 완료*/
		} else {
			/*실패*/
			/*어디로 페이지이동할까 ?*/
		}
		
		JSONArray cell = new JSONArray();
		JSONObject obj = new JSONObject();
		
		cell.add(obj);
		try {
			res.setContentType("application/json; charset=UTF-8");
			PrintWriter pw = res.getWriter();
			pw.print(cell.toString());
			pw.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
