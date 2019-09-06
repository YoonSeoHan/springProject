package light.join.dao;


import java.lang.reflect.Field;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.google.protobuf.DescriptorProtos.GeneratedCodeInfoOrBuilder;

import light.common.service.MemberInfo;
import light.join.service.JoinVo;

@Repository
public class JoinDaoimpl implements JoinDao {

	@Autowired
	 private SqlSession sqlSession;
	 private static final String Namespace = "classpath:/sqlmap/data/joinMap";


	@Override
	public int insertJoinAction(MemberInfo memVo) throws Exception{
		/*성공시  1 */
		/*실패시 0*/
		return sqlSession.insert(Namespace+".insertJoin", memVo);
	}
	
}
