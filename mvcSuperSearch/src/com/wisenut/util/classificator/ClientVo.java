package com.wisenut.util.classificator;

public class ClientVo {
	
	private String classificatorIp;
	private String classificatorPort;
	private String classificatorDiv;
	private String startDate;
	private String endDate;
	private String classificatorRetroYn;
	private String sentence;
	
	
	
	public String getSentence() {
		return sentence;
	}
	public void setSentence(String sentence) {
		this.sentence = sentence;
	}
	public String getClassificatorRetroYn() {
		return classificatorRetroYn;
	}
	public void setClassificatorRetroYn(String classificatorRetroYn) {
		this.classificatorRetroYn = classificatorRetroYn;
	}
	public String getClassificatorIp() {
		return classificatorIp;
	}
	public void setClassificatorIp(String classificatorIp) {
		this.classificatorIp = classificatorIp;
	}
	public String getClassificatorPort() {
		return classificatorPort;
	}
	public void setClassificatorPort(String classificatorPort) {
		this.classificatorPort = classificatorPort;
	}
	public String getClassificatorDiv() {
		return classificatorDiv;
	}
	public void setClassificatorDiv(String classificatorDiv) {
		this.classificatorDiv = classificatorDiv;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	

}
