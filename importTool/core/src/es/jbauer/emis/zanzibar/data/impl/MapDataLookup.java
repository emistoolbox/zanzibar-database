package es.jbauer.emis.zanzibar.data.impl;

import java.util.Map;

import es.jbauer.emis.zanzibar.data.DataLookup;

public class MapDataLookup implements DataLookup 
{
	private Map<String, String> values; 
	
	@Override
	public String get(String key) 
	{ return values.get(key); }
}
