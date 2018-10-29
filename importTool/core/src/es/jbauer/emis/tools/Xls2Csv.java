package es.jbauer.emis.tools;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.apache.commons.io.IOUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class Xls2Csv 
{
	public static final void main(String[] args)
		throws Exception
	{
		for (String arg : args)
		{
			int pos = arg.lastIndexOf(".");
			File dir = new File(arg.substring(0, pos));
			if (!dir.exists())
				dir.mkdirs(); 
			else if (!dir.isDirectory())
			{
				System.out.println(dir.getName() + " exists as file"); 
				continue; 
			}
			
			Workbook wb = WorkbookFactory.create(new File(arg)); 
			for (int i = 0; i < wb.getNumberOfSheets(); i++) 
				writeSheet(dir, wb.getSheetAt(i));  
		}
	}
	
	private static void writeSheet(File dir, Sheet sheet)
		throws IOException
	{
		BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(dir, sheet.getSheetName() + ".csv"))));
		for (int r = 0; r < sheet.getLastRowNum(); r++)
		{
			Row row = sheet.getRow(r); 
			String delim = ""; 
			if (row != null)
			{
				for (int c = 0; c < row.getLastCellNum(); c++)
				{
					out.write(delim);
					Cell cell = row.getCell(c);
					if (cell != null)
						out.write(getCellValue(cell));  
					
					delim = "\t"; 
				}
			}
			
			out.write("\n");
		}
		
		out.flush();
		IOUtils.closeQuietly(out); 
	}
	
	private static String getCellValue(Cell cell)
	{ return getCellValue(cell, cell.getCellType()); }
	
	private static String getCellValue(Cell cell, int cellType)
	{
		switch (cellType)
		{
		case Cell.CELL_TYPE_FORMULA: 
			return getCellValue(cell, cell.getCachedFormulaResultType()); 

		case Cell.CELL_TYPE_BOOLEAN: 
			return "" + cell.getBooleanCellValue();
			
		case Cell.CELL_TYPE_STRING: 
			return cell.getStringCellValue(); 

		case Cell.CELL_TYPE_NUMERIC:
			double v = cell.getNumericCellValue();
			if (Math.abs(v - Math.round(v)) < 0.0000001)
				return "" + (long) Math.round(v); 
			else
				return "" + v; 
			
		default: 
			return ""; 
		}
	}
}
