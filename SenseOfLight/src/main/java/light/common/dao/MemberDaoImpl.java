package light.common.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import light.common.service.MemberInfo;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;
	private static final String Namespace = "classpath:/sqlmap/data/commonMap";

	@Override
	public List<MemberInfo> selectById(String memId) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectById", memId);

	}
}
