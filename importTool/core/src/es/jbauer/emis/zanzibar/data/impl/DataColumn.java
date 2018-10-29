package es.jbauer.emis.zanzibar.data.impl;

public class DataColumn 
{
	public static final String TYPE_STRING = "string"; 
	public static final String TYPE_INTEGER = "int"; 
	public static final String TYPE_DOUBLE = "double"; 
	public static final String TYPE_DATE = "date"; 
	
	private String name; 
	private String source; 
	private String type = "String";

	public String getName() {
		return name;
	}
	public String getSource() {
		return source;
	}
	public String getType() {
		return type;
	}

}
