package es.jbauer.emis.zanzibar;

import java.io.FileReader;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataProcess;

public class ZanzibarImport 
{
	private static Gson gson = GsonUtils.createGson(); 

	private Map<String, DataLookup> lookups = null; 
	private List<DataProcess> processes = null; 
	
	public static final void main(String[] args)
		throws Exception
	{
		ZanzibarImport task = gson.fromJson(new FileReader(args[0]), ZanzibarImport.class); 
		task.init(); 
		
		Integer processIndex = null; 
		if (args.length > 1)
		{
			try { processIndex = new Integer(args[1]); }
			catch (Throwable err)
			{}
		}

		Integer pipeIndex = null; 
		if (args.length > 2)
		{
			try { pipeIndex = new Integer(args[2]); } 
			catch (Throwable err)
			{}
		}
		
		task.process(processIndex, pipeIndex); 
	}
	
	private void process(Integer processIndex, Integer pipeIndex)
		throws Exception
	{
		int index = 0; 
		for (DataProcess process : processes)
		{
			if (processIndex == null || index == processIndex)
				process.process(pipeIndex); 
			
			index++; 
		}
	}
	
	private void init()
	{
		for (DataProcess process : processes)
			process.init(lookups); 
	}
}
