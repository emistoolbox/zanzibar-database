package es.jbauer.emis.zanzibar.data.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;

public class SkipDataFilter implements DataFilter
{
	private String[] columns; 
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException
	{
		for (String col : columns)
		{
			if (StringUtils.isEmpty(row.get(col)))
				return new ArrayList<TableRow>(); 
		}
		
		return Arrays.asList(row);
	}
}
