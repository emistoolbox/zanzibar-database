package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class CopyDataFilter implements DataFilter 
{
	private Map<String, String> copies;

	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException 
	{
		List<String> headers = new ArrayList<String>(); 
		headers.addAll(Arrays.asList(row.getHeaders())); 
		
		List<String> values = new ArrayList<String>(); 
		values.addAll(Arrays.asList(row.getValues())); 
		for (String key : copies.keySet())
		{
			if (headers.contains(key))
				continue; 
			
			headers.add(key); 
			String value = copies.get(key); 
			if (value.startsWith("'"))
				values.add(value.substring(1, value.length() - 2)); 
			else 
				values.add(row.get(value)); 
		}

		String[] arrHeaders = headers.toArray(new String[0]);
		String[] arrValues = values.toArray(new String[0]); 
		return Collections.singletonList(new StringTableRow(arrHeaders, arrValues, null, null)); 
	} 
}
