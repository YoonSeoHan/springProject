package light.order.dao;

import java.util.List;

import light.board.service.Criteria;
import light.order.service.OrderVo;

public interface OrderDao {

	public List<OrderVo> selectOrderList() throws Exception;

	public int insertOrder(OrderVo orderVo, List<OrderVo> orderList) throws Exception;
	
	public List<OrderVo> selectOrdeyBuyList(String fromDate) throws Exception;

	public int selectTotalCount(Criteria criteria) throws Exception;

}
