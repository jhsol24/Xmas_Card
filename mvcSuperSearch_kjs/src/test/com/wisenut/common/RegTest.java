package test.com.wisenut.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegTest {
	
public static void main(String[] args) throws Exception {

		String str = "<R_FOREST_ANAL_BIGO>해군^0.13339621909246444공군^0.11466942678477761지상군/기타^0.10836932843440002주변국/중국^0.09835405279597538지상군/보병^0.09754737727878968"
					+ "<XGBOOST_ANAL_RS>지상군/특수전"
					+	"<XGBOOST_ANAL_BIGO>지상군/특수전^0.9770049해군^0.011246957지상군/준군사^0.0040282584공군^0.0020217567지상군/포병^0.0019221293"
					+	"<SVM_ANAL_RS>해군"
					+	"<SVM_ANAL_BIGO>해군^0.10526315789473684공군^0.09941520467836257지상군/기타^0.0935672514619883주변국/중국^0.08771929824561403지상군/보병^0.08187134502923976"
					+	"<R_FOREST_CF_ANAL_DT>2019-06-11 16:20:32.0"
					+	"<R_FOREST_CF_ANAL_GBN>군별자동분류";
		
		
		//String reg = "o.*?\\(\\S+[^:,0-9]\\s([0-9]+[[,~^]*\\s*[0-9]*+[~]*[0-9]*]{1,})\\)";
		String reg = "\\<XGBOOST_ANAL_RS\\>\\S+";
		
		System.out.println(str.replaceAll(reg, "CSDCD"));
		System.out.println(applyRegPattern(str,reg));
	}

	public static String applyRegPattern(String divStr, String reg) {
		String content = "";
		Pattern pat = Pattern.compile(reg, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	    Matcher match = pat.matcher(divStr);
	    
	    if(match.find()){
			content = match.group() + "\n";
	//        System.out.println("result : " + match.group());
	    }else{
	    	//content = divStr + "\n";
	    }
	    return content;
	}
}
