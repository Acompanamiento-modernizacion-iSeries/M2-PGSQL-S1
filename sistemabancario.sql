CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE CuentasBancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo DECIMAL(15, 2) DEFAULT 0.00,
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'cerrada'))
);

CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('deposito', 'retiro', 'transferencia')),
    monto DECIMAL(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(200)
);

CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100),
    fecha_contratacion DATE,
    posicion VARCHAR(100),
    salario DECIMAL(15, 2),
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id)
);

CREATE TABLE ProductosFinancieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion VARCHAR(100),
    tasa_interes DECIMAL(5, 2)
);

CREATE TABLE Prestamos (
    préstamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    monto DECIMAL(15, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'pagado'))
);

CREATE TABLE TarjetasDeCredito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    numero_tarjeta VARCHAR(50) UNIQUE NOT NULL,
    limite_credito DECIMAL(15, 2),
    saldo_actual DECIMAL(15, 2) DEFAULT 0.00,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);

CREATE TABLE RelacionClientesProductos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES ProductosFinancieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Juan', 'Pérez', 'Calle 123, Ciudad ABC', '123456789', 'juan.perez@example.com', '1980-05-15', 'activo');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('María', 'Gómez', 'Avenida XYZ, Ciudad DEF', '987654321', 'maria.gomez@example.com', '1990-08-20', 'activo');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Pedro', 'López', 'Plaza Principal, Ciudad GHI', '456123789', 'pedro.lopez@example.com', '1985-02-10', 'inactivo');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Ana', 'Martínez', 'Avenida Central, Ciudad JKL', '789456123', 'ana.martinez@example.com', '1977-11-30', 'activo');

INSERT INTO CuentasBancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (1, '001-123456789', 'corriente', 1500.00, '2023-01-15', 'activa');

INSERT INTO CuentasBancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (2, '002-987654321', 'ahorro', 3000.00, '2022-11-20', 'activa');

INSERT INTO CuentasBancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (3, '003-456123789', 'corriente', 500.00, '2023-02-28', 'cerrada');

INSERT INTO CuentasBancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES (4, '004-789456123', 'ahorro', 8000.00, '2021-07-10', 'activa');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (1, 'depósito', 500.00, '2023-01-20 09:30:00', 'Depósito inicial');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (2, 'retiro', 100.00, '2022-12-05 14:45:00', 'Retiro en cajero automático');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (3, 'transferencia', 200.00, '2023-03-10 11:00:00', 'Transferencia a otra cuenta');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (4, 'deposito', 1000.00, '2021-08-15 16:20:00', 'Depósito de salario');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('Sucursal Principal', 'Calle Mayor 123, Ciudad Principal', '1234567890');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('Sucursal Secundaria', 'Avenida Central 456, Ciudad Secundaria', '2345678901');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('Sucursal Norte', 'Plaza Central 789, Ciudad Norte', '3456789012');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('Sucursal Sur', 'Paseo Marítimo 321, Ciudad Sur', '4567890123');

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Carlos', 'García', 'Calle Principal, Ciudad XYZ', '234567890', 'carlos.garcia@example.com', '2019-03-01', 'Gerente de Sucursal', 2500.00, 1);

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Laura', 'Rodríguez', 'Avenida Central, Ciudad QRS', '345678901', 'laura.rodriguez@example.com', '2020-05-10', 'Cajero', 1800.00, 2);

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Daniel', 'López', 'Plaza Mayor, Ciudad UVW', '456789012', 'daniel.lopez@example.com', '2021-01-15', 'Asistente Administrativo', 1500.00, 3);

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Sofía', 'Hernández', 'Paseo Marítimo, Ciudad OPQ', '567890123', 'sofia.hernandez@example.com', '2018-08-20', 'Analista Financiero', 2800.00, 2);

INSERT INTO ProductosFinancieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Préstamo Personal', 'préstamo', 'Préstamo a corto plazo para necesidades personales', 8.5);

INSERT INTO ProductosFinancieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Tarjeta de Crédito Oro', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios premium', 15.0);

INSERT INTO ProductosFinancieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Seguro de Vida', 'seguro', 'Seguro que cubre riesgos de vida y salud', 5.2);

INSERT INTO ProductosFinancieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Préstamo Hipotecario', 'préstamo', 'Préstamo a largo plazo para compra de vivienda', 7.0);

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (1, 10000.00, 9.0, '2022-05-01', '2023-05-01', 'activo');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (3, 5000.00, 8.0, '2023-01-15', '2023-07-15', 'activo');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (2, 15000.00, 10.0, '2022-10-20', '2023-10-20', 'pagado');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (4, 20000.00, 9.5, '2021-08-01', '2022-08-01', 'pagado');

INSERT INTO TarjetasDeCrédito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (1, '1111-2222-3333-4444', 5000.00, 1000.00, '2022-01-15', '2025-01-15', 'activa');

INSERT INTO TarjetasDeCrédito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (2, '5555-6666-7777-8888', 10000.00, 0.00, '2021-12-01', '2024-12-01', 'activa');

INSERT INTO TarjetasDeCrédito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (3, '9999-8888-7777-6666', 3000.00, 500.00, '2023-03-10', '2026-03-10', 'bloqueada');

INSERT INTO TarjetasDeCrédito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (4, '1234-5678-9012-3456', 15000.00, 2000.00, '2020-09-15', '2023-09-15', 'activa');

INSERT INTO RelaciónClientesProductos (cliente_id, producto_id, fecha_adquisicion)
VALUES (1, 1, '2022-02-15');

INSERT INTO RelaciónClientesProductos (cliente_id, producto_id, fecha_adquisicion)
VALUES (2, 2, '2021-12-10');

INSERT INTO RelaciónClientesProductos (cliente_id, producto_id, fecha_adquisicion)
VALUES (3, 3, '2023-04-20');

INSERT INTO RelaciónClientesProductos (cliente_id, producto_id, fecha_adquisicion)
VALUES (4, 4, '2020-11-30');