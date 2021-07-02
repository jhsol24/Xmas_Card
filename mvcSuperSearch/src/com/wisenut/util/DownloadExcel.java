package com.wisenut.util;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.wisenut.run.controller.RunController;

public class DownloadExcel {
	private static Logger logger = LogManager.getLogger(DownloadExcel.class);
	private HttpServletResponse response;
	private XSSFWorkbook wb;

	public DownloadExcel(String filename, HttpServletRequest request, HttpServletResponse response, XSSFWorkbook wb) { 
		this.response = response; 
		this.wb = wb; 
		try { 
			String browser = request.getHeader("user-agent"); // 브라우저 확인하는 메서드 
			String encodedFilename = null; 
			if (browser.indexOf("MSIE") > -1 || browser.indexOf("Trident") > -1) { 
				encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll( "\\+", "%20"); 
			} else if (browser.indexOf("Firefox") > -1) { 
				encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\""; 
			} else if (browser.indexOf("Opera") > -1 || browser.indexOf("OPR") > -1) { 
				encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\""; 
			} else if (browser.indexOf("Chrome") > -1) { 
				StringBuffer sb = new StringBuffer(); 
				for (int i = 0; i < filename.length(); i++) { 
					char c = filename.charAt(i); 
					if (c > '~') { 
						sb.append(URLEncoder.encode("" + c, "UTF-8")); 
					} else { 
						sb.append(c); 
					} 
				} 
				encodedFilename = sb.toString(); 
			} else { 
				throw new IOException("Not supported browser"); 
			} 
			response.setHeader("Content-Disposition", "attachment; filename=" + encodedFilename); 
			if("Opera".equals(browser)){ 
				response.setContentType("application/octet-stream;charset=UTF-8"); 
			} 
		} catch (IOException e) { 
			logger.error("[Excel Download Error]"); 
		} 
	}
}
