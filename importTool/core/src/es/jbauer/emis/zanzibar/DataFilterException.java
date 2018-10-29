package es.jbauer.emis.zanzibar;

import es.jbauer.lib.tables.TableRow;

public class DataFilterException extends DataException
{
	private int transformIndex; 
	
	public DataFilterException(int transformException, TableRow row, int rowIndex, Throwable cause)
	{
		super(row, rowIndex, cause); 
		this.transformIndex = transformIndex; 
	}

	public int getTransformIndex() {
		return transformIndex;
	}

	public void setTransformIndex(int transformIndex) {
		this.transformIndex = transformIndex;
	}
}
