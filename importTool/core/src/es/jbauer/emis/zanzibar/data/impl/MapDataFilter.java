package es.jbauer.emis.zanzibar.data.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataObject;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class MapDataFilter implements DataFilter, DataObject
{
	private Map<String, DataLookup> lookups; 
	private Map<String, String> mappings; 
	private boolean logEmpty = false; 
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException
	{
		if (lookups == null)
			throw new IllegalArgumentException("Lookups are null"); 
		
		String[] headers = row.getHeaders(); 
		String[] values = row.getValues(); 
		
		for (Map.Entry<String, String> mapping : mappings.entrySet())
		{
			String header = mapping.getKey(); 
			int index = DataUtils.index(headers, header);
			if (index == -1)
				continue; 

			DataLookup lookup = lookups.get(mapping.getValue());
			if (lookup == null)
				throw new IllegalArgumentException("Failed to find lookup: " + mapping.getValue());
			
			if (values[index] != null)
			{
				String value = lookup.get(values[index]);
				if (logEmpty && StringUtils.isEmpty(value))
					System.out.println(mapping.getValue() + "[" + values[index] + "] is empty."); 

				values[index] = value; 
			}
		}
		
		return Arrays.asList(DataUtils.updateSourceInfo(new StringTableRow(headers, values, null, null), row, null));
	}

	@Override
	public void init(Map<String, DataLookup> lookups) 
	{ this.lookups = lookups; }
}
