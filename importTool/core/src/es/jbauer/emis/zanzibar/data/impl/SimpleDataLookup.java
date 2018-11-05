package es.jbauer.emis.zanzibar.data.impl;

import java.util.HashMap;
import java.util.Map;

import es.jbauer.emis.zanzibar.data.DataLookup;

public class SimpleDataLookup implements DataLookup 
{
	private String mappings; 
	private Map<String, String> map = null; 
	
	@Override
	public String get(String key) 
	{
		if (map == null)
		{
			map = new HashMap<String, String>(); 
			for (String mapping : mappings.split(","))
			{
				int pos = mapping.indexOf("="); 
				if (pos == -1)
					continue; 
				
				map.put(mapping.substring(0, pos).toLowerCase(), mapping.substring(pos + 1)); 
			}
		}

		return map.get(key.toLowerCase());
	}

}
