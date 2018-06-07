package com.iot.pf.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.iot.pf.controller.UserController;
import com.iot.pf.dao.AttachmentDAO;
import com.iot.pf.dao.FreeBoardDAO;
import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.FreeBoard;

@Component
public class FileUtil {
	
	@Autowired
	FreeBoardDAO fd;
	
	@Autowired
	AttachmentDAO ad;
	
	@Value("${file.upload.directory}")
	private String fileUploadDirectory;

	// AWS 경로 = /home/ubuntu/app/upload/pf
	
//	 private String fileUploadDirectory = "c:/tmp/upload";
 
	// private String fileUploadDirectory = "/home/ubuntu/app/upload/pf";
	
	private Logger log = Logger.getLogger(FileUtil.class);  
	
	
	/**
	 * 첨부파일을 서버 물리 저장소에 복사
	 * @param files
	 */
	public void copyToFolder(MultipartFile f,String uuid) {
		
		// inputStream 만들필요없음
		
		File target = new File(fileUploadDirectory);
		
		
		
		if(!target.exists()) target.mkdirs();
		
		target = new File(target,uuid);
		
		// 물리 저장소에 파일 쓰기
		try {
			FileCopyUtils.copy(f.getBytes(),target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public byte[] download(Attachment ac,HttpServletResponse rep) {
		
		
//		 String uploadDir = "c:/tmp/upload";
		// String uploadDir = "/home/ubuntu/app/upload/pf";
		File file = new File(fileUploadDirectory + "/" + ac.getFakeName());
		
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
		
		return b;
		
	}
	
	public void delete(int boardNumber) {
		

		FreeBoard fb = fd.findById(boardNumber);

		if(fb.getHasFile().equals("1")) {

			ArrayList<Attachment> ac = ad.getAttachment("free", fb.getBoardNumber());

			fd.delete(boardNumber);

			for(Attachment acm : ac) {

				ad.delete(acm.getAttachSeq());

				File file = new File(fileUploadDirectory,acm.getFakeName());
			//	File file = new File("/home/ubuntu/app/upload/pf",acm.getFakeName());

				file.delete();

			}


		}else {
			fd.delete(boardNumber);
		}
		
	}
	
	public void fileDelete(Attachment acm) {
		
		File file = new File(fileUploadDirectory,acm.getFakeName());
	//	File file = new File("/home/ubuntu/app/upload/pf",acm.getFakeName());

		file.delete();
	}
}
		
	
