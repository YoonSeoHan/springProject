package light.cart.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;



import light.cart.service.CartVo;
import light.common.service.Session;

@Repository
public class CartDaoImpl implements CartDao {
	@Autowired
	SqlSession sqlSession;
	@Autowired
	private static final String Namespace = "classpath:/sqlmap/data/cartMap";
	@Autowired
	Session ssn;
	
	@Override
	public void insertCart(Map<String, Object> params) throws Exception{
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String memId = ssn.sessionChk();
		
		String temp = params.get("params").toString();
		String array[];
		params = new HashMap<String, Object>();
		
		temp = temp.substring(1, temp.length()-1).replaceAll(" ", "");
		array = temp.split(",");
		
		
		params.put("productNum", array[0]);
		params.put("productCount", array[1]);
		params.put("memId", memId);
		
		sqlSession.insert(Namespace + ".insertCart", params);
		
		/*처음 진입한 페이지(TRUE)면 INSERT작업*/
		/*if("TRUE".equals(req.getAttribute("TOKEN_SAVE_CHECK")))*/
			
	}
	
	@Override
	public List<CartVo> selectCartList() throws Exception {
		String memId = ssn.sessionChk();
		List<CartVo> list = new ArrayList<CartVo>();
		
		list = sqlSession.selectList(Namespace + ".selectCartList", memId);

		return list;
	}
	
	@Override
	public void deleteCart(Map<String, Object> params) throws Exception{
		String memId = ssn.sessionChk();
		String temp = params.get("params").toString();
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> list = new ArrayList<String>();
		String array[];
		
		/*단일 삭제버튼 클릭스 바로 삽입*/
		if(temp.length() == 1){
			list.add(0, temp);
		} else if(temp.equals("all")){
			list.add(0, "all");
		} else {
			/*map의 직렬화된 내용을 list화 시킨후 다시 map에 삽입*/
			temp = temp.substring(1, temp.length()-1).replaceAll(" ", "");
			array = temp.split(",");
			list = new ArrayList<String>(Arrays.asList(array));
		}
		
		map.put("productNum", list);
		map.put("memId", memId);
		
		sqlSession.delete(Namespace + ".deleteCart", map);
	}
	
	@Override
	public void updateCart(Map<String, Object> params) throws Exception{
		String memId = ssn.sessionChk();
		String temp = params.get("params").toString();
		String array[];
		params = new HashMap<String, Object>();
		
		
		temp = temp.substring(1, temp.length()-1).replaceAll(" ", "");
		array = temp.split(",");
		params.put("productNum", array[0]);
		params.put("productCount", array[1]);
		params.put("memId", memId);
		
		sqlSession.update(Namespace + ".updateCart", params);
	}
	
	
}
