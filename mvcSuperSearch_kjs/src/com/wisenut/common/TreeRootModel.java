package com.wisenut.common;

import java.util.List;

public class TreeRootModel {

	private String id;
	private String text;
	private String icon;
	private List<TreeModel> children;
	private TreeStateModel state = new TreeStateModel();
	private String level = "1";
	
	
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public List<TreeModel> getChildren() {
		return children;
	}
	public void setChildren(List<TreeModel> children) {
		this.children = children;
	}
	public TreeStateModel getState() {
		return state;
	}
	public void setState(TreeStateModel state) {
		this.state = state;
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
	
	@Override
	public String toString() {
		return "TreeRootModel [id=" + id + ", text=" + text + ", icon=" + icon + ", children=" + children + ", state="
				+ state + ", level=" + level + "]";
	}
	
	
	
}
