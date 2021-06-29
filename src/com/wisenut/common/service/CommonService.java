package com.wisenut.common.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wisenut.common.TreeChildModel;
import com.wisenut.common.TreeModel;
import com.wisenut.common.mapper.CommonMapper;
import com.wisenut.common.vo.CommonVo;
import com.wisenut.common.vo.ServerVo;
import com.wisenut.util.cfUtil.CfApiVo;

@Service
public class CommonService {

	
	private Logger logger = Logger.getLogger(CommonService.class);
	
	@Autowired
	private CommonMapper mapper;
	
	
	public List<TreeModel> getCodePrList(CommonVo vo) throws Exception {
		return mapper.getCodePrList(vo);
	}


	public List<TreeChildModel> getChildList(CommonVo vo) throws Exception {
		return mapper.getChildList(vo);
	}


	public List<ServerVo> getServerList() throws Exception{
		return mapper.getServerList();
	}


	public Map<String, Object> getServerRoot(String server_id) throws Exception{
		return mapper.getServerRoot(server_id);
	}


	public List<Map<String, Object>> getBarChartData(String cfsv_id) throws Exception {
		
		return mapper.getBarChartData(cfsv_id);
	}


	public CfApiVo getServerSatatus(String cfsv_id) {
		// TODO Auto-generated method stub
		return null;
	}

}
