package com.iot.pf.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.FreeBoard;
import com.iot.pf.dto.User;
import com.iot.pf.service.AttachmentService;
import com.iot.pf.service.FreeBoardService;
import com.iot.pf.service.UserService;
import com.iot.pf.util.FileUtil;

@Controller
public class FreeBoardController {

	private Logger log = Logger.getLogger(FreeBoardController.class);  

	
	@Autowired
	FreeBoardService fs;
	
	@Autowired
	AttachmentService as;

	@Autowired
	UserService us;
	
	@Autowired
	FileUtil fu;
    
	@RequestMapping("/list.do")
	public ModelAndView list(@RequestParam HashMap<String,String> params) {
		
		log.debug("JYS list params = " + params);

		ModelAndView mav = new ModelAndView();
		// 총 게시글 수
		int totalArticle = fs.count(params);
		// 한 페이지 보여줄 게시글수
		int pageArticleCnt = 10;
		//총 페이지수
		int totalPage = 0;
		if(totalArticle % pageArticleCnt == 0) {
			totalPage = totalArticle / pageArticleCnt;
		}
		else{
			totalPage = totalArticle / pageArticleCnt + 1;
		}
		// 현재 페이지 번호 
		int currentPageNo = 1;
		if(params.containsKey("currentPageNo")) {
			currentPageNo = Integer.parseInt(params.get("currentPageNo"));
		}		
		// 시작게시글
		int startArticleNo = (currentPageNo - 1) * pageArticleCnt;
		// 페이지 블럭수
		int pageBlockSize = 10;
		//페이지 블럭 시작값
		int pageBlockStart = 0;
		pageBlockStart = (currentPageNo - 1) / pageBlockSize * pageBlockSize + 1;
		//페이지 블럭 종료값
		int pageBlockEnd = 0;
		pageBlockEnd = (currentPageNo - 1) / pageBlockSize * pageBlockSize + pageBlockSize;
		pageBlockEnd = (pageBlockEnd >= totalPage) ? totalPage : pageBlockEnd;


		HashMap<String, Object> p = new HashMap<String, Object>();
		p.put("startArticleNo", startArticleNo);
		p.put("pageArticleCnt", pageArticleCnt);
		p.put("searchType", params.get("searchType"));
		p.put("searchText", params.get("searchText"));

		ArrayList<HashMap<String,Object>> result = fs.list(p);
        
		mav.addObject("searchType",params.get("searchType"));
		mav.addObject("searchText",params.get("searchText"));
		mav.addObject("result",result);
		mav.addObject("pageBlockStart",pageBlockStart);
		mav.addObject("pageBlockEnd",pageBlockEnd);
		mav.addObject("totalPage",totalPage);
		mav.addObject("pageBlockSize",pageBlockSize);
		mav.addObject("currentPageNo",currentPageNo);


		mav.setViewName("/bbs/free/list");

		return mav;
	}
    
	@RequestMapping("/read.do")
	public ModelAndView read(@RequestParam HashMap<String,String> params,HttpSession session) {

		log.debug("read params = " + params);

		ModelAndView mav = new ModelAndView();

			int boardNumber = Integer.parseInt(params.get("boardNumber"));

			FreeBoard fb = fs.findById(boardNumber);

			String content = fb.getContent();

			fb.setContent(content);
			
			if(fb.getHasFile().equals("1")) {
				// 첨부파일 데이터 가져오기
				int seq = fb.getBoardNumber();
				
				ArrayList<Attachment> ac = as.getAttachment("free", seq);
				
				
				// 가져온 첨부파일 데이터 JSP에서 쓰기위해 넣어주기
				DecimalFormat df = new DecimalFormat("#,###");
				
			
				mav.addObject("df",df);
				mav.addObject("attachment",ac);
			
			}

			mav.addObject("msg",params.get("msg"));
			mav.addObject("currentPageNo",params.get("currentPageNo"));
			mav.addObject("boardNumber", boardNumber);
			mav.addObject("board",fb);

			mav.setViewName("/bbs/free/read");
	
		return mav;

	}
	
	@RequestMapping("/gowrite.do")

	public ModelAndView gowrite(@RequestParam HashMap<String,String> params) {

		ModelAndView mav = new ModelAndView();
		
		mav.addObject("currentPageNo",params.get("currentPageNo"));

		mav.setViewName("/bbs/free/write");

		return mav;
	}

	@RequestMapping("/write.do")


	public ModelAndView write(@RequestParam HashMap<String,String> params,HttpSession session,MultipartHttpServletRequest mReq) {

		log.debug("JYS write params = " + params);

		ModelAndView mav = new ModelAndView();
			
		if(session.getAttribute("userId") != null) {

			// 이미 FileinputStream 을 하고 있음 내보기만 하면댐
			List<MultipartFile> mpf = mReq.getFiles("attachFile");
	        
			String hasFile = "0";
			// mpf.size() : attachFile << 몇개가 있냐지 파일이 있느냐 없느냐가 아님
			for(MultipartFile f : mpf) {
			
				hasFile = !f.isEmpty() ? "1" : "0";
				
				if(hasFile.equals("1")) break;
			}
	        
			FreeBoard fb = new FreeBoard();

			fb.setUserId(params.get("name"));
			fb.setName(fs.getUser(params.get("name")).getUserName());
			fb.setTitle(params.get("title"));
			fb.setHasFile(hasFile);
			String content = params.get("content");

			fb.setContent(content);

			fs.writeWithFile(fb, mpf);

			RedirectView rv = new RedirectView("/web_portfolio/list.do");

			mav.setView(rv);
		}
		else {

			mav.setViewName("login");

		}


		return mav;
	}

	@RequestMapping("/delete.do")

	public ModelAndView delete(@RequestParam HashMap<String,String> params,HttpSession session) {

		log.debug("delete params = " + params);

		ModelAndView mav = new ModelAndView();
		

		if(session.getAttribute("userId") != null) {

			mav.addObject("currentPageNo",params.get("currentPageNo"));
			
			int boardNumber = Integer.parseInt(params.get("boardNumber"));

			String userId = String.valueOf(session.getAttribute("userId"));
            		
			String userPw = params.get("password");
			
			String msg = "";

			if(fs.comparePw(userId, userPw)) {

				fs.delete(boardNumber);
				RedirectView rv = new RedirectView("/web_portfolio/list.do");
				mav.setView(rv);


			} else {
				msg += "비밀번호를 똑바로 입력해라";
				mav.addObject("msg",msg);
				RedirectView rv = new RedirectView("/web_portfolio/read.do");
				mav.addObject("boardNumber",boardNumber);
				mav.setView(rv);

			}
		}
		else {
			mav.setViewName("login");
		}


		return mav;

	}
	
	@RequestMapping("/goupdate.do")
	
	public ModelAndView goupdate(@RequestParam HashMap<String,String> params,HttpSession session) {
		
		log.debug("update params " + params);
		
		ModelAndView mav = new ModelAndView();
		
		if(session.getAttribute("userId") != null) {
			
			boolean key = false;
			
			if(params.get("key") != null) {
			   key = Boolean.valueOf(params.get("key"));
			}
			
			int boardNumber = Integer.parseInt(params.get("boardNumber"));
			
			String userId = String.valueOf(session.getAttribute("userId"));
			
			String userPw = params.get("password");
			
			if(key || fs.comparePw(userId, userPw)) {
				
				FreeBoard fb = fs.findById(boardNumber);
				if(fb.getHasFile().equals("1")) {
				ArrayList<Attachment> ac = as.getAttachment("free", boardNumber);
				DecimalFormat df = new DecimalFormat("#,###");
				
				
				mav.addObject("df",df);
				
				
			    mav.addObject("attachment", ac);
				
				}
				String content = fb.getContent();

			
             
			    fb.setContent(content);
			    mav.addObject("boardNumber",boardNumber);
			    mav.addObject("currentPageNo",params.get("currentPageNo"));
				mav.addObject("board",fb);
				mav.setViewName("/bbs/free/update");
				
			}else {
				String msg = "비밀번호를 바르게 입력";
				mav.addObject("msg",msg);
				mav.addObject("boardNumber",boardNumber);
				RedirectView rv = new RedirectView("/web_portfolio/read.do");
				mav.setView(rv);
				
			}
			
			}
		
	
		
		return mav;
		
	}
	
	@RequestMapping("/update.do")
	
	public ModelAndView update(@RequestParam HashMap<String,String> params,HttpSession session,MultipartHttpServletRequest mReq) {
		
		log.debug("JYS update params = " + params);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("currentPageNo",params.get("currentPageNo"));
		
		if(session.getAttribute("userId") != null) {
				
			int boardNumber = Integer.parseInt(params.get("boardNumber"));
			
			FreeBoard fb = fs.findById(boardNumber);
						
			List<MultipartFile> mpf = mReq.getFiles("attachFile");
			
			String hasFile = fb.getHasFile();
			
				for(MultipartFile f : mpf) {
				
				hasFile = !f.isEmpty() ? "1" : "0";
				
				if(hasFile.equals("1")) break;
								
			 }
			
		
				
			fb.setTitle(params.get("title"));
			fb.setContent(params.get("content"));
			fb.setBoardNumber(boardNumber);
			fb.setHasFile(hasFile);
			
			   
			fs.updateWithFile(fb, mpf);
	
		
    	RedirectView rv = new RedirectView("/web_portfolio/list.do");
		mav.setView(rv);

		}else {
			mav.setViewName("login");
		}
		return mav;
		
		
	}
	
	@RequestMapping("/fileDownLoad.do")
	@ResponseBody
	public byte[] download(@RequestParam HashMap<String,String> params,HttpServletResponse rep) {
		
		log.debug("JYS download params = " + params);
		
		
		// 1. 첨부파일 seq 꺼내기
		int seq = Integer.parseInt(params.get("attachSeq"));
		// 2. seq 해당하는 첨부파일 1건 가져오기
		Attachment ac = as.getAttach(seq);
		// 3. response에 정보 입력
		
		/*
		String uploadDir = "c:/tmp/upload";
		File file = new File(uploadDir + "/" + ac.getFakeName());
		
		String endcodingName;
		byte[] b = null;
		try {
			endcodingName = java.net.URLEncoder.encode(ac.getFileName(),"UTF-8");
			rep.setContentType(ac.getContentType());
			rep.setHeader("Content-Disposition", "attachment; filename=\""+endcodingName + "\"");
			rep.setHeader("Pragma", "no-cache");
			rep.setHeader("cache-Control", "no-cache");
			rep.setContentLength((int) ac.getFileSize());
			 b = FileUtils.readFileToByteArray(file);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		
		return fu.download(ac, rep);
	}

	@RequestMapping("delAttach.do")
	
	public ModelAndView delAttach(@RequestParam HashMap<String,String> params) {
		
		log.debug("JYS delAttach params = " + params);
		
		ModelAndView mav = new ModelAndView();
		
		int boardNumber = Integer.parseInt(params.get("boardNumber"));
		
		int seq = Integer.parseInt(params.get("attachSeq"));
		
		fs.deleteAttach(seq);
		
		FreeBoard fb = fs.findById(boardNumber);
		
		
		mav.addObject("currentPageNo",params.get("currentPageNo"));
		mav.addObject("boardNumber", boardNumber);
		mav.addObject("board",fb);
		mav.addObject("key",true);
		
		RedirectView rv = new RedirectView("/web_portfolio/goupdate.do");
		mav.setView(rv);
		
		
		return mav;
	}
	
	



}
