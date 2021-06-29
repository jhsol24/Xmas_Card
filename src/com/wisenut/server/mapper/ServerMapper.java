package com.wisenut.server.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.wisenut.server.vo.ServerVo;
import com.wisenut.act.vo.ActVo;

@MapperScan
public interface ServerMapper {

	int saveServer(ServerVo serverVo) throws Exception;

	int getTotalActList(ServerVo serverVo) throws Exception;

	List<ServerVo> getList(ServerVo serverVo) throws Exception;

	ServerVo getDetail(ServerVo serverVo) throws Exception;

	int updateServer(ServerVo serverVo) throws Exception;
	
	int deleteServer(ServerVo serverVo) throws Exception;
}
