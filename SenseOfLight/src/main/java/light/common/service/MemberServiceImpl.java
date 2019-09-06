package light.common.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.common.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	MemberDao memDao;

	@Override
	public List<MemberInfo> selectById(String memId) throws Exception {
		List<MemberInfo> memVo = memDao.selectById(memId);
		
		return memVo;
	}
}
