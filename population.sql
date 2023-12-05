-- Active: 1700095530729@@127.0.0.1@3306@SENA

############################################################################################

-- INSERT CAREERS

INSERT INTO CAREERS (career)
VALUES
('Desarrollo de Software'),
('Electrónica'),
('Mecánica Automotriz'),
('Seguridad y Salud Ocupacional'),
('Soldadura');

------------------------------------------------------

-- INSERT ROUTES

INSERT INTO ROUTES (route_name)
VALUES
('Sistemas de Información Empresariales'),
('Videojuegos'),
('Machine Learning'),
('Microcontroladores'),
('Robótica'),
('Dispositivos Bio-médicos'),
('Motores Híbridos'),
('Vehículos de Uso Agrícola'),
('Sistemas de Gestión en Seguridad Ocupacional'),
('Soldadura Autógena Industrial'),
('Soldadura Eléctrica Industrial'),
('Soldadura Submarina');

------------------------------------------------------------------------------------

-- INSERT COURSES

INSERT INTO COURSES (course)
VALUES
('Matemáticas Básicas'),
('Álgebra Computacional'),
('Programación Básica'),
('Inglés'),
('Electrónica Básica'),
('Motor de Cuatro Tiempos'),
('Enfermedades Laborales'),
('Higiene Postural en el Trabajo'),
('Ergonomía'),
('Legislación Laboral en Colombia'),
('Materiales de Soldadura'),
('Métodos de Soldadura'),
('Fusión de Metales'),
('Buceo 1'),
('Buceo 2'),
('Riesgo Eléctrico'),
('Bases de Datos Relacionales'),
('Bases de Datos NO Relacionales'),
('Electrónica Digital'),
('Microprocesadores');

---------------------------------------------------------------------------------

-- INSERT INSTRUCTORS

INSERT INTO INSTRUCTORS (f_name,s_name,f_last_name,s_last_name,specialty)
VALUES
('Ricardo', 'Vicente' ,'Jaimes',NULL,'Sistemas'),
('Marinela' ,NULL,'Narvaez',NULL,'Salud Ocupacional'),
('Agustín' ,NULL,'Parra' ,'Granados','Soldadura'),
('Nelson','Raúl','Buitrago',NULL,'Mecánica'),
('Roy','Hernando','Llamas',NULL,'Inglés'),
('Maria','Jimena','Monsalve',NULL,'Electrónica'),
('Juan','Carlos','Cobos',NULL,'Electrónica'),
('Pedro','Nell','Santoamaría',NULL,'Sistemas'),
('Andrea',NULL,'González',NULL,'Sistemas'),
('Marisela',NULL,'Sevilla',NULL,'Salud Ocupacional');

---------------------------------------------------------------------------------------------------------------------

-- INSERT LEARNERS

INSERT INTO LEARNERS (f_name,s_name,f_last_name,s_last_name,age)
VALUES
('Carlos','Saúl','Gómez',NULL,23),
('Leyla','María','Delgado','Vargas',18),
('Juan','José','Cardona',NULL,19),
('Sergio','Augusto','Contreras','Navas',18),
('Ana','María','Velázquez','Parra',22),
('Gustavo',NULL,'Noriega','Alzate',20),
('Pedro','Nell','Gómez','Díaz',27),
('Jairo','Augusto','Castro','Camargo',29),
('Henry',NULL,'Soler','Vega',60),
('Antonio',NULL,'Cañate','Cortés',45),
('Daniel',NULL,'Simancas','Junior',46);

--------------------------------------------------------------------------------------

-- INSERT CAREERS EMPHASIS

INSERT INTO CAREER_EMPHASIS (id_career, id_route)
VALUES
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(5,11),
(5,10);

----------------------------------------------------------------------------------------

-- INSERT COURSES_ROUTE
INSERT INTO COURSES_ROUTE (id_course,id_route,id_instructor, duration_hrs)
VALUES
(17,1,2,(RAND() * (700 - 20) + 20)),
(18,1,2,(RAND() * (700 - 20) + 20)),
(1,1,4,(RAND() * (700 - 20) + 20)),
(2,1,1,(RAND() * (700 - 20) + 20)),
(3,1,3,(RAND() * (700 - 20) + 20)),
(4,1,5,(RAND() * (700 - 20) + 20)),
(3,2,3,(RAND() * (700 - 20) + 20)),
(4,2,5,(RAND() * (700 - 20) + 20)),
(1,2,4,(RAND() * (700 - 20) + 20)),
(2,2,1,(RAND() * (700 - 20) + 20)),
(3,3,3,(RAND() * (700 - 20) + 20)),
(4,3,5,(RAND() * (700 - 20) + 20)),
(17,3,2,(RAND() * (700 - 20) + 20)),
(5,4,7,(RAND() * (700 - 20) + 20)),
(19,4,6,(RAND() * (700 - 20) + 20)),
(20,4,7,(RAND() * (700 - 20) + 20)),
(5,5,7,(RAND() * (700 - 20) + 20)),
(19,5,6,(RAND() * (700 - 20) + 20)),
(20,5,7,(RAND() * (700 - 20) + 20)),
(11,11,3,(RAND() * (700 - 20) + 20)),
(13,11,3,(RAND() * (700 - 20) + 20)),
(11,10,3,(RAND() * (700 - 20) + 20)),
(14,10,NULL,(RAND() * (700 - 20) + 20));

--------------------------------------------------------------------------

-- INSERT ENROLLMENT

INSERT INTO ENROLLMENTS (id_route,id_learner,registration_status)
VALUES
(1,1,1),
(1,2,1),
(2,3,3),
(2,4,1),
(3,5,1),
(4,6,2),
(4,7,2),
(5,8,2),
(5,9,3),
(11,10,2),
(10,11,2);

----------------------------------------------------------------------------------

-- INSERT ENROLLED COURSES

INSERT INTO ENROLLED_COURSES (id_course_route, id_enrollment)
VALUES
(1,1),
(4,1),
(5,1),
(2,1),
(3,2),
(4,2),
(5,2),
(6,2),
(9,3),
(10,3),
(7,3),
(8,4),
(9,4),
(10,4),
(11,5),
(12,5),
(13,5),
(14,6),
(15,6),
(16,6),
(14,7),
(15,7),
(16,7),
(17,8),
(18,8),
(17,9),
(18,9),
(19,9),
(20,10),
(21,10),
(22,11),
(23,11);