package com.wisenut.common;

import java.util.List;

public class TreeModel {

	private String id;
	private String text;
	private String data;
	private String icon;
	private List<TreeChildModel> children;
	private TreeStateModel state = new TreeStateModel();
	private String level = "2";
	
	
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public TreeStateModel getState() {
		return state;
	}
	public void setState(TreeStateModel state) {
		this.state = state;
	}
	public List<TreeChildModel> getChildren() {
		return children;
	}
	public void setChildren(List<TreeChildModel> children) {
		this.children = children;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}

	
	
	
	
}
