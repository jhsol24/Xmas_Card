package com.wisenut.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.common.TreeModel;
import com.wisenut.common.TreeRootModel;
import com.wisenut.common.service.CommonService;
import com.wisenut.common.vo.CommonVo;
import com.wisenut.common.vo.ServerVo;
import com.wisenut.util.cfUtil.CfApiVo;


@Controller
@RequestMapping(value="/code")
public class CommonCotroller {

	private Logger logger =  Logger.getLogger(CommonCotroller.class);
	
	@Autowired
	private CommonService service;
	
	/**
	 * 트리매뉴 가져오기
	 * @param pvo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getCodeList.wn")
	@ResponseBody
	public Map<String, Object> getCodeList(@RequestBody @ModelAttribute CommonVo pvo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		logger.debug("### getCodeList ###");
		
		logger.info("### serverid : " + pvo.getServer_id());
		
		pvo.setCfct_pr_id(pvo.getServer_id());
		List<TreeModel> list = service.getCodePrList(pvo);
		
		CommonVo vo = null;
		
		
//		for(TreeModel tModel : list){
//			vo = new CommonVo();
//			vo.setCfct_pr_id(tModel.getId());
//			vo.setServer_id(pvo.getServer_id());
//			List<TreeChildModel> childList = service.getChildList(vo);
//			
//			tModel.setChildren(childList);
//		}
//		
		
		Map<String, Object> rootMap = service.getServerRoot(pvo.getServer_id());
		
		
		TreeRootModel trModel = new TreeRootModel();
		trModel.setChildren(list);
		trModel.setId("0");
		trModel.setText(rootMap.get("CFSV_NM").toString());
		trModel.getState().setOpened(true);
		
		logger.debug("trModel : " + trModel.toString());
		
		
		map.put("trModel", trModel);
		
		return map;
	}
	
	@RequestMapping(value="/getServerList.wn")
	@ResponseBody
	public Map<String, Object> getServerList() throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ServerVo> serverList = service.getServerList();
		
		map.put("serverList", serverList);
		
		return map;
	}
	
	
	@RequestMapping(value="/getBarChartData.wn")
	@ResponseBody
	public Map<String, Object> getBarChartData(@RequestParam("cfsv_id") String cfsv_id) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = service.getBarChartData(cfsv_id);
		
		map.put("barChartDataList", list);
		
		
		
		return map;
	}
	
	
	
}
