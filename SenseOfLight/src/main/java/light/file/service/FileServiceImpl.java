package light.file.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.file.dao.FileDao;
import light.common.service.ProductPriceConvert;;

@Service
public class FileServiceImpl implements FileService{
	@Autowired
	FileDao fDao;
	@Autowired
	ProductPriceConvert pCvt;
	
	public List<FileVo> getFile (String product) throws Exception{
		
		List<FileVo> list = new ArrayList<FileVo>();
		list = fDao.getFile(product);
		
		/*다른 값들도 들고왔는지 체크용*/
		if(list.size() < 2){
			String AddPrice = pCvt.AdditionalCost(list.get(0).getProductOption2());
			String ConsuPrice = "";
			String TotalPrice = "";
			String MileAge = "";
			String Discount = list.get(0).getProductDiscount();
			String[] temp = new String[2];
			/*할인 확인*/
			if(Discount!=null){
				temp[0] = list.get(0).getProductPrice();
				temp[1] = Discount;
				ConsuPrice = pCvt.ConsuCalc(temp);
			} else {
				ConsuPrice = list.get(0).getProductPrice();
			}
			
			/*추가비용확인*/
			if(!AddPrice.isEmpty()){
				temp[0] = ConsuPrice;
				temp[1] = AddPrice;
				TotalPrice = pCvt.TotalCalc(temp);
			} else {
				TotalPrice = ConsuPrice;
			}
			
			/*마일리지*/
			MileAge = pCvt.MileageCalc(TotalPrice);
		
			list.get(0).setProductConsuPrice(pCvt.CommaConvert(ConsuPrice));
			list.get(0).setProductPriceTotal(pCvt.CommaConvert(TotalPrice));
			list.get(0).setProductMileage(pCvt.CommaConvert(MileAge));
			list.get(0).setProductPrice(pCvt.CommaConvert(list.get(0).getProductPrice()));
			
		}
		
		return list;
	}
	
	public boolean stockChk(String productNum, String productCount) throws Exception{
		int rs = fDao.stockChk(productNum);
		if(rs >= Integer.parseInt(productCount)){
			return true;
		} else{
			return false;
		}
	}
}
