package light.board.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import light.board.dao.BoardDao;
import light.common.service.BoardEmailChange;
import light.img.service.ImgVo;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDao bDao;
	@Autowired
	BoardEmailChange bChange;
	
	public List<BoardVo> insertBoard(BoardVo boardVo) throws Exception{
		List<BoardVo> list = new ArrayList<BoardVo>();
		boardVo = bChange.ChangeBoardEmailADD(boardVo);
		bDao.insertBoard(boardVo);
		/*나중에 수정할것 왜넣었는지*/
		/*list = bDao.selectBoardList(String.valueOf(boardVo.getProductNum()));*/
		return list;
	}
	
	public List<BoardVo> insertRepleBoard(BoardVo boardVo) throws Exception{
		List<BoardVo> list = new ArrayList<BoardVo>();
		boardVo = bChange.ChangeBoardEmailADD(boardVo);
		bDao.insertRepleBoard(boardVo);
		
		return list;
	}

	public List<BoardVo> selectBoardList(Criteria criteria, String product) throws Exception{
		criteria.setProductNum(product);
		return  bDao.selectBoardList(criteria);
	}
	
	public int selectTotalCount (Criteria criteria, String product) throws Exception{
		criteria.setProductNum(product);
		return  bDao.selectTotalCount(criteria);
	}
	
	public BoardVo selectBoard(BoardVo boardVo) throws Exception{
		boardVo = bDao.selectBoard(boardVo);
		return  bChange.ChangeBoardEmailDIV(boardVo);
	}
	
	public void updateBoard(BoardVo boardVo) throws Exception{
		boardVo = bChange.ChangeBoardEmailADD(boardVo);
		bDao.updateBoard(boardVo);
	}
	
	public void deleteBoard(BoardVo boardVo) throws Exception{
		bDao.deleteBoard(boardVo);
	}
	
	public boolean pwdChk(Map<String, Object> params) throws Exception{
		return bDao.pwdChk(params);
	}
	
}
