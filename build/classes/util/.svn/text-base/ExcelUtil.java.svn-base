package util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jxl.Sheet;
import jxl.Workbook;

public class ExcelUtil {

	public List<HashMap<String, String>> thematicExcel(String filePath,String fileName)throws Exception{

		//File file = new File(filePath);
		/*
		if(!file.exists()){
			throw new Exception("파일이 존재하지 않습니다.");
		}*/
		Workbook workbook = null;
		Sheet sheet = null;
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		try{
//			workbook = Workbook.getWorkbook(file);
			workbook = Workbook.getWorkbook(new File(filePath + "/" + fileName));
			sheet = workbook.getSheet(0);
			int row = sheet.getRows();
			int col = sheet.getColumns();

			
			if(row<=0){
				throw new Exception("내용이 없습니다.");
			}
			for(int i = 0; i< row; i++){
				HashMap<String, String> hm = new HashMap<String, String>();
				for(int j=0;j<col;j++){
					//System.out.println(col);
					hm.put("COL"+j, sheet.getCell(j,i).getContents());
				}
				list.add(i,hm);
			}
			
		}catch(IOException io){
			io.printStackTrace();
			System.out.println("io예외 : " + io);
			//throw io;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("e예외 : " + e);
			//throw e;
		}finally{
			try{
				if(workbook !=null){
					workbook.close();
				}
				
			}catch(Exception e){
				return list;
			}
		}
		return list;
	}
}
