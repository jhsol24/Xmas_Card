package com.wisenut.search.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface SearchMapper {

	public List<Map<String, Object>> getCategories(String cfsv_id) throws Exception;
	
}
