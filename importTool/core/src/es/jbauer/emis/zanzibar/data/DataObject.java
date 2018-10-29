package es.jbauer.emis.zanzibar.data;

import java.util.Map;

public interface DataObject 
{
	public void init(Map<String, DataLookup> lookups); 
}
