-- Insertar registros en la tabla Clientes
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES
('Carlos', 'Perez', 'Calle 123 #45-67, Bogotá', '3001234567', 'carlos.perez@gmail.com', '1985-05-15', 'Activo'),
('Ana', 'Gomez', 'Carrera 8 #12-34, Medellín', '3109876543', 'ana.gomez@hotmail.com', '1990-07-22', 'Activo'),
('Luis', 'Martinez', 'Avenida 5 #67-89, Cali', '3115678901', 'luis.martinez@yahoo.com', '1983-03-10', 'Activo'),
('Laura', 'Garcia', 'Calle 10 #20-30, Barranquilla', '3157890123', 'laura.garcia@outlook.com', '1987-09-18', 'Inactivo'),
('Pedro', 'Lopez', 'Carrera 50 #20-30, Cartagena', '3168901234', 'pedro.lopez@gmail.com', '1975-12-05', 'Activo'),
('Maria', 'Rodriguez', 'Avenida 30 #45-67, Bucaramanga', '3179012345', 'maria.rodriguez@gmail.com', '1995-02-28', 'Activo'),
('Jorge', 'Hernandez', 'Calle 15 #5-10, Manizales', '3180123456', 'jorge.hernandez@yahoo.com', '1980-11-11', 'Inactivo'),
('Paula', 'Ramirez', 'Carrera 40 #15-25, Pereira', '3191234567', 'paula.ramirez@hotmail.com', '1992-06-24', 'Activo'),
('Sofia', 'Torres', 'Avenida 60 #30-40, Santa Marta', '3202345678', 'sofia.torres@gmail.com', '1988-01-17', 'Activo'),
('Daniel', 'Vargas', 'Calle 100 #20-30, Ibagué', '3213456789', 'daniel.vargas@outlook.com', '1984-08-02', 'Activo');

-- Insertar registros en la tabla Sucursales
INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES
('Sucursal Bogotá Centro', 'Calle 45 #10-20, Bogotá', '6011234567'),
('Sucursal Medellín Norte', 'Avenida 80 #45-67, Medellín', '6049876543'),
('Sucursal Cali Sur', 'Carrera 5 #67-89, Cali', '6025678901'),
('Sucursal Barranquilla Oeste', 'Calle 50 #20-30, Barranquilla', '6057890123'),
('Sucursal Cartagena Este', 'Avenida 10 #20-30, Cartagena', '6058901234'),
('Sucursal Bucaramanga Norte', 'Carrera 30 #45-67, Bucaramanga', '6079012345'),
('Sucursal Manizales Centro', 'Calle 15 #5-10, Manizales', '6060123456'),
('Sucursal Pereira Sur', 'Carrera 40 #15-25, Pereira', '6061234567'),
('Sucursal Santa Marta Centro', 'Avenida 60 #30-40, Santa Marta', '6052345678'),
('Sucursal Ibagué Norte', 'Calle 100 #20-30, Ibagué', '6083456789');

-- Insertar registros en la tabla Empleados
INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES
('Juan', 'Diaz', 'Calle 50 #20-30, Bogotá', '3002345678', 'juan.diaz@gmail.com', '2020-01-15', 'Gerente', 5000000.00, 1),
('Andrea', 'Moreno', 'Avenida 80 #45-67, Medellín', '3103456789', 'andrea.moreno@hotmail.com', '2019-03-10', 'Cajero', 2000000.00, 2),
('Ricardo', 'Cruz', 'Carrera 5 #67-89, Cali', '3114567890', 'ricardo.cruz@yahoo.com', '2021-05-20', 'Asesor', 2500000.00, 3),
('Diana', 'Ortiz', 'Calle 10 #20-30, Barranquilla', '3155678901', 'diana.ortiz@outlook.com', '2018-07-30', 'Analista', 3000000.00, 4),
('Fernando', 'Sanchez', 'Avenida 10 #20-30, Cartagena', '3166789012', 'fernando.sanchez@gmail.com', '2022-11-05', 'Gerente', 5000000.00, 5),
('Patricia', 'Vega', 'Carrera 30 #45-67, Bucaramanga', '3177890123', 'patricia.vega@gmail.com', '2020-02-14', 'Cajero', 2000000.00, 6),
('Sergio', 'Pardo', 'Calle 15 #5-10, Manizales', '3188901234', 'sergio.pardo@yahoo.com', '2021-09-01', 'Asesor', 2500000.00, 7),
('Monica', 'Figueroa', 'Carrera 40 #15-25, Pereira', '3199012345', 'monica.figueroa@hotmail.com', '2019-06-24', 'Analista', 3000000.00, 8),
('Camilo', 'Mejia', 'Avenida 60 #30-40, Santa Marta', '3200123456', 'camilo.mejia@gmail.com', '2020-04-12', 'Gerente', 5000000.00, 9),
('Natalia', 'Castro', 'Calle 100 #20-30, Ibagué', '3211234567', 'natalia.castro@outlook.com', '2022-08-10', 'Cajero', 2000000.00, 10);

-- Insertar registros en la tabla Cuentas Bancarias
INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES
(1, '1234567890', 'Ahorro', 500000.00, '2020-01-15', 'Activa'),
(2, '2345678901', 'Corriente', 1500000.00, '2019-03-10', 'Activa'),
(3, '3456789012', 'Ahorro', 750000.00, '2021-05-20', 'Activa'),
(4, '4567890123', 'Corriente', 200000.00, '2018-07-30', 'Cerrada'),
(5, '5678901234', 'Ahorro', 3000000.00, '2022-11-05', 'Activa'),
(6, '6789012345', 'Corriente', 1250000.00, '2020-02-14', 'Activa'),
(7, '7890123456', 'Ahorro', 600000.00, '2021-09-01', 'Cerrada'),
(8, '8901234567', 'Corriente', 1000000.00, '2019-06-24', 'Activa'),
(9, '9012345678', 'Ahorro', 2000000.00, '2020-04-12', 'Activa'),
(10, '0123456789', 'Corriente', 500000.00, '2022-08-10', 'Activa');

-- Insertar registros en la tabla Transacciones
INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES
(1, 'Deposito', 200000.00, '2023-01-15 10:00:00', 'Deposito inicial'),
(2, 'Retiro', 50000.00, '2023-01-16 14:30:00', 'Retiro en cajero automático'),
(3, 'Transferencia', 100000.00, '2023-01-17 09:00:00', 'Transferencia a cuenta 4'),
(4, 'Deposito', 300000.00, '2023-01-18 11:15:00', 'Deposito de ahorro'),
(5, 'Retiro', 150000.00, '2023-01-19 13:45:00', 'Retiro en oficina'),
(6, 'Deposito', 250000.00, '2023-01-20 15:30:00', 'Deposito inicial'),
(7, 'Transferencia', 50000.00, '2023-01-21 10:00:00', 'Transferencia a cuenta 8'),
(8, 'Retiro', 200000.00, '2023-01-22 16:00:00', 'Retiro en cajero automático'),
(9, 'Deposito', 500000.00, '2023-01-23 10:30:00', 'Deposito de ahorro'),
(10, 'Retiro', 75000.00, '2023-01-24 14:00:00', 'Retiro en oficina');

-- Insertar registros en la tabla Productos Financieros
INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES
('Prestamo Personal', 'Prestamo', 'Prestamo para necesidades personales', 12.5),
('Tarjeta de Credito Visa', 'Tarjeta de Credito', 'Tarjeta de credito internacional', 18.9),
('Seguro de Vida', 'Seguro', 'Seguro de vida para protección familiar', 5.0),
('Prestamo Hipotecario', 'Prestamo', 'Prestamo para adquisición de vivienda', 8.75),
('Tarjeta de Credito MasterCard', 'Tarjeta de Credito', 'Tarjeta de credito internacional', 19.5),
('Seguro de Auto', 'Seguro', 'Seguro para vehículos particulares', 4.5),
('Prestamo Estudiantil', 'Prestamo', 'Prestamo para estudios universitarios', 7.0),
('Tarjeta de Credito American Express', 'Tarjeta de Credito', 'Tarjeta de credito internacional', 20.0),
('Seguro de Salud', 'Seguro', 'Seguro de salud para gastos médicos', 6.0),
('Prestamo Empresarial', 'Prestamo', 'Prestamo para pequeñas y medianas empresas', 10.0);

-- Insertar registros en la tabla Prestamos
INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES
(1, 1000000.00, 12.5, '2023-01-01', '2025-01-01', 'Activo'),
(2, 500000.00, 8.75, '2022-06-01', '2027-06-01', 'Activo'),
(3, 300000.00, 7.0, '2023-03-01', '2026-03-01', 'Activo'),
(4, 1500000.00, 10.0, '2021-09-01', '2026-09-01', 'Pagado'),
(5, 2000000.00, 12.5, '2022-11-01', '2027-11-01', 'Activo'),
(6, 800000.00, 7.0, '2021-02-01', '2024-02-01', 'Pagado'),
(7, 500000.00, 8.75, '2023-05-01', '2028-05-01', 'Activo'),
(8, 250000.00, 12.5, '2022-08-01', '2025-08-01', 'Activo'),
(9, 3000000.00, 10.0, '2020-04-01', '2025-04-01', 'Activo'),
(10, 1200000.00, 7.0, '2021-12-01', '2026-12-01', 'Activo');

-- Insertar registros en la tabla Tarjetas de Crédito
INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES
(1, '4000123456789010', 5000000.00, 2500000.00, '2023-01-15', '2028-01-15', 'Activa'),
(2, '4001123456789027', 3000000.00, 1000000.00, '2022-06-15', '2027-06-15', 'Activa'),
(3, '4002123456789034', 4000000.00, 2000000.00, '2023-03-15', '2028-03-15', 'Activa'),
(4, '4003123456789041', 2500000.00, 500000.00, '2021-09-15', '2026-09-15', 'Bloqueada'),
(5, '4004123456789058', 6000000.00, 3000000.00, '2022-11-15', '2027-11-15', 'Activa'),
(6, '4005123456789065', 3500000.00, 1500000.00, '2021-02-15', '2026-02-15', 'Activa'),
(7, '4006123456789072', 4500000.00, 2000000.00, '2023-05-15', '2028-05-15', 'Activa'),
(8, '4007123456789089', 3000000.00, 1000000.00, '2022-08-15', '2027-08-15', 'Activa'),
(9, '4008123456789096', 5500000.00, 2500000.00, '2020-04-15', '2025-04-15', 'Activa'),
(10, '4009123456789102', 4000000.00, 2000000.00, '2021-12-15', '2026-12-15', 'Activa');

-- Insertar registros en la tabla Relación Clientes-Productos
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES
(1, 1, '2023-01-15'),
(2, 2, '2022-06-15'),
(3, 3, '2023-03-15'),
(4, 4, '2021-09-15'),
(5, 5, '2022-11-15'),
(6, 6, '2021-02-15'),
(7, 7, '2023-05-15'),
(8, 8, '2022-08-15'),
(9, 9, '2020-04-15'),
(10, 10, '2021-12-15');

