package es.jbauer.emis.zanzibar.data.impl;

import java.io.IOException;

import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.tables.TableReader;

public class FilteredDataSource implements DataSource 
{
	private DataSource source; 
	private DataFilter[] filters; 
	
	@Override
	public TableReader getReader() 
		throws IOException 
	{ return new FilteredTableReader(source.getReader(), filters); }
}
