package light.file.dao;

import java.util.List;

import light.file.service.FileVo;

public interface FileDao {

	public List<FileVo> getFile(String product) throws Exception;

	public int stockChk(String productNum) throws Exception;

}
