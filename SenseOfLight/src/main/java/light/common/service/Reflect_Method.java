package light.common.service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.stereotype.Service;

import light.order.service.OrderVo;


public class Reflect_Method<T extends OrderVo> {
	private Method[] methods;

	public Reflect_Method(T clz) {
		// 들어온 Vo객체의 메소드를 저장
		methods = clz.getClass().getMethods();
	}

	public void methodInvoke(T clz, String Key, String Value) {
		String firstString = "";
		for (int i = 0; i < methods.length; i++) {
			if(i == 0){
				firstString = Key.substring(0, 1).toUpperCase();
				Key = "set" + firstString
		                + Key.substring(1, Key.length());
			}
			String findMethod = methods[i].getName();
			if (findMethod.contains(Key)) {
				// secondMethod를 찾아서 실행
				try {
					methods[i].invoke(clz, Value);
					// invoke()를 통해 메소드 호출 가능
					// 첫번째 파라미터는 해당 메소드를 가진 인스턴스, 두번쨰 파라미터는 해당 메소드의 파라미터
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	public void methodInvoke(T clz, String Key, int Value) {
		String firstString = "";
		for (int i = 0; i < methods.length; i++) {
			if(i == 0){
				firstString = Key.substring(0, 1).toUpperCase();
				Key = "set" + firstString
		                + Key.substring(1, Key.length());
			}
			String findMethod = methods[i].getName();
			if (findMethod.contains(Key)) {
				// secondMethod를 찾아서 실행
				try {
					methods[i].invoke(clz, Value);
					// invoke()를 통해 메소드 호출 가능
					// 첫번째 파라미터는 해당 메소드를 가진 인스턴스, 두번쨰 파라미터는 해당 메소드의 파라미터
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
