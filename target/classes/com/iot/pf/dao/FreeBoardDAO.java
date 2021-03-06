package com.iot.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.bind.annotation.RequestParam;

import com.iot.pf.dto.FreeBoard;
import com.iot.pf.dto.User;

public interface FreeBoardDAO {
	/**
	 * 게시판list를 뽑아온다
	 * @param params
	 * @return
	 */
	public ArrayList<HashMap<String, Object>> list(HashMap<String,Object> params);

	public int write(FreeBoard fb);
	
	public int delete(int boardNumber);
	
	public int update(FreeBoard fb);
	
	public int count(HashMap<String,String> params);
	
	public int updatehits(int boardNumber);
	
	public FreeBoard findById(int boardNumber);
	
	public int chkId(String userId);
	
	public User getUser(String userId);
	
	public String password(String password);
	
	
	
	
	



}
