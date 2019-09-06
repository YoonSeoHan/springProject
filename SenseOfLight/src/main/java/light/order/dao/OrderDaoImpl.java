package light.order.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import light.board.service.Criteria;
import light.common.service.Session;
import light.order.service.OrderVo;

@Repository
public class OrderDaoImpl implements OrderDao{
	@Autowired
	SqlSession sqlsession;
	@Autowired
	Session ssn;
	@Autowired
	private static final String Namespace = "classpath:/sqlmap/data/orderMap";
	
	@Override
	public List<OrderVo> selectOrderList() throws Exception{
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String memId = ssn.sessionChk();
		
		Enumeration<?> params = req.getParameterNames();
		List<OrderVo> list = new ArrayList<OrderVo>();
		OrderVo orderVo = new OrderVo();
		Map<String, Object> map = new HashMap<String, Object>();
		int i = 0;
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    if(name.contains("productNum")){
		    	orderVo.setProductNum(Integer.parseInt(req.getParameter(name)));
		    } else if(name.contains("productCount")){
		    	orderVo.setProductCount(Integer.parseInt(req.getParameter(name)));
		    }
		    i++;
		    if(i % 2 == 0){
		    	list.add(orderVo);
		    	orderVo = new OrderVo();
		    }
		}

		map.put("list", list);
		map.put("memId", memId);
		int count[] = new int[list.size()];
		
		for(int j = 0; j < count.length; j++){
			count[j] = list.get(j).getProductCount();
		}
		
		list = sqlsession.selectList(Namespace + ".selectOrderList", map);
		for(int x = 0; x < count.length; x++){
			list.get(x).setProductCount(count[x]);
		}

		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = SQLException.class)
	/*트랜잭션이 없을경우 새로 생성, SQLException 발생시 롤백*/
	/*트랜잭션이 실행중인 상태에서 다른 메소드를 실행시 현재 트랜잭션 범위에서 쿼리를 실행(오류시 트랜잭션 설정을 안한 메소드라도 롤백이됨)*/
	public int insertOrder(OrderVo orderVo, List<OrderVo> orderList) throws Exception{
		if(orderVo.getRecipientMessage() == null){
			orderVo.setRecipientMessage("");
		}
		
		
		/*기본주문*/
		sqlsession.insert(Namespace + ".insertOrders", orderVo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		int orderNum = orderVo.getOrderNum();
		
		map.put("orderNum", orderNum);
		map.put("list", orderList);
		
		String memId = ssn.sessionChk();
		map.put("memId", memId);
		/*상세주문*/
		sqlsession.insert(Namespace + ".insertOrderDetails", map);
		map.remove("list");
		
		
		/*주문 상세번호*/
		orderList = sqlsession.selectList(Namespace + ".selectOrderDtlNum", orderNum);
		map.put("list", orderList);
		
		/*주문 상태*/
		int rs = sqlsession.insert(Namespace + ".insertOrderStatus", map);
		
		/*insert되는 row수만큼 return되므로 1이상이면 성공으로 간주*/
		if(rs >= 1){
			rs = 1;
		}
		return rs;
	}
	
	@Override
	public List<OrderVo> selectOrdeyBuyList(String fromDate) throws Exception{
		
		List<OrderVo> list = new ArrayList<OrderVo>();
		String memId = ssn.sessionChk();
		
		Map<String, Object> map = new HashMap<>();
		map.put("memId", memId);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate());
	
		list = sqlsession.selectList(Namespace + ".selectOrderBuyList", map);
	
		for(int i = 0; i < list.size(); i++){
			/*System.out.println(ToStringBuilder.reflectionToString(list.get(i), ToStringStyle.MULTI_LINE_STYLE));*/
		}
		return list;
	}
	
	@Override
	public int selectTotalCount(Criteria criteria) throws Exception{
		criteria.setToDate(toDate());
		String memId = ssn.sessionChk();
		
		Map<String, Object> map = new HashMap<>();
		map.put("memId", memId);
		map.put("criteria", criteria);
		
		int test = sqlsession.selectOne(Namespace + ".selectTotalCount", map);
		return test;
	}
	
	
	private String toDate(){
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		String toDate = format.format(date);
		return toDate;
	}
}
