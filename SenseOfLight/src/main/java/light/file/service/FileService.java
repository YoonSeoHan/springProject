package light.file.service;

import java.util.List;

public interface FileService {
	public List<FileVo> getFile (String product) throws Exception;
	
	public boolean stockChk(String productNum, String productCount) throws Exception;
}
