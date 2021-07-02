package com.wisenut.run.service;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.wisenut.common.mapper.CommonMapper;
import com.wisenut.common.vo.QueryVo;
import com.wisenut.run.mapper.RunMapper;
import com.wisenut.run.vo.CfTargetDataVo;
import com.wisenut.run.vo.RunBigAnalExcelUploadVo;
import com.wisenut.search.service.SearchService;
import com.wisenut.server.mapper.ServerMapper;
import com.wisenut.server.vo.ServerVo;
import com.wisenut.util.FileHelper;
import com.wisenut.util.cfHttp.CfResultVo;
import com.wisenut.util.cfHttp.HttpService;
import com.wisenut.util.cfUtil.CfApiUtil;
import com.wisenut.util.cfUtil.CfApiVo;
			
@Service
public class RunService {
	
	private static Logger logger = LogManager.getLogger(RunService.class);
	private String DEVIDE = "::";
	
	@Autowired
	private SearchService searchService;
	
	@Autowired
	private RunMapper mapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	
	@Autowired
	private ServerMapper serverMapper;
	
	
	@Autowired
	FileHelper fileHelper;
	
	/**
	 * @param collection
	 * @param docField
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	public int createTargetData(String collection, String docField, String cfsv_id) throws Exception {		
		QueryVo queryVo = new QueryVo();
		queryVo.setCollection(collection);
		queryVo.setQuery("");
		queryVo.setListCount(50000);
		queryVo.setStartCount(0);
		
		List<Map<String, Object>> searchList = (List<Map<String, Object>>) searchService.getTotalSearchList(queryVo).get("list");
		int totalConunt = (int) searchService.getTotalSearchList(queryVo).get("totalCount");
		int idx = 0;
		int totalCheck = 0;
		
		List<Object> list = new ArrayList<Object>();
		CfTargetDataVo dataVo = null;
		StringBuffer sb = null;
		Boolean isTotal = false;
		
		
		int wrtCnt = 0;
		
		// 전체 데이터 List에 넣기
		while(!isTotal) {			
			for(; idx < searchList.size(); idx++){
				dataVo = new CfTargetDataVo();
				sb = new StringBuffer();
				for(String doc : docField.split(",")){
					sb.append(searchList.get(idx).get(doc).toString() + (docField.split(",").length == 1 ? "" : DEVIDE));
				}
				
				dataVo.setAlias(collection);
				dataVo.setDocid((String) searchList.get(idx).get("DOCID"));
				dataVo.setContent(sb.toString());
				wrtCnt++;
				list.add(dataVo);
			}
			
			logger.debug("### totalCheck : "+totalCheck);
			totalCheck += idx;

			if(totalCheck < totalConunt) {
				queryVo.setStartCount(totalCheck);
				idx = 0;
				searchList = (List<Map<String, Object>>) searchService.getTotalSearchList(queryVo).get("list");
			}else if(totalCheck > totalConunt) {
				isTotal = true;
			}
		}
		
		
		logger.info("수집 문서 건수 : " + wrtCnt);
		
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHHmmss");

		String path = mapper.getTargetDir(cfsv_id);
		
//		path = "D:\\";
		
		String fileNm = collection + "_" + simpleDate.format(new Date()) + ".json";
		
		logger.debug("### fileName : " + fileNm);
		logger.debug("### totalCount : " + totalConunt);

		return fileHelper.listToJsonFile(path, fileNm, list);
//		return fileHelper.ListToJsonFile("D:\\data\\", fileNm, list);
	}
	
	
	/**
	 * 학습데이터 파일 생성
	 * @param collection
	 * @param docField
	 * @param cfsv_id
	 * @return
	 * @throws Exception
	 */
	public int createTraningData(String cfsv_id) throws Exception {
		List<Object> list = mapper.selectTrainingData(cfsv_id);
		
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHHmmss");
		String path = mapper.getTrainingDir(cfsv_id);
		String fileNm = "mois_training_" + cfsv_id + "_" + simpleDate.format(new Date()) + ".json";
		
		logger.debug("### fileName : " + fileNm);
		

		return fileHelper.listToJsonFile(path, fileNm, list);
//		return fileHelper.listToJsonFile("C:\\C\\99.temp\\", fileNm, list);
	}
	
	
	
	/**
	 * 서버 상태 체크 
	 * @param cf_ip_m
	 * @param cf_port_m
	 * @param mode
	 */
	public void procGetStatus(String cf_ip_m, String cf_port_m, String mode){
		
		CfResultVo rsVo = HttpService.callHttp(cf_ip_m, cf_port_m, mode, "GET");
		logger.info(rsVo.getStatus());
		
	}
	
	
	/**
	 * 학습 실행 
	 * @param cf_ip_m
	 * @param cf_port_m
	 * @param mode
	 * @param cf_std_indir
	 * @throws Exception
	 */
	public CfApiVo procTrain(String cfsv_id) throws Exception{
		
		ServerVo serverVo = new ServerVo(); 
		serverVo.setP_cfsv_id(cfsv_id);
		serverVo = serverMapper.getDetail(serverVo);
		 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("collection", "singo");
		
		CfApiVo rsVo = CfApiUtil.runTrainCf(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), "train", "POST", params);
		
		logger.info("##### response : " + rsVo.getResponse());
		logger.info("##### message : " + rsVo.getMessage());
		
		return rsVo;
	}


	
	/**
	 *  
	 * @param cf_ip_m
	 * @param cf_port_m
	 * @param mode
	 * @param cf_std_indir
	 * @throws Exception 
	 */
	public CfResultVo procClassifyFile(String cfsv_id) throws Exception{
		
		ServerVo serverVo = new ServerVo(); 
		serverVo.setP_cfsv_id(cfsv_id);
		serverVo = serverMapper.getDetail(serverVo);
		 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("inputDir", serverVo.getCfsv_anal_indir());
		params.put("outputDir", serverVo.getCfsv_anal_outdir());
		params.put("content", "content");
		params.put("predictField", "result");
		params.put("outputFields", "docid,alias");
		params.put("fileType", "json");
		
		CfResultVo rsVo = HttpService.callHttp(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), "classifyFile", "POST", params);
		
		logger.info(rsVo.getStatus());
		logger.info(rsVo.getMessage());
		
		return rsVo;
	}


	/**
	 * 대용량 분석 엑셀 업로드 
	 * @param file
	 * @param cfsv_id
	 * @param anal_threshold 
	 * @throws Exception
	 */
	public RunBigAnalExcelUploadVo analyExcelRun(MultipartFile mfile, HttpServletRequest req, String cfsv_id, String anal_threshold) throws Exception{
		
		String contextPath = req.getSession().getServletContext().getRealPath("download/analyExcel/");

		String originalFileName         = mfile.getOriginalFilename();
		List<CfApiVo> analExcelList		= new ArrayList<CfApiVo>();
		RunBigAnalExcelUploadVo retVo 	= new RunBigAnalExcelUploadVo();
		XSSFWorkbook work 				= new XSSFWorkbook(mfile.getInputStream());
		XSSFSheet sheet 				= work.getSheetAt(0);
		int rows 						= sheet.getPhysicalNumberOfRows();
		final int maxRow 				= 100000;
		FileOutputStream fileOutputStream = null;
		String analyExcelFullPath 		= "";
		
		logger.debug("######### excel row count : " + rows);
		logger.debug("######### originalFileName : " + originalFileName);
		logger.debug("######### cfsv_id : " + cfsv_id);
		
		// validation
		if(rows > maxRow + 1) {
			retVo.setMessage("십만건 이상의 분석데이터는 처리 할 수 없습니다.");
			retVo.setResponse(false);
			return retVo;
		}
		
		// 서버 정보 가져오기 ip, port
		Map<String, Object> serverRoot 	= commonMapper.getServerRoot(cfsv_id);
		String serverIp 				= serverRoot.get("CFSV_IP").toString().trim();
		String serverPort 				= serverRoot.get("CFSV_PORT").toString().trim();
		String collection 				= "singo";
		String excelFirstCellTitle 		= "";
		String excelSecondCellTitle 	= "";
		String excelThirdCellTitle 		= "분석결과";
		String excelFourthCellTitle 	= "분석결과상세";
		String excelShitName 			= sheet.getSheetName();
		
		for (int rownum = 0; rownum < rows; rownum++) {
			
			XSSFRow row = sheet.getRow(rownum);

			XSSFCell firstCell = row.getCell(0);
			XSSFCell secondCell = row.getCell(1);
			
			
			if(secondCell == null) continue;
			
			firstCell.setCellType(Cell.CELL_TYPE_STRING);
			secondCell.setCellType(Cell.CELL_TYPE_STRING);
			
			String answerLabel = "";
			String content = "";
			
			if(firstCell.getCellType() == firstCell.CELL_TYPE_NUMERIC) {
				answerLabel = Integer.toString((int)firstCell.getNumericCellValue());
			} else {
				try {
					answerLabel = firstCell.getStringCellValue();
					
				} catch (IllegalStateException e) {
					answerLabel = Integer.toString((int)firstCell.getNumericCellValue());
					e.printStackTrace();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			if(secondCell.getCellType() == secondCell.CELL_TYPE_NUMERIC) {
				content = Integer.toString((int)secondCell.getNumericCellValue());
			} else {
				
				try {
					content = secondCell.getStringCellValue();
					
				} catch (IllegalStateException e) {
					logger.error("#### rownum : " + rownum + "  #### error : " + e.getMessage());
					logger.debug("### " +  rownum);
					e.printStackTrace();
					content = Integer.toString((int)secondCell.getNumericCellValue());
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			
			if(rownum == 0) { //헤더 세팅
				
				excelFirstCellTitle = answerLabel;
				excelSecondCellTitle = content;
				
			} else {
				
				if(rownum == 2 || rownum == 3) Thread.sleep(4000); //대용량 분석 시작시에 CF엔진이 모델 로드 할 시간을 줌 
				
				if("".equals(content)) continue;
				
				//CF 엔진 호출
				CfApiVo runAnalyCf = CfApiUtil.runAnalyCf(collection, content, serverIp, serverPort, Double.valueOf(anal_threshold));
				
				runAnalyCf.setContent(content);
				runAnalyCf.setAnswer(answerLabel);
				
				analExcelList.add(runAnalyCf);
				
			}
			
			if(rownum % 100 == 0) logger.debug("############# read excel : " + rownum); 
			
		}

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
		
		
		for (int downRownum = 0; downRownum < analExcelList.size(); downRownum++) {
			
			CfApiVo runAnalyCf = analExcelList.get(downRownum);
			
			downRow = downSheet.createRow(downRownum + 1);
			
			downRow.createCell(0).setCellValue(runAnalyCf.getAnswer());
			downRow.createCell(1).setCellValue(runAnalyCf.getContent());
			downRow.createCell(2).setCellValue(runAnalyCf.getResultAnal());
			downRow.createCell(3).setCellValue(runAnalyCf.getList().toString());
		}
		
		//엑셀파일 세팅 후 파일 생성
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );
		
		String[] arrOriginalFileName = originalFileName.split("\\.");
		originalFileName = arrOriginalFileName[0].toString() + dTime + "." + arrOriginalFileName[1].toString();
		
		try {
			
			File file = new File(contextPath);
			boolean checkDel = true;
			
			
			//file을 생성할 폴더가 없으면 생성합니다.
			if(!file.exists()) {
				file.mkdirs();
			} else {
				//기존 파일 제거
				File[] delFiles = file.listFiles();
				for(int i = 0; i < delFiles.length; i++) {
					checkDel = delFiles[i].delete();
				}
			}
			
			logger.debug("#### checkDel : " + checkDel);
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
		retVo.setAnalyExcelFileName(originalFileName);
		
		return retVo;
		
	}


	public CfApiVo getStudyStatus(String cfsv_id) throws Exception {
		ServerVo serverVo = new ServerVo(); 
		serverVo.setP_cfsv_id(cfsv_id);
		serverVo = serverMapper.getDetail(serverVo);
		
		CfApiVo rsVo = CfApiUtil.getStudyStatus(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), "status", "GET");
		
		logger.info("##### response : " + rsVo.getResponse());
		logger.info("##### progress : " + rsVo.getProgress());
		logger.info("##### status : " + rsVo.getStatus());
		
		return rsVo;
	}


	public CfApiVo getServerSatatus(String cfsv_id) throws Exception {
		ServerVo serverVo = new ServerVo(); 
		serverVo.setP_cfsv_id(cfsv_id);
		serverVo = serverMapper.getDetail(serverVo);
		
		CfApiVo rsVo = CfApiUtil.getServerSatatus(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), "status", "GET");
		
		logger.info("##### response : " + rsVo.getResponse());
		logger.info("##### progress : " + rsVo.getProgress());
		logger.info("##### status : " + rsVo.getStatus());
		
		return rsVo;
	}


	
	public CfApiVo getModelInfo(String cfsv_id)  throws Exception{
		ServerVo serverVo = new ServerVo(); 
		serverVo.setP_cfsv_id(cfsv_id);
		serverVo = serverMapper.getDetail(serverVo);
		
		CfApiVo rsVo = CfApiUtil.getModelInfo(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), "model", "GET", "singo");
		
		List<String> modelList = rsVo.getModel_list();
		
		if(modelList != null && modelList.size() > 0) rsVo.setModelNm(modelList.get(modelList.size() - 1).toString());
		
		logger.debug("#### rsVo  : " + rsVo);
		logger.info("##### response : " + rsVo.getResponse());
		logger.info("##### progress : " + rsVo.getProgress());
		logger.info("##### status : " + rsVo.getStatus());
		
		return rsVo;
	}

	
	
	
}
