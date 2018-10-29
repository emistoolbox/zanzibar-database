	package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.TableRow;

public class FilteredTableReader implements TableReader 
{
	private TableReader reader;
	private DataFilter[] filters; 

	private boolean first = true;
	private String[] headers; 
	private List<TableRow> nextRows;

	public FilteredTableReader(TableReader reader, DataFilter[] filters)
	{
		this.reader = reader; 
		this.filters = filters; 
	}
	
	private void fetchNextRows()
	{
		if (nextRows != null && nextRows.size() > 0)
			return; 
		
		if (!reader.hasNextRow())
			return; 
		
		List<TableRow> result = new ArrayList<TableRow>(); 
		TableRow row = reader.getNextRow();
		if (row != null)
		{
			try { addRows(Arrays.asList(row), 0, result); }
			catch (Exception ex) 
			{ ex.printStackTrace(); }
		}

		if (row != null && result.size() == 0)
			fetchNextRows(); 
		else
			nextRows = result; 
	}
	
	private void addRows(List<TableRow> rows, int filterIndex, List<TableRow> result)
		throws DataFilterException
	{
		if (filterIndex < filters.length)
		{
			DataFilter filter = filters[filterIndex]; 
			for (TableRow row : rows)
				addRows(filter.filter(row, 0, filterIndex), filterIndex + 1, result);
		}
		else
			result.addAll(rows);
	}
	
	@Override
	public String[] getHeaders() 
	{
		if (headers != null)
			return headers; 
		
		fetchNextRows(); 
		if (nextRows != null &&  nextRows.size() > 0)
			headers = nextRows.get(0).getHeaders(); 

		return headers;
	}

	@Override
	public boolean isFirstRow() 
	{ return first; }

	@Override
	public boolean hasNextRow() 
	{
		fetchNextRows(); 
		return nextRows != null &&  nextRows.size() > 0; 
	}

	@Override
	public TableRow getNextRow() 
	{
		first = false;
		if (!hasNextRow())
			return null;

		return nextRows.remove(0); 
	}

	@Override
	public void close() 
	{ reader.close(); }

	@Override
	public String getInfo() 
	{ return null; }

	@Override
	public void setDateFormat(String dateFormat, String dateTimeFormat) 
	{ reader.setDateFormat(dateFormat, dateTimeFormat); }
}
