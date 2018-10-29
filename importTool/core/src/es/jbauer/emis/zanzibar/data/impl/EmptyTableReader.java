package es.jbauer.emis.zanzibar.data.impl;

import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.TableRow;

public class EmptyTableReader implements TableReader 
{
	@Override
	public String[] getHeaders() 
	{ return new String[] { "null" }; }

	@Override
	public boolean isFirstRow() 
	{ return false; } 

	@Override
	public boolean hasNextRow() 
	{ return false; } 

	@Override
	public TableRow getNextRow() 
	{ return null; }

	@Override
	public void close() 
	{}

	@Override
	public String getInfo() 
	{ return "EmptyTableReader"; }

	@Override
	public void setDateFormat(String dateFormat, String dateTimeFormat) 
	{}
}
