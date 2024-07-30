-- Creación de la base de datos sistema_bancario
CREATE DATABASE sistema_bancario;

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100),
    fecha_nacimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'inactivo'))
);

-- Creación de la tabla Cuentas Bancarias
CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo DECIMAL(15, 2) DEFAULT 0.00,
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'cerrada'))
);

-- Creación de la tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('depósito', 'retiro', 'transferencia')),
    monto DECIMAL(15, 2),
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT
);

-- Creación de la tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20)
);

-- Creación de la tabla Empleados
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100),
    fecha_contratacion DATE,
    posicion VARCHAR(100),
    salario DECIMAL(15, 2),
    sucursal_id INT REFERENCES Sucursales(sucursal_id)
);

-- Creación de la tabla Productos Financieros
CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')),
    descripcion TEXT,
    tasa_interes DECIMAL(5, 2)
);

-- Creación de la tabla Préstamos
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    monto DECIMAL(15, 2),
    tasa_interes DECIMAL(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'pagado'))
);

-- Creación de la tabla Tarjetas de Crédito
CREATE TABLE Tarjetas_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(50) UNIQUE NOT NULL,
    limite_credito DECIMAL(15, 2),
    saldo_actual DECIMAL(15, 2),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);

-- Creación de la tabla Relación Clientes-Productos
CREATE TABLE Relacion_Clientes_Productos (
    cliente_id INT REFERENCES Clientes(cliente_id),
    producto_id INT REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);



-- Inserción de datos en la tabla Clientes
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) VALUES
('Juan', 'Pérez', 'Calle 123', '555-1234', 'juan.perez@clientes.com', '1980-01-15', 'activo'),
('María', 'López', 'Avenida 456', '555-5678', 'maria.lopez@clientes.com', '1990-02-25', 'activo'),
('Carlos', 'Gómez', 'Calle 789', '555-8765', 'carlos.gomez@clientes.com', '1975-03-30', 'inactivo'),
('Ana', 'Rodríguez', 'Boulevard 101', '555-4321', 'ana.rodriguez@clientes.com', '1985-04-20', 'activo');

-- Inserción de datos en la tabla Sucursales
INSERT INTO Sucursales (nombre, direccion, telefono) VALUES
('Sucursal Central', 'Calle Principal 100', '555-0000'),
('Sucursal Norte', 'Avenida Norte 200', '555-1111'),
('Sucursal Sur', 'Calle Sur 300', '555-2222'),
('Sucursal Este', 'Boulevard Este 400', '555-3333');

-- Inserción de datos en la tabla Empleados
INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) VALUES
('Pedro', 'Martínez', 'Calle Alfa 1', '555-4444', 'pedro.martinez@empleados.com', '2015-06-15', 'Cajero', 30000.00, 1),
('Lucía', 'García', 'Avenida Beta 2', '555-5555', 'lucia.garcia@empleados.com', '2018-09-20', 'Asistente', 35000.00, 2),
('Miguel', 'Sánchez', 'Calle Gamma 3', '555-6666', 'miguel.sanchez@empleados.com', '2020-01-10', 'Gerente', 50000.00, 3),
('Elena', 'Ruiz', 'Boulevard Delta 4', '555-7777', 'elena.ruiz@empleados.com', '2017-11-25', 'Contador', 40000.00, 4);

-- Inserción de datos en la tabla Productos Financieros
INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes) VALUES
('Préstamo Personal', 'préstamo', 'Préstamo para necesidades personales', 5.00),
('Tarjeta de Crédito Oro', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios premium', 2.50),
('Seguro de Vida', 'seguro', 'Seguro de vida completo', NULL),
('Préstamo Hipotecario', 'préstamo', 'Préstamo para compra de vivienda', 4.00);

-- Inserción de datos en la tabla Cuentas Bancarias
INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) VALUES
(1, '1234567890', 'corriente', 10000.00, '2021-05-15', 'activa'),
(2, '2345678901', 'ahorro', 15000.00, '2022-06-20', 'activa'),
(3, '3456789012', 'corriente', 5000.00, '2023-07-25', 'cerrada'),
(4, '4567890123', 'ahorro', 2000.00, '2020-08-30', 'activa');

-- Inserción de datos en la tabla Transacciones
INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion) VALUES
(1, 'depósito', 1000.00, '2024-01-01 10:00:00', 'Depósito inicial'),
(2, 'retiro', 500.00, '2024-02-01 11:00:00', 'Retiro de efectivo'),
(3, 'transferencia', 2000.00, '2024-03-01 12:00:00', 'Transferencia a otra cuenta'),
(4, 'depósito', 3000.00, '2024-04-01 13:00:00', 'Depósito de salario');

-- Inserción de datos en la tabla Préstamos
INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) VALUES
(1, 5000.00, 5.00, '2023-01-01', '2025-01-01', 'activo'),
(2, 10000.00, 4.50, '2022-02-01', '2026-02-01', 'activo'),
(3, 7000.00, 5.00, '2021-03-01', '2025-03-01', 'pagado'),
(4, 8000.00, 4.00, '2020-04-01', '2024-04-01', 'activo');

-- Inserción de datos en la tabla Tarjetas de Crédito
INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) VALUES
(1, '1111222233334444', 10000.00, 2000.00, '2023-05-15', '2027-05-15', 'activa'),
(2, '5555666677778888', 15000.00, 5000.00, '2022-06-20', '2026-06-20', 'activa'),
(3, '9999000011112222', 20000.00, 10000.00, '2021-07-25', '2025-07-25', 'bloqueada'),
(4, '3333444455556666', 5000.00, 1000.00, '2020-08-30', '2024-08-30', 'activa');

-- Inserción de datos en la tabla Relación Clientes-Productos
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2022-02-01'),
(3, 3, '2021-03-01'),
(4, 4, '2020-04-01');
