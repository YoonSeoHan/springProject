package light.img.dao;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.codec.language.bm.Languages.SomeLanguages;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import light.img.service.ImgVo;

@Repository
public class ImgDaoImpl implements ImgDao{
	@Autowired
	 private SqlSession sqlSession;
	 private static final String Namespace = "classpath:/sqlmap/data/imageMap";
	 
	@Override
	public List<ImgVo> getImage(String product) throws Exception {
		String sort[] = product.split("_");
		List<ImgVo> list = new ArrayList<ImgVo>();
		if(sort.length > 1){
			list = sqlSession.selectList(Namespace+".selectImage", product);
		} else {
			String Allproduct = sort[0];
			list = sqlSession.selectList(Namespace+".selectAllImage", Allproduct+"%");
		}
		return list;
	}
}
