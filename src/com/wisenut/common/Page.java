package com.wisenut.common;

public class Page {
	private static Page page = new Page();
	private int startRow, endRow;
	private StringBuffer sb;

	private Page() {
	}

	public static Page getInstance() {
		if (page == null) {
			page = new Page();
		}
		return page;
	}

	public synchronized void paging(int pageNum, int totalCount, int pageSize, int pageBlock, String fnName) {
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		startRow = (pageNum - 1) * pageSize + 1;
		endRow = pageNum * pageSize;

		int startPage = (int) ((pageNum - 1) / pageBlock) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}

		sb = new StringBuffer();

		// Page클래스 변경 부분
		/*if (startPage < pageBlock) {
			sb.append(
					"<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>");
		} else {
			sb.append("<li class=''><a href='javascript:" + fnName + "(");
			sb.append(startPage - pageBlock);
			sb.append(")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i == pageNum) {
				sb.append("<li class='active'><a href='#'>");
				sb.append(i);
				sb.append("<span class='sr-only'>");
				sb.append(i);
				sb.append("</span></a></li>");
			} else {
				sb.append("<li class=''><a href='javascript:" + fnName + "(");
				sb.append(i);
				sb.append(")'>");
				sb.append(i);
				sb.append("<span class='sr-only'>");
				sb.append(i);
				sb.append("</span></a></li>");
			}
		}

		if (endPage < totalPage) {
			sb.append("<li class=''><a href='javascript:" + fnName + "(");
			sb.append(startPage + pageBlock);
			sb.append(")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>");
		} else {
			sb.append(
					"<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>");
		}*/
		if (startPage < pageBlock) {
			sb.append(
					"<li class='paginate_button page-item previous disabled'><a href='#' tabindex='0' class='page-link' aria-controls='dataTable' data-dt-idx='0'>&laquo;</a></li>");
		} else {
			sb.append("<li class='paginate_button page-item previous'><a href='javascript:" + fnName + "(");
			sb.append(startPage - pageBlock);
			sb.append(")' tabindex='0' class='page-link' aria-controls='dataTable' data-dt-idx='0'>&laquo;</a></li>");
		}

		for (int i = startPage; i <= endPage; i++) {
			if (i == pageNum) {
				sb.append("<li class='paginate_button page-item active'><a tabindex='0' class='page-link' aria-controls='dataTable' href='#' data-dt-idx='" + i + "'>");
				sb.append(i);
				sb.append("</a></li>");
			} else {
				sb.append("<li class='paginate_button page-item '><a tabindex='0' class='page-link' aria-controls='dataTable' data-dt-idx='" + i + "' href='javascript:" + fnName + "(");
				sb.append(i);
				sb.append(")'>");
				sb.append(i);
				sb.append("</a></li>");
			}
		}

		if (endPage < totalPage) {
			sb.append("<li class='paginate_button page-item next'><a tabindex='0' class='page-link' aria-controls='dataTable' data-dt-idx='" + endPage + "' href='javascript:" + fnName + "(");
			sb.append(startPage + pageBlock);
			sb.append(")' >&raquo;</a></li>");
		} else {
			sb.append(
					"<li class='paginate_button page-item next disabled'><a href='#' tabindex='0' class='page-link' aria-controls='dataTable' data-dt-idx='" + totalPage + "'>&raquo;</a></li>");
		}
		
	}

	public StringBuffer getSb() {
		return sb;
	}

	public int getStartRow() {
		//startRow = startRow;
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

}
