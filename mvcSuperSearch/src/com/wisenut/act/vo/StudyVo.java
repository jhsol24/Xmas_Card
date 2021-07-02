package com.wisenut.act.vo;

import com.wisenut.common.CommonModel;

public class StudyVo extends CommonModel{

	
	private int cfst_id;
	private int cfct_id;
	private String cfct_nm;
	private int cfsv_id;
	private String cfst_gubun;
	private String cfst_content;
	private String cfst_reg_dt;
	private String cfst_upd_dt;
	private String cfct_value;
	
	private String std_cfct_id;
	private String std_pageNum;
	private String std_query;
	
	public String getCfct_value() {
		return cfct_value;
	}
	public void setCfct_value(String cfct_value) {
		this.cfct_value = cfct_value;
	}
	public String getCfct_nm() {
		return cfct_nm;
	}
	public void setCfct_nm(String cfct_nm) {
		this.cfct_nm = cfct_nm;
	}
	public int getCfst_id() {
		return cfst_id;
	}
	public void setCfst_id(int cfst_id) {
		this.cfst_id = cfst_id;
	}
	public int getCfct_id() {
		return cfct_id;
	}
	public void setCfct_id(int cfct_id) {
		this.cfct_id = cfct_id;
	}
	public int getCfsv_id() {
		return cfsv_id;
	}
	public void setCfsv_id(int cfsv_id) {
		this.cfsv_id = cfsv_id;
	}
	public String getCfst_gubun() {
		return cfst_gubun;
	}
	public void setCfst_gubun(String cfst_gubun) {
		this.cfst_gubun = cfst_gubun;
	}
	public String getCfst_content() {
		return cfst_content;
	}
	public void setCfst_content(String cfst_content) {
		this.cfst_content = cfst_content;
	}
	public String getCfst_reg_dt() {
		return cfst_reg_dt;
	}
	public void setCfst_reg_dt(String cfst_reg_dt) {
		this.cfst_reg_dt = cfst_reg_dt;
	}
	public String getCfst_upd_dt() {
		return cfst_upd_dt;
	}
	public void setCfst_upd_dt(String cfst_upd_dt) {
		this.cfst_upd_dt = cfst_upd_dt;
	}
	public String getStd_cfct_id() {
		return std_cfct_id;
	}
	public void setStd_cfct_id(String std_cfct_id) {
		this.std_cfct_id = std_cfct_id;
	}
	public String getStd_pageNum() {
		return std_pageNum;
	}
	public void setStd_pageNum(String std_pageNum) {
		this.std_pageNum = std_pageNum;
	}
	public String getStd_query() {
		return std_query;
	}
	public void setStd_query(String std_query) {
		this.std_query = std_query;
	}
	

	
	
}
