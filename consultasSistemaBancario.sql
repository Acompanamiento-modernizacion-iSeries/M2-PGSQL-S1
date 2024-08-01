-- SELECT Básico
-- Enunciado: Selecciona todos los registros de la tabla "Clientes".
SELECT * FROM Clientes;

-- SELECT DISTINCT
-- Enunciado: Obtén una lista de todos los tipos de cuentas sin duplicados.
SELECT DISTINCT tipo_cuenta FROM Cuentas_Bancarias;

-- COUNT
-- Enunciado: Cuenta cuántos clientes hay en la tabla "Clientes".
SELECT COUNT(*) FROM Clientes;

-- SELECT WHERE
-- Enunciado: Selecciona todas las transacciones que tienen un monto mayor a 1000.
SELECT * FROM Transacciones WHERE monto > 1000;

-- ORDER BY
-- Enunciado: Ordena la lista de cuentas por su saldo en orden ascendente.
SELECT * FROM Cuentas_Bancarias ORDER BY saldo ASC;

-- LIMIT
-- Enunciado: Selecciona los primeros 5 empleados ordenados por su fecha de contratación en orden descendente.
SELECT * FROM Empleados ORDER BY fecha_contratacion DESC LIMIT 5;

-- BETWEEN
-- Enunciado: Selecciona todas las transacciones realizadas entre el 1 de enero de 2023 y el 31 de diciembre de 2023.
SELECT * FROM Transacciones WHERE fecha_transaccion BETWEEN '2023-01-01' AND '2023-12-31';

-- IN
-- Enunciado: Selecciona todas las cuentas cuyo tipo sea "Ahorro", "Corriente" o "Inversión".
SELECT * FROM Cuentas_Bancarias WHERE tipo_cuenta IN ('ahorro', 'corriente', 'inversión');

-- LIKE (Búsqueda por nombre)
-- Enunciado: Selecciona todos los clientes cuyo nombre contiene la letra "a".
SELECT * FROM Clientes WHERE nombre LIKE '%a%';

-- LIKE (Búsqueda por apellido)
-- Enunciado: Selecciona todos los empleados cuyos apellidos empiezan con la letra "S".
SELECT * FROM Empleados WHERE apellido LIKE 'S%';

-- LIKE (Búsqueda por dirección)
-- Enunciado: Selecciona todos los clientes que viven en direcciones que terminan con "Avenue".
SELECT * FROM Clientes WHERE direccion LIKE '%Avenue';

-- LIKE (Búsqueda por correo electrónico)
-- Enunciado: Selecciona todos los empleados cuyo correo electrónico contiene "bank".
SELECT * FROM Empleados WHERE correo_electronico LIKE '%bank%';

-- LIKE (Búsqueda por nombre de sucursal)
-- Enunciado: Selecciona todas las sucursales cuyo nombre comienza con "Sucursal".
SELECT * FROM Sucursales WHERE nombre LIKE 'Sucursal%';

-- LIKE (Búsqueda por tipo de transacción)
-- Enunciado: Selecciona todas las transacciones que son de tipo "Depósito".
SELECT * FROM Transacciones WHERE tipo_transaccion LIKE 'depósito';

-- LIKE (Búsqueda por fecha)
-- Enunciado: Selecciona todas las transacciones que ocurren en el año 2023.
SELECT * FROM Transacciones WHERE fecha_transaccion::TEXT LIKE '2023%';

-- LIKE (Búsqueda por descripción)
-- Enunciado: Selecciona todas las transacciones cuya descripción contiene la palabra "pago".
SELECT * FROM Transacciones WHERE descripcion LIKE '%pago%';

-- LIKE (Búsqueda por número de teléfono)
-- Enunciado: Selecciona todos los clientes cuyo número de teléfono comienza con "555".
SELECT * FROM Clientes WHERE telefono LIKE '555%';

-- LIKE (Búsqueda por cargo)
-- Enunciado: Selecciona todos los empleados cuyo cargo contiene la palabra "Gerente".
SELECT * FROM Empleados WHERE posicion LIKE '%Gerente%';