package es.jbauer.emis.zanzibar;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataObject;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class DataUtils
{
	public static TableRow copy(TableRow source)
	{ return DataUtils.updateSourceInfo(new StringTableRow(source.getHeaders(), source.getValues(), null, null), source, null); }
	
	public static void updateLookups(Object item, Map<String, DataLookup> lookups)
	{
		if (item instanceof DataObject)
			((DataObject) item).init(lookups); 
	}

	public static void updateLookupsArray(Object[] items, Map<String, DataLookup> lookups)
	{
		if (items == null)
			return; 
		
		for (Object item : items)
			updateLookups(item, lookups); 
	}
	
	public static void updateLookupsList(List items, Map<String, DataLookup> lookups)
	{
		if (items == null)
			return; 
		
		for (Object item : items)
			updateLookups(item, lookups);
	}
	
	public static int index(String[] haystack, String needle)
	{
		for (int i = 0; i < haystack.length; i++)
			if (haystack[i].equals(needle))
				return i; 
		
		return -1; 
	}

	public static TableRow updateSourceInfo(TableRow newRow, TableRow oldRow, String message)
	{
		String oldMessage = oldRow.getSourceInfo(); 
		if (StringUtils.isEmpty(oldMessage))
			newRow.setSourceInfo(message);
		else if (StringUtils.isEmpty(message))
			newRow.setSourceInfo(oldMessage);
		else
			newRow.setSourceInfo(oldMessage + ", " + message);

		return newRow; 
	}
}
