package web_portfolio;

import java.util.ArrayList;
import java.util.HashMap;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.iot.pf.dto.User;
import com.iot.pf.exception.AnomalyException;
import com.iot.pf.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/resources-common/applicationContext-datasource.xml",
		"file:src/main/resources-common/applicationContext-beans.xml"		
})


public class UserTest {

	@Autowired
	UserService us;

	@Test
	
	public void write() {
		
		User user = new User();
		
	    user.setUserName("장연식");
	    user.setUserId("장연식123");
	    user.setEmail("장연식@장연식.장연식");
	    user.setUserPw("20180424");
	    user.setNickName("장연식");
	    user.setIsAdmin("아님");
	    
	    try {
			us.insert(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    User del = us.getUser("장연식123");
	    
	    try {
			us.delete(del.getSeq());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}




