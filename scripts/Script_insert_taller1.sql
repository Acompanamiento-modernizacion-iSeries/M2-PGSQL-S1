-- Insertar registros en la tabla Clientes
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) VALUES
('Juan', 'Pérez', 'Calle 123 #45-67, Medellín', '3001234567', 'juan.perez@example.com', '1985-06-15', 'activo'),
('María', 'Gómez', 'Carrera 45 #12-34, Medellín', '3002345678', 'maria.gomez@example.com', '1990-08-22', 'activo'),
('Carlos', 'Rodríguez', 'Avenida 68 #45-12, Cali', '3003456789', 'carlos.rodriguez@example.com', '1982-11-10', 'inactivo'),
('Ana', 'Martínez', 'Diagonal 123 #45-67, Medellín', '3004567890', 'ana.martinez@example.com', '1995-03-05', 'activo'),
('Luis', 'Ramírez', 'Calle 78 #10-11, Medellín', '3005678901', 'luis.ramirez@example.com', '1987-09-19', 'activo'),
('Sofía', 'Torres', 'Carrera 21 #34-56, Medellín', '3006789012', 'sofia.torres@example.com', '1992-12-25', 'inactivo'),
('Miguel', 'López', 'Avenida 123 #67-89, Medellín', '3007890123', 'miguel.lopez@example.com', '1984-04-02', 'activo');


-- Insertar registros en la tabla Sucursales
INSERT INTO Sucursales (nombre, direccion, telefono) VALUES
('Sucursal Norte', 'Calle 45 #12-34, Bogotá', '3101234567'),
('Sucursal Centro', 'Carrera 7 #8-90, Medellín', '3102345678'),
('Sucursal Sur', 'Avenida Roosevelt #34-56, Cali', '3103456789'),
('Sucursal Oeste', 'Calle 72 #15-20, Barranquilla', '3104567890'),
('Sucursal Oriente', 'Calle 80 #11-22, Bogotá', '3105678901'),
('Sucursal Noroeste', 'Carrera 50 #21-34, Medellín', '3106789012'),
('Sucursal Suroeste', 'Avenida 9 #43-21, Cali', '3107890123');

-- Insertar registros en la tabla Empleados
INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) VALUES
('Pedro', 'López', 'Calle 123 #45-67, Bogotá', '3201234567', 'pedro.lopez@example.com', '2022-01-10', 'Cajero', 2000000, 1),
('Laura', 'Ramírez', 'Carrera 45 #12-34, Medellín', '3202345678', 'laura.ramirez@example.com', '2021-05-20', 'Asesor Comercial', 2500000, 2),
('Jorge', 'Fernández', 'Avenida 68 #45-12, Cali', '3203456789', 'jorge.fernandez@example.com', '2019-08-30', 'Gerente', 4000000, 3),
('Sofía', 'Torres', 'Diagonal 123 #45-67, Barranquilla', '3204567890', 'sofia.torres@example.com', '2020-03-15', 'Analista de Crédito', 3000000, 4),
('Andrés', 'Martínez', 'Calle 78 #10-11, Bogotá', '3205678901', 'andres.martinez@example.com', '2018-11-10', 'Cajero', 2200000, 5),
('Paula', 'Gómez', 'Carrera 21 #34-56, Medellín', '3206789012', 'paula.gomez@example.com', '2017-07-25', 'Asesor Comercial', 2700000, 6),
('Ricardo', 'Ríos', 'Avenida 123 #67-89, Cali', '3207890123', 'ricardo.rios@example.com', '2020-02-10', 'Gerente', 4200000, 7);


-- Insertar registros en la tabla Cuentas Bancarias
INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado, empleado_id) VALUES
(1, '1234567890', 'ahorro', 500000, '2020-01-01', 'activa', 2),
(2, '2345678901', 'corriente', 1000000, '2019-05-15', 'activa', 2),
(3, '3456789012', 'ahorro', 750000, '2018-08-10', 'cerrada', 2),
(4, '4567890123', 'corriente', 300000, '2021-03-20', 'activa', 2),
(5, '5678901234', 'ahorro', 250000, '2021-09-15', 'activa', 2),
(6, '6789012345', 'corriente', 600000, '2020-02-28', 'cerrada', 2),
(7, '7890123456', 'ahorro', 800000, '2019-07-11', 'activa', 2);

-- Insertar registros en la tabla Transacciones
INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, descripcion) VALUES
(1, 'deposito', 200000, 'Depósito en efectivo'),
(2, 'retiro', 500000, 'Retiro en cajero automático'),
(3, 'transferencia', 150000, 'Transferencia a otra cuenta'),
(4, 'deposito', 100000, 'Depósito en cheque'),
(5, 'retiro', 300000, 'Retiro en oficina'),
(6, 'deposito', 400000, 'Depósito en efectivo'),
(7, 'transferencia', 200000, 'Transferencia a otra cuenta');


-- Insertar registros en la tabla Productos Financieros
INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes) VALUES
('Préstamo Hipotecario', 'prestamo', 'Préstamo para adquisición de vivienda', 8.5),
('Tarjeta de Crédito Oro', 'tarjeta de credito', 'Tarjeta de crédito con beneficios exclusivos', 28.5),
('Seguro de Vida', 'seguro', 'Seguro de vida con cobertura amplia', 5.2),
('Préstamo Personal', 'prestamo', 'Préstamo para libre inversión', 12.3),
('Tarjeta de Crédito Platino', 'tarjeta de credito', 'Tarjeta de crédito con alta disponibilidad de crédito', 25.0),
('Seguro de Automóvil', 'seguro', 'Seguro para cobertura de daños y accidentes de automóvil', 6.5),
('Préstamo Educativo', 'prestamo', 'Préstamo para financiar estudios superiores', 10.0);

-- Insertar registros en la tabla Préstamos
INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) VALUES
(1, 50000000, 8.5, '2022-01-01', '2032-01-01', 'activo'),
(2, 10000000, 12.3, '2021-05-15', '2026-05-15', 'activo'),
(3, 25000000, 8.5, '2018-08-10', '2028-08-10', 'pagado'),
(4, 5000000, 12.3, '2021-03-20', '2026-03-20', 'activo'),
(5, 20000000, 10.0, '2021-09-15', '2031-09-15', 'activo'),
(6, 15000000, 12.3, '2020-02-28', '2030-02-28', 'pagado'),
(7, 30000000, 8.5, '2019-07-11', '2029-07-11', 'activo');

-- Insertar registros en la tabla Tarjetas de Crédito
INSERT INTO Tarjetas_de_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) VALUES
(1, '1111222233334444', 10000000, 2000000, '2022-01-01', '2026-01-01', 'activa'),
(2, '2222333344445555', 5000000, 1000000, '2021-05-15', '2025-05-15', 'activa'),
(3, '3333444455556666', 2000000, 500000, '2018-08-10', '2022-08-10', 'bloqueada'),
(4, '4444555566667777', 3000000, 750000, '2021-03-20', '2025-03-20', 'activa'),
(5, '5555666677778888', 7000000, 3500000, '2021-09-15', '2025-09-15', 'activa'),
(6, '6666777788889999', 4000000, 1000000, '2020-02-28', '2024-02-28', 'activa'),
(7, '7777888899990000', 8000000, 1500000, '2019-07-11', '2023-07-11', 'bloqueada');

-- Insertar registros en la tabla Relación Clientes-Productos
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) VALUES
(1, 1, '2022-01-01'),
(2, 2, '2021-05-15'),
(3, 3, '2018-08-10'),
(4, 4, '2021-03-20'),
(5, 5, '2021-09-15'),
(6, 6, '2020-02-28'),
(7, 7, '2019-07-11');