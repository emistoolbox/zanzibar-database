package es.jbauer.emis.zanzibar.data.impl;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.TableRowHandler;
import es.jbauer.lib.tables.TableUtils;

public class FileDataLookup implements DataLookup
{
	private DataSource source; 
	private Map<String, String> values; 
	private String keyColumn; 
	private String valueColumn; 

	@Override
	public synchronized String get(String key) 
	{
		if (values == null)
			readValues(); 
		
		return values.get(key);
	}
	
	private void readValues()
	{
		keyColumn = keyColumn.trim(); 
		valueColumn = valueColumn.trim(); 
		try { 
			values = new HashMap<String, String>(); 
			TableReader reader = source.getReader();
			TableUtils.readAll(reader, new TableRowHandler() {
				@Override
				public void process(TableRow row, int rowIndex) throws Exception 
				{ values.put(row.get(keyColumn), row.get(valueColumn)); }
			});
		}
		catch (Exception ex)
		{ ex.printStackTrace(); }
	}
}
	