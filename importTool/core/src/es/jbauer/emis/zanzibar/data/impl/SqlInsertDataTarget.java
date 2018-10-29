package es.jbauer.emis.zanzibar.data.impl;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataException;
import es.jbauer.lib.tables.TableRow;

public class SqlInsertDataTarget extends DataTargetBase 
{
	private static final int MAX_ROWS_PER_INSERT = 1000; 
	
	private String table; 
	private boolean withDelete = false; 
	private Map<String, String> types; 
	private Map<String, String> columns; 
	private String[] skipIfColumnsEmpty; 
	private String[] notNullColumns; 
	
	private int count = 0;
	private boolean first = true; 
	
	@Override
	public void process(TableRow row, int index) throws Exception 
	{
		if (skip(row))
			return; 
	
		String emptyCols = getEmptyNotNullColumns(row); 
		if (emptyCols != null)
		{
			output ("-- Error: Empty NOT NULL columns: " + emptyCols + " - " + row.getSourceInfo());
			return; 
		}
		
		try { output(getRowSql(row, index)); }
		catch (Exception ex)
		{ 
			String message = "-- Error: " + ex.getMessage();
			if (ex.getCause() != null)
				message += ";" + ex.getCause().getMessage(); 

			message = message.replaceAll("\n", "\n-- ") + "\n"; 
			
			output(message); 
		}
	}
	
	private String getRowSql(TableRow row, int index) 
		throws Exception
	{
		StringBuffer result = new StringBuffer(); 

		String delim = ""; 
		if (count == 0)
		{
			if (withDelete && first)
				result.append("DELETE FROM ").append(table).append(";\n"); 
			first = false; 
			
			result.append("INSERT INTO ").append(table).append(" ("); 
			for (Map.Entry<String, String> column : columns.entrySet())
			{
				result.append(delim); 
				result.append(column.getKey());
				delim = ", "; 
			}
	
			result.append(") VALUES \n      "); 
		}
		else
			result.append("    , "); 
		
		delim = ""; 
		result.append("("); 
		for (Map.Entry<String, String> entry : columns.entrySet())
		{
			result.append(delim);
			
			try { result.append(format(eval(entry.getValue(), row), getType(entry.getKey()))); }
			catch (Throwable err)
			{ throw new DataException("Row " + index + ": " + entry.getKey() + "=" + entry.getValue(), row, index, err); }
			
			delim = ", "; 
		}

		result.append(")"); 
		
		count++; 
		if (count == MAX_ROWS_PER_INSERT)
		{
			result.append(";\n\n"); 
			count = 0; 
		}
		else
			result.append("\n"); 

		return result.toString(); 
	}
	
	private String getEmptyNotNullColumns(TableRow row)
	{
		if (notNullColumns == null)
			return null; 
		
		StringBuffer result = new StringBuffer(); 
		for (String column : notNullColumns)
			if (StringUtils.isEmpty(column))
			{
				if (result.length() > 0)
					result.append(","); 
				result.append(column); 
			}
		
		return result.length() == 0 ? null : result.toString(); 
	}
	
	private boolean skip(TableRow row)
	{
		if (skipIfColumnsEmpty == null)
			return false; 
		
		for (String col : skipIfColumnsEmpty)
		{
			if (!StringUtils.isEmpty(row.get(col)))
				return false; 
		}
		
		return true; 
	}
	
	@Override
	public void close(int totalRowCount) 
		throws IOException
	{ output(";"); }



	private String getType(String key)
	{
		if (types != null && types.get(key) != null)
			return types.get(key); 
		
		return DataColumn.TYPE_INTEGER; 
	}

	private String format(String value, String type)
	{
		if (value == null)
			return "NULL"; 
		
		switch (type)
		{
		case DataColumn.TYPE_DATE:
		case DataColumn.TYPE_STRING: 
			return "'" + StringEscapeUtils.escapeSql(value) + "'"; 
			
		case DataColumn.TYPE_DOUBLE:
			if ("".equals(value))
				value ="0.0"; 
			
			new Double(value); 
			return value; 
			
		case DataColumn.TYPE_INTEGER: 
			if ("".equals(value))
				value ="0"; 
			
			new Integer(value);  
			return value; 
		}
		
		return "NULL";  
	}
}
