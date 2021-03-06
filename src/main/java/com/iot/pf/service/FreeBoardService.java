package com.iot.pf.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dto.FreeBoard;
import com.iot.pf.dto.User;

public interface FreeBoardService {
	
	public ArrayList<HashMap<String, Object>> list(HashMap<String, Object> p);
	
	public void delete(int boardNumber);
	
	public int count(HashMap<String,String> params);
	
	public FreeBoard findById(int boardNumber);
	
	public boolean comparePw(String userId,String userPw);
	
	public int chkId(String userId);
	
	public User getUser(String userId);
	
	public String password(String password);
	
	public void writeWithFile(FreeBoard board, List<MultipartFile> files);
	
	public void updateWithFile(FreeBoard board, List<MultipartFile> files);
	
	public void deleteAttach(int seq);
	
	
	

	
	



}
