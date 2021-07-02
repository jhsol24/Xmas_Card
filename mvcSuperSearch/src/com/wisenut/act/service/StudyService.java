package com.wisenut.act.service;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.wisenut.act.mapper.StudyMapper;
import com.wisenut.act.vo.CategoryVo;
import com.wisenut.act.vo.StudyExcelDownVo;
import com.wisenut.act.vo.StudyVo;
import com.wisenut.act.vo.TrainingVo;

@Service
public class StudyService {

	private Logger logger = Logger.getLogger(StudyService.class);

	@Autowired
	private StudyMapper mapper;
	
	/**
	 * 
	 * @param items_data
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	public boolean isDuplicate(String items_data, String cfsv_id, String u_items) throws Exception{
		
		CategoryVo cateVo = new CategoryVo();
		
		cateVo.setCFSV_ID(Integer.parseInt(cfsv_id));
		cateVo.setCFCT_VALUE(items_data);
		if(!"".equals(u_items)) cateVo.setCFCT_ID(Integer.parseInt(u_items));
		
		int cnt = mapper.getCountByValue(cateVo);
		
		if(cnt > 0) {
			return true;
		}
			
		return false;
	}

	/**
	 * 
	 * @param pItems
	 * @param items_depth
	 * @param items_text
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	public int insertTree(String pItems, String items_depth, String items_text, String items_data, String cfsv_id) throws Exception{
		
		CategoryVo cateVo = new CategoryVo();
		
		cateVo.setCFSV_ID(Integer.parseInt(cfsv_id));
		cateVo.setCFCT_VALUE(items_data);
		cateVo.setCFCT_NAME(items_text);
		cateVo.setCFCT_DEPTH(items_depth);
		cateVo.setCFCT_PR_ID(Integer.parseInt(pItems));
		cateVo.setCFCT_DESC("");
		
		mapper.insertTree(cateVo);
		
		logger.debug("ID ============== " + cateVo.getCFCT_ID());
			
		return cateVo.getCFCT_ID();
	}


	/**
	 * 
	 * @param u_pItems
	 * @param u_items
	 * @param u_items_text
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	public int updateTree(String pItems, String items_depth, String items_text, String items_data, String cfsv_id, String u_items) throws Exception {
		
		CategoryVo cateVo = new CategoryVo();
		
		cateVo.setCFSV_ID(Integer.parseInt(cfsv_id));
		cateVo.setCFCT_ID(Integer.parseInt(u_items));
		cateVo.setCFCT_VALUE(items_data);
		cateVo.setCFCT_NAME(items_text);
		cateVo.setCFCT_PR_ID(Integer.parseInt(pItems));
		
		mapper.updateTree(cateVo);
			
		return 0;
	}


	/**
	 * 검색엔진 연동 학습데이터 저장
	 * @param checkItems
	 * @param cfct_id
	 * @return
	 * @throws Exception
	 */
//	public int setStudy(List<Map<String, Object>> searchDetailList, String cfct_id, String collectionName, String docField) throws Exception{
//		
//		StudyVo vo = null;
//		StringBuffer sb = null;
//		
//		// 검색엔진 결과를 받아  DB 인서트
//		for(int idx=0; idx<searchDetailList.size(); idx++){
//			vo = new StudyVo();
//			sb = new StringBuffer();
//			for(String doc : docField.split(",")){
//				sb.append(searchDetailList.get(idx).get(doc).toString() + "\n");
//			}
//			
//			vo.setCf_gubun(collectionName);
//			vo.setCfct_id(cfct_id);
//			vo.setCf_id((String) searchDetailList.get(idx).get("DOCID"));
//			vo.setCf_content(sb.toString());
//			logger.debug("### content : "+ sb.toString());
//			mapper.insertStudyData(vo);
//		}
//		
//		logger.debug("### List Size : " + searchDetailList.size());
//
//		return 0;
//	}
	


	public int updateStudy(String cfst_id, String cf_content) throws Exception {
		return mapper.updateStudyData(cfst_id, cf_content);
	}


	/**
	 * 
	 * @param stdVo
	 * @return
	 * @throws Exception
	 */
	public int getTotalStdList(StudyVo stdVo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getTotalStdList(stdVo);
	}


	/**
	 * 
	 * @param stdVo
	 * @return
	 * @throws Exception
	 */
	public List<StudyVo> getStdList(StudyVo stdVo)  throws Exception {
		// TODO Auto-generated method stub
		return mapper.getStdList(stdVo);
	}


	/**
	 * 
	 * @param delItems
	 * @return
	 * @throws Exception
	 */
	public int deleteStudy(String delItems) throws Exception{

		String[] delItemArr = delItems.split(",");
		for(String delItem : delItemArr){
			
			mapper.deleteStudy(delItem);
			
		}
		return 0;
	}
	

	/**
	 * 
	 * @param cfst_id
	 * @return
	 * @throws Exception
	 */
	public StudyVo getStdDetail(String cfst_id) throws Exception{
		
		return mapper.getStdDetail(cfst_id);
	}


	/**
	 * 
	 * @param d_items
	 * @return
	 * @throws Exception
	 */
	public int deleteTree(String d_items, String cfsv_id) throws Exception{
		
		String[] delItemArr = d_items.split(",");
		CategoryVo cateVo = null;
		
		for(String delItem : delItemArr){
			cateVo = new CategoryVo();
			
			cateVo.setCFCT_ID(Integer.parseInt(delItem));
			cateVo.setCFSV_ID(Integer.parseInt(cfsv_id));
			mapper.deleteCateStudy(cateVo);
			mapper.deleteTree(cateVo);
		}
		
		return 0;
	}


	/**
	 * @param cfct_id
	 * @param std_sentence
	 * @param save_cfsv_id 
	 * @return
	 * @throws Exception
	 */
	public void saveSentence(StudyVo studyVo) throws Exception{
 
		mapper.insertStudyData(studyVo);
	}
	
	
	/**
	 * @param cfsv_id
	 * @param req 
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getTrainingData(String cfsv_id, HttpServletRequest req) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		String outputPath = "/data/wisenut/tomcat8/webapps/classificatorManager/download/trainingData/training_data.xls";
		String downloadurl = "/download/trainingData/training_data.xls";
		
		String contextPath = req.getSession().getServletContext().getRealPath("download/analyExcel/");
		
		String collection 				= "singo";
		String excelFirstCellTitle 		= "";
		String excelSecondCellTitle 	= "";
		String excelThirdCellTitle 		= "분석결과";
		String excelFourthCellTitle 	= "분석결과상세";
		String excelShitName 			= "";
		String originalFileName			= "학습데이터.xlsx";
		
		// 분석결과 포함한 엑셀 다운로드
		XSSFWorkbook downWork = new XSSFWorkbook();
		XSSFSheet downSheet = downWork.createSheet(excelShitName);

		downSheet.setColumnWidth(0, 6000);
		downSheet.setColumnWidth(1, 7000);
		downSheet.setColumnWidth(2, 5000);
		downSheet.setColumnWidth(3, 6000);

		//스타일 설정
		XSSFCellStyle style = downWork.createCellStyle();
		style.setFillForegroundColor(HSSFColor.YELLOW.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);

		XSSFRow downRow = downSheet.createRow(0);
		XSSFCell cell = downRow.createCell(0);
		cell.setCellValue(excelFirstCellTitle);
		cell.setCellStyle(style);

		cell = downRow.createCell(1);
		cell.setCellValue(excelSecondCellTitle);
		cell.setCellStyle(style);

		cell = downRow.createCell(2);
		cell.setCellValue(excelThirdCellTitle);
		cell.setCellStyle(style);

		cell = downRow.createCell(3);
		cell.setCellValue(excelFourthCellTitle);
		cell.setCellStyle(style);


//		for (int downRownum = 0; downRownum < analExcelList.size(); downRownum++) {
//
//			CfApiVo runAnalyCf = analExcelList.get(downRownum);
//
//			downRow = downSheet.createRow(downRownum + 1);
//
//			downRow.createCell(0).setCellValue(runAnalyCf.getAnswer());
//			downRow.createCell(1).setCellValue(runAnalyCf.getContent());
//			downRow.createCell(2).setCellValue(runAnalyCf.getResultAnal());
//			downRow.createCell(3).setCellValue(runAnalyCf.getList().toString());
//		}
//
//		//엑셀파일 세팅 후 파일 생성
//		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
//		Date currentTime = new Date ( );
//		String dTime = formatter.format ( currentTime );
//
//		String[] arrOriginalFileName = originalFileName.split("\\.");
//		originalFileName = arrOriginalFileName[0].toString() + dTime + "." + arrOriginalFileName[1].toString();
//
//		try {
//
//			File file = new File(contextPath);
//
//			//file을 생성할 폴더가 없으면 생성합니다.
//			if(!file.exists()) {
//				file.mkdirs();
//			} else {
//				//기존 파일 제거
//				File[] delFiles = file.listFiles();
//				for(int i = 0; i < delFiles.length; i++) {
//					delFiles[i].delete();
//				}
//			}
//
//			logger.debug("############# down excel ###########");
//
//			analyExcelFullPath = file + File.separator + originalFileName;
//
//			fileOutputStream = new FileOutputStream(analyExcelFullPath);
//			downWork.write(fileOutputStream);
//
//		} catch(Exception e) {
//
//			e.printStackTrace();
//			retVo.setMessage("파일 분석에 실패 하였습니다.");
//			retVo.setResponse(false);
//
//		} finally {
//
//			if(fileOutputStream != null) fileOutputStream.close();
//
//		}
//
//		retVo.setMessage("성공");
//		retVo.setResponse(true);
//		retVo.setAnalyExcelFileName(originalFileName);
		
		
//		map.put("path", outputPath);
//		map.put("url", downloadurl);
//		map.put("filename", "training.xls");
//		
//		List<TrainingVo> trainingData = mapper.selectTrainingData(cfsv_id);
//		
//		int rownum;
//		HSSFWorkbook wb = new HSSFWorkbook();
//		HSSFSheet s = wb.createSheet();
//		HSSFCellStyle cs = wb.createCellStyle();
//		HSSFCellStyle cs2 = wb.createCellStyle();
//		HSSFFont f = wb.createFont();
//		HSSFFont f2 = wb.createFont();
//		
//		f.setFontHeightInPoints((short) 12);
//		f.setColor((short) 0xA);
//		f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
//		f2.setFontHeightInPoints((short) 10);
//		f2.setColor((short) 0xf);
//		f2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
//		cs.setFont(f);
//		cs.setDataFormat(HSSFDataFormat.getBuiltinFormat("($#,##0_);[Red]($#,##0)"));
//		cs2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//		cs2.setFillPattern((short) 1); // fill w fg
//		cs2.setFillForegroundColor((short) 0xA);
//		cs2.setFont(f2);
//		wb.setSheetName(0, "학습데이터");
//		
//		for (rownum = 0; rownum < trainingData.size(); rownum++) {
//			HSSFRow r = s.createRow(rownum);
//			
//			
//			HSSFCell c = r.createCell(0);
//			if(rownum == 0) c.setCellValue(new HSSFRichTextString("카테고리"));
//			else c.setCellValue((trainingData.get(rownum).getNm()));
//			
//			c = r.createCell(1);
//			if(rownum == 0) c.setCellValue(new HSSFRichTextString("학습내용"));
//			else c.setCellValue(trainingData.get(rownum).getCf_content());
//		}
//
//		// end deleted sheet
//		FileOutputStream out = new FileOutputStream(outputPath);
//		wb.write(out);
//		out.close();
//		
		return map;
	}
	
	
	/**
	 * 확인이 필요한 다운로드 기능
	 * @param resp
	 * @return
	 */
	public FileSystemResource downloadExcel(HttpServletResponse resp, String path, String fName) {

		resp.setContentType("application/download");
		resp.setContentLength(fName.length());
		//resp.setHeader("Content-Disposition", "attachment;" + " filename=\"" + Fname + "\";");
		FileSystemResource fsr = new FileSystemResource(path + fName);

		return fsr;
	}
	
	
	/**
	 * excelFileUpload
	 * 학습데이터 업로드
	 * 
	 * @param mfile
	 * @throws Exception 
	 */
	public Map<String, Object> excelFileUpload(MultipartFile mfile, String cfsv_id) throws Exception {
		
		Map<String, Object> map		= new HashMap<String, Object>();
		
		if(!mfile.isEmpty()) {
			logger.debug("### test : "  + mfile.getOriginalFilename());
			
			map = saveExcelData(mfile, cfsv_id);
		}
		
		return map;
}
	
	/**
	 * @param path
	 * @throws Exception
	 */
	@Transactional
	private synchronized Map<String, Object> saveExcelData(MultipartFile mfile, String cfsv_id) throws Exception {
		
		Map<String, Object> map		= new HashMap<String, Object>();
		CategoryVo cateVo 			= null;
		StudyVo studyVo				= null; 
		String cfctValue 			= "";
		String cfctName 			= "";
		String cfContent			= "";
		int cateCnt					= 0;
		int studyCnt				= 0;
		
		try {
			XSSFWorkbook work = new XSSFWorkbook(mfile.getInputStream());

			// 2번째 시트 (카테고리 입력)
			XSSFSheet sheet = work.getSheetAt(1);
			int rows = sheet.getPhysicalNumberOfRows();

			// 학습 데이터 삭제
			mapper.deleteTrainingAllData(cfsv_id);
			mapper.deleteCategoryAllData(cfsv_id);
			
			logger.debug("#### rows : " + rows);
			
			if(rows <= 1) {
				throw new Exception("카테고리 정의 시트가 비어 있습니다.");
			}
			
			// 카테고리 입력
			for (int rownum = 1; rownum < rows; rownum++) {
				cateVo = new CategoryVo();
				
				XSSFRow row = sheet.getRow(rownum);
				XSSFCell firstCell = row.getCell(0);
				XSSFCell secondCell = row.getCell(1);
				
				
				try {
					if(firstCell.getCellType() == firstCell.CELL_TYPE_NUMERIC) {
						cfctValue = Integer.toString((int)firstCell.getNumericCellValue());
					} else {
						try {
							cfctValue = firstCell.getStringCellValue();
							
						} catch (IllegalStateException e) {
							cfctValue = Integer.toString((int)firstCell.getNumericCellValue());
						}
					}
					if(secondCell.getCellType() == secondCell.CELL_TYPE_NUMERIC) {
						cfctName = Integer.toString((int)secondCell.getNumericCellValue());
					} else {
						
						try {
							cfctName = secondCell.getStringCellValue();
							
						} catch (IllegalStateException e) {
							cfctName = Integer.toString((int)secondCell.getNumericCellValue());
						}
					}
					
				} catch (NullPointerException e) {
					logger.error("공백이 있는 행이 있습니다.");
					continue;
				}
				
				cateVo.setCFSV_ID(Integer.parseInt(cfsv_id));
				cateVo.setCFCT_VALUE(cfctValue);
				cateVo.setCFCT_NAME(cfctName);
				cateVo.setCFCT_SORT(String.valueOf(rownum));
				cateVo.setCFCT_DEPTH("1");
				cateVo.setCFCT_DESC("행정안전부 학습데이터");
				mapper.insertCategory(cateVo);
				cateCnt++;
				logger.debug("###############  cateCnt : " + cateCnt);
			}

			// 입력 된 카테고리 리스트
			List<Map<String, String>> categories = mapper.getCategoriesBySvId(cfsv_id);
			
			// 학습 데이터 저장
			sheet = work.getSheetAt(0);
			rows = sheet.getPhysicalNumberOfRows();
			
			for(int rownum = 1; rownum < rows; rownum++) {
				
				XSSFRow row = sheet.getRow(rownum);
				XSSFCell firstCell = row.getCell(0);
				XSSFCell secondCell = row.getCell(1);
				try {
					if(firstCell.getCellType() == firstCell.CELL_TYPE_NUMERIC) {
						cfctValue = Integer.toString((int)firstCell.getNumericCellValue());
					} else {
						try {
							cfctValue = firstCell.getStringCellValue();

						} catch (IllegalStateException e) {
							cfctValue = Integer.toString((int)firstCell.getNumericCellValue());
						}
					}
					if(secondCell.getCellType() == secondCell.CELL_TYPE_NUMERIC) {
						cfContent = Integer.toString((int)secondCell.getNumericCellValue());
					} else {

						try {
							cfContent = secondCell.getStringCellValue();

						} catch (IllegalStateException e) {
							cfContent = Integer.toString((int)secondCell.getNumericCellValue());
						}
					}

				} catch (NullPointerException e) {
					logger.error("공백이 있는 행이 있습니다.");
					continue;
				}
			
				final String ctValue = cfctValue;

				Optional<Map<String, String>> cfCtOpt = categories.stream().filter(x -> x.get("CFCT_VALUE").equals(ctValue)).findFirst();
				
				if (cfCtOpt.isPresent() == true) {
					
					Map<String, String> cfCtMap = cfCtOpt.get();
					
					int cfCtId = Integer.parseInt(String.valueOf(cfCtMap.get("CFCT_ID")));
					
					studyVo = new StudyVo();
					studyVo.setCfst_content(cfContent);
					studyVo.setCfct_id(cfCtId);
					studyVo.setCfsv_id(Integer.parseInt(cfsv_id));
					studyVo.setCfst_gubun("");
					
					mapper.insertStudyData(studyVo);
					studyCnt++;
					logger.debug("###############  studyCnt : " + studyCnt);
					
				} else {
					logger.error("### 카테고리 시트에 등록되어 있지 않는 데이터입니다.  => " + cfctValue);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		map.put("studyCnt", studyCnt);
		map.put("cateCnt", cateCnt);
		
		
		return map;
	}
	
	
	/**
	 * @param list
	 * @param cfsv_id
	 * @throws Exception
	 */
//	private void insertTrainingData(ArrayList<TrainingVo> voList, String cfsv_id) throws Exception {
//		HashMap<String, String> idMap = getTreeidMap(cfsv_id);
//		logger.debug("### idMap : " + idMap.toString());
//		StudyVo vo = null;
//		
//		for(TrainingVo data : voList){
//			vo = new StudyVo();
//			vo.setCf_content(data.getCf_content());
//			vo.setCfct_nm(data.getNm());
//			logger.debug("### idMapNM : " + idMap.get(data.getNm().split("/").length > 1 ? data.getNm().split("/")[1] : data.getNm()));
//			logger.debug("### dataNM : " + data.getNm());
//			vo.setCfct_id(idMap.get(data.getNm().split("/").length > 1 ? data.getNm().split("/")[1] : data.getNm()));
//			mapper.insertStudyData(vo);
//		}
//	}
	
	
	
	/**
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	private HashMap<String, String> getTreeidMap(String cfsv_id) throws Exception {
		List<TrainingVo> idList = mapper.selectTreeIdList(cfsv_id);
		HashMap<String, String> idMap = new HashMap<>();
		for( TrainingVo tv : idList) {
			idMap.put(tv.getNm(), tv.getCfct_id());
		}
		return idMap;
	}


	/**
	 * 학습데이터 다운로드
	 * @param cfsv_id
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public StudyExcelDownVo downloadStudyData(String cfsv_id, HttpServletRequest req) throws Exception{
		
		String contextPath 		= req.getSession().getServletContext().getRealPath("download/trainingData/");
		String firstSheetName 	= "학습데이터";
		String originalFileName = "학습데이터.xlsx";
		String secondSheetName 	= "카테고리정의";
		String analyExcelFullPath = "";
		FileOutputStream fileOutputStream = null;
		StudyExcelDownVo retVo 	= new StudyExcelDownVo();
		
		List<StudyVo> studies = mapper.getStudyDataBySvId(cfsv_id);
		List<Map<String, String>> categories = mapper.getCategoriesBySvId(cfsv_id);
		
		// 엑셀 쓰기
		XSSFWorkbook downWork = new XSSFWorkbook();
		
		// 첫째 시트
		XSSFSheet downSheet = downWork.createSheet(firstSheetName);

		downSheet.setColumnWidth(0, 6000);
		downSheet.setColumnWidth(1, 7000);
		downSheet.setColumnWidth(2, 5000);
		downSheet.setColumnWidth(3, 6000);
		
		//스타일 설정
		XSSFCellStyle style = downWork.createCellStyle();
		style.setFillForegroundColor(HSSFColor.YELLOW.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		

		XSSFRow downRow = downSheet.createRow(0);
		XSSFCell cell = downRow.createCell(0);
		cell.setCellValue("카테고리");
		cell.setCellStyle(style);
		
		cell = downRow.createCell(1);
		cell.setCellValue("학습내용");
		cell.setCellStyle(style);
		

		for (int downRownum = 0; downRownum < studies.size(); downRownum++) {
			
			StudyVo studyVo = studies.get(downRownum);
			
			downRow = downSheet.createRow(downRownum + 1);
			
			downRow.createCell(0).setCellValue(studyVo.getCfct_value());
			downRow.createCell(1).setCellValue(studyVo.getCfst_content());
		}
		
		// 두번째 시트
		downSheet = downWork.createSheet(secondSheetName);

		downSheet.setColumnWidth(0, 6000);
		downSheet.setColumnWidth(1, 7000);
		downSheet.setColumnWidth(2, 5000);
		downSheet.setColumnWidth(3, 6000);

		//스타일 설정
		style = downWork.createCellStyle();
		style.setFillForegroundColor(HSSFColor.YELLOW.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);


		downRow = downSheet.createRow(0);
		cell = downRow.createCell(0);
		cell.setCellValue("카테고리코드(정렬순서)");
		cell.setCellStyle(style);

		cell = downRow.createCell(1);
		cell.setCellValue("카테고리코드명");
		cell.setCellStyle(style);


		for (int downRownum = 0; downRownum < categories.size(); downRownum++) {

			Map<String, String> cateMap = categories.get(downRownum);

			downRow = downSheet.createRow(downRownum + 1);

			downRow.createCell(0).setCellValue(cateMap.get("CFCT_VALUE"));
			downRow.createCell(1).setCellValue(cateMap.get("CFCT_NAME"));
		}
		
		

		//엑셀파일 세팅 후 파일 생성
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );

		String[] arrOriginalFileName = originalFileName.split("\\.");
		originalFileName = arrOriginalFileName[0].toString() + dTime + "." + arrOriginalFileName[1].toString();
		
		try {

			File file = new File(contextPath);

			//file을 생성할 폴더가 없으면 생성합니다.
			if(!file.exists()) {
				file.mkdirs();
			} else {
				//기존 파일 제거
				File[] delFiles = file.listFiles();
				for(int i = 0; i < delFiles.length; i++) {
					delFiles[i].delete();
				}
			}

			logger.debug("############# down excel ###########");

			analyExcelFullPath = file + File.separator + originalFileName;

			fileOutputStream = new FileOutputStream(analyExcelFullPath);
			downWork.write(fileOutputStream);

		} catch(Exception e) {

			e.printStackTrace();
			retVo.setMessage("파일 분석에 실패 하였습니다.");
			retVo.setResponse(false);

		} finally {

			if(fileOutputStream != null) fileOutputStream.close();

		}
		retVo.setMessage("성공");
		retVo.setResponse(true);
		retVo.setDownExcelFileName(originalFileName);
		
		
		return retVo;
	}
}
