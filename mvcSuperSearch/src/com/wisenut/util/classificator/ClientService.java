package com.wisenut.util.classificator;

import java.util.List;

import org.apache.http.HttpException;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.google.gson.JsonSyntaxException;
import com.wisenut.util.classificator.pojo.ClassificationResponsePojo;
import com.wisenut.util.classificator.pojo.ClassifiedLabelPojo;
import com.wisenut.util.classificator.pojo.ServiceStatusPojo;

public class ClientService {
	
	private static Logger logger =  LogManager.getLogger(ClientService.class);

	public static List<ClassifiedLabelPojo> act(ClientVo cmVo) {

		String sentence = cmVo.getSentence();

		ClientForClassifierService ccs = new ClientForClassifierService(cmVo.getClassificatorIp(),
				Integer.parseInt(cmVo.getClassificatorPort()));
		ClassificationResponsePojo cfrp;
		List<ClassifiedLabelPojo> classifiedlabels = null;
		try {
			cfrp = ccs.classifySentence(sentence, ClientConstant.topK, ClientConstant.scoreThreshold);
			classifiedlabels = cfrp.getClassifiedlabels();
			
			logger.info("return classificator result : " + classifiedlabels);
			
			logger.debug("####################################");
			
			logger.debug("입력문장 : [" + sentence + "]");
			
			for(int i = 0 ; i < classifiedlabels.size() ; i++){
				
				ClassifiedLabelPojo pojo = classifiedlabels.get(i);
				int docCnt = 3;
				
				if(i >= docCnt) break;
				if(i == 0) logger.debug("분류 결과 : [" + pojo.getLabel() + "]");
				
				logger.debug("순위 : [" + (i+1) +"] || 뷴류 : [" + pojo.getLabel() + "] || 점수 : [" + pojo.getConfidence() + "]");
				
			}
			logger.debug("####################################");
			
			
		} catch (JsonSyntaxException | HttpException e) {
			logger.error(e.getMessage());
		}
		
		return classifiedlabels;
	}

	public static void getServerStatus(ClientVo cmVo) {

		ClientForClassifierService ccs = new ClientForClassifierService(cmVo.getClassificatorIp(),
				Integer.parseInt(cmVo.getClassificatorPort()));
		ServiceStatusPojo statusPojo;
		try {
			statusPojo = ccs.getServerStatus();
			logger.info("ClassifierService status : " + statusPojo.toString());

		} catch (JsonSyntaxException e) {
			logger.error(e.getMessage());
		} catch (HttpException e) {
			logger.error(e.getMessage());
		}

	}

	
}
