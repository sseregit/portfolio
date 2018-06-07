package com.iot.pf.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.dao.AttachmentDAO;
import com.iot.pf.dao.FreeBoardDAO;
import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.FreeBoard;
import com.iot.pf.dto.User;
import com.iot.pf.service.FreeBoardService;
import com.iot.pf.util.FileUtil;

@Service("freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService{


	@Autowired
	FreeBoardDAO fd;

	@Autowired
	AttachmentDAO ad;

	@Autowired
	FileUtil fu;

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void delete(int boardNumber) {

		fu.delete(boardNumber);
	}

	@Override
	public int count(HashMap<String,String> params) {
		// TODO Auto-generated method stub
		return fd.count(params);
	}

	@Override
	public ArrayList<HashMap<String, Object>> list(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return fd.list(params);
	}

	@Override
	public FreeBoard findById(int boardNumber) {

		fd.updatehits(boardNumber);

		FreeBoard fb = fd.findById(boardNumber);

		return fb;
	}

	@Override
	public boolean comparePw(String userId, String userPw) {
		int result = fd.chkId(userId);

		User user = new User();

		if(result == 1) {

			user = fd.getUser(userId);

		}
		else {
			return false;		
		}

		return 	user.getUserPw().equals(fd.password(userPw));

	}

	@Override
	public int chkId(String userId) {
		// TODO Auto-generated method stub
		return fd.chkId(userId);
	}

	@Override
	public User getUser(String userId) {
		// TODO Auto-generated method stub
		return fd.getUser(userId);
	}

	@Override
	public String password(String password) {
		// TODO Auto-generated method stub
		return fd.password(password);
	}

/*
	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void writeTest(FreeBoard board, File[] files) {
		// 게시글 입력
		fd.write(board);
		// 글번호 꺼냄
		int seq = board.getBoardNumber();

		for(File f : files) {
			Attachment att = new Attachment();
			att.setAttachDocType("free");
			att.setAttachDocSep(seq);
			att.setFileName(f.getName());
			att.setFileSize(f.length());
			String fakeName = UUID.randomUUID().toString();
			att.setFakeName(fakeName);

			ad.insert(att);

			try {
				FileInputStream fis = null;

				if(f.exists()) fis = new FileInputStream(f);

				File target = new File("c:/tmp/upload/");

				if(!target.exists()) target.mkdirs();

				target = new File(target,att.getFakeName());

				FileOutputStream fos = new FileOutputStream(target);

				int data = 0;
				while((data=fis.read()) != 1){

					fos.write(data);
				}


			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}
*/
	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void writeWithFile(FreeBoard board, List<MultipartFile> files) {
		// 게시글 쳐 넣고
		fd.write(board);
		// 게시글번호 가져오고
		int seq = board.getBoardNumber();

		if(board.getHasFile().equals("1")) {
			for(MultipartFile f : files) {
				if(!f.isEmpty()) {
					Attachment att = new Attachment();
					att.setAttachDocType("free");
					att.setAttachDocSep(seq);
					att.setFileName(f.getOriginalFilename());
					att.setFileSize(f.getSize());
					String fakeName = UUID.randomUUID().toString();
					att.setFakeName(fakeName);

					ad.insert(att);

					fu.copyToFolder(f,fakeName); 
				}
			}
		}

	}
	
	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void updateWithFile(FreeBoard board, List<MultipartFile> files) {
		// 업데이트 게시판 쳐 넣고
		fd.update(board);
		// 게시글번호 가져오고
		int seq = board.getBoardNumber();
		
		if(board.getHasFile().equals("1")) {
			for(MultipartFile f : files) {
				if(!f.isEmpty()) {
					Attachment att = new Attachment();
					att.setAttachDocType("free");
					att.setAttachDocSep(seq);
					att.setFileName(f.getOriginalFilename());
					att.setFileSize(f.getSize());
					String fakeName = UUID.randomUUID().toString();
					att.setFakeName(fakeName);
					
					ad.insert(att);
					
					fu.copyToFolder(f,fakeName); 
				}
			}
		}
		
	}
	

	@Override
	@Transactional(rollbackFor= {Exception.class})
	public void deleteAttach(int seq) {

	Attachment ac = ad.getAttach(seq);
	
	int boardseq = ac.getAttachDocSeq();
	
	FreeBoard fb = fd.findById(boardseq);
	
	// 데이터베이스 지움
	ad.delete(seq);
		
	ArrayList<Attachment> acd = ad.getAttachment("free", fb.getBoardNumber());
			
	if(acd.size() == 0) {
		// DTO에 저장
		fb.setHasFile("0");
		// DB에 저장 
		fd.update(fb);			
	}

    fu.fileDelete(ac);
	
	}


}
