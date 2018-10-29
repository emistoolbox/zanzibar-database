package es.jbauer.emis.zanzibar.data;

import java.util.List;
import java.util.Map;

import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.TableRowHandler;
import es.jbauer.lib.tables.TableUtils;

public class DataProcess implements DataObject
{
	private DataSource source; 
	private List<DataPipe> pipes;
	
	public DataSource getSource() {
		return source;
	}
	
	public List<DataPipe> getPipes() {
		return pipes;
	} 
	
	int rowCount = 0; 
	
	public void process(Integer pipeIndex)
		throws Exception
	{
		rowCount = 0; 
		TableUtils.readAll(source.getReader(), new TableRowHandler() {
			@Override
			public void process(TableRow row, int rowIndex) throws Exception 
			{
				rowCount++; 
				
				int index = 0; 
				for (DataPipe pipe : pipes)
				{
					if (pipeIndex == null || index == pipeIndex)
						pipe.process(DataUtils.copy(row), rowIndex); 
					
					index++; 
				}
			}
		});

		// Close pipes.
		//
		int index = 0; 
		for (DataPipe pipe : pipes)
		{
			if (pipeIndex == null || index == pipeIndex)
				pipe.close(rowCount); 
			
			index++; 
		}
	}

	@Override
	public void init(Map<String, DataLookup> lookups) 
	{
		DataUtils.updateLookups(source, lookups); 
		DataUtils.updateLookupsList(pipes, lookups); 
	}
}
