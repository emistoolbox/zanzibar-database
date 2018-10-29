--   
-- HIERARCHY
--
DROP TABLE IF EXISTS school_positions; 
CREATE TABLE school_positions
(
    emis_id INTEGER NOT NULL, 
    gis_long FLOAT NOT NULL, 
    gis_lat FLOAT NOT NULL
); 

DROP TABLE IF EXISTS schools_hierarchy; 
CREATE TABLE schools_hierarchy
(
    emis_id INTEGER NOT NULL, 

    district_id INTEGER NOT NULL, 
    tc_id INTEGER,
    shehia_id INTEGER, 

    school_name VARCHAR(100) NOT NULL,
    school_level_id TINYINT, 
    school_type_id TINYINT
); 

DROP TABLE IF EXISTS schools_cluster_hierarchy; 
CREATE TABLE schools_cluster_hierarchy
(
    emis_id INTEGER NOT NULL, 
    cluster_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_school_types; 
CREATE TABLE lookup_school_types
(
	school_type_id TINYINT NOT NULL PRIMARY KEY, 
	school_type_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_school_types VALUES
(0, "government"), 
(1, "private"); 

DROP TABLE IF EXISTS districts; 
CREATE TABLE districts
(
	district_id INTEGER NOT NULL, 
	district_name VARCHAR(100) NOT NULL, 
	region_id INTEGER NOT NULL
); 

DROP TABLE IF EXISTS teacher_centers; 
CREATE TABLE teacher_centers
(
	tc_id INTEGER NOT NULL, 
	tc_name VARCHAR(100) NOT NULL, 
	region_id INTEGER NOT NULL
); 

DROP TABLE IF EXISTS clusters; 
CREATE TABLE clusters
(
	cluster_id INTEGER NOT NULL, 
	cluster_name VARCHAR(100) NOT NULL, 
	tc_id INTEGER NOT NULL
); 

DROP TABLE IF EXISTS shehias; 
CREATE TABLE shehias
(
	shehia_id INTEGER NOT NULL, 
	shehia_name VARCHAR(100) NOT NULL, 
	district_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS regions; 
CREATE TABLE regions
(
	region_id INTEGER NOT NULL, 
	region_name VARCHAR(100) NOT NULL, 
	island_id INTEGER NOT NULL
); 

DROP TABLE IF EXISTS islands; 
CREATE TABLE islands
(
	island_id INTEGER NOT NULL, 
	island_name VARCHAR(100) NOT NULL, 
	nation_id INTEGER NOT NULL
); 

DROP TABLE IF EXISTS nation; 
CREATE TABLE nation
(
	nation_id INTEGER NOT NULL, 
	nation_name VARCHAR(100) NOT NULL
); 

--
-- ENROLMENT
--

DROP TABLE IF EXISTS enrolments; 
CREATE TABLE enrolments 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    grade_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    qty INTEGER NOT NULL
);


DROP TABLE IF EXISTS enrolment_dropouts; 
CREATE TABLE enrolment_dropouts 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);


DROP TABLE IF EXISTS enrolment_repeaters; 
CREATE TABLE enrolment_repeaters 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS enrolment_entrant_ages; 
CREATE TABLE enrolment_entrant_ages 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL,
    gender_id TINYINT NOT NULL, 
    age TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS enrolment_ages; 
CREATE TABLE enrolment_ages
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    age TINYINT NOT NULL, 
    grade_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS enrolment_entrants_educations; 
CREATE TABLE enrolment_entrants_educations 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    educated TINYINT NOT NULL, 
    qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS enrolment_disabilities_pre2018; 
CREATE TABLE enrolment_disabilities_pre2018
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    disability_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_disabilities; 
CREATE TABLE lookup_disabilities
(
	disability_id TINYINT NOT NULL PRIMARY KEY, 
	disability_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_disabilities; 
INSERT INTO lookup_disabilities VALUES
(0, "Visual"), 
(1, "Physical"), 
(2, "Deaf"), 
(3, "Mute"), 
(4, "Mental"), 
(5, "Mixed"),
(6, "Other"), 
(7, "Visual Partial"), 
(8, "Albino"); 



--
-- CLASSROOMS
-- (source DATASET_BAJETI)
DROP TABLE IF EXISTS classrooms; 
CREATE TABLE classrooms
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
	education_level_id TINYINT NOT NULL,
	qty INTEGER NOT NULL, 
    qty_functional INTEGER NOT NULL
); 

-- 
-- TEACHERS
--
DROP TABLE IF EXISTS teacher_educations; 
CREATE TABLE teacher_educations
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    education_level_id TINYINT NOT NULL, 
    qualified TINYINT NOT NULL, 
    teacher_education_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS teacher_attritions; 
CREATE TABLE teacher_attritions
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    teacher_edu_condensed_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS teacher_experiences;
CREATE TABLE teacher_experiences
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    experience_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS teacher_multilevels_pre2018;
CREATE TABLE teacher_multilevels_pre2018
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    teacher_edu_condensed_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS teacher_subject_taught; 
CREATE TABLE teacher_subject_taught
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL, 
    subject_id INTEGER NOT NULL, 
    teacher_edu_condensed_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS population; 
CREATE TABLE population
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    district_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL, 
    age TINYINT NOT NULL, 
    qty INTEGER
); 

DROP TABLE IF EXISTS enrolment_school_leavers; 
CREATE TABLE enrolment_school_leavers
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    leaver_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    qty INTEGER
); 

DROP TABLE IF EXISTS lookup_leaver; 
CREATE TABLE lookup_leaver
(
	leaver_id TINYINT NOT NULL PRIMARY KEY, 
	leaver_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_leaver; 
INSERT INTO  lookup_leaver VALUES 
(0, "Enumerator"),
(1, "Denominator"); 

DROP TABLE IF EXISTS lookup_teacher_experiences; 
CREATE TABLE lookup_teacher_experiences
(
	experience_id TINYINT NOT NULL PRIMARY KEY, 
	experience_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_teacher_experiences VALUES 
(0, "0-5"),
(1, "6-10"), 
(2, "11-15"), 
(3, "16-20"), 
(4, "21-25"), 
(5, "26-30"), 
(6, "30+");  

--
-- TOILETS
--
DROP TABLE IF EXISTS toilets; 
CREATE TABLE toilets
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
	education_level_id TINYINT NOT NULL, 
	toilet_id TINYINT NOT NULL, 
	qty INTEGER NOT NULL
);	

DROP TABLE IF EXISTS toilets_gender; 
CREATE TABLE toilets_gender
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
	education_level_id TINYINT NOT NULL, 
	gender_id TINYINT NOT NULL, 
	qty INTEGER NOT NULL
);	

DROP TABLE IF EXISTS lookup_toilets; 
CREATE TABLE lookup_toilets
(
	toilet_id TINYINT NOT NULL PRIMARY KEY, 
	toilet_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_toilets VALUES
(0, "male"),
(1, "female"),
(2, "teacher"),
(3, "pupils mixed"), 
(4, "pupil/teacher"),
(5, "disabled"); 


--
-- FURNITURE
DROP TABLE IF EXISTS furnitures; 
CREATE TABLE furnitures
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
	education_level_id TINYINT NOT NULL, 
	furniture_id TINYINT NOT NULL, 
	qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_furnitures; 
CREATE TABLE lookup_furnitures
(
	furniture_id TINYINT NOT NULL PRIMARY KEY, 
	furniture_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_furnitures VALUES
(0, "1 pupil desk"),
(1, "2 pupil desk"),
(2, "3 pupil desk"),
(3, "chair"),
(4, "1 pupil table"),
(5, "2 pupil table");

--
-- TEXTBOOKS
DROP TABLE IF EXISTS textbooks; 
CREATE TABLE textbooks
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
	grade_id TINYINT NOT NULL, 
	subject_id INTEGER NOT NULL, 
	qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_subjects; 
CREATE TABLE lookup_subjects
(
	subject_id INTEGER NOT NULL PRIMARY KEY, 
	subject_name CHAR(32) NOT NULL, 
	education_level_id TINYINT NOT NULL
); 

INSERT INTO lookup_subjects VALUES
(0, "Lugha", 0), 
(1, "Dini ya Kiislam", 0), 
(2, "Hisabati", 0),
(3, "Mazingira", 0), 
(4, "Michezo", 0), 
(5, "Sanaa na Ufundi", 0),

(100, "Arabic", 1), 
(101, "Computer", 1), 
(102, "English", 1), 
(103, "Islamic", 1), 
(104, "Kiswahili", 1), 
(105, "Hisabati", 1), 
(106, "Sayansi", 1), 
(107, "Sayansi Jamii", 1), 
(108, "Michezo", 1), 
(109, "Elimu Amali", 1), 
(110, "Geography", 1), 
(111, "Historia", 1), 
(112, "Uraia", 1),

(200, "Arabic", 2), 
(201, "Biol", 2), 
(202, "B.Keeping", 2), 
(203, "Chem", 2), 
(204, "Commer", 2), 
(205, "Comp", 2), 
(206, "Eng", 2), 
(207, "Geog", 2), 
(208, "Hist", 2), 
(209, "Islamic", 2), 
(210, "Kisw", 2), 
(211, "Math", 2), 
(212, "Phys", 2), 
(213 ,"Civ", 2); 


DROP TABLE IF EXISTS lookup_genders; 
CREATE TABLE lookup_genders
(
	gender_id TINYINT NOT NULL PRIMARY KEY, 
	gender_name CHAR(2) NOT NULL
); 

INSERT INTO lookup_genders VALUES
(0, 'm'), 
(1, 'f'); 

DROP TABLE IF EXISTS lookup_school_levels; 
CREATE TABLE lookup_school_levels
(
    school_level_id TINYINT NOT NULL PRIMARY KEY, 
    school_level_name CHAR(16) NOT NULL
); 

INSERT INTO lookup_school_levels VALUES
(0, 'Pre-Primary'), 
(1, 'Primary'), 
(2, 'Secondary'),
(3, 'Basic'), 
(4, 'TuTu');

DROP TABLE IF EXISTS lookup_education_levels; 
CREATE TABLE lookup_education_levels
(
education_level_id TINYINT NOT NULL PRIMARY KEY, 
education_level_name CHAR(16) NOT NULL
); 

INSERT INTO lookup_education_levels VALUES
(0, 'Pre-Primary'), 
(1, 'Primary'), 
(2, 'Secondary'); 

DROP TABLE IF EXISTS lookup_grades; 
CREATE TABLE lookup_grades
(
	grade_id TINYINT NOT NULL PRIMARY KEY, 
	grade_name CHAR(16) NOT NULL, 
	education_level_id TINYINT NOT NULL
); 

INSERT INTO lookup_grades VALUES
(1, 'Nr', 0), 
(2, 'Jr', 0), 
(3, 'Sr', 0), 

(4, 'Std I', 1), 
(5, 'Std II', 1), 
(6, 'Std III', 1), 
(7, 'Std IV', 1), 
(8, 'Std V', 1), 
(9, 'Std VI', 1), 
(10, 'Std VII', 1), 

(11, 'Form I', 2), 
(12, 'Form II', 2), 
(13, 'Form III', 2), 
(14, 'Form IV', 2), 
(15, 'Form V', 2), 
(16, 'Form VI', 2);

DROP TABLE IF EXISTS lookup_teacher_educations; 
CREATE TABLE lookup_teacher_educations
(
	teacher_education_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_education_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_teacher_educations VALUES
(0, "Under F4"), 
(1, "F4"), 
(2, "F6"), 
(3, "FTC"), 
(4, "Diploma"), 
(5, "Degree"); 


DROP TABLE IF EXISTS lookup_teacher_edu_condensed; 
CREATE TABLE lookup_teacher_edu_condensed
(
	teacher_edu_condensed_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_edu_condensed_name CHAR(32) NOT NULL
); 

INSERT INTO lookup_teacher_edu_condensed VALUES
(0, "Untrained"), 
(1, "FTC"), 
(2, "Diploma"), 
(3, "Degree");

DROP TABLE IF EXISTS exam_passes; 
CREATE TABLE exam_passes
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
	exam_grade_id TINYINT NOT NULL, 
	exam_level_id INTEGER NOT NULL, 
	qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS exam_scores; 
CREATE TABLE exam_scores
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	emis_id INTEGER NOT NULL, 
	year INTEGER NOT NULL, 
    exam_grade_id TINYINT NOT NULL, 
    exam_subject_id TINYINT NOT NULL,
	score FLOAT NOT NULL, 
	max_score FLOAT NOT NULL
); 

DROP TABLE IF EXISTS lookup_exam_grades; 
CREATE TABLE lookup_exam_grades
(
	exam_grade_id TINYINT NOT NULL PRIMARY KEY, 
	exam_grade_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_exam_grades; 
INSERT INTO lookup_exam_grades VALUES
(0, "Std IV"), 
(1, "Std VI"),
(2, "Form II"), 
(3, "Form IV"), 
(4, "Form VI"); 

DROP TABLE IF EXISTS lookup_exam_levels; 
CREATE TABLE lookup_exam_levels
(
	exam_level_id TINYINT NOT NULL PRIMARY KEY, 
	exam_level_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_exam_levels; 
INSERT INTO lookup_exam_levels VALUES
(0, "Failed"), 
(1, "Passed"),
(2, "Excellent"), 
(3, "Superior"), 
(5, "Div 4"), 
(6, "Div 3"), 
(7, "Div 2"), 
(8, "Div 1"), 
(10, "Attended Exam"), 
(11, "Missed Exam"), 
(12, "Matriculated Form 5"), 
(13, "Matriculated FTC"); 

DROP TABLE IF EXISTS lookup_exam_subjects; 
CREATE TABLE lookup_exam_subjects
(
	exam_subject_id TINYINT NOT NULL PRIMARY KEY, 
	exam_subject_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_exam_subjects; 
INSERT INTO lookup_exam_subjects VALUES
(0, "ENG"),
(1, "KISW"),
(2, "DINI"),
(3, "KIAR"),
(4, "GEOG"),
(5, "CIVICS"),
(6, "HIST"),
(7, "CHEM"),
(8, "PHY"),
(9, "BIOL"),
(10, "MATH"),
(11, "URAIA"),
(12, "SCIENCE"),
(13, "ICT"), 
(14, "SAYANSI"), 
(15, "HISABATI");

DROP VIEW IF EXISTS schools_active_by_level; 
CREATE VIEW schools_active_by_level AS 
SELECT emis_id, year, education_level_id, 1 isActive 
FROM enrolment_ages e 
INNER JOIN lookup_grades g ON g.grade_id = e.grade_id 
WHERE qty > 0
GROUP BY emis_id, year, education_level_id; 

DROP VIEW IF EXISTS schools_active; 
CREATE VIEW schools_active AS 
SELECT emis_id, year, 1 isActive 
FROM schools_active_by_level
GROUP BY emis_id, year; 

DROP VIEW IF EXISTS schools_hierarchy_by_year ; 
CREATE VIEW schools_hierarchy_by_year AS 
SELECT a.emis_id as emis_id, year, district_id, tc_id, shehia_id, school_name, school_type_id, h.school_level_id
FROM schools_hierarchy h, schools_active a
WHERE h.emis_id = a.emis_id; 

DROP VIEW IF EXISTS exam_attendance; 
CREATE VIEW exam_attendance AS 
SELECT emis_id, year, exam_grade_id, SUM(qty) as attended
FROM exam_passes 
WHERE exam_level_id IN (10)
GROUP BY emis_id, year, exam_grade_id;

DROP VIEW IF EXISTS exam_total_score; 
CREATE VIEW exam_total_score AS 
SELECT es.emis_id, es.year, es.exam_grade_id, exam_subject_id, ROUND(score * attended) as total_score, ROUND(max_score * attended) as max_score, attended
FROM exam_scores es, exam_attendance ea
WHERE es.emis_id = ea.emis_id 
    AND es.year = ea.year 
    AND es.exam_grade_id = ea.exam_grade_id; 
    
DROP VIEW IF EXISTS exam_gender_attendance; 
CREATE VIEW exam_gender_attendance AS 
SELECT emis_id, year, gender_id, exam_grade_id, SUM(qty) as attended
FROM exam_passes 
WHERE exam_level_id IN (10)
GROUP BY emis_id, year, gender_id, exam_grade_id;

DROP VIEW IF EXISTS enrolment_by_level; 
CREATE VIEW enrolment_by_level AS
SELECT emis_id, year, education_level_id, gender_id, SUM(qty) as qty 
FROM enrolments
GROUP BY emis_id, year, education_level_id, gender_id; 

DROP VIEW IF EXISTS enrolment_repeaters_by_level;
CREATE VIEW enrolment_repeaters_by_level AS 
SELECT emis_id, year, 0 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_repeaters WHERE grade_id IN (1,2,3)
GROUP BY emis_id, year, gender_id
UNION 
SELECT emis_id, year, 1 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_repeaters WHERE grade_id IN (4,5,6,7,8,9,10)
GROUP BY emis_id, year, gender_id
UNION 
SELECT emis_id, year, 2 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_repeaters WHERE grade_id IN (11,12,13,14,15,16)
GROUP BY emis_id, year, gender_id; 

DROP VIEW IF EXISTS enrolment_dropouts_by_level; 
CREATE VIEW enrolment_dropouts_by_level AS 
SELECT emis_id, year, 0 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_dropouts WHERE grade_id IN (1,2,3)
GROUP BY emis_id, year, gender_id
UNION 
SELECT emis_id, year, 1 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_dropouts WHERE grade_id IN (4,5,6,7,8,9,10)
GROUP BY emis_id, year, gender_id
UNION 
SELECT emis_id, year, 2 as education_level_id, gender_id, SUM(qty) as qty 
FROM enrolment_dropouts WHERE grade_id IN (11,12,13,14,15,16)
GROUP BY emis_id, year, gender_id; 

DROP TABLE IF EXISTS school_shifts; 
CREATE TABLE school_shifts
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id INTEGER NOT NULL,
    shifts TINYINT NOT NULL
);

DROP VIEW IF EXISTS classrooms_functional; 
CREATE VIEW classrooms_functional AS 
SELECT c.emis_id, c.year, c.education_level_id, SUM(CASE WHEN shifts IS NULL THEN qty ELSE shifts * qty END) as classrooms_functional
FROM classrooms c
LEFT JOIN school_shifts s ON s.emis_id = c.emis_id AND s.education_level_id = c.education_level_id AND s.year = c.year
GROUP BY c.emis_id, c.year, c.education_level_id; 

DROP VIEW IF EXISTS seats; 
CREATE VIEW seats AS 
SELECT f.emis_id, f.year, f.education_level_id, SUM(CASE WHEN furniture_id IN (0, 1, 2) THEN furniture_id + 1 WHEN furniture_id = 3 THEN 1 ELSE 0 END) as seats
FROM furnitures f
GROUP BY f.emis_id, f.year, f.education_level_id; 

DROP VIEW IF EXISTS seats_functional; 
CREATE VIEW seats_functional AS 
SELECT s.emis_id, s.year, s.education_level_id, seats, CASE WHEN shifts IS NULL THEN seats ELSE shifts * seats END as seats_functional
FROM seats s
LEFT JOIN school_shifts i ON s.emis_id = i.emis_id AND s.education_level_id = i.education_level_id AND s.year = i.year;

--
-- Facilities
--
DROP TABLE IF EXISTS school_facilities; 
CREATE TABLE school_facilities 
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    hasWater TINYINT NOT NULL, 
    hasPower TINYINT NOT NULL, 
    hasLibrary TINYINT NOT NULL, 
    hasLaboratory TINYINT NOT NULL, 
    hasFeeding TINYINT NOT NULL, 
    hasPlayground TINYINT NOT NULL
); 

DROP VIEW IF EXISTS facilities;
CREATE VIEW facilities AS 
(SELECT emis_id, year, education_level_id, 0 as facility, 1 as count FROM school_facilities WHERE hasWater = 1)
UNION 
(SELECT emis_id, year, education_level_id, 1 as facility, 1 as count FROM school_facilities WHERE hasPower = 1)
UNION 
(SELECT emis_id, year, education_level_id, 2 as facility, 1 as count FROM school_facilities WHERE hasLibrary = 1)
UNION 
(SELECT emis_id, year, education_level_id, 3 as facility, 1 as count FROM school_facilities WHERE hasPlayground = 1)
UNION 
(SELECT emis_id, year, education_level_id, 4 as facility, 1 as count FROM school_facilities WHERE hasLaboratory = 1)
UNION 
(SELECT emis_id, year, education_level_id, 5 as facility, 1 as count FROM school_facilities WHERE hasFeeding = 1); 

DROP VIEW IF EXISTS population_by_level; 
CREATE VIEW population_by_level AS 
SELECT district_id, year, gender_id, 0 as education_level_id, sum(qty) as qty 
FROM population 
WHERE age in (4, 5) 
GROUP BY district_Id, year, gender_id
UNION
SELECT district_id, year, gender_id, 1 as education_level_id, sum(qty) as qty 
FROM population 
WHERE age in (6, 7, 8, 9, 10, 11) 
GROUP BY district_Id, year, gender_id
UNION
SELECT district_id, year, gender_id, 2 as education_level_id, sum(qty) as qty 
FROM population 
WHERE age in (12, 13, 14, 15) 
GROUP BY district_Id, year, gender_id;

DROP VIEW IF EXISTS enrolment_net; 
CREATE VIEW enrolment_net AS 
SELECT emis_id, year, gender_id, 0 as education_level_id, sum(qty) as qty 
FROM enrolment_ages 
WHERE age in (4, 5) 
GROUP BY emis_id, year, gender_id
UNION
SELECT emis_id, year, gender_id, 1 as education_level_id, sum(qty) as qty 
FROM enrolment_ages 
WHERE age in (6, 7, 8, 9, 10, 11) 
GROUP BY emis_id, year, gender_id
UNION
SELECT emis_id, year, gender_id, 2 as education_level_id, sum(qty) as qty 
FROM enrolment_ages
WHERE age in (12, 13, 14, 15) 
GROUP BY emis_id, year, gender_id;

-------------------------------------------------
-- New Tables Oct 2018
-------------------------------------------------
DROP TABLE if exists enrolment_disabilities_post2017; 
CREATE TABLE enrolment_disabilities_post2017
(
id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
emis_id INTEGER NOT NULL, 
year INTEGER NOT NULL, 
education_level_id TINYINT NOT NULL, 
grade_id TINYINT NOT NULL,
gender_id TINYINT NOT NULL, 
disability_id TINYINT NOT NULL, 
qty INTEGER NOT NULL
);

DROP VIEW IF EXISTS enrolment_disabilities; 
CREATE VIEW enrolment_disabilities AS 
SELECT emis_id, year, education_level_id, gender_id, disability_id, qty FROM enrolment_disabilities_pre2018
UNION 
SELECT emis_id, year, education_level_id, gender_id, disability_id, SUM(qty) FROM enrolment_disabilities_post2017
GROUP BY emis_id, year, education_level_id, gender_id, disability_id; 

ALTER TABLE enrolment_dropouts add column dropout_reason_id TINYINT NOT NULL;
Update enrolment_dropouts set dropout_reason_id = 12;

DROP TABLE if exists lookup_dropout_reasons; 
CREATE TABLE lookup_dropout_reasons
(
	dropout_reason_id TINYINT NOT NULL PRIMARY KEY, 
	dropout_reason_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_dropout_reasons; 
INSERT INTO lookup_dropout_reasons VALUES
(1, "Parental abandonment"), 
(2, "Domestic duties"), 
(3, "No family support"), 
(4, "Poverty"), 
(5, "Marriage"), 
(6, "Pregnacy"),
(7, "Death"), 
(8, "Relocation"), 
(9, "Employment"),
(10, "Explusion"),
(11, "Illness"), 
(12, "Unknown");

DROP TABLE if exists expenses;
CREATE TABLE expenses
(
id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
emis_id INTEGER NOT NULL, 
year INTEGER NOT NULL, 
education_level_id TINYINT NOT NULL, 
expense_id TINYINT NOT NULL,
amount integer NOT NULL);

DROP TABLE if exists lookup_expenses;
CREATE TABLE lookup_expenses
(expense_id TINYINT NOT NULL PRIMARY KEY, 
	expense_name CHAR(64) NOT NULL
	);

DELETE FROM lookup_expenses; 
INSERT INTO lookup_expenses VALUES
(1, "Mishahara"), 
(2, "Vifaa vya kusomeshea na kujiunzia"),
(3, "Vifaa vya maabara"),
(4, "Vifaa vyengine"),
(5, "Gharama za maji, umeme na usafi"),
(6, "Usafiri"),
(7, "Ujenzi"),
(8, "Ziara za kimasomo"),
(9, "Michezo"), 
(10, "Matumzi mengine");

DROP TABLE if exists revenues;
CREATE TABLE revenues
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    revenue_id TINYINT NOT NULL,
    amount integer NOT NULL
);

DROP TABLE if exists lookup_revenues;
CREATE TABLE lookup_revenues
(
    revenue_id TINYINT NOT NULL PRIMARY KEY, 
	revenue_name CHAR(64) NOT NULL
);

DELETE FROM lookup_revenues; 
INSERT INTO lookup_revenues VALUES
(1, "Kilimo"), 
(2, "Biashara ndogo ndogo "),
(3, "Kazi za mikono"),
(4, "Kodi ya jengo"),
(5, "Ada ya masomo"),
(6, "Misada ya nje"),
(7, "Ruzuku ya jengo"),
(8, "Misada isiyokuwa ya fedha"),
(9, "Michango ya wazee"), 
(10, "Michango mengine");


DROP TABLE if exists lookup_othertlms;
CREATE TABLE lookup_other_tlms
(
    other_tlms_id TINYINT NOT NULL PRIMARY KEY, 
	other_tlms_name CHAR(64) NOT NULL
);

DELETE FROM lookup_other_tlms; 
INSERT INTO lookup_other_tlms VALUES

(1, "Taipu"), 
(2, "Atlas"), 
(3, "Kamusi"), 
(4, "Geometric sets"), 
(5, "Globe"), 
(6, "Projector"), 
(7, "Fotokopi"), 
(8, "Printa"), 
(9, "Redio"), 
(10, "Scanner"), 
(11, "TV"), 
(12, "Video"), 
(13, "Chati za ukutani"), 
(14, "Kompyuta za wanafunzi"), 
(15, "Kompyuta za walimu"), 
(18, "Science kit"), 
(17, "Ramani za ukutani"), 
(16, "Braille machine"), 
(22, "Physics Kit"), 
(21, "Biology Kit"), 
(20, "Chemistry Kit"), 
(19, "Physical education kit");

DROP TABLE if exists other_tlms;
CREATE TABLE other_tlms
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    other_tlms_id TINYINT NOT NULL,
    qty integer NOT NULL
);

DROP TABLE if exists lookup_shifts;
CREATE TABLE lookup_shifts
(
    shift_id TINYINT NOT NULL PRIMARY KEY, 
	shift_name CHAR(64) NOT NULL
);

DELETE FROM lookup_shifts; 
INSERT INTO lookup_shifts VALUES
(1, "Morning"), 
(2, "Afternoon");


DROP TABLE if exists streams;
CREATE TABLE streams
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    grade_id TINYINT NOT NULL,
    shift_id TINYINT NOT NULL,
    qty TINYINT NOT NULL
);



DROP TABLE if exists teacher_guides;
CREATE TABLE teacher_guides
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    grade_id TINYINT NOT NULL, 
    subject_id INTEGER NOT NULL,
    qty integer NOT NULL
);


DROP TABLE if exists lookup_teacher_age;
CREATE TABLE lookup_teacher_age
(
    teacher_age_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_age CHAR(32) NOT NULL
);

DELETE FROM lookup_teacher_age; 
INSERT INTO lookup_teacher_age VALUES
(0, "Chini ya miaka 21"), 
(1, "21-25"), 
(2, "26-30"), 
(3, "31-35"), 
(4, "36-40"), 
(5, "41-45"), 
(6, "46-50"), 
(7, "51-55"), 
(8, "56-60"), 
(9, "Zaidi ya miaka 60");


DROP TABLE if exists teacher_age;
CREATE TABLE teacher_age
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    teacher_age_id INTEGER NOT NULL,
    qty integer NOT NULL
);



DROP TABLE if exists lookup_teacher_duties;
CREATE TABLE lookup_teacher_duties
(
    teacher_duties_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_duties CHAR(32) NOT NULL
);

DELETE FROM lookup_teacher_duties; 
INSERT INTO lookup_teacher_duties VALUES

(1, "Karani"), 
(2, "Mpiga chapa"), 
(3, "Mkutubi"), 
(4, "Mlinzi"), 
(5, "Mpishi"), 
(6, "Dereva"), 
(7, "Utingo"), 
(8, "Fundi"), 
(9, "Matron"), 
(11, "Mshauri nasaha"), 
(12, "Barsar"), 
(13, "Afisa nidhame"),
(14, "Msidizi wa maabara"),
(10, "Mengineyo");


DROP TABLE if exists teacher_duties;
CREATE TABLE teacher_duties
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    teacher_education_id TINYINT NOT NULL,
    teacher_duties_id INTEGER NOT NULL,
    qty integer NOT NULL
);

CREATE TABLE `enrolment_entrants` 
(
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `emis_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `gender_id` tinyint(4) NOT NULL,
  `education_level_id` tinyint(4) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `PPE_status_id` tinyint(4) NOT NULL,
  `qty` int(11) NOT NULL
); 

CREATE TABLE `lookup_ppe_status` 
(
  `ppe_status_id` tinyint(4) NOT NULL,
  `ppe_status` char(32) NOT NULL
); 

DELETE FROM lookup_ppe_status; 
INSERT INTO lookup_ppe_status VALUES
(1, "With PPE"), 
(2, "Without PPE"); 
    
DROP Table IF EXISTS lookup_teacher_age;
CREATE TABLE `lookup_teacher_age` 
(
  `teacher_age_id` tinyint(4) NOT NULL,
  `teacher_age` char(32) NOT NULL
); 

DELETE FROM lookup_teacher_age; 
INSERT INTO lookup_teacher_age VALUES
(0, "Chini ya miaka 21"),
(1, "21-25"),
(2, "26-30"),
(3, "31-35"),
(4, "36-40"),
(5, "41-45"),
(6, "46-50"),
(7, "51-55"),
(8, "56-60"),
(9, "Zaidi ya miaka 60"); 

DROP Table IF EXISTS teacher_multilevels_post2017;
CREATE TABLE teacher_multilevels_post2017
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    teacher_trained_id TINYINT NOT NULL,
    teacher_education_id TINYINT NOT NULL,
    qty integer NOT NULL
); 

DROP VIEW IF EXISTS teacher_multilevels;
CREATE VIEW teacher_multilevels AS 
SELECT emis_id, year, education_level_id, gender_id, teacher_edu_condensed_id, qty FROM teacher_multilevels_pre2018
UNION
SELECT emis_id, year, education_level_id, gender_id, 0 as teacher_edu_condensed_id, qty FROM teacher_multilevels_post2017 WHERE teacher_education_id = 0
UNION
(SELECT emis_id, year, education_level_id, gender_id, 1 as teacher_edu_condensed_id, SUM(qty) as qty FROM teacher_multilevels_post2017 WHERE teacher_education_id IN (1, 2, 3)
GROUP BY emis_id, year, education_level_id, gender_id) 
UNION
SELECT emis_id, year, education_level_id, gender_id, teacher_education_id - 2 as teacher_edu_condensed_id, qty FROM teacher_multilevels_post2017 WHERE teacher_education_id IN (4, 5); 


DROP TABLE IF EXISTS school_infos; 
CREATE TABLE school_infos
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    shared_building TINYINT NOT NULL, 
    distance_road FLOAT NOT NULL,
    registration_no VARCHAR(32) NOT NULL,
    year_established INTEGER NOT NULL,
    location_id TINYINT NOT NULL,
    school_owner_id TINYINT NOT NULL,
    telephone CHAR(12) NOT NULL,
    email VARCHAR(64) NOT NULL,
    loi_kiswahili TINYINT NOT NULL,
    loi_english TINYINT NOT NULL,
    loi_other TINYINT NOT NULL,
    stats_name VARCHAR(100) NOT NULL,
    stats_telephone CHAR(32) NOT NULL,
    HT_name VARCHAR(100) NOT NULL,
    head_gender_id TINYINT NOT NULL, 
    HT_telephone CHAR(32) NOT NULL
); 

DROP TABLE IF EXISTS lookup_school_owner; 
CREATE TABLE lookup_school_owner
(
	school_owner_id TINYINT NOT NULL PRIMARY KEY, 
	school_owner_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_school_owner; 
INSERT INTO lookup_school_owner VALUES
(1, "Serikali"), 
(2, "Jamil"),
(3, "Mtu Binafisi"),
(4, "Jumiya isiyo ya kiserikali"),
(5, "Mashirika")
; 

DROP TABLE IF EXISTS lookup_location; 
CREATE TABLE lookup_location
(
	location_id TINYINT NOT NULL PRIMARY KEY, 
	location_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_location; 
INSERT INTO lookup_location VALUES
(1, "Urban"), 
(2, "Rural")
; 

----------
-- jorg --
----------
--
-- Power
--
DROP TABLE IF EXISTS school_power; 
CREATE TABLE school_power
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    power_id TINYINT NOT NULL
); 

DROP TABLE IF EXISTS lookup_power; 
CREATE TABLE lookup_power
(
	power_id TINYINT NOT NULL PRIMARY KEY, 
	power_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_power; 
INSERT INTO lookup_power VALUES
(1, "Grid"), 
(2, "Other"); 

-- 
-- Waters
--
DROP TABLE IF EXISTS school_water; 
CREATE TABLE school_water
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    water_id TINYINT NOT NULL
); 

DROP TABLE IF EXISTS lookup_water; 
CREATE TABLE lookup_water
(
	water_id TINYINT NOT NULL PRIMARY KEY, 
	water_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_water; 
INSERT INTO lookup_water VALUES
(1, "Tap"), 
(2, "waters Pump"), 
(3, "Protected Well"), 
(4, "Unprotected Well"), 
(5, "Other"); 


-- 
-- Teacher_housing
--
DROP TABLE IF EXISTS school_teacher_housing; 
CREATE TABLE school_teacher_housing
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    houses_qty INTEGER, 
    teachers_housed INTEGER
); 


--
-- 
-- Buildings
--

DROP TABLE IF EXISTS school_buildings; 
CREATE TABLE school_buildings
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    building_id TINYINT NOT NULL,
    qty INTEGER
); 

DROP TABLE IF EXISTS lookup_buildings; 
CREATE TABLE lookup_buildings
(
	buildings_id TINYINT NOT NULL PRIMARY KEY, 
	buildings_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_buildings; 
INSERT INTO lookup_buildings VALUES
(0, "Ukumbi"),
(4, "Mkahawa"),
(1, "Jiko"),
(5, "Dakhalia W'me"),
(6, "Dakhalia W'ke"),
(2, "Ghala"),
(3, "Duka"); 

--
-- 
-- OtherRooms
--

DROP TABLE IF EXISTS other_rooms; 
CREATE TABLE other_rooms
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 
    other_room_id TINYINT NOT NULL,
    qty INTEGER
); 

DROP TABLE IF EXISTS lookup_other_rooms; 
CREATE TABLE lookup_other_rooms
(
	other_rooms_id TINYINT NOT NULL PRIMARY KEY, 
	other_rooms_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_other_rooms; 
INSERT INTO lookup_other_rooms VALUES
(0, "Maktaba"), 
(1, "Afisi ya Mwalimu Mkuu"), 
(2, "Afisi za Walimu"), 
(3, "Ukumbi ya kusoma"), 
(4, "Chumba cha Kompyuta"), 
(5, "Chumba cha Ushauri Nasaha"), 
(6, "Vyumba vyengine"), 
(7, "Maabara"), 
(8, "Karakana ya ufundi"), 
(9, "Chumba cha jiografia"); 
---
--- Classrooms
--- 
ALTER TABLE classrooms ADD COLUMN classrooms_notused INTEGER; 
ALTER TABLE classrooms ADD COLUMN classrooms_good INTEGER; 
ALTER TABLE classrooms ADD COLUMN classrooms_major_repairs INTEGER; 
ALTER TABLE classrooms ADD COLUMN classroom_new_constructions INTEGER; 


--
-- teacher_subject_specialization
--
DROP TABLE IF EXISTS teacher_subject_specializations; 
CREATE TABLE teacher_subject_specializations
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    subject_id TINYINT NOT NULL, 
    subject_specialization_qualification TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
); 

DROP TABLE IF EXISTS lookup_subject_specialization_qualifications; 
CREATE TABLE lookup_subject_specialization_qualifications
(
	subject_specialization_qualifications_id TINYINT NOT NULL PRIMARY KEY, 
	subject_specialization_qualifications_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_subject_specialization_qualifications; 
INSERT INTO lookup_subject_specialization_qualifications VALUES
(1, "Cheti"), 
(2, "Stashahada (Diploma)"), 
(3, "Shahada ya kwanz"), 
(4, "Shahada ya Uzamili"), 
(5, "Shahada ya Uzamivu"); 


-- 
-- enrolment_transout
-- 
DROP TABLE IF EXISTS enrolment_transout; 
CREATE TABLE enrolment_transout
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

-- 
-- enrolment_transin
-- 
DROP TABLE IF EXISTS enrolment_transin; 
CREATE TABLE enrolment_transin
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

-- 
-- enrolment_streetkids
-- 
DROP TABLE IF EXISTS enrolment_streetkids; 
CREATE TABLE enrolment_streetkids
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

-- 
-- enrolment_orphans
-- 
DROP TABLE IF EXISTS enrolment_orphans; 
CREATE TABLE enrolment_orphans
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    gender_id TINYINT NOT NULL,
    grade_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

-- 
-- teacher_skills
-- 
DROP TABLE IF EXISTS teacher_skills; 
CREATE TABLE teacher_skills
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    gender_id TINYINT NOT NULL,
    teacher_skills_id TINYINT NOT NULL,
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_teacher_skills; 
CREATE TABLE lookup_teacher_skills
(
	teacher_skills_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_skills_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_teacher_skills; 
INSERT INTO lookup_teacher_skills VALUES
(1, "Computer"), 
(2, "Life Skills"), 
(3, "HIV/AIDS"), 
(4, "School Development"), 
(5, "Language and English"), 
(8, "ECD/Pre-1"), 
(6, "Integrated Education"), 
(7, "Special Education"), 
(9, "Alternative Learning");

--
-- teacher_leave
--
DROP TABLE IF EXISTS teacher_leaves;
CREATE TABLE teacher_leaves
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    gender_id TINYINT NOT NULL,
    teacher_edu_condensed_id TINYINT NOT NULL, 
    teacher_leave_id TINYINT NOT NULL,
    qty INTEGER NOT NULL
);

CREATE TABLE lookup_teacher_leave_reasons
(
	teacher_leave_reason_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_leave_reason_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_teacher_leave_reasons; 
INSERT INTO lookup_teacher_leave_reasons VALUES
(1, "discharged"), 
(2, "retired"), 
(3, "death"), 
(4, "illness"), 
(5, "paid vacation"), 
(6, "transfer to government office"), 
(7, "transfer to private organization"), 
(8, "training"), 
(9, "disability"), 
(10, "Other");

--
-- teacher_inset
--
DROP TABLE IF EXISTS teacher_insets; 
CREATE TABLE teacher_insets
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    gender_id TINYINT NOT NULL,
    teacher_inset_id TINYINT NOT NULL,
    teacher_trained_id TINYINT NOT NULL, 
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_teacher_trained; 
CREATE TABLE lookup_teacher_trained
(
	teacher_trained_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_trained_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_teacher_trained;
INSERT INTO lookup_teacher_trained VALUES
(1, "Trained"), 
(2, "Untrained"); 

-- 
-- teacher_education
-- 
DROP TABLE IF EXISTS teacher_educations; 
CREATE TABLE teacher_educations
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    emis_id INTEGER NOT NULL, 
    year INTEGER NOT NULL, 
    education_level_id TINYINT NOT NULL, 

    teacher_education_id TINYINT NOT NULL, 
    teacher_specialization_id TINYINT NOT NULL,
    teacher_trained_id TINYINT NOT NULL, 
    gender_id TINYINT NOT NULL,
    qty INTEGER NOT NULL
);

DROP TABLE IF EXISTS lookup_teacher_specialization; 
CREATE TABLE lookup_teacher_specialization
(
	teacher_specialization_id TINYINT NOT NULL PRIMARY KEY, 
	teacher_specialization_name CHAR(32) NOT NULL
); 

DELETE FROM lookup_teacher_specialization; 
INSERT INTO lookup_teacher_specialization VALUES
(1, "Sanaa"), 
(2, "Sayansi"), 
(3, "Mchanganyiko"); 
