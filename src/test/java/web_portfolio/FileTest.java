package web_portfolio;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileTest {

	public static void main(String[] args) {

		FileInputStream fis = null;
		
		// 있는놈
		File f = new File("c:/20180404.xlsx");

			// 예외가 발생할수 있다.
			try {
				if(f.exists()) fis = new FileInputStream(f);
				
				File target = new File("c:/filetest/copy/");
				
				if(!target.exists()) target.mkdirs();
				
				target = new File(target,f.getName());
				
				FileOutputStream fos = new FileOutputStream(target);
				
				int data = 0;
				while((data=fis.read()) != -1) {
					
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
