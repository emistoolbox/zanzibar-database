package es.jbauer.emis.zanzibar.data.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import es.jbauer.emis.zanzibar.DataFilterException;
import es.jbauer.emis.zanzibar.DataUtils;
import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.lib.tables.TableRow;
import es.jbauer.lib.tables.impl.StringTableRow;

public class RenameDataFilter implements DataFilter 
{
	private Map<String, String> renames; 

	private Pattern regex; 
	private String matchRegex; 
	private String replaceRegex; 
	
	@Override
	public List<TableRow> filter(TableRow row, int rowIndex, int filterIndex) 
		throws DataFilterException 
	{
		String[] oldHeaders = row.getHeaders(); 
		String[] headers = new String[oldHeaders.length]; 
		for (int i = 0; i < headers.length; i++)
			headers[i] = renameHeader(oldHeaders[i]); 

		return Arrays.asList(DataUtils.updateSourceInfo(new StringTableRow(headers, row.getValues(), null, null), row,  null));
	}
	
	private String renameHeader(String oldHeader)
	{
		if (renames != null)
		{
			String newHeader = renames.get(oldHeader); 
			if (!StringUtils.isEmpty(newHeader))
				return newHeader; 
		}
		
		if (!StringUtils.isEmpty(matchRegex) && !StringUtils.isEmpty(matchRegex))
		{
			if (regex == null); 
				regex = Pattern.compile(matchRegex); 

			Matcher m = regex.matcher(oldHeader); 
			String newHeader = m.replaceAll(replaceRegex); 
			if (!StringUtils.isEmpty(newHeader))
				return newHeader; 
		}
		
		return oldHeader; 	
	}
}
