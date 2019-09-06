package light.img.service;

import java.util.List;

import light.test.TestVo;

public interface ImgService {
	
	public List<ImgVo> getImage(String product) throws Exception;
	
}
