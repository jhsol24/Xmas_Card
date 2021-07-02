package com.wisenut.act.vo;

import com.wisenut.common.CommonModel;

public class ActVo extends CommonModel{

	private String sentence;
	private String analConfidence;
	private String analLabel;
	
	private String analRs;
	private String analBigo;
	private String query;
	
	private String cf_id;
	private String cf_time;
	private String cf_category;
	private String cf_reg_dt;
	private String cf_upd_dt;
	private String cf_title;
	private String cf_content;
	private String cf_anal_yn;
	private String cf_anal_rs;
	private String cf_anal_bigo;
	private String cf_anal_dt;
	
	
	public String getCf_id() {
		return cf_id;
	}


	public void setCf_id(String cf_id) {
		this.cf_id = cf_id;
	}


	public String getCf_time() {
		return cf_time;
	}


	public void setCf_time(String cf_time) {
		this.cf_time = cf_time;
	}


	public String getCf_category() {
		return cf_category;
	}


	public void setCf_category(String cf_category) {
		this.cf_category = cf_category;
	}


	public String getCf_reg_dt() {
		return cf_reg_dt;
	}


	public void setCf_reg_dt(String cf_reg_dt) {
		this.cf_reg_dt = cf_reg_dt;
	}


	public String getCf_upd_dt() {
		return cf_upd_dt;
	}


	public void setCf_upd_dt(String cf_upd_dt) {
		this.cf_upd_dt = cf_upd_dt;
	}


	public String getCf_title() {
		return cf_title;
	}


	public void setCf_title(String cf_title) {
		this.cf_title = cf_title;
	}


	public String getCf_content() {
		return cf_content;
	}


	public void setCf_content(String cf_content) {
		this.cf_content = cf_content;
	}


	public String getCf_anal_yn() {
		return cf_anal_yn;
	}


	public void setCf_anal_yn(String cf_anal_yn) {
		this.cf_anal_yn = cf_anal_yn;
	}


	public String getCf_anal_rs() {
		return cf_anal_rs;
	}


	public void setCf_anal_rs(String cf_anal_rs) {
		this.cf_anal_rs = cf_anal_rs;
	}


	public String getCf_anal_bigo() {
		return cf_anal_bigo;
	}


	public void setCf_anal_bigo(String cf_anal_bigo) {
		this.cf_anal_bigo = cf_anal_bigo;
	}


	public String getCf_anal_dt() {
		return cf_anal_dt;
	}


	public void setCf_anal_dt(String cf_anal_dt) {
		this.cf_anal_dt = cf_anal_dt;
	}


	public String getQuery() {
		return query;
	}


	public void setQuery(String query) {
		this.query = query;
	}


	public String getAnalLabel() {
		return analLabel;
	}


	public void setAnalLabel(String analLabel) {
		this.analLabel = analLabel;
	}


	public String getAnalConfidence() {
		return analConfidence;
	}


	public void setAnalConfidence(String analConfidence) {
		this.analConfidence = analConfidence;
	}


	public String getAnalRs() {
		return analRs;
	}


	public void setAnalRs(String analRs) {
		this.analRs = analRs;
	}


	public String getAnalBigo() {
		return analBigo;
	}


	public void setAnalBigo(String analBigo) {
		this.analBigo = analBigo;
	}


	public String getSentence() {
		return sentence;
	}
	

	public void setSentence(String sentence) {
		this.sentence = sentence;
	}

}