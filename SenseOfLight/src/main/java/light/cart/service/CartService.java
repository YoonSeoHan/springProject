package light.cart.service;

import java.util.List;
import java.util.Map;

public interface CartService {

	public List<CartVo> selectCartList() throws Exception;
	
	public void deleteCart(Map<String, Object> params) throws Exception;

	public void insertCart(Map<String, Object> params) throws Exception;

	public void updateCart(Map<String, Object> params) throws Exception;
}
