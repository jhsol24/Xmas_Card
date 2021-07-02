package com.wisenut.act.service;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.wisenut.common.vo.QueryVo;
import com.wisenut.common.wnsearch.WNSearch;
import com.wisenut.util.FileHelper;

@Service
public class StudyResultService {
	
	private Logger logger = Logger.getLogger(StudyResultService.class);
	
	@Value("#{common['search.path.indexer']}")
	String indexerFile;
	
	@Value("#{common['search.path.config']}")
	String configFile;
	
	@Autowired
	WNSearch search;
	
	public void makeScdFile(String collection, String uid, String gubun) {
		try {
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHHmmss");
			String date = simpleDate.format(new Date());
			
			String dynamicScdFileName = "B-00-" + date.substring(0, 12) + "-" + date.substring(9, 14) + "-U-C.SCD";
			String outputPath = "/data/wisenut/sf-1/collection/" + collection + "/scd/dynamic/";
			//String outputPath = "E:\\";

			QueryVo searchQuery = new QueryVo();
			searchQuery.setCollection(collection);
			String scd = search.getScdDetail(searchQuery, uid);
			String newScd = scd.replaceAll("\\<XGBOOST_ANAL_RS\\>\\S+", "<XGBOOST_ANAL_RS>" + gubun);

			FileHelper wirteFile = new FileHelper();
			wirteFile.stringToScdFile(outputPath, dynamicScdFileName, newScd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Boolean startIndexer(String collection, String mode) {
		try {
			String[] command = {indexerFile, configFile, collection , mode};
			Process process = new ProcessBuilder(command).start();
			
			InputStream is = process.getInputStream();
			logger.debug("### is read : "+ is.read());
			is.close();
			
			while(process.isAlive()){
				Thread.sleep(500);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
