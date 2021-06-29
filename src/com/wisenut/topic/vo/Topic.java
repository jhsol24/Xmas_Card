package com.wisenut.topic.vo;

import java.util.List;

public class Topic {
	
	private int DocCount;
	private String Id;
	private List<TopicKeywords> Keywords;
	private String Label;
	
	public int getDocCount() {
		return DocCount;
	}
	public void setDocCount(int docCount) {
		DocCount = docCount;
	}
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public List<TopicKeywords> getKeywords() {
		return Keywords;
	}
	public void setKeywords(List<TopicKeywords> keywords) {
		Keywords = keywords;
	}
	public String getLabel() {
		return Label;
	}
	public void setLabel(String label) {
		Label = label;
	}

	
}
