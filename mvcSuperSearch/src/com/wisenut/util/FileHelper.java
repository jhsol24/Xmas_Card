package com.wisenut.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.wisenut.run.vo.CfTargetDataVo;
import com.wisenut.run.vo.CfTrainingDataVo;

@Component
public class FileHelper {
	
	private static Logger logger = LogManager.getLogger(FileHelper.class);
	private int SUCCESS = 0;
	private int FAIL = -1;
	
	public int listToJsonFile(String path, String fileNm, List<Object> list) {
		int result = FAIL;
		OutputStream os = null;

		try {
			File file = new File(path + File.separator + fileNm);
			os = new FileOutputStream(file);
			
			logger.debug("### Path : " +path + fileNm);
			
			ObjectMapper om = new ObjectMapper();
			om.writeValue(os, list);
			result = SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {	
			if(os != null) try { os.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return result;
	}
	
	
	public int stringToScdFile(String path, String fileNm, String scd) {
		int result = FAIL;
		OutputStream os = null;

		try {
			File file = new File(path + File.separator + fileNm);
			os = new FileOutputStream(file);
			
			logger.debug("### Path : " +path + fileNm);
			
			os.write(scd.getBytes());
			
			result = SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {	
			if(os != null) try { os.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return result;
	}

}
