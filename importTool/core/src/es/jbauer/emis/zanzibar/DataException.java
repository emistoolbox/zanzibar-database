package es.jbauer.emis.zanzibar;

import es.jbauer.lib.tables.TableRow;

public class DataException extends Exception 
{
	private int rowIndex; 
	private TableRow row; 

	public DataException(String message, TableRow row, int rowIndex, Throwable err)
	{
		super(message); 
		this.rowIndex = rowIndex; 
		this.row = row; 
		initCause(err); 
	}
	
	public DataException(TableRow row, int rowIndex, Throwable err)
	{ this(null, row, rowIndex, err); }

	public int getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(int rowIndex) {
		this.rowIndex = rowIndex;
	}

	public TableRow getRow() {
		return row;
	}

	public void setRow(TableRow row) {
		this.row = row;
	}

	@Override
	public String getMessage() 
	{ return super.getMessage() + " " + row.getSourceInfo() + ";" + String.join(",", row.getHeaders()) + "=" + String.join(",", row.getValues()); }
}
