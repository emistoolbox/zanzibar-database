package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class ExpandDataFilter implements DataFilter
{
	private String valueColumn;
	private boolean skipIfEmpty = true; 
	private String[] copyColumns; 
	private String[] constColumnHeaders;
	private Map<String, String> constColumnValues;

	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException
	{
		String[] headers = getHeaders(); 
		
		List<TableRow> result = new ArrayList<TableRow>(); 
		for (Map.Entry<String, String> constColumnValue : constColumnValues.entrySet())
		{
			String value = row.get(constColumnValue.getKey()); 
			if (StringUtils.isEmpty(value))
				continue; 
			
			String[] values = new String[headers.length]; 
			for (String copyColumn : copyColumns)
				set(values, headers, copyColumn, row.get(copyColumn)); 

			set(values, headers, valueColumn, value);

			String[] constValues = constColumnValue.getValue().split(","); 
			for (int i = 0; i < constValues.length; i++)
				set(values, headers, constColumnHeaders[i], constValues[i]); 
			
			if (skipIfEmpty && isEmpty(get(values, headers, valueColumn)))
				continue; 
			
			try { result.add(DataUtils.updateSourceInfo(new StringTableRow(headers, values, null, null), row, "expandCol=" + constColumnValue.getKey())); }
			catch (Throwable err)
			{ throw new DataFilterException(filterIndex, row, rowIndex, err); }
		}
		
		return result;
	}
	
	private boolean isEmpty(String value)
	{ 
		if (value == null)
			return true; 
		
		return value.trim().equals(""); 
	}
	
	private String get(String[] values, String[] headers, String column)
	{
		int index = DataUtils.index(headers,  column); 
		if (index == -1)
			return null; 
		
		return values[index]; 
	}
	
	private void set(String[] values, String[] headers, String column, String value)
	{
		int index = DataUtils.index(headers, column);
		if (index != -1)
			values[index] = value; 
	}
	
	private String[] getHeaders()
	{
		Set<String> headers = new HashSet<String>(); 
		for (String col : copyColumns)
			headers.add(col); 

		headers.add(valueColumn); 
		for (String col : constColumnHeaders)
			headers.add(col);
		
		return headers.toArray(new String[0]); 
	}
}
