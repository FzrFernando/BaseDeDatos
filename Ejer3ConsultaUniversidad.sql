--1. Cuantos costes b?sicos hay.
SELECT COUNT(NVL(COSTEBASICO, 0)) 
FROM ASIGNATURA;

--2. Para cada titulaci?n mostrar el n?mero de asignaturas que hay junto con el nombre de la titulaci?n.
SELECT TI.NOMBRE, COUNT(IDASIGNATURA)
FROM TITULACION TI, ASIGNATURA AA   
WHERE TI.IDTITULACION = AA.IDTITULACION 
GROUP BY TI.NOMBRE;

--3. Para cada titulaci?n mostrar el nombre de la titulaci?n junto con el precio total de todas sus asignaturas.
SELECT TI.NOMBRE, SUM(AA.COSTEBASICO)
FROM TITULACION TI, ASIGNATURA AA   
WHERE TI.IDTITULACION = AA.IDTITULACION 
GROUP BY TI.NOMBRE;

--4. Cual ser?a el coste global de cursar la titulaci?n de Matem?ticas si el coste de cada asignatura fuera incrementado en un 7%. 
SELECT SUM(AA.COSTEBASICO *1.07)
FROM ASIGNATURA AA, TITULACION TI 
WHERE AA.IDASIGNATURA = TI.IDTITULACION 
AND TI.NOMBRE  = 'Matematicas';

--5. Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
SELECT COUNT(IDALUMNO), IDASIGNATURA 
FROM ALUMNO_ASIGNATURA 
GROUP BY IDASIGNATURA;

--6. Igual que el anterior pero mostrando el nombre de la asignatura.
SELECT A.NOMBRE, COUNT(AA.IDALUMNO) 
FROM ALUMNO_ASIGNATURA AA, ASIGNATURA A
WHERE A.IDASIGNATURA = AA.IDASIGNATURA
GROUP BY A.NOMBRE;

--7. Mostrar para cada alumno, el nombre del alumno junto con lo que tendr?a que pagar por el total de todas las asignaturas en las que est? matriculada. 
--Recuerda que el precio de la matr?cula tiene un incremento de un 10% por cada a?o en el que est? matriculado. 
SELECT P.NOMBRE, SUM(NVL(AA.COSTEBASICO, 0)) 
FROM PERSONA P, ASIGNATURA AA, ALUMNO AL, ALUMNO_ASIGNATURA ASIG
WHERE P.DNI = AL.DNI AND AL.IDALUMNO = ASIG.IDALUMNO AND ASIG.IDASIGNATURA = AA.IDASIGNATURA
GROUP BY P.NOMBRE;

--8. Coste medio de las asignaturas de cada titulaci?n, para aquellas titulaciones en el que el coste total de la 1? matr?cula sea mayor que 60 euros. 
SELECT AVG(A.COSTEBASICO), TI.NOMBRE 
FROM ASIGNATURA A, TITULACION TI, ALUMNO_ASIGNATURA AA
WHERE A.IDTITULACION  = TI.IDTITULACION AND A.IDASIGNATURA = AA.IDASIGNATURA 
AND AA.NUMEROMATRICULA = 1
GROUP BY TI.NOMBRE
HAVING SUM(A.COSTEBASICO) > 60;

--9. Nombre de las titulaciones  que tengan m?s de tres alumnos.
SELECT TI.NOMBRE 
FROM TITULACION TI, ALUMNO A, ALUMNO_ASIGNATURA ASIG, ASIGNATURA AA 
WHERE A.IDALUMNO = ASIG.IDALUMNO AND ASIG.IDASIGNATURA = AA.IDASIGNATURA AND TI.IDTITULACION = AA.IDTITULACION
GROUP BY TI.NOMBRE
HAVING COUNT(A.IDALUMNO) > 3; 

--10. Nombre de cada ciudad junto con el n?mero de personas que viven en ella.
SELECT CIUDAD, COUNT(NOMBRE) 
FROM PERSONA 
GROUP BY CIUDAD;

--11. Nombre de cada profesor junto con el n�mero de asignaturas que imparte.
SELECT P.NOMBRE, COUNT(A.IDASIGNATURA) 
FROM ASIGNATURA A, PROFESOR PR, PERSONA P
WHERE A.IDPROFESOR = PR.IDPROFESOR AND P.DNI = PR.DNI
GROUP BY P.NOMBRE;

--12. Nombre de cada profesor junto con el n�mero de alumnos que tiene, para aquellos profesores que tengan dos o m�s de 2 alumnos.
SELECT P.NOMBRE, COUNT(AA.IDALUMNO) 
FROM ASIGNATURA A, PROFESOR PR, PERSONA P, ALUMNO AL, ALUMNO_ASIGNATURA AA
WHERE AL.IDALUMNO = AA.IDALUMNO AND P.DNI = PR.DNI AND PR.IDPROFESOR = A.IDPROFESOR AND A.IDASIGNATURA = AA.IDASIGNATURA
GROUP BY P.NOMBRE
HAVING COUNT(AA.IDALUMNO) >= 3;

--13. Obtener el m�ximo de las sumas de los costesb�sicos de cada cuatrimestre
SELECT MAX(SUM(COSTEBASICO)) 
FROM ASIGNATURA 
GROUP BY CUATRIMESTRE;

--14. Suma del coste de las asignaturas
SELECT SUM(COSTEBASICO) 
FROM ASIGNATURA;

--15. �Cu�ntas asignaturas hay?
SELECT COUNT(IDASIGNATURA) 
FROM ASIGNATURA;

--16. Coste de la asignatura m�s cara y de la m�s barata
SELECT MAX(COSTEBASICO), MIN(COSTEBASICO) 
FROM ASIGNATURA;

--17. �Cu�ntas posibilidades de cr�ditos de asignatura hay?
SELECT COUNT(DISTINCT CREDITOS) 
FROM ASIGNATURA;

--18. �Cu�ntos cursos hay?
SELECT COUNT(DISTINCT NVL(CURSO,0)) 
FROM ASIGNATURA;

--19. �Cu�ntas ciudades haY?
SELECT COUNT(DISTINCT CIUDAD) 
FROM PERSONA;

--20. Nombre y n�mero de horas de todas las asignaturas.
SELECT DISTINCT AA.NOMBRE, AA.CREDITOS *10 AS NUM_HORAS 
FROM ASIGNATURA AA, ALUMNO A, ALUMNO_ASIGNATURA ASIG 
WHERE A.IDALUMNO = ASIG.IDALUMNO AND AA.IDASIGNATURA = ASIG.IDASIGNATURA;

--21. Mostrar las asignaturas que no pertenecen a ninguna titulaci�n.
SELECT * 
FROM ASIGNATURA A, TITULACION TI 
WHERE TI.IDTITULACION IN A.IDTITULACION;

--22. Listado del nombre completo de las personas, sus tel�fonos y sus direcciones, 
--llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".
SELECT NOMBRE || ' ' || APELLIDO || '' || TELEFONO || ' 'AS NOMBRECOMPLETO, DIRECCIONCALLE || ' ' || DIRECCIONNUM AS DIRECCION 
FROM PERSONA;

--23. Cual es el d�a siguiente al d�a en que nacieron las personas de la B.D.
SELECT SUM(EXTRACT(DAY FROM FECHA_NACIMIENTO+1)) 
FROM PERSONA 
GROUP BY DNI;

--24. A�os de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM FECHA_NACIMIENTO) 
FROM PERSONA;

--25. Listado de personas mayores de 25 a�os ordenadas por apellidos y nombre, esta consulta tiene que valor para cualquier momento
SELECT NOMBRE, APELLIDO, SUM(EXTRACT(YEAR FROM SYSDATE) - EXTRACT( YEAR FROM FECHA_NACIMIENTO)) 
FROM PERSONA P
GROUP BY NOMBRE, APELLIDO
HAVING SUM(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM FECHA_NACIMIENTO)) > 25
ORDER BY NOMBRE, APELLIDO;

--26. Nombres completos de los profesores que adem�s son alumnos
SELECT P.NOMBRE || ' ' || P.APELLIDO AS NOMBRECOMPLETO 
FROM PERSONA P, PROFESOR PR, ALUMNO A
WHERE A.DNI = P.DNI AND PR.DNI = P.DNI;

--27. Suma de los cr�ditos de las asignaturas de la titulaci�n de Matem�ticas
SELECT SUM(A.CREDITOS) 
FROM ASIGNATURA A, TITULACION TI 
WHERE TI.IDTITULACION = A.IDTITULACION AND UPPER(TI.NOMBRE) = 'MATEMATICAS';

--28. N�mero de asignaturas de la titulaci�n de Matem�ticas
SELECT COUNT(A.CREDITOS) 
FROM ASIGNATURA A, TITULACION TI 
WHERE TI.IDTITULACION = A.IDTITULACION AND UPPER(TI.NOMBRE) = 'MATEMATICAS';

--29. �Cu�nto paga cada alumno por su matr�cula?
SELECT DISTINCT NVL(A.COSTEBASICO * ASIG.NUMEROMATRICULA,0), P.NOMBRE 
FROM ASIGNATURA A, TITULACION TI, PERSONA P, ALUMNO_ASIGNATURA ASIG, PROFESOR PR
WHERE A.IDPROFESOR = PR.IDPROFESOR AND PR.DNI = P.DNI AND A.IDASIGNATURA = ASIG.IDASIGNATURA ;

--30. �Cu�ntos alumnos hay matriculados en cada asignatura?
SELECT A.NOMBRE, COUNT(AA.IDALUMNO) 
FROM ASIGNATURA A, ALUMNO AL, ALUMNO_ASIGNATURA AA 
WHERE A.IDASIGNATURA = AA.IDASIGNATURA AND AL.IDALUMNO = AA.IDALUMNO 
GROUP BY A.NOMBRE;

