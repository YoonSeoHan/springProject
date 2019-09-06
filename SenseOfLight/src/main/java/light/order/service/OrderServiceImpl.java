package light.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.board.service.Criteria;
import light.board.service.PageMaker;
import light.common.service.ProductPriceConvert;
import light.common.service.Reflect_Method;
import light.order.dao.OrderDao;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	OrderDao oDao;
	@Autowired
	ProductPriceConvert pCvt;

	Reflect_Method<OrderVo> Reflect;

	public List<OrderVo> selectOrderList() throws Exception {
		List<OrderVo> list = new ArrayList<OrderVo>();
		list = oDao.selectOrderList();
		int amount = 0;
		int Mileageamount = 0;
		for (int i = 0; i < list.size(); i++) {
			String AddPrice = pCvt.AdditionalCost(list.get(i).getProductOption2());
			String ConsuPrice = "";
			String TotalPrice = "";
			String MileAge = "";
			String Discount = list.get(i).getProductDiscount();
			String[] temp = new String[2];
			/* 할인 확인 */

			if (Discount != null) {
				temp[0] = list.get(i).getProductPrice();
				temp[1] = Discount;
				ConsuPrice = pCvt.ConsuCalc(temp);
			} else {
				ConsuPrice = list.get(i).getProductPrice();
			}

			/* 추가비용확인 */
			if (!AddPrice.isEmpty()) {
				temp[0] = ConsuPrice;
				temp[1] = AddPrice;
				ConsuPrice = pCvt.TotalCalc(temp);
			}

			/* 총금액 x 개수 */
			TotalPrice = pCvt.NumToString(pCvt.StringToNum(ConsuPrice) * list.get(i).getProductCount());
			amount += pCvt.StringToNum(TotalPrice);
			/* 마일리지 */
			MileAge = pCvt.MileageCalc(TotalPrice);
			Mileageamount += pCvt.StringToNum(MileAge);

			list.get(i).setProductPrice(pCvt.CommaConvert(ConsuPrice));
			list.get(i).setProductMileage(pCvt.CommaConvert(MileAge));
			list.get(i).setProductPriceTotal(pCvt.CommaConvert(TotalPrice));

			if (i == list.size() - 1) {
				list.get(0).setProductAmount(pCvt.CommaConvert(pCvt.NumToString(amount)));
				list.get(0).setProductMileageAmount(pCvt.CommaConvert(pCvt.NumToString(Mileageamount)));
			}
		}
		return list;
	}

	public int insertOrder(List<Map<String, Object>> json) throws Exception {
		List<OrderVo> orderList = new ArrayList<OrderVo>();
		Map<String, Object> productMap = new HashMap<String, Object>();
		OrderVo orderVo = new OrderVo();
		Reflect_Method<OrderVo> reflect = new Reflect_Method<OrderVo>(orderVo);
		String temp = "";
		String temp1 = "";
		String value1 = "";
		for (int i = 0; i < json.size(); i++) {
			
			for (Entry<String, Object> elem : json.get(i).entrySet()) {
				String key = elem.getKey();
				String value = String.valueOf(elem.getValue());
				if(value.contains("product") || value.contains("order") || value.contains("recipient")){
					temp = value;
				} else {
					if(temp.contains("product")){
						if(temp.equals("productNum") || temp.equals("productCount")){
							reflect.methodInvoke(orderVo, temp, Integer.parseInt(value));
						} else{
							value = value.replaceAll(",", "");
							reflect.methodInvoke(orderVo, temp, value);
						}
					}
					
					if(temp.contains("order") || temp.contains("recipient")){
						if(i < json.size()-1){
							for(Entry<String, Object> elem2 : json.get(i+1).entrySet()){
								if(elem2.getKey() == "name")
									temp1 = String.valueOf(elem2.getValue());
							}
						}
						
						if(!temp.equals(temp1)){
							if(!value.equals("")){
								value1 += value;
								value = value1;
							}
							reflect.methodInvoke(orderVo, temp, value);
							value1="";
						} else{
							if(temp.contains("Phone") || temp.contains("Landline")){
								value1 = value1 + value + "-";
							} else if(temp.contains("Email")){
								value1 = value1 + value + "@";
							}
						}
					}
				}
				
				if(temp.equals("productPriceTotal") && key.equals("value")){
					
					orderList.add(orderVo);
					orderVo = new OrderVo();
				}
			}
		}
		oDao.insertOrder(orderVo,orderList);
		return 1;
	}
	
	
	public List<OrderVo> selectOrdeyBuyList(String fromDate) throws Exception{
		
		List<OrderVo> list = oDao.selectOrdeyBuyList(fromDate);
	
		return list;
	}
	
	public int selectTotalCount(Criteria criteria) throws Exception{
		return oDao.selectTotalCount(criteria);
	}

}
