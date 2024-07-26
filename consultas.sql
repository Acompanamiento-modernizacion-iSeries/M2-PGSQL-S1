SELECT * FROM Clientes;
SELECT DISTINCT tipo_cuenta FROM CuentasBancarias;
SELECT COUNT(*) AS total_clientes FROM Clientes;
SELECT * FROM Transacciones WHERE monto > 1000;
SELECT * FROM CuentasBancarias ORDER BY saldo ASC;
SELECT * FROM Empleados ORDER BY fecha_contratacion DESC LIMIT 5;
SELECT * FROM Transacciones 
WHERE fecha_transaccion BETWEEN '2023-01-01' AND '2023-12-31';
SELECT * FROM CuentasBancarias 
WHERE tipo_cuenta IN ('Ahorro', 'Corriente', 'Inversión');
SELECT * FROM Clientes WHERE nombre LIKE '%a%';
SELECT * FROM Empleados WHERE apellido LIKE 'S%';
SELECT * FROM Clientes WHERE direccion LIKE '%Avenue';
SELECT * FROM Empleados WHERE correo_electronico LIKE '%bank%';
SELECT * FROM Sucursales WHERE nombre LIKE 'Central%';
SELECT * FROM Transacciones WHERE tipo_transaccion LIKE 'Depósito%';
SELECT * FROM Transacciones WHERE fecha_transaccion >= '2023-01-01 00:00:00' 
  AND fecha_transaccion < '2024-01-01 00:00:00';
SELECT * FROM Transacciones WHERE descripcion LIKE '%pago%';
SELECT * FROM Clientes WHERE telefono LIKE '555%';
SELECT * FROM Empleados WHERE posicion LIKE '%Manager%';