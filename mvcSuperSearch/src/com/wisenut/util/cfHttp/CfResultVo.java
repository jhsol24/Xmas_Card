package com.wisenut.util.cfHttp;

import java.util.List;

public class CfResultVo {

	private String message;
	private List<CfPredictVo> predict;
	private String status;
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public List<CfPredictVo> getPredict() {
		return predict;
	}
	public void setPredict(List<CfPredictVo> predict) {
		this.predict = predict;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "CfResultVo [message=" + message + ", predict=" + predict + ", status=" + status + "]";
	}
	
	
	
	
	
	
	
	
}
