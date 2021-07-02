package com.wisenut.common.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

import com.wisenut.common.TreeChildModel;
import com.wisenut.common.TreeModel;
import com.wisenut.common.vo.CommonVo;
import com.wisenut.common.vo.ServerVo;

@MapperScan
public interface CommonMapper {

	
	public List<TreeModel> getCodePrList(CommonVo vo) throws Exception;

	public List<TreeChildModel> getChildList(CommonVo vo) throws Exception;

	public List<ServerVo> getServerList() throws Exception;

	public Map<String, Object> getServerRoot(String server_id) throws Exception;

	public List<Map<String, Object>> getBarChartData(String cfsv_id) throws Exception;
	
	
}
