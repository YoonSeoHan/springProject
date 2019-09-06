package light.common.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service
public class ProductPriceConvert {
	
	/*제품 적립 마일리지 계산*/
	public String MileageCalc(String str){
		int temp = StringToNum(str);
		temp = (int) (temp * 0.01);
		str = NumToString(temp);
		return str;
	}
	
	/*콤마 변경*/
	public String CommaConvert(String str){
		int num = StringToNum(str);
		str = String.format("%,d", num);
		return str;
	}
	
	/*총금액 계산*/
	public String TotalCalc(String[] str){
		int num = 0;
		for(int i = 0; i < str.length; i++){
			num = num + StringToNum(str[i]);
		}
		String rs  = NumToString(num);
		return rs;
	}
	
	/*discount에 따라 소비자가 계산*/
	public String ConsuCalc(String[] str){
		int num[] = new int[str.length];
		String rs = "";
		for(int i = 0; i < str.length; i++){
			num[i] =  StringToNum(str[i]);
		}
		if(num[0]> num[1]){
			rs  = NumToString(num[0] - num[1]);
		} else{
			rs  = NumToString(num[1] - num[0]);
		}
		return rs;
	}
	
	/*옵션1과 옵션2에 적힌 금액추출*/
	/*ex)6500K [무상 AS 1년 보장] (+2000원) => 2000 추출*/
	public String AdditionalCost(String str){
		Pattern p = Pattern.compile("\\((.*?)\\)");
		Matcher m = p.matcher(str);
		String rs = "";
		while(m.find()){
			char str1 = m.group(1).charAt(0);
			char str2 = m.group(1).charAt(m.group(1).length()-1);
			String str11 = String.valueOf(str1);
			String str22 = String.valueOf(str2);
			if(str11.equals("+") && str22.equals("원")){
				rs = m.group(1).substring(1, m.group(1).length()-1);
			}
		}
		return rs;
	}
	
	/*숫자로 변경*/
	public int StringToNum(String str){
		int num = Integer.parseInt(str);
		return num;
	}
	
	/*문자로 변경*/
	public String NumToString(int num){
		String str = String.valueOf(num);
		return str;
	}
}
