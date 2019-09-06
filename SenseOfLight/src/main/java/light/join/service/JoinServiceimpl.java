package light.join.service;
 
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
 
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.common.service.MemberInfo;
import light.common.service.MemberInfoChange;
import light.join.dao.JoinDao;

 
@Service
public class JoinServiceimpl implements JoinService {
 
	@Autowired
    private JoinDao joinDao;
	@Autowired
	private MemberInfoChange memInfoSvc;
	
	@Override
	public int insertJoinAction(List<JoinVo> list) throws Exception {
		MemberInfo memVo = new MemberInfo();
		memVo = memInfoSvc.ChangeInfoService(list);
		return joinDao.insertJoinAction(memVo);
	}

 
}
