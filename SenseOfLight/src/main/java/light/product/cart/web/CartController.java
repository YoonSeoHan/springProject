package light.product.cart.web;

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
import org.apache.commons.lang.builder.ToStringStyle;import org.apache.log4j.DailyRollingFileAppender;
import org.omg.CORBA.OBJ_ADAPTER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import light.cart.service.CartVoList;
import light.board.service.BoardVo;
import light.cart.service.CartService;
import light.cart.service.CartVo;
import light.common.service.Token;
import light.domain.SessionGenerator;
import light.join.service.JoinVoList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
@Controller
public class CartController {
	@Autowired
	CartService cSvc;

	@RequestMapping(value = "/product_Cart.do", method = RequestMethod.GET)
	public String cartForm()throws Exception {
		
		return "product_Cart.page";
	}
	
	@RequestMapping(value = "/CartList.ajax", method = RequestMethod.POST)
	public void cartList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		JSONArray cell = new JSONArray();
		List<CartVo> list = new ArrayList<CartVo>();

		list = cSvc.selectCartList();

		CartVo cartVo;
		 for(int i=0 ; i<list.size() ; i++){
		    	cartVo = list.get(i);
		        JSONObject obj = new JSONObject();
		        obj.put("productNum", cartVo.getProductNum());
		        obj.put("productName", cartVo.getProductName());
		        obj.put("productAccount", cartVo.getProductAccount());
		        obj.put("productPriceTotal", cartVo.getProductPriceTotal());
		        obj.put("productPrice", cartVo.getProductPrice());
		        obj.put("productOption1", cartVo.getProductOption1());
		        obj.put("productOption2", cartVo.getProductOption2());
		        obj.put("productMileage", cartVo.getProductMileage());
		        obj.put("imgList", cartVo.getImgList());
		        obj.put("productCount", cartVo.getProductCount());
		        obj.put("memId", cartVo.getMemId());
		        if(i == 0){
		        	obj.put("productAmount", cartVo.getProductAmount());
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
	@RequestMapping(value = "/CartService.ajax", method = RequestMethod.POST)
	public void cartService(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res) throws Exception{
		/*현재페이지 새로고침 방지*/
		/*if (Token.isValid(req)) {
			Token.set(req);
			req.setAttribute("TOKEN_SAVE_CHECK", "TRUE");
			
		} else {
			req.setAttribute("TOKEN_SAVE_CHECK", "FALSE");
		}
		*/
		JSONObject obj = new JSONObject();
		
		if(params.get("CRUD").equals("delete")){
			cSvc.deleteCart(params);
			obj.put("message", "삭제되었습니다.");
		} else if(params.get("CRUD").equals("update")){
			cSvc.updateCart(params);
			obj.put("message", "수량이 변경되었습니다.");
		} else if(params.get("CRUD").equals("insert")){
			cSvc.insertCart(params);
		} else{
			
		}
		
		try {
        	PrintWriter pw = res.getWriter();
	        pw.print(obj.toString());
	        pw.flush();
        	
		} catch (Exception e) {
			e.printStackTrace();
		}
		res.setContentType("application/json; charset=UTF-8");
		
	}
	
}
