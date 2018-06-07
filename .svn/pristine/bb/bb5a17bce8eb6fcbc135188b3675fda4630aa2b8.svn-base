package com.iot.pf.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@Controller
public class UserController {

	private Logger log = Logger.getLogger(UserController.class);  

	@Autowired
	UserService us;

	@RequestMapping("/login.do")
	public ModelAndView login(@RequestParam HashMap<String,String> params) {

		log.debug("login() params : " +params);

		ModelAndView mav = new ModelAndView();

		User user = new User();

		user.setUserId(params.get("userId"));
		user.setUserName(params.get("userName"));
		user.setUserPw(params.get("userPw"));
		user.setNickName(params.get("nickName"));

		try {
			us.insert(user);

		}catch(AnomalyException ae) {

			ae.printStackTrace();
		}catch(Exception e) {
			e.printStackTrace();
		}

		mav.setViewName("login");


		return mav;

	}

	@RequestMapping("/join.do")
	public ModelAndView join(@RequestParam HashMap<String,String> params,HttpSession session) {

		log.debug("join params = " + params);

		ModelAndView mav = new ModelAndView();

		String userId = params.get("userId");
		String userPw = params.get("userPw");

		if(us.comparePw(userId, userPw)) {
			User user = us.getUser(userId);

			session.setAttribute("userId", user.getUserId());
			session.setAttribute("isAdmin", user.getIsAdmin());

			RedirectView rv = new RedirectView("/web_portfolio/index.do");

			mav.setView(rv);

		}
		else {
			String msg = "";
			
			
			
			if(us.chkId(userId) != 1) {
				msg += "아이디가 없습니다";
			}else {
				msg += "비밀번호 불일치";
			}

			mav.addObject("msg",msg);
			mav.setViewName("login");
		}


		return mav;

	}

	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpSession session) {

		ModelAndView mav = new ModelAndView();

		session.invalidate();

		mav.setViewName("index");

		return mav;

	}



	@RequestMapping("/chkId.do")
	@ResponseBody
	public int chkId(@RequestParam HashMap<String,String> params) {

		log.debug("chkId() params :  " + params);

		String userId = params.get("userId");

		return us.chkId(userId);

	}

	@RequestMapping("/userList.do")

	public ModelAndView userList(@RequestParam HashMap<String,String> params,HttpSession session) {

		ModelAndView mav = new ModelAndView();

		String msg = "";

		if(session.getAttribute("userId") != null) { 

			User user = us.getUser(String.valueOf(session.getAttribute("userId")));

			if(user.getIsAdmin().equals("1")) {

				mav.setViewName("user/list");

			}else {
				mav.setViewName("error/error");
				msg += "권한이 없습니다";
				mav.addObject("msg",msg);
				mav.addObject("nextLocation","/index.do");

			}

		}else {
			mav.setViewName("error/error");
			msg += "로그인이 필요합니다";
			mav.addObject("msg",msg);
			mav.addObject("nextLocation","/loginPage.do");

		}

		return mav;
	}

	@RequestMapping("/getUser.do")
	@ResponseBody
	public HashMap<String,Object> getUser(@RequestParam HashMap<String,Object> params) {

		log.debug("JYS getUser.do params : " + params);

		params.put("searchType", params.get("searchType"));
		params.put("searchText", params.get("searchText"));

		// 한페이지에 보여줄 게시글
		int pageSize = Integer.parseInt(params.get("rows").toString());
		// 현재 페이지
		int currentPage = Integer.parseInt(params.get("page").toString());
		// 총 게시글
		int totalCount = us.count(params);
		// 총 페이지 수
		int totalPage = (totalCount % pageSize == 0)? (totalCount / pageSize) : (totalCount / pageSize)+1;
		// 시작 로우
		int start = (currentPage - 1) * pageSize;

		params.put("start", String.valueOf(start));

		ArrayList<User> result = us.list(params);

		HashMap<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("rows", result);
		resultMap.put("page", currentPage);
		resultMap.put("total", totalPage);
		resultMap.put("records", totalCount);

		return resultMap;
	}

	@RequestMapping("checkPk.do")
	@ResponseBody
	public long checkPk(@RequestParam HashMap<String,Object> params) {

		log.debug("JYS getUser.do params : " + params);

		int seq = Integer.parseInt(params.get("rowId").toString());

		Calendar cal = Calendar.getInstance();

		return cal.getTimeInMillis();
	}

	@RequestMapping("delUser.do")
	@ResponseBody
	public HashMap<String,Object> delUser(@RequestParam HashMap<String,Object> params,HttpSession session) {

		log.debug("JYS delUser.do params : " + params);

		int seq = Integer.parseInt(params.get("id").toString());

		HashMap<String,Object> result = new HashMap<String,Object>();



		try {   
			int del = us.delete(seq);
			result.put("del", "삭제 되었습니다");

		}catch (AnomalyException ae) {
			ae.printStackTrace();
			result.put("del", "삭제 중 오류(삭제이상)가 발생");
		}catch (Exception e) {
			e.printStackTrace();
			result.put("del", "삭제 중 오류(예외)가 발생");
		}



		return result;


	}

	@RequestMapping("editUser.do")
	@ResponseBody
	public String editUser(@RequestParam HashMap<String,Object> params) {

		log.debug("JYS editUser : " + params);

		User user = new User();

		user.setUserName(params.get("userName").toString());
		user.setNickName(params.get("nickName").toString());
		user.setEmail(params.get("email").toString());
		user.setIsAdmin(params.get("isAdmin").toString());
		user.setSeq(Integer.parseInt(params.get("seq").toString()));

		String msg = "";
		try {
			
              us.update(user);
             msg += "success";
		}catch (AnomalyException ae){ 
		     msg += "anomaly";						
		}catch (Exception e) {
		     msg += "exception";				
		}
		return msg;

	}






}
