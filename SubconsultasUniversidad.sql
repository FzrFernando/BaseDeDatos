--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura 
--excepto la '150212' y la '130113'.
SELECT a.IDALUMNO 
FROM ALUMNO a 
WHERE a.IDALUMNO IN (SELECT aa.IDALUMNO 
						FROM ALUMNO_ASIGNATURA aa
						WHERE aa.IDASIGNATURA NOT LIKE '150212'
						AND aa.IDASIGNATURA NOT LIKE '130113');
						
--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial".
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.CREDITOS > (SELECT a.CREDITOS
					FROM ASIGNATURA a
					WHERE a.NOMBRE LIKE '%Seguridad Vial%');
					
--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez.
SELECT a.IDALUMNO 
FROM ALUMNO a
WHERE a.IDALUMNO IN (SELECT aa.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa
					WHERE aa.IDASIGNATURA LIKE '150212'
					AND aa.IDASIGNATURA LIKE '130113');
				
--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", 
--en una o en otra pero no en ambas a la vez.
SELECT a.IDALUMNO 
FROM ALUMNO a
WHERE a.IDALUMNO IN (SELECT aa.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa
					WHERE aa.IDASIGNATURA LIKE '150212'
					OR aa.IDASIGNATURA LIKE '130113');

--5. Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen 
--el coste básico promedio por asignatura en esa titulación.
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION LIKE '130110'
AND a.COSTEBASICO > (SELECT AVG(NVL(a.COSTEBASICO,0))
					FROM ASIGNATURA a
					WHERE a.IDTITULACION LIKE '130110');
				
--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”.
SELECT a.IDALUMNO 
FROM ALUMNO a 
WHERE a.IDALUMNO IN (SELECT aa.IDALUMNO 
						FROM ALUMNO_ASIGNATURA aa
						WHERE aa.IDASIGNATURA NOT LIKE '150212'
						AND aa.IDASIGNATURA NOT LIKE '130113');
					
--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113".
SELECT a.IDALUMNO 
FROM ALUMNO a
WHERE a.IDALUMNO IN (SELECT aa.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa
					WHERE aa.IDASIGNATURA LIKE '150212'
					AND aa.IDASIGNATURA NOT LIKE '130113');

--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial".
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.CREDITOS > (SELECT a.CREDITOS
					FROM ASIGNATURA a
					WHERE a.NOMBRE LIKE '%Seguridad Vial%');
				
--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT p.NOMBRE 
FROM PERSONA p
WHERE p.DNI NOT IN (SELECT p2.DNI 
					FROM PROFESOR p2);
				
--10. Mostrar el nombre de las asignaturas que tengan más créditos.
--DUDA
SELECT a.NOMBRE, a.CREDITOS 
FROM ASIGNATURA a
WHERE a.CREDITOS >= (SELECT MAX(a.CREDITOS) 
					FROM ASIGNATURA a);
				
--11. Lista de asignaturas en las que no se ha matriculado nadie
SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDASIGNATURA NOT IN (SELECT aa.IDASIGNATURA 
							FROM ALUMNO_ASIGNATURA aa);
						
--12. Ciudades en las que vive algún profesor y también algún alumno.
SELECT p.CIUDAD, p.DNI 
FROM PERSONA p
WHERE p.CIUDAD IN (SELECT p3.CIUDAD 
					FROM ALUMNO a, PERSONA p3
					WHERE a.DNI = p3.DNI)
AND p.CIUDAD IN (SELECT p4.CIUDAD 
				FROM PROFESOR p2, PERSONA p4
				WHERE p2.DNI = p4.DNI);
		
INSERT INTO PERSONA
VALUES ('780',NULL,NULL,'Torremolinos',NULL,NULL,NULL,NULL,null);

INSERT INTO PROFESOR
VALUES('79','780');
				
				
				
				
				
