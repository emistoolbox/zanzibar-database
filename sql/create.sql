CREATE DATABASE emis_zanzibar
   DEFAULT CHARACTER SET utf8
   DEFAULT COLLATE utf8_general_ci;
USE emis_zanzibar; 

GRANT SELECT ON emis_zanzibar.* TO 'emis_user' IDENTIFIED BY 'CountZanzibarSchools';
GRANT SELECT, INSERT, UPDATE, DELETE ON emis_zanzibar.* TO 'emis_admin' IDENTIFIED BY 'ZanzibarSchoolsAdmin';
