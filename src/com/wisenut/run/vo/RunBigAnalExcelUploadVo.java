package com.wisenut.run.vo;

public class RunBigAnalExcelUploadVo {

	private Boolean response;
	private String message;
	private String analyExcelFileName;
	
	public String getAnalyExcelFileName() {
		return analyExcelFileName;
	}
	public void setAnalyExcelFileName(String analyExcelFileName) {
		this.analyExcelFileName = analyExcelFileName;
	}
	public Boolean getResponse() {
		return response;
	}
	public void setResponse(Boolean response) {
		this.response = response;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
