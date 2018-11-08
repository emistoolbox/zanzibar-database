@echo off
mkdir %TMP%\importTool-xls 2> NUL
mkdir %TMP%\importTool-sql 2> NUL
echo = JSON - %1
java -Xmx4096m -DEMIS_EXCEL_CACHE=%TMP%\importTool-xls -cp core/build/zanzibar-import.jar;core/lib/commons-codec-1.5.jar;core/lib/commons-io-2.4.jar;core/lib/commons-lang-2.1.jar;core/lib/dom4j-1.6.1.jar;core/lib/gson-2.8.1.jar;core/lib/gson-extras-0.2.1.jar;core/lib/jbauer.jar;core/lib/poi-3.10-FINAL-20140208.jar;core/lib/poi-ooxml-3.10-FINAL-20140208.jar;core/lib/poi-ooxml-schemas-3.10-FINAL-20140208.jar;core/lib/xmlbeans-2.3.0.jar es.jbauer.emis.zanzibar.ZanzibarImport %1 > %TMP%\importTool-sql\%~n1.sql
echo = DB - %TMP%\importTool-sql\%~n1.sql
mysql -u root -ptesting emis_zanzibar < %TMP%\importTool-sql\%~n1.sql
echo ===
