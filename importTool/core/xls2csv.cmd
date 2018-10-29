@echo off 
java -Xmx4096m -cp lib\commons-codec-1.5.jar;lib\commons-io-2.4.jar;lib\commons-lang-2.1.jar;lib\dom4j-1.6.1.jar;lib\gson-2.8.1.jar;lib\gson-extras-0.2.1.jar;lib\jbauer.jar;lib\poi-3.10-FINAL-20140208.jar;lib\poi-ooxml-3.10-FINAL-20140208.jar;lib\poi-ooxml-schemas-3.10-FINAL-20140208.jar;lib\xmlbeans-2.3.0.jar;build\zanzibar-import.jar es.jbauer.emis.tools.Xls2Csv %*
