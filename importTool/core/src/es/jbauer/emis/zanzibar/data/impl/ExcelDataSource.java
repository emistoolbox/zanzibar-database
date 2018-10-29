package es.jbauer.emis.zanzibar.data.impl;

import java.io.File;
import java.io.IOException;

import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.lib.io.IOInput;
import es.jbauer.lib.io.impl.IOFileInput;
import es.jbauer.lib.tables.TableReader;
import es.jbauer.lib.tables.impl.excel.ExcelTableFactory;

public class ExcelDataSource implements DataSource
{
	private String filename; 
	private String worksheet;
	
	@Override
	public TableReader getReader() 
		throws IOException
	{
		ExcelTableFactory factory = new ExcelTableFactory(); 
		
		IOInput input = new IOFileInput(new File(filename)); 
		return worksheet == null ? factory.create(input) : factory.create(input, worksheet); 
	} 
}
