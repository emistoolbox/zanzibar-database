package es.jbauer.emis.zanzibar.data.impl;

import java.io.IOException;
import java.util.Map;

import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataObject;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class UnionDataSource implements DataSource, DataObject
{
	private boolean skip; 
	private String[] headers; 
	private DataSource[] sources;
	private DataFilter[] filters; 
	
	@Override
	public TableReader getReader() throws IOException 
	{
		if (skip)
			return new EmptyTableReader(); 
		
		TableReader[] readers = new TableReader[sources.length]; 
		if (filters != null && filters.length > 0)
		{
			for (int i = 0; i < readers.length; i++)
				readers[i] = new FilteredTableReader(sources[i].getReader(), filters);
		}
		else
		{
			for (int i = 0; i < readers.length; i++)
				readers[i] = sources[i].getReader(); 
		}
		
		return new UnionTableReader(headers, readers); 
	}

	@Override
	public void init(Map<String, DataLookup> lookups) 
	{ 
		DataUtils.updateLookupsArray(filters, lookups); 
		DataUtils.updateLookupsArray(sources, lookups); 
	}
}

class UnionTableReader implements TableReader
{
	private String[] headers;
	private TableReader[] readers;
	private int readerIndex = 0;
	
	private String dateFormat; 
	private String dateTimeFormat;
	
	private TableRow nextRow; 
	
	public UnionTableReader(String[] headers, TableReader[] readers)
	{
		this.headers = headers; 
		this.readers = readers; 
	}
	
	@Override
	public String[] getHeaders() 
	{ return headers; }

	private void fetchNextRow()
	{
		nextRow = null;
		if (readerIndex >= readers.length)
			return; 
		
		if (readers[readerIndex].hasNextRow())
			nextRow = readers[readerIndex].getNextRow();
		else
		{
			readerIndex++; 
			fetchNextRow(); 
		}
	}
	
	@Override
	public boolean isFirstRow() 
	{ return readerIndex == 0 && readers[0].isFirstRow(); }

	@Override
	public boolean hasNextRow() 
	{
		if (nextRow == null)
			fetchNextRow(); 
		
		return nextRow != null; 
	}

	@Override
	public TableRow getNextRow() 
	{
		if (nextRow == null)
			fetchNextRow(); 
		
		if (nextRow == null)
			return null; 

		String[] values = new String[headers.length]; 
		for (int i = 0; i < values.length; i++)
			values[i] = nextRow.get(headers[i]); 

		try { return DataUtils.updateSourceInfo(new StringTableRow(headers, values, dateFormat, dateTimeFormat), nextRow, null); }
		finally { nextRow = null; } 
	}

	@Override
	public void close() 
	{
		for (TableReader reader : readers)
			reader.close(); 
	}

	@Override
	public String getInfo()
	{ return "Combined: " + readers[readerIndex].getInfo(); }

	@Override
	public void setDateFormat(String dateFormat, String dateTimeFormat) 
	{
		for (TableReader reader : readers)
			reader.setDateFormat(dateFormat, dateTimeFormat);
		
		this.dateFormat = dateFormat; 
		this.dateTimeFormat = dateTimeFormat; 
	}
}
