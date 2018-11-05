package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;

public class SkipDataFilter implements DataFilter
{
	private String[] columns; 
	private String[] emptyValues; 
	
	private Set<String> emptyLookup; 
	private boolean emptySkip; 
	
	private synchronized void init()
	{
		if (emptyLookup != null)
			return; 
		
		emptyLookup = new HashSet<String>(); 
		if (emptyValues != null && emptyValues.length > 0)
		{
			for (String value : emptyValues)
			{
				if ("(NULL)".equals(value))
					emptySkip = true; 
				else
					emptyLookup.add(value); 
			}
		}
		else
			emptySkip = true; 
	}
	
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException
	{
		init(); 
		
		for (String col : columns)
		{
			String val = row.get(col); 
			if (emptySkip && StringUtils.isEmpty(val))
				return new ArrayList<TableRow>();
			else if (emptyLookup.contains(val))
				return new ArrayList<TableRow>(); 
		}
		
		return Arrays.asList(row);
	}
}
