-- Insercción de datos en la tabla clientes
INSERT INTO clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES
('Carlos', 'Muñoz', 'Laureles, Calle 5', '555-1234', 'carlos.munoz@example.com', '1980-01-01', 'activo'),
('Daniela', 'López', 'Loma Linda, Calle 10', '555-5678', 'daniela.lopez@example.com', '1985-05-05', 'activo'),
('Camilo', 'Sánchez', 'San Fernando, Calle 20', '555-9101', 'camilo.sanchez@example.com', '1990-10-10', 'inactivo'),
('Miguel', 'Arteaga', 'El Ingenio, Carrera 1', '555-1111', 'miguel.arteaga@example.com', '1992-11-12', 'activo'),
('Laura', 'Diuza', 'Ciudad Jardín, Carrera 8', '555-2222', 'laura.diuza@example.com', '1987-03-14', 'activo');

-- Insercción de datos en la tabla sucursales
INSERT INTO sucursales (nombre, direccion, telefono)
VALUES
('Sucursal Centro', 'Centro 123', '555-1122'),
('Sucursal Norte', 'Norte 456', '555-3344'),
('Sucursal Sur', 'Sur 789', '555-5566'),
('Sucursal Este', 'Este 101', '555-7788'),
('Sucursal Oeste', 'Oeste 202', '555-8899');

-- Insercción de datos en la tabla empleados
INSERT INTO empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES
('Lina', 'Hernández', 'Campo Bello, Transversal Sur', '555-2233', 'lina.hernandez@example.com', '2020-01-15', 'Cajero', 2000.00, 1),
('Valentina', 'Torres', 'El Ingenio, Avenida Paso Ancho', '555-4455', 'valentina.torres@example.com', '2019-06-25', 'Gerente', 5000.00, 2),
('Olga', 'Muñoz', 'Cerritos de la Paz, Carrera 1', '555-6677', 'olga.munoz@example.com', '2018-09-10', 'Asesor', 3000.00, 3),
('Carlos', 'López', 'El Recuerdo, Calle 5', '555-8899', 'carlos.lopez@example.com', '2021-02-20', 'Cajero', 2100.00, 4),
('Daniela', 'Sánchez', 'San Fernando, Calle 10', '555-1010', 'daniela.sanchez@example.com', '2017-04-30', 'Asesor', 3200.00, 5);

-- Insercción de datos en la tabla cuentas_bancarias
INSERT INTO cuentas_bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES
(1, '1234567890', 'ahorro', 1000.00, '2021-01-01', 'activa'),
(2, '0987654321', 'corriente', 500.00, '2022-02-02', 'activa'),
(3, '1122334455', 'ahorro', 250.00, '2023-03-03', 'cerrada'),
(4, '5566778899', 'corriente', 750.00, '2022-04-04', 'activa'),
(5, '6677889900', 'ahorro', 1200.00, '2021-05-05', 'activa');

-- Insercción de datos en la tabla transacciones
INSERT INTO transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES
(1, 'deposito', 100.00, '2024-01-01 10:00:00', 'Depósito inicial'),
(2, 'retiro', 50.00, '2024-02-02 11:00:00', 'Retiro en cajero automático'),
(1, 'transferencia', 200.00, '2024-03-03 12:00:00', 'Transferencia a cuenta de ahorro'),
(3, 'deposito', 300.00, '2024-04-04 13:00:00', 'Depósito en efectivo'),
(4, 'retiro', 400.00, '2024-05-05 14:00:00', 'Retiro en ventanilla');

-- Insercción de datos en la tabla productos_financieros
INSERT INTO productos_financieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES
('Préstamo Personal', 'préstamo', 'Préstamo a corto plazo', 5.00),
('Tarjeta Oro', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios premium', 15.00),
('Seguro de Vida', 'seguro', 'Cobertura de seguro de vida completa', NULL),
('Préstamo Hipotecario', 'préstamo', 'Préstamo a largo plazo para vivienda', 3.50),
('Seguro de Automóvil', 'seguro', 'Cobertura completa para vehículos', NULL);

-- Insercción de datos en la tabla prestamos
INSERT INTO prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES
(1, 5000.00, 5.00, '2023-01-01', '2025-01-01', 'activo'),
(2, 3000.00, 5.50, '2022-02-02', '2024-02-02', 'pagado'),
(3, 7000.00, 4.00, '2023-03-03', '2025-03-03', 'activo'),
(4, 4000.00, 4.50, '2022-04-04', '2024-04-04', 'activo'),
(5, 6000.00, 3.50, '2021-05-05', '2023-05-05', 'pagado');

-- Insercción de datos en la tabla tarjetas_credito
INSERT INTO tarjetas_credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES
(1, '4000123412341234', 10000.00, 2000.00, '2023-01-01', '2026-01-01', 'activa'),
(2, '4000567812345678', 5000.00, 1000.00, '2022-02-02', '2025-02-02', 'bloqueada'),
(3, '4000987612348765', 7000.00, 3000.00, '2023-03-03', '2026-03-03', 'activa'),
(4, '4000123498765432', 6000.00, 2500.00, '2022-04-04', '2025-04-04', 'activa'),
(5, '4000654321987654', 8000.00, 3500.00, '2021-05-05', '2024-05-05', 'bloqueada');

-- Insercción de datos en la tabla relacion_clientes_productos
INSERT INTO relacion_clientes_productos (cliente_id, producto_id, fecha_adquisicion)
VALUES
(1, 1, '2024-01-01'),
(2, 2, '2024-02-02'),
(3, 3, '2024-03-03'),
(4, 4, '2024-04-04'),
(5, 5, '2024-05-05');
