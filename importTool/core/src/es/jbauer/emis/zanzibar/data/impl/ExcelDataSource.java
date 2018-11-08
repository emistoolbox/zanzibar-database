package es.jbauer.emis.zanzibar.data.impl;

import java.io.File;
import java.io.IOException;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.tools.Xls2Csv;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.io.impl.IOFileInput;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.impl.csv.CsvTableFactory;

public class ExcelDataSource extends DataSourceBase implements DataSource
{
	private static String ENV_CACHE_DIR = "EMIS_EXCEL_CACHE";

	private String filename; 
	private String worksheet;
	
	@Override
	public TableReader getReader() 
		throws IOException
	{
		CsvTableFactory factory = new CsvTableFactory(); 

		File xlsFile = new File(DataSourceBase.getPath(filename)); 
		File cacheFile = new File(getCacheFile()); 
		if (!cacheFile.exists() || cacheFile.lastModified() < xlsFile.lastModified())
		{
			System.out.println("-- Extracting Excel data.");
			Xls2Csv.extractExcel(getCacheDirectory(), DataSourceBase.getPath(filename), ".tab");
			System.out.println("-- Data extracted.");
		}

		return adaptReader(factory.create(new IOFileInput(cacheFile))); 
	} 
	
	private String getCacheDirectory()
	{
		String cacheDir = System.getProperty(ENV_CACHE_DIR); 
		if (StringUtils.isEmpty(cacheDir))
			cacheDir = System.getenv(ENV_CACHE_DIR);
		
		if (!StringUtils.isEmpty(cacheDir))
		{
			if (cacheDir.endsWith("/"))
				cacheDir = cacheDir.substring(0, cacheDir.length() -1);
			
			return cacheDir;
		}
		else
		{
			int pos = filename.lastIndexOf(".");
			if (pos == -1)
				throw new IllegalArgumentException("Unexpected filename");
			
			return DataSourceBase.getPath(filename.substring(0, pos));  
		}
	}
	
	private String getCacheFile()
	{ return getCacheDirectory() + "/" + worksheet + ".tab"; }
}
