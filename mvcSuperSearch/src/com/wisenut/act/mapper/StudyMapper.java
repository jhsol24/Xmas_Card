package com.wisenut.act.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

import com.wisenut.act.vo.CategoryVo;
import com.wisenut.act.vo.StudyVo;
import com.wisenut.act.vo.TrainingVo;

@MapperScan
public interface StudyMapper {

	int getCountByValue(CategoryVo cateVo) throws Exception;
	
	void insertTree(CategoryVo cateVo) throws Exception;
	
	void updateTree(CategoryVo cateVo) throws Exception;

	List<StudyVo> selectAnalTargetData(String checkItems) throws Exception;

	void insertStudyData(StudyVo vo) throws Exception;
	
	int updateStudyData(String cfst_id, String cf_content) throws Exception;

	int getTotalStdList(StudyVo stdVo) throws Exception;

	List<StudyVo> getStdList(StudyVo stdVo) throws Exception;

	void deleteStudy(String delItem) throws Exception;

	StudyVo getStdDetail(String cfst_id) throws Exception;

	int deleteTree(CategoryVo cateVo) throws Exception;

	void deleteCateStudy(CategoryVo cateVo) throws Exception;

	int saveSentence(StudyVo studyVo) throws Exception;
	
	List<TrainingVo> selectTrainingData(String cfsv_id) throws Exception;
	
	int insertTrainingData(Map<String, Object> map) throws Exception;
	
	List<TrainingVo> selectTreeIdList(String cfsv_id) throws Exception; 
	
	void deleteTrainingAllData(String cfsv_id) throws Exception;
	
	void deleteCategoryAllData(String cfsv_id) throws Exception;
	
	int updateSort(String id, String name) throws Exception;

	void insertCategory(CategoryVo cateVo) throws Exception;

	List<Map<String, String>> getCategoriesBySvId(String cfsv_id) throws Exception;

	List<StudyVo> getStudyDataBySvId(String cfsv_id) throws Exception;
	
}



