-- Tabla Clientes
CREATE TABLE Clientes(
    cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(100),
	telefono VARCHAR(20),
	correo_electronico VARCHAR(200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado VARCHAR(10) NOT NULL CHECK (estado IN ('activo','inactivo'))
);

-- Tabla Cuentas_Bancarias
CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
    numero_cuenta VARCHAR(20) NOT NULL UNIQUE,
    tipo_cuenta VARCHAR(10) NOT NULL CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo DECIMAL(15, 2),
    fecha_apertura DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('activa', 'cerrada'))
);

-- Tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
    tipo_transaccion VARCHAR(20) NOT NULL CHECK (tipo_transaccion IN ('depósito', 'retiro', 'transferencia')),
    monto DECIMAL(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(200) NOT NULL
);
 
-- Tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) 
);

-- Tabla Empleados
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(200) UNIQUE,
    fecha_contratacion TIMESTAMP NOT NULL,
    posicion VARCHAR(100),
    salario DECIMAL(10, 2),
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
);
 
-- Tabla Productos_Financieros
CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) NOT NULL CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')),
    descripcion VARCHAR(200) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL
);
 
-- Tabla Prestamos
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('activo', 'pagado'))
);
 
-- Tabla Tarjetas_Credito
CREATE TABLE Tarjetas_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito DECIMAL(12, 2),
    saldo_actual DECIMAL(12, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);
 
-- Tabla RelaciO_Clientes-Productos
CREATE TABLE Relacion_Clientes_Productos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE NOT NULL,
    PRIMARY KEY (cliente_id, producto_id)
);

-- INSERCION DE REGISTROS EN LAS TABLAS

-- Tabla Clientes
-- Cliente 1
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES (1, 'Juan', 'Perez', 'Calle 123', '3214587895', 'juan.perez@hotmail.com', '1990-05-15', 'activo');

-- Cliente 2
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES (2, 'María', 'Gomez', 'Calle 456', '3214587896', 'maria.gomez@hotmail.com', '1995-08-20', 'activo');

-- Cliente 3
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES (3, 'Pedro', 'Lopez', 'Calle 789', '3214587897', 'pedro.lopez@hotmail.com', '1989-03-10', 'inactivo');

-- Cliente 4
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES (4, 'Ana', 'Martinez', 'Calle 010', '3214587898', 'ana.martinez@hotmail.com', '1996-11-25', 'inactivo');

-- Tabla Cuentas_Bancarias
-- Cuenta 1
INSERT INTO Cuentas_Bancarias (cuenta_id, cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (1, 1, '1234567890', 'corriente', 5000.00, '2023-01-10', 'activa');

-- Cuenta 2
INSERT INTO Cuentas_Bancarias (cuenta_id, cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (2, 2, '9876543210', 'ahorro', 2500.00, '2022-05-20', 'activa');

-- Cuenta 3
INSERT INTO Cuentas_Bancarias (cuenta_id, cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (3, 3, '1112223330', 'corriente', 8000.00, '2024-03-15', 'activa');

-- Cuenta 4
INSERT INTO Cuentas_Bancarias (cuenta_id, cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (4, 4, '4445556660', 'ahorro', 3500.00, '2023-11-01', 'activa');

--Tabla Transacciones
-- Transacción 1
INSERT INTO Transacciones (transaccion_id, cuenta_id, tipo_transaccion, monto, descripcion)
VALUES (1, 1, 'depósito', 1000.00, 'Depósito inicial');

-- Transacción 2
INSERT INTO Transacciones (transaccion_id, cuenta_id, tipo_transaccion, monto, descripcion)
VALUES (2, 2, 'retiro', 500.00, 'Retiro en cajero');

-- Transacción 3
INSERT INTO Transacciones (transaccion_id, cuenta_id, tipo_transaccion, monto, descripcion)
VALUES (3, 3, 'transferencia', 2000.00, 'Transferencia a cuenta externa');

-- Transacción 4
INSERT INTO Transacciones (transaccion_id, cuenta_id, tipo_transaccion, monto, descripcion)
VALUES (4, 4, 'depósito', 1500.00, 'Depósito de salario');

-- Tabla Sucursales
-- Sucursal 1
INSERT INTO Sucursales (sucursal_id, nombre, direccion, telefono)
VALUES (1, 'Sucursal Central', 'Av. Principal 123', '1234567890');

-- Sucursal 2
INSERT INTO Sucursales (sucursal_id, nombre, direccion, telefono)
VALUES (2, 'Sucursal Norte', 'Calle Norte 456', '9876543210');

-- Sucursal 3
INSERT INTO Sucursales (sucursal_id, nombre, direccion, telefono)
VALUES (3, 'Sucursal Sur', 'Av. Sur 789', '1112223333');

-- Sucursal 4
INSERT INTO Sucursales (sucursal_id, nombre, direccion, telefono)
VALUES (4, 'Sucursal Este', 'Calle Este 010', '4445556666');

-- Tabla Empleados
-- Empleado 1
INSERT INTO Empleados (empleado_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES (1, 'Carlos', 'Gonzalez', 'Avenida Libertador 123', '+555666777', 'carlos.gonzalez@example.com', '2020-02-15', 'Gerente de Sucursal', 4500.00, 1);

-- Empleado 2
INSERT INTO Empleados (empleado_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES (2, 'Laura', 'Hernandez', 'Calle Principal 456', '+333444555', 'laura.hernandez@example.com', '2019-07-10', 'Cajero', 2500.00, 2);

-- Empleado 3
INSERT INTO Empleados (empleado_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES (3, 'Daniel', 'Rojas', 'Avenida Bolivar 789', '+777888999', 'daniel.rojas@example.com', '2021-01-30', 'Analista de Crédito', 3500.00, 1);

-- Empleado 4
INSERT INTO Empleados (empleado_id, nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES (4, 'Carolina', 'Sanchez', 'Calle Secundaria 010', '+111222333', 'carolina.sanchez@example.com', '2023-03-20', 'Asesor Financiero', 3800.00, 3);

-- Tabla Productos_Financieros
-- Producto Financiero 1 
INSERT INTO Productos_Financieros (producto_id, nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES (1, 'Préstamo Personal', 'préstamo', 'Préstamo personal para necesidades diversas', 8.5);

-- Producto Financiero 2 
INSERT INTO Productos_Financieros (producto_id, nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES (2, 'Tarjeta de Crédito Platinum', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios premium', 18.0);

-- Producto Financiero 3
INSERT INTO Productos_Financieros (producto_id, nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES (3, 'Seguro de Vida Familiar', 'seguro', 'Seguro de vida que protege a la familia', 4.2);

-- Producto Financiero 4 
INSERT INTO Productos_Financieros (producto_id, nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES (4, 'Préstamo Hipotecario Variable', 'préstamo', 'Préstamo hipotecario con tasa de interés variable', 7.8);

-- Tabla Prestamos
-- Préstamo 1
INSERT INTO Prestamos (prestamo_id, cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (1, 1, 20000.00, 8.0, '2024-06-15', '2025-06-15', 'activo');

-- Préstamo 2
INSERT INTO Prestamos (prestamo_id, cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (2, 3, 15000.00, 7.5, '2023-11-20', '2024-11-20', 'activo');

-- Préstamo 3
INSERT INTO Prestamos (prestamo_id, cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (3, 2, 10000.00, 8.5, '2024-03-10', '2025-03-10', 'activo');

-- Préstamo 4
INSERT INTO Prestamos (prestamo_id, cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (4, 4, 30000.00, 7.0, '2023-09-01', '2024-09-01', 'activo');

-- Tabla Tarjetas Credito
-- Tarjeta de Crédito 1
INSERT INTO Tarjetas_Credito (tarjeta_id, cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (1, 2, '1234567890123456', 5000.00, 2500.00, '2024-01-01', '2025-01-01', 'activa');

-- Tarjeta de Crédito 2
INSERT INTO Tarjetas_Credito (tarjeta_id, cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (2, 4, '9876543210987654', 10000.00, 7500.00, '2023-05-15', '2024-05-15', 'activa');

-- Tarjeta de Crédito 3
INSERT INTO Tarjetas_Credito (tarjeta_id, cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (3, 1, '5678901234567890', 3000.00, 1200.00, '2024-03-01', '2025-03-01', 'activa');

-- Tarjeta de Crédito 4
INSERT INTO Tarjetas_Credito (tarjeta_id, cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (4, 3, '2345678901234567', 8000.00, 3000.00, '2023-08-10', '2024-08-10', 'activa');

-- Tabla Relacion Clientes Productos
-- Relacion 1
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES (1, 1, '2023-01-15');

-- Relacion 2
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES (2, 2, '2023-03-22');

--Relacion 3
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES (3, 3, '2023-05-10');

--Relacion 4
INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES (4, 4, '2023-07-08');
