package com.wisenut.run.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface RunMapper {
	
	public String getTargetDir(String cfsv_id) throws Exception;
	
	public String getTrainingDir(String cfsv_id) throws Exception;
	
	public List<Object> selectTrainingData(String cfsv_id) throws Exception;
	
}
