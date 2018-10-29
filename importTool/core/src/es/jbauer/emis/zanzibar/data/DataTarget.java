package es.jbauer.emis.zanzibar.data;

import java.io.IOException;

import es.jbauer.lib.tables.TableRowHandler;

public interface DataTarget extends TableRowHandler 
{
	public void close(int totalRowCount)
		throws IOException; 
}
