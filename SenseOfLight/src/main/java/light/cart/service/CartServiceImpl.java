package light.cart.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.cart.dao.CartDao;
import light.common.service.ProductPriceConvert;

@Service
public class CartServiceImpl implements CartService{
	@Autowired
	CartDao cDao;
	@Autowired
	ProductPriceConvert pCvt;
	public void insertCart(Map<String, Object> params) throws Exception{
		cDao.insertCart(params);
	}
	public List<CartVo> selectCartList() throws Exception{
		List<CartVo> list = new ArrayList<CartVo>();
		list = cDao.selectCartList();
		int amount = 0;
		for(int i = 0; i < list.size(); i++){
			String AddPrice = pCvt.AdditionalCost(list.get(i).getProductOption2());
			String ConsuPrice = "";
			String TotalPrice = "";
			String MileAge = "";
			String Discount = list.get(i).getProductDiscount();
			String[] temp = new String[2];
			/*할인 확인*/

			if(Discount!=null){
				temp[0] = list.get(i).getProductPrice();
				temp[1] = Discount;
				ConsuPrice = pCvt.ConsuCalc(temp);
			} else {
				ConsuPrice = list.get(i).getProductPrice();
			}

			/*추가비용확인*/
			if(!AddPrice.isEmpty()){
				temp[0] = ConsuPrice;
				temp[1] = AddPrice;
				ConsuPrice = pCvt.TotalCalc(temp);
			}
			
			/*총금액 x 개수*/
			TotalPrice = pCvt.NumToString(pCvt.StringToNum(ConsuPrice) * list.get(i).getProductCount());
			amount += pCvt.StringToNum(TotalPrice);
			/*마일리지*/
			MileAge = pCvt.MileageCalc(TotalPrice);
			
			list.get(i).setProductPrice(pCvt.CommaConvert(ConsuPrice));
			list.get(i).setProductMileage(pCvt.CommaConvert(MileAge));
			list.get(i).setProductPriceTotal(pCvt.CommaConvert(TotalPrice));
			
			if(i == list.size()-1){
				list.get(0).setProductAmount(pCvt.CommaConvert(pCvt.NumToString(amount)));
			}
		}
		
		return list; 
	}
	
	public void deleteCart(Map<String, Object> params) throws Exception{		
		
		cDao.deleteCart(params);
	}
	
	public void updateCart(Map<String, Object> params) throws Exception{
		
		cDao.updateCart(params);
	}
}
