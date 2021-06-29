package com.wisenut.act.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.wisenut.act.vo.ActVo;
import com.wisenut.server.vo.ServerVo;

@MapperScan
public interface ActMapper {

	ServerVo getServer(String cfsv_id) throws Exception;
	

	
	
	
	

	
	
	
	
	
	
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//이하 학습관리 사용 여부 확인요.	





	int getTotalActList(ActVo actVo) throws Exception;

	List<ActVo> getActList(ActVo actVo) throws Exception;

	ActVo getDetail(String cf_id) throws Exception;

}
