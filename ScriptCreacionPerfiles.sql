--Script para crear perfil

--Perfil para script de jardineria
alter session set "_oracle_script"=true;  
create user jardineria identified by jardineria;
GRANT CONNECT, RESOURCE, DBA TO jardineria;

--Perfil para script de editorial
alter session set "_oracle_script"=true;  
create user editorial identified by editorial;
GRANT CONNECT, RESOURCE, DBA TO editorial;

--Perfil para script de vehiculos
alter session set "_oracle_script"=true;  
create user vehiculos identified by vehiculos;
GRANT CONNECT, RESOURCE, DBA TO vehiculos;

--Perfil para script de partidos
alter session set "_oracle_script"=true;  
create user partidos identified by partidos;
GRANT CONNECT, RESOURCE, DBA TO partidos;

--Perfil para script de partidos
alter session set "_oracle_script"=true;  
create user caladero identified by caladero;
GRANT CONNECT, RESOURCE, DBA TO caladero;

--Perfil para script de tiendas
alter session set "_oracle_script"=true;  
create user tiendas identified by tiendas;
GRANT CONNECT, RESOURCE, DBA TO tiendas;

--Perfil para script de ejercicio1 del boletin
alter session set "_oracle_script"=true;  
create user boletin1 identified by boletin1;
GRANT CONNECT, RESOURCE, DBA TO boletin1;

--Perfil para script de ejercicio2 del boletin
alter session set "_oracle_script"=true;  
create user boletin2 identified by boletin2;
GRANT CONNECT, RESOURCE, DBA TO boletin2;

--Perfil para script de ejercicio3 del boletin
alter session set "_oracle_script"=true;  
create user boletin3 identified by boletin3;
GRANT CONNECT, RESOURCE, DBA TO boletin3;

--Perfil para script de tienda del boletin de dml
alter session set "_oracle_script"=true;  
create user tienda1 identified by tienda1;
GRANT CONNECT, RESOURCE, DBA TO tienda1;

--Perfil para script de empleados del boletin de dml
alter session set "_oracle_script"=true;  
create user empleados identified by empleados;
GRANT CONNECT, RESOURCE, DBA TO empleados;

--Perfil para script de academia de dml
alter session set "_oracle_script"=true;  
create user academia identified by academia;
GRANT CONNECT, RESOURCE, DBA TO academia;

--Perfil para script de hipodromo de dml
alter session set "_oracle_script"=true;  
create user hipodromo identified by hipodromo;
GRANT CONNECT, RESOURCE, DBA TO hipodromo;

--Perfil para script de simulacro de dml
alter session set "_oracle_script"=true;  
create user simulacro identified by simulacro;
GRANT CONNECT, RESOURCE, DBA TO simulacro;

--Perfil para script de universidad de consultas
alter session set "_oracle_script"=true;  
create user universidadconsultas identified by universidadconsultas;
GRANT CONNECT, RESOURCE, DBA TO universidadconsultas;

--Perfil para script de gestion de consultas
alter session set "_oracle_script"=true;  
create user gestionconsultas identified by gestionconsultas;
GRANT CONNECT, RESOURCE, DBA TO gestionconsultas;

--Perfil para script de consultas bancos
alter session set "_oracle_script"=true;  
create user bancos identified by bancos;
GRANT CONNECT, RESOURCE, DBA TO bancos;

--Perfil para script de consultas peces
alter session set "_oracle_script"=true;  
create user peces identified by peces;
GRANT CONNECT, RESOURCE, DBA TO peces;






