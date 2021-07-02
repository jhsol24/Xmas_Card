package com.wisenut.superSearch.service;

import java.util.*;

public interface WiseSearchService {
	//public HashMap<String, Object> doSearch(HttpServletRequest request);
	LinkedHashMap<String, Object> doSearch(Map<String, String> searchMap);
}
