--1. Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT a.NOMBRE, a.CREDITOS 
FROM ASIGNATURA a;

--2. Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.
SELECT DISTINCT a.CREDITOS 
FROM ASIGNATURA a;

--3. Mostrar todos los datos de todas de las personas
SELECT *
FROM PERSONA p;

--4. Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT a.NOMBRE, a.CREDITOS 
FROM ASIGNATURA a 
WHERE a.CUATRIMESTRE = 1;

--5. Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT p.NOMBRE, p.APELLIDO 
FROM PERSONA p
WHERE p.FECHA_NACIMIENTO < TO_DATE('01/01/1975','DD/MM/YYYY');

--6. Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT a.NOMBRE, a.COSTEBASICO 
FROM ASIGNATURA a 
WHERE a.CREDITOS > 4.5;

--7. Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.COSTEBASICO BETWEEN 25 AND 35;

--8. Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA LIKE '150212' OR aa.IDASIGNATURA LIKE '130113' OR (aa.IDASIGNATURA LIKE '130113' AND aa.IDASIGNATURA LIKE '150212');

--9. Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.CUATRIMESTRE = 2 AND a.CREDITOS != 6;

--10. Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT p.NOMBRE, p.APELLIDO
FROM PERSONA p 
WHERE p.APELLIDO LIKE 'G%';

--11. Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion. 
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION IS NULL;

--12. Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION IS NOT NULL;

--13. Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros. 
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.COSTEBASICO > 8;

--14. Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
SELECT a.NOMBRE, (a.CREDITOS*10) AS NUM_HORAS
FROM ASIGNATURA a;
--14. Pero quitando valores nulos
SELECT a.NOMBRE, NVL(a.CREDITOS,0)*10 AS NUM_HORAS
FROM ASIGNATURA a;

--15. Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT *
FROM ASIGNATURA a
WHERE a.CUATRIMESTRE = 2
ORDER BY a.IDASIGNATURA;

--16. Mostrar el nombre de todas las mujeres que viven en “Madrid”.
SELECT p.NOMBRE 
FROM PERSONA p
WHERE p.VARON = 0 AND p.CIUDAD LIKE '%Madrid%';

--17. Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT p.NOMBRE, p.TELEFONO 
FROM PERSONA p 
WHERE p.TELEFONO LIKE '91%';

--18. Mostrar el nombre de las asignaturas que contengan la sílaba “pro”
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE LOWER(a.NOMBRE) LIKE '%pro%';

--19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.CURSO = 1 AND a.IDPROFESOR LIKE 'P101';

--20. Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, mostrando también el código de la asignatura correspondiente.
SELECT aa.IDALUMNO, aa.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.NUMEROMATRICULA  >= 3;

--21. El coste de cada asignatura va subiendo a medida que se repite la asignatura. 
--Para saber cuál sería el precio de las distintas asignaturas en las repeticiones (y así animar a nuestros alumnos a que estudien) se quiere mostrar un listado 
--en donde esté el nombre de la asignatura, el precio básico, el precio de la primera repetición (un 10 por ciento más que el coste básico),  
--el precio de la segunda repetición (un 30 por ciento más que el coste básico) y el precio de la tercer repetición (un 60 por ciento más que el coste básico).
SELECT a.NOMBRE, a.COSTEBASICO, a.COSTEBASICO + (a.COSTEBASICO*0.1) AS PRIMERA_REPETICION, a.COSTEBASICO + (a.COSTEBASICO*0.3) AS SEGUNDA_REPETICION, a.COSTEBASICO + (a.COSTEBASICO*0.6) AS TERCERA_REPETICION
FROM ASIGNATURA a;

--22. Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de los 70.
SELECT *
FROM PERSONA p 
WHERE p.FECHA_NACIMIENTO < TO_DATE('01/01/1970','DD/MM/YYYY');

--23. Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT p.DNI 
FROM PERSONA p, PROFESOR p2 
WHERE p.DNI = p2.DNI;

--24. Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.IDASIGNATURA LIKE '130122';

--25. Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan códigos repetidos.
SELECT DISTINCT aa.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDALUMNO IS NOT NULL;

--26. Mostrar el nombre de las asignaturas que tienen más de 4 créditos, y además, o se imparten en el primer cuatrimestre o son del primer curso.
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.CREDITOS > 4 AND (a.CUATRIMESTRE = 1 OR a.CURSO = 1);

--27. Mostrar los distintos códigos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT DISTINCT a.IDTITULACION 
FROM ASIGNATURA a
WHERE a.IDTITULACION IS NOT NULL;

--28. Mostrar el dni de las personas cuyo apellido contiene la letra g en mayúsculas o minúsculas.
SELECT p.DNI
FROM PERSONA p 
WHERE p.APELLIDO LIKE '%G%' OR p.APELLIDO LIKE '%g%';

--29. Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970 y que vivan en una ciudad que empieza por M.
SELECT *
FROM PERSONA p
WHERE p.VARON = 1 AND p.FECHA_NACIMIENTO > TO_DATE('31/12/1970','DD/MM/YYYY') AND p.CIUDAD LIKE 'M%';



