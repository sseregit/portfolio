package com.iot.pf.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.iot.pf.dto.User;

public interface UserService {

	public ArrayList<User> list(HashMap<String,Object> params);

	public int count(HashMap<String,Object> params);

	public int chkId(String userId);

	public int insert(User user) throws Exception;

	public int delete(int seq) throws Exception;

	public int update(User user) throws Exception;

	public User getUser(String userId);

	public String password(String password);

	public boolean comparePw(String userId,String userPw);



}
