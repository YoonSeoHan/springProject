package light.board.service;

import java.util.List;
import java.util.Map;

public interface BoardService {
	
	public List<BoardVo> insertBoard(BoardVo boardVo) throws Exception;

	public List<BoardVo> selectBoardList(Criteria criteria, String product) throws Exception;
	
	public BoardVo selectBoard(BoardVo boardVo) throws Exception;
	
	public void updateBoard(BoardVo boardVo) throws Exception;

	public void deleteBoard(BoardVo boardVo) throws Exception;
	
	public int selectTotalCount (Criteria criteria, String product) throws Exception;

	public List<BoardVo> insertRepleBoard(BoardVo boardVo) throws Exception;

	public boolean pwdChk(Map<String, Object> params) throws Exception;
	
}
