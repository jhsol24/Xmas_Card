package com.wisenut.common.wnsearch;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.wisenut.common.vo.QueryVo;

public class WNUtil {
	
	/**
	 * @param dayNum
	 * @return
	 */
	public static String getDate(int dayNum){
		
		 Calendar cal = new GregorianCalendar();
		 cal.add(Calendar.DATE, dayNum);
		 
		 String year = Integer.toString(cal.get(Calendar.YEAR));
		 String month = "";
		 String day = "";
		 
		 if(Integer.toString((cal.get(Calendar.MONTH) + 1)).length() == 1){
			 month = "0" + (cal.get(Calendar.MONTH) + 1);
		 }else{
			 month = Integer.toString((cal.get(Calendar.MONTH) + 1));
		 }
		 
		 if(Integer.toString(cal.get(Calendar.DAY_OF_MONTH)).length() == 1){
			 day = "0" + cal.get(Calendar.DAY_OF_MONTH);
		 }else{
			 day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		 }
		 
		return year+"/"+month+"/"+day;
	}
	
	/**
	 * @return
	 */
	public static String getDate(){
		
		 Calendar cal = new GregorianCalendar();
		 
		 String year = Integer.toString(cal.get(Calendar.YEAR));
		 String month = "";
		 String day = "";
		 
		 if(Integer.toString((cal.get(Calendar.MONTH) + 1)).length() == 1){
			 month = "0" + (cal.get(Calendar.MONTH) + 1);
		 }else{
			 month = Integer.toString((cal.get(Calendar.MONTH) + 1));
		 }
		 
		 if(Integer.toString(cal.get(Calendar.DAY_OF_MONTH)).length() == 1){
			 day = "0" + cal.get(Calendar.DAY_OF_MONTH);
		 }else{
			 day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		 }
		 
		 return year+"/"+month+"/"+day;
	}
	
	/**
	 * @return
	 */
	public static String getCurrentDate(){
		
		 Calendar cal = new GregorianCalendar();
		 
		 String year = Integer.toString(cal.get(Calendar.YEAR));
		 String month = "";
		 String day = "";
		 
		 if(Integer.toString((cal.get(Calendar.MONTH) + 1)).length() == 1){
			 month = "0" + (cal.get(Calendar.MONTH) + 1);
		 }else{
			 month = Integer.toString((cal.get(Calendar.MONTH) + 1));
		 }
		 
		 if(Integer.toString(cal.get(Calendar.DAY_OF_MONTH)).length() == 1){
			 day = "0" + cal.get(Calendar.DAY_OF_MONTH);
		 }else{
			 day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		 }
		 
		 return year+""+month+""+day;
	}
	
	
	/**
	 * @param field
	 * @param seperator
	 * @return
	 */
	public static ArrayList<String> StringToArrayList(String field, String seperator){
		
		ArrayList<String> list = new ArrayList<String>();
		
		for(String str : field.split(seperator)){
			list.add(str);
		}
		
		return list;
	}
	
	/**
	 * @param arr
	 * @param seperator
	 * @return
	 */
	public static String arrJoin(String[] arr, String seperator){
		String result = "";
		for(int idx = 0; idx < arr.length; idx++){
			result += arr[idx];
			if(idx < arr.length - 1) result += seperator;
		}
		return result;
	}
	
	/**
	 * @param arr
	 * @param seperator
	 * @return
	 */
	public static String arrJoin(ArrayList<String> arr, String seperator){
		String result = "";
		for(int idx = 0; idx < arr.size(); idx++){
			result += arr.get(idx);
			if(idx < arr.size() - 1) result += seperator;
		}
		return result;
	}
	
	/**
	 * @param inputTxt
	 * @param rex
	 * @return
	 */
	public static boolean matched(String inputTxt, String rex){
		if(inputTxt.equals("") || rex.equals("")) return false;
		
		Pattern p = Pattern.compile(rex);
		Matcher m = p.matcher(inputTxt);
		return m.find();
	}
	
	   /**
	 * @param e
	 * @return
	 */
	public static String StackTraceToString( Throwable e ){
       ByteArrayOutputStream b = new ByteArrayOutputStream();
       PrintStream p = new PrintStream( b );
       e.printStackTrace( p );
       p.flush();
       p.close();
       String msg = b.toString();
       try {
           b.flush();
           b.close();
       } catch (IOException e1) {}
       return msg;
   }
   
	/**
	 * @param req
	 * @param parameter
	 * @param def
	 * @return
	 */
	public static String getCheckReq(HttpServletRequest req, String parameter, String def){
		return (req !=null && req.getParameter(parameter) !=null && !"".equals(req.getParameter(parameter)))? req.getParameter(parameter):def;
	}
	
	/**
	 * @param req
	 * @param parameter
	 * @param def
	 * @return
	 */
	public static String[] getCheckReqArray(HttpServletRequest req, String parameter, String[] def){
		return (req !=null && req.getParameterValues(parameter) !=null && !"".equals(req.getParameterValues(parameter)))? req.getParameterValues(parameter):def;
	}
	
	/**
	 * @param str
	 * @return
	 */
	public static String replaceSnippetField(String str) {
		return str.split("/").length > 1 ? str.split("/")[0] : str;
	}
	
	/**
	 * @param str
	 * @return
	 */
	public static String replaceHighlight(String str) {
		return str.replaceAll("&lt;!HS&gt;", "<font color='red'>").replaceAll("&lt;!HE&gt;", "</font>");
	}
	
	/**
	 * @param str
	 * @return
	 */
	public static String replaceTagLikeChr(String str){
		return str.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	/**
	 * @param extendsField
	 * @param field
	 * @return
	 */
	public static String getExtendsField(String extendsField,String field){
		
		if(extendsField.equals("")){
		}else{
			String[] tempArr1 = extendsField.split("\\^");
			for(int idx=0; idx < tempArr1.length; idx++){
				String[] tempArr2 = tempArr1[idx].split("=");
				//tempArr2[0] -> CMMT_CONTENTS,CPS_CONTENTS  | tempArr2[1] -> CONTENTS 
				field = field.replaceAll(tempArr2[1], tempArr2[0]);
			}
		}
		
		return field;
	}
	
	/**
	 * @param searchQuery
	 * @return
	 */
	public static QueryVo nullCheckQuery(QueryVo searchQuery) {
		
		if(searchQuery.getCollection() == null) new Error("Collection not fount");
		if(searchQuery.getRange() == null || "".equals(searchQuery.getRange())) searchQuery.setRange("CF_DATE/DESC"); 					// 정렬
		if(searchQuery.getStartDate() == null || "".equals(searchQuery.getStartDate())) searchQuery.setStartDate(WNDefine.STATE_DATE);	// 시작날짜
		if(searchQuery.getEndDate() == null || "".equals(searchQuery.getEndDate())) searchQuery.setEndDate(WNDefine.END_DATE);			// 종료날짜
		if(searchQuery.getHighlight() == null || searchQuery.getHighlight() == false) searchQuery.setHighlight(false);				// 하이라이팅
		else searchQuery.setHighlight(true);
		if(searchQuery.getExquery() == null || "".equals(searchQuery.getExquery())) searchQuery.setExquery("");
		
		return searchQuery;
	}
	
	/**
	 * @param number
	 * @return
	 */
	public static String numberFormat(int number) {
		DecimalFormat df = new DecimalFormat("###,###");
		return df.format(number);
	}
}
