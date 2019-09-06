package light.common.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import light.join.service.JoinVo;

@Service
public class MemberInfoChange {
	
	public MemberInfo ChangeInfoService(List<JoinVo> list1){
		MemberInfo memVo = new MemberInfo();
		
		memVo.setMemId(list1.get(0).getJoin_memId());
		memVo.setMemPw(list1.get(0).getJoin_memPw());
		memVo.setMemName(list1.get(0).getMemName());
		memVo.setMemPost(list1.get(0).getMemPaddr());
		memVo.setMemAddr1(list1.get(0).getMemDaddr());
		memVo.setMemAddr2(list1.get(0).getMemRaddr());
		memVo.setMemPhone(list1.get(0).getMemPhone1()+"-"+list1.get(0).getMemPhone2()+"-"+list1.get(0).getMemPhone3());
		memVo.setMemEmail(list1.get(0).getMemFemail()+"@"+list1.get(0).getMemBemail());
		return memVo;
	}
	
	public JoinVo ChangeInfoServiceOrigin(List<MemberInfo> list2){
		JoinVo joinVo = new JoinVo();
		joinVo.setJoin_memId(list2.get(0).getMemId());
		joinVo.setMemName(list2.get(0).getMemName());
		joinVo.setMemPaddr(list2.get(0).getMemPost());
		joinVo.setMemDaddr(list2.get(0).getMemAddr1());
		joinVo.setMemRaddr(list2.get(0).getMemAddr2());
		String temp[] = list2.get(0).getMemPhone().split("-");
		joinVo.setMemPhone1(temp[0]);
		joinVo.setMemPhone2(temp[1]);
		joinVo.setMemPhone3(temp[2]);
		temp = list2.get(0).getMemEmail().split("@");
		joinVo.setMemFemail(temp[0]);
		joinVo.setMemBemail(temp[1]);
		joinVo.setMemMileage(list2.get(0).getMemMileage());
		return joinVo;
		
	}
}
