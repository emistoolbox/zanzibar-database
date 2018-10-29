package es.jbauer.emis.zanzibar.data.impl;

import java.io.IOException;
import java.io.PrintWriter;

import es.jbauer.emis.zanzibar.data.DataIOOutputProvider;
import es.jbauer.emis.zanzibar.data.DataTarget;

public abstract class DataTargetBase extends DataBase implements DataTarget 
{
	private PrintWriter out = null; 
	private DataIOOutputProvider output = new ConsoleIOOutputProvider();
	
	protected void output(String value)
		throws IOException
	{
		if (out == null)
			out = new PrintWriter(output.getOutput().getOutputStream());  
	
		out.print(value);
		out.flush(); 
	}
}
