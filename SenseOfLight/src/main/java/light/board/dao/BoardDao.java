package light.board.dao;

import java.util.List;
import java.util.Map;

import light.board.service.BoardVo;
import light.board.service.Criteria;

public interface BoardDao {

	public void insertBoard(BoardVo boardVo) throws Exception;

	/*public List<BoardVo> selectBoardList(String product, int page) throws Exception;*/

	public void updateBoard(BoardVo boardVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public void deleteBoard(BoardVo boardVo) throws Exception;

	public List<BoardVo> selectBoardList(Criteria criteria) throws Exception;

	public int selectTotalCount(Criteria criteria) throws Exception;

	public void insertRepleBoard(BoardVo boardVo) throws Exception;

	public boolean pwdChk(Map<String, Object> params) throws Exception;

	
}
