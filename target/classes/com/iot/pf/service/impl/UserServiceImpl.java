package com.iot.pf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iot.pf.dao.UserDAO;
import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@Service("userService")
@Transactional(rollbackFor= {Exception.class,AnomalyException.class})
public class UserServiceImpl  implements UserService{

	@Autowired
	UserDAO ud;
	
	
	

	@Override
	public int insert(User user) throws Exception {
		
		int result = ud.insert(user);
		if(result != 1) {
			throw new AnomalyException(1,result);
		}
		
		return result;
	}


	@Override
	public int delete(int seq) throws Exception {
		
		int result = ud.delete(seq);
		if(result != 1) {
			throw new AnomalyException(1,result);
		}
		
		return result;
	}


	@Override
	public int update(User user)throws Exception{
		
		int result = ud.update(user);
		
		if(result != 1) {
			throw new AnomalyException(1,result);
		}
				
		return result;
	}


	@Override
	public int chkId(String userId) {
		// TODO Auto-generated method stub
		return ud.chkId(userId);
	}


	@Override
	public User getUser(String userId) {
		
		
		return ud.getUser(userId);
	}


	@Override
	public String password(String password) {
		// TODO Auto-generated method stub
		return ud.password(password);
	}


	@Override
	public boolean comparePw(String userId,String userPw) {
		
		int result = ud.chkId(userId);
		
		User user = new User();
		
		if(result == 1) {
		
		user = ud.getUser(userId);
		
		}
		else {
			return false;		
		}
		
		return 	user.getUserPw().equals(ud.password(userPw));
		
		
	}


	@Override
	public ArrayList<User> list(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return ud.list(params);
	}


	@Override
	public int count(HashMap<String,Object> params) {
		// TODO Auto-generated method stub
		return ud.count(params);
	}

}
