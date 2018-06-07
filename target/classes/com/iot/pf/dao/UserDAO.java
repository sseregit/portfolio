package com.iot.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.User;

public interface UserDAO {

	public ArrayList<User> list(HashMap<String,Object> params);
	
	public int count(HashMap<String,Object> params);
	
	public int chkId(String userId);
	
	public int insert(User user);
	
	public int delete(int seq);
	
	public int update(User user);
	
	public User getUser(String userId);
	
	public String password(String password);
	
	
	
}
