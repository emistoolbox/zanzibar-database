package es.jbauer.emis.zanzibar.data.impl;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.TableRow;

public abstract class DataSourceBase implements DataSource
{
	private static String ENV_DATA_DIR = "EMIS_IMPORT_DATA";
	private static String dataDirectory; 
	
	static {
		dataDirectory = System.getProperty(ENV_DATA_DIR );
		if (StringUtils.isEmpty(dataDirectory))
			dataDirectory = System.getenv(ENV_DATA_DIR); 
		if (StringUtils.isEmpty(dataDirectory))
			dataDirectory = "./"; 


		if (!dataDirectory.endsWith("/"))
			dataDirectory = dataDirectory + "/";
	};

	private Map<String, String> consts;
	
	public static String getPath(String filename)
	{
		if (filename == null)
			return null;
		
		
		
		return filename.replaceAll("\\$\\{DATA\\}\\/", dataDirectory).replaceAll("\\$\\{DATA\\}", dataDirectory);
	}
	
	protected TableReader adaptReader(TableReader reader)
	{
		reader = new FilterEmptyTableReader(reader);
		if (consts != null && consts.size() > 0)
			return new FilteredTableReader(reader, new DataFilter[] { AddDataFilter.create(consts)}); 
		
		return reader; 
	}
}

class FilterEmptyTableReader implements TableReader
{
	private TableReader reader; 
	private TableRow nextRow; 
	private boolean first = true; 
	
	public FilterEmptyTableReader(TableReader reader)
	{ this.reader = reader; }

	@Override
	public void close() 
	{ reader.close(); } 

	@Override
	public String[] getHeaders() 
	{ return reader.getHeaders(); }

	@Override
	public String getInfo() 
	{ return reader.getInfo(); }

	private void fetchNextRow()
	{
		if (nextRow != null)
			return; 
		
		TableRow row = reader.getNextRow(); 
		while (row != null && isEmpty(row))
			row = reader.getNextRow(); 
		
		nextRow = row; 
	}
	
	protected boolean isEmpty(TableRow row)
	{
		for (String value : row.getValues())
		{
			if (value != null)
				value.trim(); 
			
			if (StringUtils.isNotEmpty(value))
				return false;
		}
		
		return true; 
	}
	
	@Override
	public TableRow getNextRow() 
	{
		try { 
			fetchNextRow();
			return nextRow; 
		}
		finally { 
			if (nextRow != null)
				first = false; 

			nextRow = null; 
		} 
	}

	@Override
	public boolean hasNextRow() 
	{
		fetchNextRow();
		return nextRow != null; 
	}

	@Override
	public boolean isFirstRow() 
	{ return first; }

	@Override
	public void setDateFormat(String dateFormat, String dateTimeFormat) 
	{ reader.setDateFormat(dateFormat, dateTimeFormat); }
}
