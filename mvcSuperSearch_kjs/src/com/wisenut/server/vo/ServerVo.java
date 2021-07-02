package com.wisenut.server.vo;

import com.wisenut.common.CommonModel;

public class ServerVo extends CommonModel{

	private String cfsv_id;
	private String cfsv_ip;
	private String cfsv_port;
	private String cfsv_nm;
	private String cfsv_desc;
	private String cfsv_reg_dt;
	private String cfsv_upd_dt;
	private String cfsv_std_indir;
	private String cfsv_anal_indir;
	private String cfsv_anal_outdir;
	private String d_cfsv_id;
	
	@Override
	public String toString() {
		return "ServerVo [cfsv_id=" + cfsv_id + ", cfsv_ip=" + cfsv_ip + ", cfsv_port=" + cfsv_port + ", cfsv_nm="
				+ cfsv_nm + ", cfsv_desc=" + cfsv_desc + ", cfsv_reg_dt=" + cfsv_reg_dt + ", cfsv_upd_dt=" + cfsv_upd_dt
				+ ", cfsv_std_indir=" + cfsv_std_indir + ", cfsv_anal_indir=" + cfsv_anal_indir + ", cfsv_anal_outdir="
				+ cfsv_anal_outdir + ", d_cfsv_id=" + d_cfsv_id + ", query=" + query + ", p_cfsv_id=" + p_cfsv_id
				+ ", key_id=" + key_id + ", cfsv_stat=" + cfsv_stat + "]";
	}
	public String getD_cfsv_id() {
		return d_cfsv_id;
	}
	public void setD_cfsv_id(String d_cfsv_id) {
		this.d_cfsv_id = d_cfsv_id;
	}
	public String query;
	
	/* param */
	public String p_cfsv_id;
	
	public int key_id;
	public String cfsv_stat;
	
	public String getCfsv_id() {
		return cfsv_id;
	}
	public void setCfsv_id(String cfsv_id) {
		this.cfsv_id = cfsv_id;
	}
	public String getCfsv_ip() {
		return cfsv_ip;
	}
	public void setCfsv_ip(String cfsv_ip) {
		this.cfsv_ip = cfsv_ip;
	}
	public String getCfsv_port() {
		return cfsv_port;
	}
	public void setCfsv_port(String cfsv_port) {
		this.cfsv_port = cfsv_port;
	}
	public String getCfsv_nm() {
		return cfsv_nm;
	}
	public void setCfsv_nm(String cfsv_nm) {
		this.cfsv_nm = cfsv_nm;
	}
	public String getCfsv_std_indir() {
		return cfsv_std_indir;
	}
	public void setCfsv_std_indir(String cfsv_std_indir) {
		this.cfsv_std_indir = cfsv_std_indir;
	}
	public String getCfsv_desc() {
		return cfsv_desc;
	}
	public void setCfsv_desc(String cfsv_desc) {
		this.cfsv_desc = cfsv_desc;
	}
	public String getCfsv_reg_dt() {
		return cfsv_reg_dt;
	}
	public void setCfsv_reg_dt(String cfsv_reg_dt) {
		this.cfsv_reg_dt = cfsv_reg_dt;
	}
	public String getCfsv_upd_dt() {
		return cfsv_upd_dt;
	}
	public void setCfsv_upd_dt(String cfsv_upd_dt) {
		this.cfsv_upd_dt = cfsv_upd_dt;
	}
	public String getCfsv_anal_indir() {
		return cfsv_anal_indir;
	}
	public void setCfsv_anal_indir(String cfsv_anal_indir) {
		this.cfsv_anal_indir = cfsv_anal_indir;
	}
	public String getCfsv_anal_outdir() {
		return cfsv_anal_outdir;
	}
	public void setCfsv_anal_outdir(String cfsv_anal_outdir) {
		this.cfsv_anal_outdir = cfsv_anal_outdir;
	}
	public String getCfsv_stat() {
		return cfsv_stat;
	}
	public void setCfsv_stat(String cfsv_stat) {
		this.cfsv_stat = cfsv_stat;
	}
	public int getKey_id() {
		return key_id;
	}
	public void setKey_id(int key_id) {
		this.key_id = key_id;
	}
	public String getP_cfsv_id() {
		return p_cfsv_id;
	}
	public void setP_cfsv_id(String p_cfsv_id) {
		this.p_cfsv_id = p_cfsv_id;
	}

	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	
}