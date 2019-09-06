package light.common.service;

import org.springframework.stereotype.Service;

import light.board.service.BoardVo;

@Service
public class BoardEmailChange {
	public BoardVo ChangeBoardEmailADD(BoardVo boardVo){

		boardVo.setBoardEmail(boardVo.getBoardFemail()+"@"+boardVo.getBoardBemail());
		return boardVo;
	}
	
	public BoardVo ChangeBoardEmailDIV(BoardVo boardVo){
		String temp[] = boardVo.getBoardEmail().split("@");
		boardVo.setBoardFemail(temp[0]);
		boardVo.setBoardBemail(temp[1]);
		return boardVo;
	}
	
}
