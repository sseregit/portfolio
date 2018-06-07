package com.iot.pf.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iot.pf.dao.AttachmentDAO;
import com.iot.pf.dao.FreeBoardDAO;
import com.iot.pf.dto.Attachment;
import com.iot.pf.service.AttachmentService;
import com.iot.pf.util.FileUtil;

@Service("AttachmentServiceImpl")
public class AttachmentServiceImpl implements AttachmentService{

	@Autowired
	AttachmentDAO ad;
	
	@Autowired
	FreeBoardDAO fd;
	
	@Autowired
	FileUtil fu;
	
	@Override
	public int insert(Attachment acm) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Attachment> getAttachment(String docType, int seq) {
		// TODO Auto-generated method stub
		return ad.getAttachment(docType, seq);
	}

	@Override
	public Attachment getAttach(int seq) {
		// TODO Auto-generated method stub
		return ad.getAttach(seq);
	}

	
}

