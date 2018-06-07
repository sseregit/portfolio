package web_portfolio;

import java.util.ArrayList;
import java.util.HashMap;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.iot.pf.dto.FreeBoard;
import com.iot.pf.service.FreeBoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/resources-common/applicationContext-datasource.xml",
		"file:src/main/resources-common/applicationContext-beans.xml"		
})


public class FreeBoardTest {
	
	@Autowired
	FreeBoardService fs;
	
	
	@Test
	
	public void wrtie() {
		
		
		
	}
	
	


}
