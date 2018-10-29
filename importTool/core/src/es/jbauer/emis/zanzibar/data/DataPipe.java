package es.jbauer.emis.zanzibar.data;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.lib.tables.TableRow;

public class DataPipe implements DataObject
{
	private String comment; 
	private List<DataFilter> filters; 
	private DataTarget target;

	public List<DataFilter> getFilters() 
	{ return filters; }
	
	public DataTarget getTarget() 
	{ return target; } 
	
	public void process(TableRow row, int index)
		throws Exception
	{ process(Arrays.asList(row), index, 0); }
	
	private void process(List<TableRow> rows, int rowIndex, int filterIndex)
		throws Exception
	{
		if (filters == null || filterIndex >= filters.size())
		{
			for (TableRow row : rows)
				target.process(row, rowIndex);
		}
		else
		{
			DataFilter filter = filters.get(filterIndex); 
			for (TableRow row : rows)
				process(filter.filter(row, rowIndex, filterIndex), rowIndex, filterIndex + 1);
		}
	}
	
	public void close(int totalRowCount)
		throws IOException
	{ target.close(totalRowCount); }

	@Override
	public void init(Map<String, DataLookup> lookups) 
	{
		DataUtils.updateLookups(target, lookups);
		DataUtils.updateLookupsList(filters, lookups);
	}
}
