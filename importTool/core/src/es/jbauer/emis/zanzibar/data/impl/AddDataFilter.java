package es.jbauer.emis.zanzibar.data.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class AddDataFilter implements DataFilter 
{
	private String[] headers; 
	private String [] values; 

	public static AddDataFilter create(Map<String, String> consts)
	{
		String[] headers = new String[consts.size()];
		String[] values = new String[headers.length]; 
		int index = 0; 
		for (Map.Entry<String, String> entry : consts.entrySet())
		{
			headers[index] = entry.getKey(); 
			values[index] = entry.getValue(); 
			index++; 
		}
		
		return create(headers, values); 
	}
	
	public static AddDataFilter create(String[] headers, String[] values)
	{ 
		AddDataFilter result = new AddDataFilter(); 
		result.headers = headers; 
		result.values = values; 
		
		return result; 
	}
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException 
	{
		String[] rowHeaders = row.getHeaders(); 
		String[] rowValues = row.getValues(); 

		String[] newHeaders = new String[rowHeaders.length + headers.length]; 
		String[] newValues = new String[newHeaders.length]; 
		for (int i = 0; i < rowHeaders.length; i++) 
		{
			newHeaders[i] = rowHeaders[i]; 
			newValues[i] = rowValues[i]; 
		}
		
		for (int i = 0; i < headers.length; i++) 
		{
			newHeaders[i + rowHeaders.length] = headers[i]; 
			newValues[i + rowValues.length] = values[i]; 
		}
		
		return Arrays.asList(DataUtils.updateSourceInfo(new StringTableRow(newHeaders, newValues, null, null), row, null));
	}
}
