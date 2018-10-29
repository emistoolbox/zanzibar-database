package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class JoinColumnsDataFilter implements DataFilter 
{
	private String columns; 
	private String resultColumn; 
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException 
	{
		List<String> headers = new ArrayList<String>(); 
		headers.addAll(Arrays.asList(row.getHeaders())); 
		headers.add(resultColumn); 
		
		List<String> values = new ArrayList<String>(); 
		values.addAll(Arrays.asList(row.getValues())); 

		String result = null; 
		for (String col : columns.split(","))
		{
			if (isMatch(row.get(col)))
			{
				result = col;  
				break; 
			}
		}
		
		values.add(result);
		
		String[] arrHeaders = headers.toArray(new String[0]);
		String[] arrValues = values.toArray(new String[0]); 
		return Collections.singletonList(new StringTableRow(arrHeaders, arrValues, null, null)); 
	}
	
	private boolean isMatch(String value)
	{ return value.equals("1") || value.equalsIgnoreCase("true") || value.equalsIgnoreCase("Y") || value.equalsIgnoreCase("Yes"); }
}
