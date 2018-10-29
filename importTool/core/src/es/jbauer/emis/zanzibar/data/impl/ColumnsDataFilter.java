package es.jbauer.emis.zanzibar.data.impl;

import java.util.Arrays;
import java.util.List;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class ColumnsDataFilter implements DataFilter
{
	private String[] headers; 

	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException 
	{
		String[] values = new String[headers.length]; 
		for (int i = 0; i < headers.length; i++)
			values[i] = row.get(headers[i]); 
		
		return Arrays.asList(DataUtils.updateSourceInfo(new StringTableRow(headers, values, null, null), row, null));  
	}
}
