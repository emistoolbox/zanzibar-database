package es.jbauer.emis.zanzibar.data.impl;

import java.io.File;

import es.jbauer.emis.zanzibar.data.DataIOOutputProvider;
import es.jbauer.lib.io.IOOutput;
import es.jbauer.lib.io.impl.IOFileOutput;

public class FileIOOutputProvider implements DataIOOutputProvider 
{
	private String pathname; 
	
	@Override
	public IOOutput getOutput() 
	{ return new IOFileOutput(new File(pathname)); }
}
