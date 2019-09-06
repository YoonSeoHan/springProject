package light.img.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.img.dao.ImgDao;
import light.test.TestVo;

@Service
public class ImgServiceImpl implements ImgService{
	
	@Autowired
	ImgDao iDao;
	
	public List<ImgVo> getImage(String product) throws Exception{
		return iDao.getImage(product);
	}
}
