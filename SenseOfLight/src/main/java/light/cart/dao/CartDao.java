package light.cart.dao;

import java.util.List;
import java.util.Map;

import light.cart.service.CartVo;

public interface CartDao {

	public List<CartVo> selectCartList() throws Exception;
	
	public void deleteCart(Map<String, Object> params) throws Exception;
	
	public void insertCart(Map<String, Object> params) throws Exception;

	public void updateCart(Map<String, Object> params) throws Exception;
}
