package es.jbauer.emis.zanzibar.data;

import java.util.List;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.lib.tables.TableRow;

public interface DataFilter
{ 
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex)
		throws DataFilterException; 
}
