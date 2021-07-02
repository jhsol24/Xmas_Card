package com.wisenut.search.service;

import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;

import com.wisenut.common.vo.QueryVo;
import com.wisenut.common.wnsearch.WNDefine;
import com.wisenut.common.wnsearch.WNSearch;
import com.wisenut.search.mapper.SearchMapper;

@Service
public class SearchService {
	
	@Autowired
	private SearchMapper mapper;
	
	private Logger logger = Logger.getLogger(SearchService.class);
	
	@Autowired
	private WNSearch search;
	
	/**
	 * @param queryVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTotalSearchList(QueryVo queryVo) throws Exception {
		return search.getTotalSearchList(queryVo);
	}
	
	
	/**
	 * @return
	 */
	public List<Map<String,String>> getCollectionList() {
		return search.getCollectionList();
	}
	
	
	/**
	 * @param queryVo
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getJsonDetail(QueryVo queryVo, String uid) throws Exception {
		return search.getJsonDetail(queryVo, uid);
	}
	
	
	/**
	 * @param collection
	 * @return
	 * @throws Exception
	 */
	public String[] getDoucmentField(String collection) throws Exception {
		String field = search.getDocumentField(collection);
		return field.split(",");
	}
	
	
	public List<HashMap<String, Object>> getTermsGroup(QueryVo queryVo) throws Exception {
		return search.getTermsGroup(queryVo);
	}
	
	
	/**
	 * @param queryVo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCategoryXGGubun(QueryVo queryVo) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		if("PMESII_ANAL_RS".equals(queryVo.getGroupField())){
			list = mapper.getCategories("40");
		}else {
			list = mapper.getCategories("39");
		}
		
		String[] strCol = queryVo.getCollection().split(",");
		
		for(int i = 0 ; i < strCol.length ; i++){
			queryVo.setCollection(strCol[i]);
			Map<String, Integer> tempMap = search.getCategoryGroupGubun(queryVo);
			//logger.debug("tempMap : " + tempMap);
				
			for(int idx=0; idx < list.size(); idx++) {
				if(tempMap.keySet().contains(list.get(idx).get("title"))) {
					list.get(idx).put("cnt", Integer.parseInt(tempMap.get(list.get(idx).get("title")).toString()) +  Integer.parseInt(list.get(idx).get("cnt").toString()));
				}
			}
		}
		return list;
	}
	
	/**
	 * @param queryVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> downloadSearchResult(QueryVo queryVo, String gubun) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		String outputPath = "/data/wisenut/tomcat8/webapps/classificatorManager/download/searchData/"+ gubun.replace("/", "_") + ".xls";
		String downloadurl = "/download/searchData/" + gubun.replace("/", "_") + ".xls";
		
		map.put("path", outputPath);
		map.put("url", downloadurl);
		map.put("filename", gubun.replace("/", "_") + ".xls");
		
		Map<String, Object> searchResult = search.getTotalSearchList(queryVo);
		
		int rownum = 0;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet s = wb.createSheet();
		HSSFCellStyle cs = wb.createCellStyle();
		HSSFCellStyle cs2 = wb.createCellStyle();
		HSSFFont f = wb.createFont();
		HSSFFont f2 = wb.createFont();
		
		f.setFontHeightInPoints((short) 12);
		f.setColor((short) 0xA);
		f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		f2.setFontHeightInPoints((short) 10);
		f2.setColor((short) 0xf);
		f2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		cs.setFont(f);
		cs.setDataFormat(HSSFDataFormat.getBuiltinFormat("($#,##0_);[Red]($#,##0)"));
		cs2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cs2.setFillPattern((short) 1); // fill w fg
		cs2.setFillForegroundColor((short) 0xA);
		cs2.setFont(f2);
		wb.setSheetName(0, "검색결과 데이터");
		
		List<Map<String, Object>> list = (List<Map<String, Object>>) searchResult.get("list");
		String field = setDownloadField(queryVo.getCollection());
		
		logger.debug("### download field : " +field);
		logger.debug("### list size : " + list.size());
		logger.debug("### outputPath : " + outputPath);
		logger.debug("### filename : " + gubun.replace("/", "_") + ".xls");
		
		String[] fieldArr = field.split(",");
		
		for (rownum = 0; rownum < list.size(); rownum++) {
			HSSFRow r = s.createRow(rownum);	
			
			HSSFCell c = r.createCell(0);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("날짜"));
			else c.setCellValue((String) list.get(rownum).get(fieldArr[0]));
			
			c = r.createCell(1);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("카테고리"));
			else c.setCellValue(gubun);
			
			c = r.createCell(2);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("제목"));
			else c.setCellValue((String) list.get(rownum).get(fieldArr[1]));
			
			c = r.createCell(3);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("내용"));
			else c.setCellValue((String) list.get(rownum).get(fieldArr[2]));
			
			if(fieldArr.length > 3) {
				c = r.createCell(4);
				if(rownum == 0) c.setCellValue(new HSSFRichTextString("내용2"));
				else c.setCellValue((String) list.get(rownum).get(fieldArr[3]));
			}
		}
		
		logger.debug("### OutputStream start");
		
		// end deleted sheet
		FileOutputStream out = new FileOutputStream(outputPath);
		wb.write(out);
		out.close();
		
		return map;
	}
	
	private String setDownloadField(String coll) throws Exception {
		String collectionName = coll.split("_")[2].toUpperCase();
		String downloadField = ReflectionUtils.findField(WNDefine.class, "DOWNLOAD_FIELD_" + collectionName, String.class).get(WNDefine.class).toString();		
		return downloadField;
	}
	
}
