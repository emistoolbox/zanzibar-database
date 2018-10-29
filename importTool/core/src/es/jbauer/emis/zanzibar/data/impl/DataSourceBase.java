package es.jbauer.emis.zanzibar.data.impl;

import java.util.Map;

import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.tables.TableReader;

public abstract class DataSourceBase implements DataSource
{
	private Map<String, String> consts;
	
	protected TableReader adaptReader(TableReader reader)
	{
		if (consts != null && consts.size() > 0)
			return new FilteredTableReader(reader, new DataFilter[] { AddDataFilter.create(consts)}); 
		
		return reader; 
	}
}
