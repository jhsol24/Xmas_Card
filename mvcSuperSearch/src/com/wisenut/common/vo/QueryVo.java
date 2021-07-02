package com.wisenut.common.vo;

import java.util.Calendar;

import com.wisenut.common.wnsearch.WNUtil;

public class QueryVo {
	Calendar nowDate = Calendar.getInstance();
	
	private int startCount;
	private int listCount;
	private String query;
	private String collection;
	
	private String rt;
	private String rt2;
	private String requery;
	private String sort;
	private String range;
	
	private String startDate;
	private String endDate;
	
	private String writer;
	
	private Boolean highlight;
	private Boolean snipet;
	private String exquery;
	private String groupField;
	
	private String pageNum;
	
	public void update() {
		if(highlight == null) this.highlight = false;
		if(snipet == null) this.snipet = false;
        if(startDate == null) this.startDate = "1970/01/01";
        if(endDate == null) this.endDate = WNUtil.getDate();
        if(sort == null) this.sort = "CF_DATE/DESC";
        if(range == null) this.range = "CF_DATE/DESC";
        if(exquery == null) this.exquery = "";
	}

	public Boolean getSnipet() {
		return snipet;
	}
	public void setSnipet(Boolean snipet) {
		this.snipet = snipet;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public int getStartCount() {
		return startCount;
	}
	public void setStartCount(int startCount) {
		this.startCount = startCount;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getCollection() {
		return collection;
	}
	public void setCollection(String collection) {
		this.collection = collection;
	}
	public String getRt() {
		return rt;
	}
	public void setRt(String rt) {
		this.rt = rt;
	}
	public String getRt2() {
		return rt2;
	}
	public void setRt2(String rt2) {
		this.rt2 = rt2;
	}
	public String getRequery() {
		return requery;
	}
	public void setRequery(String requery) {
		this.requery = requery;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getRange() {
		return range;
	}
	public void setRange(String range) {
		this.range = range;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Boolean getHighlight() {
		return highlight;
	}
	public void setHighlight(Boolean highlight) {
		this.highlight = highlight;
	}
	public String getExquery() {
		return exquery;
	}
	public void setExquery(String exquery) {
		this.exquery = exquery;
	}
	
	public String getGroupField() {
		return groupField;
	}
	public void setGroupField(String groupField) {
		this.groupField = groupField;
	}
	@Override
	public String toString() {
		return "SearchQueryVo startCount=" + startCount + ", listCount=" + listCount + ", query=" + query
				+ ", collection=" + collection + ", rt=" + rt + ", rt2=" + rt2 + ", requery=" + requery + ", sort=" + sort + ", range=" + range + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", writer=" + writer + ", pageNum=" + pageNum + "]";
	}
	
	
}
