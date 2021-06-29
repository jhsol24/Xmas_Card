package com.wisenut.common;

public class TreeChildModel {

	private String id;
	private String text;
	private String icon = "glyphicon glyphicon-file";
	private String children;
	private String pr_id;
	private TreeStateModel state = new TreeStateModel();
	private String level = "3";
	
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
	public String getChildren() {
		return children;
	}
	public void setChildren(String children) {
		this.children = children;
	}
	public String getPr_id() {
		return pr_id;
	}
	public void setPr_id(String pr_id) {
		this.pr_id = pr_id;
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
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}

	
	
	
	
}
