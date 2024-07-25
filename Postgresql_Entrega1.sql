CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(10) NOT NULL CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) NOT NULL CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo NUMERIC(15, 2),
    fecha_apertura DATE,
    estado VARCHAR(10) NOT NULL CHECK (estado IN ('activa', 'cerrada'))
);

CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) NOT NULL,
    monto NUMERIC(15, 2) NOT NULL,
    fecha_transaccion DATE,
    descripcion VARCHAR(100)
);
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50) UNIQUE NOT NULL,
    fecha_contratacion DATE,
    posicion VARCHAR(50),
    salario NUMERIC(10, 2),
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id)
);


CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    tipo_producto VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100),
    tasa_interes NUMERIC(5, 2)
);

CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    monto NUMERIC(15, 2) NOT NULL,
    tasa_interes NUMERIC(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(10) NOT NULL CHECK (estado IN ('activo', 'pagado'))
);

CREATE TABLE Tarjetas_de_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito NUMERIC(15, 2),
    saldo_actual NUMERIC(15, 2),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(10) NOT NULL CHECK (estado IN ('activa', 'bloqueada'))
);

CREATE TABLE Clientes_Productos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);

-- Insertar registros en las tablas
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES
('Juan', 'Pérez', 'Calle 53 50-53', '887654323', 'juan.perez@gmail.com', '1988-07-01', 'activo'),
('María', 'García', 'Avenida 742', '687654323', 'maria.garcia@hotmail.com', '1990-02-02', 'inactivo'),
('Pedro', 'López', 'Calle 45 93-01 ', '456789123', 'pedro.lopez@yahoo.com', '1985-08-03', 'inactivo'),
('Ana', 'Martínez', 'Avenida 7 7-9', '789123456', 'ana.martinez@gmail.com', '1996-04-08', 'activo');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES
('Sucursal Centro', 'Centro de la ciudad', '887654324'),
('Sucursal Norte', 'Norte de la ciudad', '887654325'),
('Sucursal Sur', 'Sur de la ciudad', '887654329'),
('Sucursal Este', 'Este de la ciudad', '887654327');

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES
('Carlos', 'Sánchez', 'Calle 123', '78765432489', 'carlos.sanchez@gmail.com', '2020-01-01', 'Gerente', 5000, 1),
('Luisa', 'Ramírez', 'Avenida 456', '456456456', 'luisa.ramirez@hotmail.com', '2019-02-02', 'Cajero', 3000, 2),
('Jorge', 'Fernández', 'Calle 789', '789789789', 'jorge.fernandez@hotmail.com', '2018-03-03', 'Ejecutivo de Cuenta', 4000, 3),
('Sofía', 'Gómez', 'Avenida101', '101101101', 'sofia.gomez@hotmail.com', '2021-04-04', 'Cajero', 3000, 4);

INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES
(1, '1234567890', 'corriente', 1000.00, '2022-01-01', 'activa'),
(2, '2345678901', 'ahorro', 2000.00, '2022-02-02', 'activa'),
(3, '3456789012', 'corriente', 3000.00, '2022-03-03', 'cerrada'),
(4, '4567890123', 'ahorro', 4000.00, '2022-04-04', 'activa');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES
(1, 'depósito', 500.00, '2023-01-01', 'Depósito inicial'),
(2, 'retiro', 200.00, '2023-02-02', 'Retiro en efectivo'),
(3, 'transferencia', 300.00, '2023-03-03', 'Transferencia a otra cuenta'),
(4, 'depósito', 400.00, '2023-04-04', 'Depósito mensual');

INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES
('Préstamo Personal', 'préstamo', 'Préstamo personal a bajo interés', 5.00),
('Tarjeta de Crédito', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios', 15.00),
('Seguro de Vida', 'seguro', 'Seguro de vida completo', 3.00),
('Préstamo Hipotecario', 'préstamo', 'Préstamo hipotecario con condiciones favorables', 4.50);

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES
(1, 10000.00, 5.00, '2023-01-01', '2028-01-01', 'activo'),
(2, 20000.00, 4.50, '2023-02-02', '2033-02-02', 'activo'),
(3, 15000.00, 6.00, '2023-03-03', '2028-03-03', 'pagado'),
(4, 5000.00, 5.50, '2023-04-04', '2025-04-04', 'activo');

INSERT INTO Tarjetas_de_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES
(1, '787654324', 5000.00, 1000.00, '2023-01-01', '2026-01-01', 'activa'),
(2, '887654323', 6000.00, 2000.00, '2023-02-02', '2027-02-02', 'bloqueada'),
(3, '687654329', 7000.00, 3000.00, '2023-03-03', '2028-03-03', 'bloqueada'),
(4, '787654328', 8000.00, 4000.00, '2023-04-04', '2029-04-04', 'activa');

INSERT INTO Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-02'),
(3, 3, '2023-03-03'),
(4, 4, '2023-04-04');
