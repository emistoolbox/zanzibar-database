package es.jbauer.emis.zanzibar.data.impl;

import es.jbauer.emis.zanzibar.data.DataIOOutputProvider;
import es.jbauer.lib.io.IOOutput;
import es.jbauer.lib.io.impl.IOOutputStreamOutput;

public class ConsoleIOOutputProvider implements DataIOOutputProvider 
{
	@Override
	public IOOutput getOutput() 
	{ return new IOOutputStreamOutput(System.out); }
}
