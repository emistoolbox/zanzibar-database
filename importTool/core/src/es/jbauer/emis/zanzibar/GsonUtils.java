package es.jbauer.emis.zanzibar;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.typeadapters.RuntimeTypeAdapterFactory;

import es.jbauer.emis.zanzibar.data.DataFilter;
import es.jbauer.emis.zanzibar.data.DataIOOutputProvider;
import es.jbauer.emis.zanzibar.data.DataLookup;
import es.jbauer.emis.zanzibar.data.DataSource;
import es.jbauer.emis.zanzibar.data.DataTarget;
import es.jbauer.emis.zanzibar.data.impl.AddDataFilter;
import es.jbauer.emis.zanzibar.data.impl.ColumnsDataFilter;
import es.jbauer.emis.zanzibar.data.impl.UnionDataSource;
import es.jbauer.emis.zanzibar.data.impl.ConsoleIOOutputProvider;
import es.jbauer.emis.zanzibar.data.impl.CopyDataFilter;
import es.jbauer.emis.zanzibar.data.impl.CsvDataSource;
import es.jbauer.emis.zanzibar.data.impl.ExcelDataSource;
import es.jbauer.emis.zanzibar.data.impl.ExpandDataFilter;
import es.jbauer.emis.zanzibar.data.impl.FileDataLookup;
import es.jbauer.emis.zanzibar.data.impl.FileIOOutputProvider;
import es.jbauer.emis.zanzibar.data.impl.FilteredDataSource;
import es.jbauer.emis.zanzibar.data.impl.JoinColumnsDataFilter;
import es.jbauer.emis.zanzibar.data.impl.MapDataFilter;
import es.jbauer.emis.zanzibar.data.impl.MapDataLookup;
import es.jbauer.emis.zanzibar.data.impl.RenameDataFilter;
import es.jbauer.emis.zanzibar.data.impl.SimpleDataLookup;
import es.jbauer.emis.zanzibar.data.impl.SkipDataFilter;
import es.jbauer.emis.zanzibar.data.impl.SqlInsertDataTarget;

public class GsonUtils 
{
	public static Gson createGson()
	{
		GsonBuilder builder = new GsonBuilder(); 

		RuntimeTypeAdapterFactory<DataSource> dataSourceAdaptor = RuntimeTypeAdapterFactory.of(DataSource.class);
		dataSourceAdaptor.registerSubtype(ExcelDataSource.class, "excel"); 
		dataSourceAdaptor.registerSubtype(CsvDataSource.class, "csv"); 
		dataSourceAdaptor.registerSubtype(UnionDataSource.class, "union"); 
		dataSourceAdaptor.registerSubtype(FilteredDataSource.class, "filtered");
		builder.registerTypeAdapterFactory(dataSourceAdaptor);

		RuntimeTypeAdapterFactory<DataFilter> dataFilterAdaptor = RuntimeTypeAdapterFactory.of(DataFilter.class);
		dataFilterAdaptor.registerSubtype(ExpandDataFilter.class, "expand");
		dataFilterAdaptor.registerSubtype(MapDataFilter.class, "map");
		dataFilterAdaptor.registerSubtype(SkipDataFilter.class, "skip");
		dataFilterAdaptor.registerSubtype(RenameDataFilter.class, "rename");
		dataFilterAdaptor.registerSubtype(ColumnsDataFilter.class, "cols");
		dataFilterAdaptor.registerSubtype(AddDataFilter.class, "add");
		dataFilterAdaptor.registerSubtype(CopyDataFilter.class, "copy");
		dataFilterAdaptor.registerSubtype(JoinColumnsDataFilter.class, "joinCols");
		builder.registerTypeAdapterFactory(dataFilterAdaptor);

		RuntimeTypeAdapterFactory<DataTarget> dataTargetAdaptor = RuntimeTypeAdapterFactory.of(DataTarget.class);
		dataTargetAdaptor.registerSubtype(SqlInsertDataTarget.class, "sql"); 
		builder.registerTypeAdapterFactory(dataTargetAdaptor); 

		RuntimeTypeAdapterFactory<DataLookup> dataLookupAdaptor = RuntimeTypeAdapterFactory.of(DataLookup.class);
		dataLookupAdaptor.registerSubtype(MapDataLookup.class, "map"); 
		dataLookupAdaptor.registerSubtype(SimpleDataLookup.class, "simple"); 
		dataLookupAdaptor.registerSubtype(FileDataLookup.class, "file");  
		builder.registerTypeAdapterFactory(dataLookupAdaptor); 
		
		RuntimeTypeAdapterFactory<DataIOOutputProvider> dataOutputProviderAdaptor = RuntimeTypeAdapterFactory.of(DataIOOutputProvider.class);
		dataOutputProviderAdaptor.registerSubtype(ConsoleIOOutputProvider.class, "console"); 
		dataOutputProviderAdaptor.registerSubtype(FileIOOutputProvider.class, "file"); 
		builder.registerTypeAdapterFactory(dataOutputProviderAdaptor); 

		return builder.create(); 
	}
}
