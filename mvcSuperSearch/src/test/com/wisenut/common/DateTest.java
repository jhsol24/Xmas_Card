package test.com.wisenut.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {
	public static void main(String[] args) {
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = simpleDate.format(new Date());
		
		String fileNm = date + ".json";
		System.out.println(fileNm);
	}
}
