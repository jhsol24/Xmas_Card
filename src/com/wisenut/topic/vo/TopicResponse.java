package com.wisenut.topic.vo;

import java.util.List;

public class TopicResponse {
	
	private List<TopicParams> Params;
	
	private List<TopicStatus> Status;
	
	private List<Topics> Topics;

	public List<TopicParams> getParams() {
		return Params;
	}

	public void setParams(List<TopicParams> params) {
		Params = params;
	}

	public List<TopicStatus> getStatus() {
		return Status;
	}

	public void setStatus(List<TopicStatus> status) {
		Status = status;
	}

	public List<Topics> getTopics() {
		return Topics;
	}

	public void setTopics(List<Topics> topics) {
		Topics = topics;
	}


}
