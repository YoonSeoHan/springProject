package light.test;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.poi.ss.formula.functions.T;

import com.mysql.cj.result.Field;

import ch.qos.logback.core.net.SyslogOutputStream;

public class JavaTest {
	
	public static void main(String[] args) {
		for(int i = 11; i <= 40; i++ ){
			int rt = (int)(Math.random() * 20)+1;
			System.out.println("rt : " + rt);

		}
		
	}
}
