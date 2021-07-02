package com.wisenut.util.cfUtil;

import java.util.List;
import java.util.Map;

public class CfApiVo {

	private List<Map<String, Object>> resultList;
	private String resultAnal;
	private Boolean response;
	private String message;
	private String content;
	private String answer;
	private String progress;
	private String status;
	private List<String> model_list;
	private String modelNm;
	
	public String getModelNm() {
		return modelNm;
	}
	public void setModelNm(String modelNm) {
		this.modelNm = modelNm;
	}
	
	public List<String> getModel_list() {
		return model_list;
	}
	public void setModel_list(List<String> model_list) {
		this.model_list = model_list;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Boolean getResponse() {
		return response;
	}
	public void setResponse(Boolean response) {
		this.response = response;
	}
	public List<Map<String, Object>> getResultList() {
		return resultList;
	}
	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public List<Map<String, Object>> getList() {
		return resultList;
	}
	public void setList(List<Map<String, Object>> list) {
		this.resultList = list;
	}
	public String getResultAnal() {
		return resultAnal;
	}
	public void setResultAnal(String resultAnal) {
		this.resultAnal = resultAnal;
	}
	
	@Override
	public String toString() {
		return "CfApiVo [resultList=" + resultList + ", resultAnal=" + resultAnal + ", reponse=" + response
				+ ", message=" + message + ", content=" + content + ", progress=" + progress + ", status=" + status + ", answer=" + answer + "]";
	}
	
	
}
