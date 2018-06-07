package web_portfolio;

import java.io.File;
import java.io.FileInputStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.iot.pf.dto.Attachment;
import com.iot.pf.dto.FreeBoard;
import com.iot.pf.service.FreeBoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/resources-common/applicationContext-datasource.xml",
		"file:src/main/resources-common/applicationContext-beans.xml"		
})

public class AttachmentTest {
	
	@Autowired
	FreeBoardService fs;
	
	
	@Test
	public void insert() {
		FreeBoard fb = new FreeBoard();
		fb.setUserId("첨부파일");
		fb.setName("연습용");
		fb.setTitle("첨부파일");
		fb.setContent("첨부파일");
		fb.setHasFile("1");
	    	
	    File f1 = new File("c:/20180404.xlsx");
	    File f2 = new File("c:/20180226.docx");
	    File[] files = new File[] {f1,f2};
	 

}

}
