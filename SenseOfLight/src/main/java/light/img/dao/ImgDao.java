package light.img.dao;

import java.util.List;

import light.img.service.ImgVo;

public interface ImgDao {
	public List<ImgVo> getImage(String product) throws Exception;
}
