package light.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import light.board.service.Criteria;

public interface OrderService {
	
	public List<OrderVo> selectOrderList() throws Exception;
	
	public int insertOrder(List<Map<String, Object>> json) throws Exception;
	
	public List<OrderVo> selectOrdeyBuyList(String fromDate) throws Exception;

	public int selectTotalCount(Criteria criteria) throws Exception;
}
