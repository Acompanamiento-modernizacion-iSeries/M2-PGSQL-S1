--------------------------------------------
----------- Tabla Clientes------------------
--------------------------------------------
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    apellido VARCHAR(150) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(25),
    correo_electronico VARCHAR(150) UNIQUE,
    fecha_nacimiento DATE,
    estado VARCHAR(30) CHECK (estado IN ('activo', 'inactivo'))
);
 
--------------------------------------------
------------ Tabla Sucursales --------------
--------------------------------------------
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20)
);
 
 --------------------------------------------
------------- Tabla Empleados ---------------
---------------------------------------------
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(25),
    correo_electronico VARCHAR(100) UNIQUE,
    fecha_contratacion DATE NOT NULL,
    posicion VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL, 
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id)
);
 
--------------------------------------------
------- Tabla Cuentas Bancarias ------------
--------------------------------------------
CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo DECIMAL(12, 2),
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'cerrada')) NOT NULL
);
 
--------------------------------------------
--------- Tabla Transacciones --------------
--------------------------------------------
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('depósito', 'retiro', 'transferencia')),
    monto DECIMAL(12, 2),
    fecha_transaccion TIMESTAMP,
    descripcion TEXT
);
 
--------------------------------------------
---- Tabla Productos Financieros -----------
--------------------------------------------
CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')),
    descripcion TEXT,
    tasa_interes DECIMAL(5, 2)
);
 
--------------------------------------------
---------- Tabla Préstamos -----------------
--------------------------------------------
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    monto DECIMAL(12, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'pagado')) NOT NULL
);
 
--------------------------------------------
------ Tabla Tarjetas de Crédito -----------
--------------------------------------------
CREATE TABLE Tarjetas_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito DECIMAL(12, 2) NOT NULL,
    saldo_actual DECIMAL(12, 2) NOT NULL,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);
 
--------------------------------------------
--- Tabla Relación Clientes-Productos ------
--------------------------------------------
CREATE TABLE Relacion_Clientes_Productos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);

--------------------------------------------
------ llenar la tabla de clientes ---------
--------------------------------------------
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) VALUES
('Juan', 'Perez', 'Calle Falsa 123', '555-1234', 'juan.perez@example.com', '1980-05-15', 'activo'),
('Ana', 'Lopez', 'Avenida Siempre Viva 456', '555-5678', 'ana.lopez@example.com', '1992-07-24', 'activo'),
('Carlos', 'Gomez', 'Diagonal 789', '555-9012', 'carlos.gomez@example.com', '1975-03-30', 'inactivo'),
('Laura', 'Martinez', 'Ronda de Nelle 101', '555-3456', 'laura.martinez@example.com', '1988-12-10', 'activo');

--------------------------------------------
---- llenar la tabla de sucursales ---------
--------------------------------------------
INSERT INTO Sucursales (nombre, direccion, telefono) VALUES
('Sucursal Centro', 'Calle Central 123', '123-456-7890'),
('Sucursal Norte', 'Avenida Norte 456', '234-567-8901'),
('Sucursal Este', 'Boulevard Este 789', '345-678-9012'),
('Sucursal Oeste', 'Calle Oeste 101', '456-789-0123');

--------------------------------------------
------ llenar la tabla de empleados --------
--------------------------------------------
INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) VALUES
('Elena', 'Rodriguez', 'Calle Luna 45', '987-654-3210', 'elena.rodriguez@example.com', '2021-03-15', 'Gerente', 4500.00, 1),
('Miguel', 'Fernandez', 'Avenida Sol 123', '987-654-3211', 'miguel.fernandez@example.com', '2020-06-20', 'Asistente', 2500.00, 2),
('Sofia', 'Martinez', 'Calle Estrella 789', '987-654-3212', 'sofia.martinez@example.com', '2019-09-10', 'Cajero', 2000.00, 3),
('Carlos', 'Garcia', 'Boulevard Luna 456', '987-654-3213', 'carlos.garcia@example.com', '2022-01-05', 'Analista Financiero', 3000.00, 4);

--------------------------------------------
-- llenar la tabla de cuentas bancarias ----
--------------------------------------------
INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) VALUES
(1, '1234567890', 'corriente', 10000.00, '2023-01-01', 'activa'),
(2, '0987654321', 'ahorro', 5000.00, '2023-02-01', 'activa'),
(3, '1122334455', 'corriente', 15000.00, '2023-03-01', 'activa'),
(4, '5566778899', 'ahorro', 200.00, '2023-04-01', 'cerrada');

--------------------------------------------
-- llenar la tabla de transacciones --------
--------------------------------------------
INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion) VALUES
(1, 'depósito', 2000.00, '2023-04-01 10:00:00', 'Depósito inicial'),
(2, 'retiro', 500.00, '2023-04-02 12:30:00', 'Retiro cajero automático'),
(1, 'transferencia', 1500.00, '2023-04-03 09:45:00', 'Transferencia a cuenta 3'),
(3, 'depósito', 1500.00, '2023-04-03 09:46:00', 'Depósito desde cuenta 1');

--------------------------------------------
--llenar la tabla de productos financieros--
--------------------------------------------
INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes) VALUES
('Préstamo Personal', 'préstamo', 'Préstamo sin garantía para individuos', 12.50),
('Tarjeta Platinum', 'tarjeta de crédito', 'Tarjeta de crédito con límite alto y beneficios exclusivos', 1.99),
('Seguro de Vida', 'seguro', 'Cobertura completa para usted y su familia', 0.00),
('Crédito Hipotecario', 'préstamo', 'Préstamos para la compra de propiedad residencial', 8.75);

--------------------------------------------
------- llenar la tabla de préstamos -------
--------------------------------------------
INSERT INTO prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) VALUES
(1, 10000.00, 5.00, '2023-01-01', '2024-01-01', 'activo'),
(2, 5000.00, 6.00, '2023-02-01', '2024-02-01', 'activo'),
(3, 15000.00, 4.50, '2023-03-01', '2024-03-01', 'pagado'),
(4, 20000.00, 5.50, '2023-04-01', '2024-04-01', 'activo');

--------------------------------------------
---- llenar Tabla Tarjetas de Crédito ------
--------------------------------------------
INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) VALUES
(1, '1234567890123456', 10000.00, 2000.00, '2023-01-01', '2028-01-01', 'activa'),
(2, '2345678901234567', 8000.00, 1500.00, '2023-02-01', '2028-02-01', 'activa'),
(3, '3456789012345678', 12000.00, 3000.00, '2023-03-01', '2028-03-01', 'bloqueada'),
(4, '4567890123456789', 15000.00, 500.00, '2023-04-01', '2028-04-01', 'activa');

----------------------------------------------------
-- llenar la tabla de relación clientes-productos --
----------------------------------------------------
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');