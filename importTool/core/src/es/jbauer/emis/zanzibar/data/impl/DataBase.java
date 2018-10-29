package es.jbauer.emis.zanzibar.data.impl;

import es.jbauer.lib.tables.TableRow;

public class DataBase 
{
	protected String eval(String value, TableRow row)
	{
		if (value.startsWith("'") && value.endsWith("'"))
			return value.substring(1, value.length() - 1); 
		
		return row.get(value); 
	}
}
