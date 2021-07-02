package test.com.wisenut.wnsearch;

import java.io.FileOutputStream;
import java.text.DecimalFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class Test {

	public static void main(String[] args) throws Exception {
		
		System.out.println(numberFormat(1234567890));
		test2();

	}
	
	
	public static void test2() throws Exception{
		
		

	}
	
	
	public static void  test() throws Exception{
		
		String outputFilename = "D:\\test\\test1.xls";
		
		
		int rownum;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet s = wb.createSheet();
		HSSFCellStyle cs = wb.createCellStyle();
		HSSFCellStyle cs2 = wb.createCellStyle();
		HSSFCellStyle cs3 = wb.createCellStyle();
		HSSFFont f = wb.createFont();
		HSSFFont f2 = wb.createFont();
		
		
		
		f.setFontHeightInPoints((short) 12);
		f.setColor((short) 0xA);
		f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		f2.setFontHeightInPoints((short) 10);
		f2.setColor((short) 0xf);
		f2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		cs.setFont(f);
		cs.setDataFormat(HSSFDataFormat.getBuiltinFormat("($#,##0_);[Red]($#,##0)"));
		cs2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cs2.setFillPattern((short) 1); // fill w fg
		cs2.setFillForegroundColor((short) 0xA);
		cs2.setFont(f2);
		wb.setSheetName(0, "HSSF Test");
		
		
		int dataSize = 300;
		
		for (rownum = 0; rownum < dataSize; rownum++) {
			HSSFRow r = s.createRow(rownum);
			
			
			HSSFCell c = r.createCell(0);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("카테고리"));
			else c.setCellValue("지상군/포병");
			
			c = r.createCell(1);
			if(rownum == 0) c.setCellValue(new HSSFRichTextString("내용"));
			else c.setCellValue("김정은이 함흥도로 이동하였다");
		}
		
		
		// end deleted sheet
		FileOutputStream out = new FileOutputStream(outputFilename);
		wb.write(out);
		out.close();
		
		
		
	}
	
	
	public static String numberFormat(int number) {
		DecimalFormat df = new DecimalFormat("###,###");
		return df.format(number);
	}
	
}
