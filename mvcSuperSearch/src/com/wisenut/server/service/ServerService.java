package com.wisenut.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeHandler;
import org.apache.log4j.Logger;

import com.wisenut.act.vo.ActVo;
import com.wisenut.server.controller.ServerController;
import com.wisenut.server.mapper.ServerMapper;
import com.wisenut.server.vo.ServerVo;

@Service
public class ServerService {
	
	private Logger logger = Logger.getLogger(ServerService.class);
	
	@Autowired
	private ServerMapper mapper;
	

	public int saveServer(ServerVo serverVo) throws Exception{
		return mapper.saveServer(serverVo);
	}


	public int getTotalActList(ServerVo serverVo) throws Exception{
		return mapper.getTotalActList(serverVo);
	}


	public List<ServerVo> getList(ServerVo serverVo) throws Exception{
		return mapper.getList(serverVo);
	}

	public ServerVo getDetail(ServerVo serverVo) throws Exception{
		return mapper.getDetail(serverVo);
	}


	public int updateServer(ServerVo serverVo)  throws Exception{
		return mapper.updateServer(serverVo);
	}
	
	public int deleteServer(ServerVo serverVo) throws Exception{
		
		String cfsvId = serverVo.getD_cfsv_id();
		
		String[] cfsvIds = cfsvId.split(",");
		
		int delCnt = 0;
		
		for(int i = 0; i < cfsvIds.length; i++) {
			
			serverVo.setP_cfsv_id(cfsvIds[i]);	//서버ID :서버ID : ## p_cfsv_id : n
			mapper.deleteServer(serverVo);
			delCnt++;
		}
		
		return delCnt;
	}
	
	
}
