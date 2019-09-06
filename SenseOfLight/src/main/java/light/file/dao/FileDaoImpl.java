package light.file.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.session.SqlSession;
import org.junit.runner.manipulation.Sortable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import light.file.service.FileVo;

@Repository
public class FileDaoImpl implements FileDao{
	@Autowired
	SqlSession sqlsession;
	private static final String Namespace = "classpath:/sqlmap/data/fileMap";
	
	@Override
	public List<FileVo> getFile(String product) throws Exception {
		List<FileVo> list = new ArrayList<FileVo>();
		String sort[] = product.split(",");

		if(sort.length > 1){
			Map<String, Object> param = new HashMap<String, Object>();
			List<String> codeList = new ArrayList<String>();
			codeList.add(sort[0]); 
			codeList.add(sort[1]);
			param.put("code_list", codeList); //map에 list를 넣는다.
			list = sqlsession.selectList(Namespace+".selectAllFile", param);
			
		} else {
			
			if(product.startsWith("00")){
				list = sqlsession.selectList(Namespace+".selectGroupFile", product);
			} else{
				list = sqlsession.selectList(Namespace+".selectFile", product);
			}
		}
		return list;
	}
	
	@Override
	public int stockChk(String productNum) throws Exception{
		
		int rs = sqlsession.selectOne(Namespace+".selectStockChk", productNum);
		
		
		return rs;
	}

}
