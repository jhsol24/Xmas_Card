package com.wisenut.run.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wisenut.run.service.RunService;
import com.wisenut.run.vo.RunBigAnalExcelUploadVo;
import com.wisenut.util.cfHttp.CfResultVo;
import com.wisenut.util.cfUtil.CfApiVo;

@Controller
@RequestMapping(value = "/run")
public class RunController {
	
	private static Logger logger = LogManager.getLogger(RunController.class);
	
	@Autowired
	RunService service;
	
	/**
	 * 시작페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/runMove.wn")
	public String runMove(Model model) throws Exception {

		return "run/run";
	}
	

	
	/**
	 * 대용량 분석 엑셀 업로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/analyExcelRun.wn")
	@ResponseBody
	public Map<String, Object> analyExcelRun(MultipartHttpServletRequest mRequest
			                               , HttpServletRequest req
			                               , @RequestParam("excel_cfsv_id") String cfsv_id
			                               , @RequestParam("anal_threshold") String anal_threshold) throws Exception {
		
		logger.info("####### maxThreashHolder setting => " + anal_threshold);
		RunBigAnalExcelUploadVo analyExcelRunVo = service.analyExcelRun(mRequest.getFile("fname"), req, cfsv_id, anal_threshold);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("analyExcelRunVo", analyExcelRunVo);
		
		return map;
	}
	
	
	
	/**
	 * 학습실행
	 * @param docField
	 * @param collection
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/createTraining.wn")
	public Map<String, Object> createTrainingData(@RequestParam("cfsv_id") String cfsv_id) throws Exception {
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.debug("### cfsv_id : " + cfsv_id);
		
		int isOk = service.createTraningData(cfsv_id);
		if(isOk < 0) {
			map.put("ok", false);
		}else {
			
			try {
				CfApiVo rsVo = service.procTrain(cfsv_id);
				logger.debug("#### rsVo.getReponse() : " + rsVo.getResponse());
				if(rsVo.getResponse()){
					map.put("ok", true);
				}else {
					map.put("ok", false);
				}
			} catch (Exception e) {
				e.printStackTrace();
				map.put("ok", false);
			}
		}
		return map;
	}
	
	
	/**
	 * 서버상태체크
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getServerSatatus.wn")
	public Map<String, Object> getServerSatatus(@RequestParam("cfsv_id") String cfsv_id) throws Exception {
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.debug("### getServerSatatus  cfsv_id : " + cfsv_id);
		
		CfApiVo rsVo = service.getServerSatatus(cfsv_id);
		
		map.put("progress", rsVo.getProgress());
		map.put("status", rsVo.getStatus());
		map.put("response", rsVo.getResponse());
		
		
		return map;
	}
	

	/**
	 * 학습상태체크
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getStudyStatus.wn")
	public Map<String, Object> getStudyStatus(@RequestParam("cfsv_id") String cfsv_id) throws Exception {
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.debug("### getStudyStatus cfsv_id : " + cfsv_id);
		
		CfApiVo rsVo = service.getStudyStatus(cfsv_id);
		
		map.put("progress", rsVo.getProgress());
		map.put("status", rsVo.getStatus());
		map.put("response", rsVo.getResponse());
		
		
		return map;
	}
	

	
	/**
	 * 모덜정보 조회
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getModelInfo.wn")
	public Map<String, Object> getModelInfo(@RequestParam("cfsv_id") String cfsv_id) throws Exception {
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.debug("### getModelInfo cfsv_id : " + cfsv_id);
		
		CfApiVo rsVo = service.getModelInfo(cfsv_id);
		
		
		map.put("modelNm", rsVo.getModelNm());
		map.put("progress", rsVo.getProgress());
		map.put("status", rsVo.getStatus());
		map.put("response", rsVo.getResponse());
		
		
		return map;
	}

	
}
