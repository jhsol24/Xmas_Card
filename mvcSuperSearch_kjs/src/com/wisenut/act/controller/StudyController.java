package com.wisenut.act.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wisenut.act.service.StudyService;
import com.wisenut.act.vo.StudyExcelDownVo;
import com.wisenut.act.vo.StudyVo;
import com.wisenut.common.Page;
import com.wisenut.search.service.SearchService;

@Controller
@RequestMapping(value="/study")
public class StudyController {

	private Logger logger = Logger.getLogger(StudyController.class);
	
	@Autowired
	private StudyService studyService;
	
	@Autowired
	private SearchService searchService;
	
	
	/**
	 * 학습데이터 관리 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/studyMove.wn")
	public String studyMove() throws Exception {
		
		logger.debug("### studyMove ###");
		
		return "act/studyMng";	
	}
	
	
	/**
	 * 학습데이터 관리 트리메뉴 저장(분류 카테고리 입력,수정)
	 * @param pItems
	 * @param items_text
	 * @param u_pItems
	 * @param u_items
	 * @param u_items_text
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveTree.wn")
	@ResponseBody
	public Map<String, Object> saveTree( @RequestParam("pItems") String pItems
            						   , @RequestParam("items_text") String items_text 
            						   , @RequestParam("items_depth") String items_depth 
            						   , @RequestParam("items_data") String items_data
            						   , @RequestParam("u_items") String u_items
            						   , @RequestParam("cfsv_id") String cfsv_id
            						   ) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(studyService.isDuplicate(items_data, cfsv_id, u_items)) {
			map.put("result", "D");
			return map;
		}
		
		if("".equals(u_items)) {
			int id = studyService.insertTree(pItems, items_depth , items_text, items_data, cfsv_id);
			map.put("result", "I");
			map.put("id", id);
		}else {
			studyService.updateTree(pItems, items_depth , items_text, items_data, cfsv_id, u_items);
			map.put("result", "U");
		}
		
		return map;
	}
	
	/**
	 * 학습데이터 관리 트리메뉴 삭제(체크 된 항목을 삭제한다./ 카테고리 + 학습데이터 삭제
	 * @param d_items
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteTree.wn")
	@ResponseBody
	public Map<String, Object> deleteTree(@RequestParam("d_items") String d_items, @RequestParam("cfsv_id") String cfsv_id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		int delCnt = studyService.deleteTree(d_items, cfsv_id);
		
		return map;
	}
	
	
//	/**
//	 * 학습데이터 저장(화살표 이용 및 검색엔진 연동)
//	 * @param checkItems
//	 * @param cfct_id
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/setStudy.wn")
//	@ResponseBody
//	public List<Map<String, Object>> setStudy( @RequestParam("checkItems") String checkItems
//			   						   , @RequestParam("cfct_id") String cfct_id
//			   						   , @RequestParam("docField") String docField
//			   						   , @RequestBody @ModelAttribute QueryVo searchQuery) throws Exception{
//		
//		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
//				
//		// 필요한 목록 가져오기
//		list = searchService.getJsonDetail(searchQuery, checkItems);
//		studyService.setStudy(list, cfct_id, searchQuery.getCollection(), docField);
//		
//		logger.debug("checkItems : " + checkItems);
//		logger.debug("cfct_id : " + cfct_id);
//
//		return list; 
//	}
	
	/**
	 * 학습데이터 검색
	 * @param model
	 * @param stdVo
	 * @param std_query
	 * @param pagingPageBlock
	 * @param pagingPageSize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getStudyDataList.wn")
	@ResponseBody
	public Map<String, Object> getStudyDataList( Model model
									           , @RequestBody @ModelAttribute StudyVo stdVo
										       , @RequestParam("std_query") String std_query
										       , @Value("#{common['paging.pageBlock']}") String pagingPageBlock
										       , @Value("#{common['paging.pageSize']}")  String pagingPageSize) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		String pageNum = "".equals(stdVo.getPageNum()) ||  stdVo.getPageNum() == null ? "1" : stdVo.getPageNum();
		
		logger.debug("### pageNum   : " + pageNum);
		logger.debug("### pageSize  : " + pagingPageSize);
		logger.debug("### pageBlock : " + pagingPageBlock);
		
		// 페이징 start
		Page page 		= Page.getInstance();
		int pageSize 	= Integer.parseInt(pagingPageSize);
		int pageBlock 	= Integer.parseInt(pagingPageBlock);
		logger.debug("## getStudyDataList  getStd_query  : " + stdVo.getStd_query());
		logger.debug("## getStudyDataList  getStd_cfct_id  : " + stdVo.getStd_cfct_id());
		
		
		int totalCount 	= studyService.getTotalStdList(stdVo); //화면별 총갯수 필수.
		logger.debug("totalCount : " + totalCount);
		page.paging(Integer.parseInt(pageNum), totalCount, pageSize, pageBlock, "fn_getStudyDataList");
		// 페이징 end
		
		
		logger.debug("totalCount : " + totalCount);
		logger.debug("page.getStartRow() : " + page.getStartRow());
		logger.debug("page.getEndRow() : " + page.getEndRow());
		
		stdVo.setStartNum(page.getStartRow());
		stdVo.setEndNum(page.getEndRow());
		
		List<StudyVo> list = studyService.getStdList(stdVo);
		
		logger.debug("### list : " + list);
		
		map.put("pageCode"	, page.getSb().toString());
		map.put("totalCount", totalCount);
		map.put("stdVo"		, stdVo);
		map.put("std_query"	, std_query);
		map.put("list"		, list);
		
		return map;
	}
	
	/**
	 * 학습데이터 삭제(화살표 이용)
	 * @param delItems
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteStudy.wn")
	@ResponseBody
	public Map<String, Object> deleteStudy(@RequestParam("delItems") String delItems) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		int delCnt = studyService.deleteStudy(delItems);
		
		
		return map;
	}
	
	
	
	/**
	 * 학습데이터 모달팝업 상세 
	 * @param delItems
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getStdDetail.wn")
	@ResponseBody
	public Map<String, Object> getStdDetail(@RequestParam("cfst_id") String cfst_id) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		StudyVo vo = studyService.getStdDetail(cfst_id);
		map.put("stdVo", vo);
		
		
		return map;
	}
	
	/**
	 * @param cfst_id
	 * @param cf_content
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateStudy.wn")
	@ResponseBody
	public Map<String, Object> updateSentence( @RequestParam("cfst_id") String cfst_id
											 , @RequestParam("cf_content") String cf_content) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.debug("### cfst_id : " + cfst_id);
		
		int udtCnt = studyService.updateStudy(cfst_id, cf_content); 
		
		return map;
	}
	

	/**
	 * 학습데이터 문장 입력
	 * @param cfct_id
	 * @param std_sentence
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveSentence.wn")
	@ResponseBody
	public Map<String, Object> saveSentence(  @RequestParam("cfct_id") int cfct_id
											, @RequestParam("std_sentence") String std_sentence
											, @RequestParam("save_cfsv_id") int save_cfsv_id) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.debug("### cfct_id : " + cfct_id );
		
		StudyVo studyVo = new StudyVo();
		
		studyVo.setCfct_id(cfct_id);
		studyVo.setCfst_content(std_sentence);
		studyVo.setCfsv_id(save_cfsv_id);
		studyVo.setCfst_gubun("");
		studyService.saveSentence(studyVo);
		
		return map;
	}
	
	
	/**
	 * 학습데이터 업로드
	 * @param mRequest
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveStdExcel.wn")
	@ResponseBody
	public Map<String, Object> saveExcelFile(MultipartHttpServletRequest mRequest, @RequestParam("excel_cfsv_id") String cfsv_id) throws Exception {
		
		logger.debug("#### saveStdExcel.wn ##### ");
		
		Map<String, Object> map = studyService.excelFileUpload(mRequest.getFile("fname"), cfsv_id);
		
		return map;
	}
	
	
	/**
	 * @param resp
	 * @return
	 */
	@RequestMapping(value="/downloadSample.wn")
	@ResponseBody
	public FileSystemResource downloadSample(HttpServletResponse resp) {
		logger.debug("### response : " + resp.getContentType());
		// String path = "/data/wisenut/tomcat8/webapps/classificatorManager/download/trainingSample/";
		String path = "E:\\data\\";
		String fName = "trainingSample.xlsx";
		return studyService.downloadExcel(resp, path, fName);
	}
	
	
	/**
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadTraining.wn")
	@ResponseBody
	public Map<String,String> downloadTraining( @RequestParam("cfsv_id") String cfsv_id
			                                  , HttpServletRequest req) throws Exception {
		return studyService.getTrainingData(cfsv_id, req);
	}
	
	
	/**
	 * 학습데이터 다운로드
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadStudyData.wn")
	@ResponseBody
	public Map<String,Object> downloadStudyData( @RequestParam("cfsv_id") String cfsv_id
			                                  , HttpServletRequest req) throws Exception {
		logger.debug("########## downloadStudyData ##############");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		StudyExcelDownVo retVo = studyService.downloadStudyData(cfsv_id, req);
		
		
		map.put("retVo", retVo);
		
		
		return map;
	}
	
	
	
	
	
}
