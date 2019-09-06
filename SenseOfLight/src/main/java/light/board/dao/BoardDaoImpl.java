package light.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import light.board.service.BoardVo;
import light.board.service.Criteria;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	SqlSession sqlSession;
	@Autowired
	private static final String Namespace = "classpath:/sqlmap/data/boardMap";
	
	@Override
	public void insertBoard(BoardVo boardVo) throws Exception{
		sqlSession.insert(Namespace + ".insertBoard", boardVo);
	/*	for(int i = 0; i < 32; i++){
			boardVo.setBoardWriter("한윤서");
			boardVo.setBoardSubject((i+1)+"번째 문의입니다.");
			boardVo.setBoardContents((i+1)+"번쨰 문의 내용입니다.");
			boardVo.setBoardEmail("ginfizz1124@gmail.com");
			boardVo.setBoardPwd(String.valueOf(i));
			sqlSession.insert(Namespace + ".insertBoard", boardVo);
		}*/
	}
	
	@Override
	public void insertRepleBoard(BoardVo boardVo) throws Exception{
		
		/*원글 정보*/
		boardVo = selectBoard(boardVo);

		/*첫번째 댓글이 아니면*/
		if (boardVo.getFirstReple() > 1) {
			/*원글 혹은 부모글에 대한 No와 Ord를 이용하여 update*/
			sqlSession.update(Namespace + ".updateOrder", boardVo);
		}
		sqlSession.insert(Namespace + ".insertRepleBoard", boardVo);
	}
	
	@Override
	public void updateBoard(BoardVo boardVo) throws Exception{
		sqlSession.update(Namespace + ".updateBoard", boardVo);
	}
	
	@Override
	public void deleteBoard(BoardVo boardVo) throws Exception{
		sqlSession.delete(Namespace + ".deleteBoard", boardVo);
		
	}
	
	/*게시판리스트*/
	@Override
	public List<BoardVo> selectBoardList(Criteria criteria) throws Exception{
		List<BoardVo> list = new ArrayList<BoardVo>();
		list = sqlSession.selectList(Namespace + ".selectListBoard", criteria);
		return list;
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception{
		List<BoardVo> list = new ArrayList<BoardVo>();
		list = sqlSession.selectList(Namespace + ".selectBoard",  boardVo);
		
		if(boardVo.getBoardSubject() == null){
			try {
				boardVo.setBoardNum(list.get(0).getBoardNum());
				boardVo.setBoardSeq(list.get(0).getBoardSeq());
				boardVo.setProductNum(list.get(0).getProductNum());
				boardVo.setBoardWriter(list.get(0).getBoardWriter());
				boardVo.setBoardSubject(list.get(0).getBoardSubject());
				boardVo.setBoardEmail(list.get(0).getBoardEmail());
				boardVo.setBoardContents(list.get(0).getBoardContents());
				boardVo.setBoardCnt(list.get(0).getBoardCnt());
				boardVo.setBoardDate(list.get(0).getBoardDate());
				boardVo.setGrpno(list.get(0).getGrpno());
				boardVo.setGrpord(list.get(0).getGrpord());
				boardVo.setDepth(list.get(0).getDepth());
				boardVo.setBoardOrgContents(list.get(0).getBoardOrgContents());
				boardVo.setFirstReple(list.get(0).getFirstReple());
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else{
			/*원글의 정보를 이용 -> 댓글의 입력정보 가공*/
			boardVo.setGrpno(list.get(0).getGrpno());
			boardVo.setGrpord(list.get(0).getGrpord());
			boardVo.setDepth(list.get(0).getDepth());
			boardVo.setBoardOrgContents(list.get(0).getBoardContents());
			boardVo.setFirstReple(list.get(0).getFirstReple());
		}
		
		return boardVo;
	}
	
	/*페이징처리 게시물 총개수*/
	@Override
	public int selectTotalCount(Criteria criteria) throws Exception{
		return sqlSession.selectOne(Namespace + ".selectTotalCount", criteria);
	}
	
	@Override
	public boolean pwdChk(Map<String, Object> params) throws Exception{
		int rs = sqlSession.selectOne(Namespace + ".pwdChk", params);
		if(rs == 1){
			return true;
		} else{
			return false;
		}
	}
	
	

}



