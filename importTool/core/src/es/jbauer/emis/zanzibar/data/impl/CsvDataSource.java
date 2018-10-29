package es.jbauer.emis.zanzibar.data.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.io.IOInput;
import es.jbauer.lib.io.impl.IOFileInput;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.impl.csv.CsvTableConfig;
import es.jbauer.lib.tables.impl.csv.CsvTableFactory;

public class CsvDataSource extends DataSourceBase implements DataSource 
{
	private boolean skip; 
	private String filename; 
	
	@Override
	public TableReader getReader() 
		throws IOException 
	{
		if (skip)
			return new EmptyTableReader(); 
		
		Map<String, String> config = new HashMap<String, String>(); 
		config.put(CsvTableConfig.CSV_DELIMITER, "\t"); 
		
		CsvTableFactory csvFactory = new CsvTableFactory(); 
		IOInput input = new IOFileInput(new File(filename)); 
		return adaptReader(csvFactory.create(input, config)); 
	}
}
