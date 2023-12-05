-- Active: 1700095530729@@127.0.0.1@3306@SENA

#######################################################################

-- ENTITIES

#######################################################################

-- CREATE DATABASE

CREATE DATABASE IF NOT EXISTS SENA;

-------------------------------------------------------------------

-- CREATE CAREERS TABLE

CREATE TABLE IF NOT EXISTS CAREERS (
    id_career INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    career VARCHAR(100) NOT NULL
);

-----------------------------------------------------------------------

-- CREATE ROUTES TABLES

CREATE TABLE IF NOT EXISTS ROUTES (
    id_route INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    route_name VARCHAR(100) NOT NULL
);

------------------------------------------------------------------------

-- CREATE COURSES

CREATE TABLE IF NOT EXISTS COURSES (
    id_course INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    course VARCHAR(100) NOT NULL
);

--------------------------------------------------------------------------

-- CREATE INSTRUCTORS TABLE
CREATE TABLE IF NOT EXISTS INSTRUCTORS (
    id_instructor INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    s_name VARCHAR(50),
    f_last_name VARCHAR(60) NOT NULL,
    s_last_name VARCHAR(60),
    specialty VARCHAR(100) NOT NULL
);

----------------------------------------------------------------------------

-- CREATE LEARNERS TABLE

CREATE TABLE IF NOT EXISTS LEARNERS (
    id_learner INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    s_name VARCHAR(50),
    f_last_name VARCHAR(60) NOT NULL,
    s_last_name VARCHAR(60)
);

-------------------------------------------------------------------------------

###############################################################################

-- INTERMEDIATE TABLES

###############################################################################

-- CREATE CAREER EMPHASIS (INTERMEDIATE TABLE BETWEEN CAREERS TABLE AND ROUTES TABLE)

CREATE TABLE IF NOT EXISTS CAREER_EMPHASIS (
    id_career INT NOT NULL,
    id_route INT NOT NULL,
    CONSTRAINT FOREIGN KEY (id_career) REFERENCES CAREERS(id_career),
    CONSTRAINT FOREIGN KEY (id_route) REFERENCES ROUTES(id_route)
);

---------------------------------------------------------------------------------------

-- CREATE COURSES ROUTE (INTERMEDIATE TABLE BETWEEN ROUTES TABLE, INSTRUCTORS TABLE AND COURSES TABLE)

CREATE TABLE IF NOT EXISTS COURSES_ROUTE (
    id_course_route INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    id_course INT,
    id_route INT,
    id_instructor INT,
    CONSTRAINT FOREIGN KEY (id_course) REFERENCES COURSES(id_course),
    CONSTRAINT FOREIGN KEY (id_route) REFERENCES ROUTES(id_route),
    CONSTRAINT FOREIGN KEY (id_instructor) REFERENCES INSTRUCTORS(id_instructor)
);

------------------------------------------------------------------------------------------------

-- CREATE ENROLLMENTS TABLE (INTERMEDIATE TABLE BETWEEN LEARNERS AND ROUTES)

CREATE TABLE IF NOT EXISTS ENROLLMENTS (
    id_enrollment INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    id_route INT NOT NULL,
    id_learner INT NOT NULL
);

-------------------------------------------------------------------------------------------------

-- CREATE ENROLLED COURSES TABLE ( REFERENCE TO THE ENROLL WITH IT'S COURSES )

CREATE TABLE IF NOT EXISTS ENROLLED_COURSES (
    id_enrollmentS INT NOT NULL,
    id_course_route INT,
    CONSTRAINT FOREIGN KEY (id_enrollmentS) REFERENCES ENROLLMENTSS(id_enrollmentS),
    CONSTRAINT FOREIGN KEY (id_course_route) REFERENCES COURSES_ROUTE(id_course_route)
);

###########################################################################

-- ADD A ENROLLMENTS_STATE FIELD TO ENROLLMENTS TABLE THAT INDICATES WETHER THE STUDENT IS "IN PROGRESS", "COMPLETE" OR "CANCELLED"

ALTER TABLE ENROLLMENTS ADD COLUMN registration_status ENUM('In progress', 'Complete','Cancelled') NOT NULL;

----------------------------------------------------------------------------------------------------------------------------------------

-- ADD THE AGE FIELD TO LEARNERS TABLE

ALTER TABLE LEARNERS ADD COLUMN age INT NOT NULL;

-------------------------------------------------------------

-- IF WE ASSUME THAT COURSES HAVE A DIFFERENT DURATION THAT THE ROUTE CONTAIN THEM, ¿WHAT MODIFICATION WOULD YOU MAKE TO THE DATA STRUCTURE ALREADY PROPOSED?

ALTER TABLE COURSES_ROUTE ADD COLUMN duration_hrs INT;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT THE NAMES AND AGES FROM LEARNERS THAT IS COURSING CAREER OF ELECTRONIC

SELECT f_name, s_name, f_last_name, s_last_name, age, career
FROM LEARNERS 
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner)) 
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route)) 
INNER JOIN CAREER_EMPHASIS ON (ROUTES.id_route IN (CAREER_EMPHASIS.id_route)) 
INNER JOIN CAREERS ON (CAREER_EMPHASIS.id_career IN (CAREERS.id_career) AND career = 'Electrónica')
GROUP BY f_name, s_name, f_last_name, s_last_name, age;

------------------------------------------------------------------------------------------------------------------------------------

-- SELECT THE NAMES OF THE LEARNERS TOGETHER TO THE NAME OF THE LEARN ROUTE THAT THEY CALLED

SELECT f_name, s_name, f_last_name, s_last_name, route_name, registration_status
FROM LEARNERS 
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = "CANCELLED") 
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route))
GROUP BY f_name, s_name, f_last_name, s_last_name, route_name, registration_status;

---------------------------------------------------------------------------------------------------------

-- SELECT THE NAMES OF THE COURSES THAT NOT ASSIGNED INSTRUCTOR

SELECT course, id_instructor 
FROM COURSES 
INNER JOIN COURSES_ROUTE ON (COURSES.id_course IN (COURSES_ROUTE.id_course) AND id_instructor IS NULL);

------------------------------------------------------------------------------

-- SELECT THE NAMES OF THE INSTRUCTORS THAT TEACH COURSES IN THE ROUTE OF LEARN "ENTERPRISE INFORMATION SYSTEM"

SELECT f_name, s_name, f_last_name, s_last_name, route_name AS route_name
FROM INSTRUCTORS
INNER JOIN COURSES_ROUTE ON (INSTRUCTORS.id_instructor IN (COURSES_ROUTE.id_instructor))
INNER JOIN ROUTES ON (COURSES_ROUTE.id_route IN (ROUTES.id_route) AND route_name = 'Sistemas de Información Empresariales')
GROUP BY f_name, s_name, f_last_name, s_last_name;

------------------------------------------------------------------------------------------------

-- YOU WILL GENERATE A LIST OF ALL LEARNERS  THAT FINISHED A CAREER SHOWING THE PROFESSIONAL NAME, THE CAREER NAME AND THE EMPHASIS CAREER (LEARN ROUTE NAME)

SELECT LEARNERS.id_learner, f_name, s_name, f_last_name, s_last_name, career, route_name AS learn_route
FROM LEARNERS
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = 'Complete')
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route))
INNER JOIN CAREER_EMPHASIS ON (ROUTES.id_route IN (CAREER_EMPHASIS.id_route))
INNER JOIN CAREERS ON (CAREER_EMPHASIS.id_career IN (CAREERS.id_career))
GROUP BY LEARNERS.id_learner, f_name, s_name, f_last_name, s_last_name, career, route_name;

-------------------------------------------------------------------------------------------------------------------

-- YOU WILL GENERATE A LIST OF THE LEARNERS ENROLLED IN THE COURSE "RELATIONAL DATABASES"

SELECT f_name, s_name, f_last_name, s_last_name, course, registration_status 
FROM LEARNERS
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = 'In progress' )
INNER JOIN ENROLLED_COURSES ON (ENROLLMENTS.id_enrollment IN (ENROLLED_COURSES.id_enrollment))
INNER JOIN COURSES_ROUTE ON (ENROLLED_COURSES.id_course_route IN (COURSES_ROUTE.id_course_route))
INNER JOIN COURSES ON (COURSES_ROUTE.id_course IN (COURSES.id_course) AND COURSES.course = 'Bases de Datos Relacionales');

-------------------------------------------------------------------------------------------------------------------------------

-- INSTRUCTORS NAMES THAT NOT HAVE COURSE ASSIGNED

SELECT INSTRUCTORS.id_instructor, f_name, s_name, f_last_name, s_last_name
FROM INSTRUCTORS
LEFT OUTER JOIN COURSES_ROUTE
ON INSTRUCTORS.id_instructor = COURSES_ROUTE.id_instructor
WHERE COURSES_ROUTE.id_instructor IS NULL;

---------------------------------------------------------------------------------------------------------------------------------