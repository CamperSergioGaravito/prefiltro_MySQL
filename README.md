# PROYECTO FINAL MYSQL
---
## MENU

* [DIAGRAM ENTITY RELATIONSHIP](#diagram-entity-relationship)
* [RELTAIONAL DIAGRAM](#relational-diagram)
* [QUERY 1](#1-add-a-enrollments_state-field-to-enrollments-table-that-indicates-wether-the-student-is-in-progress-complete-or-cancelled)
* [QUERY 2](#2-add-the-age-field-to-learners-table)
* [QUERY 3](#3-if-we-assume-that-courses-have-a-different-duration-that-the-route-contain-them-¿what-modification-would-you-make-to-the-data-structure-already-proposed)
* [QUERY 4](#4-select-the-names-and-ages-from-learners-that-is-coursing-career-of-electronic)
* [QUERY 5](#5-select-the-names-of-the-learners-together-to-the-name-of-the-learn-route-that-they-called)
* [QUERY 6](#6-select-the-names-of-the-courses-that-not-assigned-instructor)
* [QUERY 7](#7-select-the-names-of-the-instructors-that-teach-courses-in-the-route-of-learn-enterprise-information-system)
* [QUERY 8](#8-you-will-generate-a-list-of-all-learners-that-finished-a-career-showing-the-professional-name-the-career-name-and-the-emphasis-career-learn-route-name)
* [QUERY 9](#9-you-will-generate-a-list-of-the-learners-enrolled-in-the-course-relational-databases)

* [QUERY 10](#10-instructors-names-that-not-have-course-assigned)
* [QUESTIONS](#questions)

---

### # DIAGRAM ENTITY RELATIONSHIP

![DIAGRAM ER](./diagram%20entity%20relationship.png)

---

### # RELATIONAL DIAGRAM

![RELATIONAL DIAGRAM](./RELATIONAL%20DIAGRAM.png)

---

### 1) Add a enrollments_state field to enrollments table that indicates wether the student is "in progress", "complete" or "cancelled".

~~~ SQL
ALTER TABLE ENROLLMENTS ADD COLUMN registration_status ENUM('In progress', 'Complete','Cancelled') NOT NULL;
~~~
---

### 2) Add the age field to learners table.

~~~SQL
ALTER TABLE LEARNERS ADD COLUMN age INT NOT NULL;
~~~
---

### 3) If we assume that courses have a different duration that the route contain them, ¿what modification would you make to the data structure already proposed?.

~~~ SQL
ALTER TABLE COURSES_ROUTE ADD COLUMN duration_hrs INT;
~~~
[GO TO MENU](#menu)
---

### 4) Select the names and ages from learners that is coursing career of electronic.

~~~ SQL
SELECT f_name, s_name, f_last_name, s_last_name, age, career
FROM LEARNERS 
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner)) 
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route)) 
INNER JOIN CAREER_EMPHASIS ON (ROUTES.id_route IN (CAREER_EMPHASIS.id_route)) 
INNER JOIN CAREERS ON (CAREER_EMPHASIS.id_career IN (CAREERS.id_career) AND career = 'Electrónica')
GROUP BY f_name, s_name, f_last_name, s_last_name, age;
~~~
---

### 5) Select the names of the learners together to the name of the learn route that they called.

~~~ SQL
SELECT f_name, s_name, f_last_name, s_last_name, route_name, registration_status
FROM LEARNERS 
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = "CANCELLED") 
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route))
GROUP BY f_name, s_name, f_last_name, s_last_name, route_name, registration_status;
~~~
---

### 6) Select the names of the courses that not assigned instructor.

~~~ SQL
SELECT course, id_instructor 
FROM COURSES 
INNER JOIN COURSES_ROUTE ON (COURSES.id_course IN (COURSES_ROUTE.id_course) AND id_instructor IS NULL);
~~~
[GO TO MENU](#menu)
---

### 7) Select the names of the instructors that teach courses in the route of learn "enterprise information system".

~~~ SQL
SELECT f_name, s_name, f_last_name, s_last_name, route_name AS route_name
FROM INSTRUCTORS
INNER JOIN COURSES_ROUTE ON (INSTRUCTORS.id_instructor IN (COURSES_ROUTE.id_instructor))
INNER JOIN ROUTES ON (COURSES_ROUTE.id_route IN (ROUTES.id_route) AND route_name = 'Sistemas de Información Empresariales')
GROUP BY f_name, s_name, f_last_name, s_last_name;
~~~
---

### 8) You will generate a list of all learners  that finished a career showing the professional name, the career name and the emphasis career (learn route name).

~~~ SQL
SELECT LEARNERS.id_learner, f_name, s_name, f_last_name, s_last_name, career, route_name AS learn_route
FROM LEARNERS
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = 'Complete')
INNER JOIN ROUTES ON (ENROLLMENTS.id_route IN (ROUTES.id_route))
INNER JOIN CAREER_EMPHASIS ON (ROUTES.id_route IN (CAREER_EMPHASIS.id_route))
INNER JOIN CAREERS ON (CAREER_EMPHASIS.id_career IN (CAREERS.id_career))
GROUP BY LEARNERS.id_learner, f_name, s_name, f_last_name, s_last_name, career, route_name;
~~~
---

### 9) You will generate a list of the learners enrolled in the course "relational databases".

~~~ SQL
SELECT f_name, s_name, f_last_name, s_last_name, course, registration_status 
FROM LEARNERS
INNER JOIN ENROLLMENTS ON (LEARNERS.id_learner IN (ENROLLMENTS.id_learner) AND registration_status = 'In progress' )
INNER JOIN ENROLLED_COURSES ON (ENROLLMENTS.id_enrollment IN (ENROLLED_COURSES.id_enrollment))
INNER JOIN COURSES_ROUTE ON (ENROLLED_COURSES.id_course_route IN (COURSES_ROUTE.id_course_route))
INNER JOIN COURSES ON (COURSES_ROUTE.id_course IN (COURSES.id_course) AND COURSES.course = 'Bases de Datos Relacionales');
~~~
---

### 10) Instructors names that not have course assigned.

~~~ SQL
SELECT INSTRUCTORS.id_instructor, f_name, s_name, f_last_name, s_last_name
FROM INSTRUCTORS
LEFT OUTER JOIN COURSES_ROUTE
ON INSTRUCTORS.id_instructor = COURSES_ROUTE.id_instructor
WHERE COURSES_ROUTE.id_instructor IS NULL;
~~~
[GO TO MENU](#menu)
---
---

# QUESTIONS

~~~
En un gallinero hay gallinas con sus pollitos y un gallo para el gallinero, si los granjeros llevan un registro de los pollitos antes de nacer, ¿ donde se crea dicha relación?:


A) POLLITO
B) GALLO
C) HUEVO [X]
D) GALLINA
E) NINGUNA
~~~
---

~~~
TENGO UNA TIENDA DE DULCES CON MUCHOS CLIENTES, TODOS LOS DIAS SE VENDE A UN SOLO CLIENTE 100 DULCES, PERO, EL MARTES JUEVES Y SABADO SE VENDEN 25 DULCES A 3 NIÑOS, ¿QUE FORMA DEBO USA PARA SABER EL PROMEDIO DE DICHAS VENTAS A LA SEMANA DE MANERA OPTIMA?

A) SUMANDO LA CANTIDAD DE DULCES Y MULTIPLICANDO POR 100
B) SUMANDO TODA LA VENTA SEMANAL Y DIVIDIENDO ENTRE LA CANTIDAD DE VENTAS DE LA SEMANA
C) AVG(SUM(VENTAS))
D) AVG(VENTAS) [X]
E) NINGUNA
~~~
---

~~~
SI QUIERO CONTAR CUANTOS APRENDICES TIENEN 20 AÑOS DE UNA TABLA CON SUS NOMBRES Y EDADES, ¿CUAL SERÍA LA CONSULTA?

A) SELECT IF age = 20 COUNT(age) FROM APRENDICES;
B) SELECT IF age = 20 SUM(age) FROM APRENDICES;
C) SELECT SUM(age) FROM APRENDICES
D) SELECT COUNT(age) FROM APRENDICES WHERE AGE = 20;  [X]
E) SELECT CONT(age) FROM APRENDICES WHERE AGE = 20;
~~~
---

~~~
QUE COMPONE EL CUERPO DE UNA SENTENCIA UPDATE?

A) FROM, WHERE
B) WHERE
C) FROM, WHERE, SET
D) WHERE, SET [X]
E) NINGUNA
~~~
