package es.jbauer.emis.zanzibar.data;

import java.io.IOException;

import es.jbauer.lib.tables.TableReader;

public interface DataSource 
{
	TableReader getReader()
		throws IOException; 
}
