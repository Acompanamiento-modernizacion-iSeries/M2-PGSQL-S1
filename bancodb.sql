-- Taller número 1, CAMILO ANDRES GARCIA CRUZ
-- Creación de la base de datos
CREATE DATABASE BancoDB;

-- Tabla Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50),
    fecha_nacimiento DATE,
    estado VARCHAR(10) CHECK (estado IN ('activo', 'inactivo')) NOT NULL
);

-- Tabla Cuentas Bancarias
CREATE TABLE CuentasBancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(10) CHECK (tipo_cuenta IN ('corriente', 'ahorro')) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL,
    fecha_apertura DATE NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('activa', 'cerrada')) NOT NULL
);

-- Tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES CuentasBancarias(cuenta_id),
    tipo_transaccion VARCHAR(15) CHECK (tipo_transaccion IN ('depósito', 'retiro', 'transferencia')) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    descripcion VARCHAR(100)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50),
    fecha_contratacion DATE NOT NULL,
    posicion VARCHAR(50),
    salario DECIMAL(10, 2),
    sucursal_id INT
);

-- Tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Productos Financieros
CREATE TABLE ProductosFinancieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    tipo_producto VARCHAR(20) CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')) NOT NULL,
    descripcion VARCHAR(100),
    tasa_interes DECIMAL(5, 2)
);

-- Tabla Préstamos
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES CuentasBancarias(cuenta_id),
    monto DECIMAL(10, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('activo', 'pagado')) NOT NULL
);

-- Tabla Tarjetas de Crédito
CREATE TABLE TarjetasCredito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES CuentasBancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito DECIMAL(10, 2) NOT NULL,
    saldo_actual DECIMAL(10, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('activa', 'bloqueada')) NOT NULL
);

-- Tabla Relación Clientes-Productos
CREATE TABLE ClientesProductos (
    cliente_id INT REFERENCES Clientes(cliente_id),
    producto_id INT REFERENCES ProductosFinancieros(producto_id),
    fecha_adquisicion DATE NOT NULL,
    PRIMARY KEY (cliente_id, producto_id)
);

-- Inserciones en la tabla Clientes
INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) VALUES
('Juan', 'Perez', 'Calle 123', '123456789', 'juan.perez@example.com', '1980-01-01', 'activo'),
('Maria', 'Gomez', 'Avenida 456', '987654321', 'maria.gomez@example.com', '1990-02-02', 'activo'),
('Carlos', 'Lopez', 'Calle 789', '456123789', 'carlos.lopez@example.com', '1985-03-03', 'inactivo'),
('Ana', 'Martinez', 'Boulevard 101', '321654987', 'ana.martinez@example.com', '1995-04-04', 'activo');

-- Inserciones en la tabla Cuentas Bancarias
INSERT INTO CuentasBancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) VALUES
(1, '1234567890', 'corriente', 1000.00, '2020-01-01', 'activa'),
(2, '0987654321', 'ahorro', 2000.00, '2021-02-02', 'activa'),
(3, '1122334455', 'corriente', 1500.00, '2019-03-03', 'cerrada'),
(4, '5566778899', 'ahorro', 2500.00, '2022-04-04', 'activa');

-- Inserciones en la tabla Transacciones
INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion) VALUES
(1, 'depósito', 500.00, '2023-01-01', 'Depósito inicial'),
(2, 'retiro', 300.00, '2023-02-02', 'Retiro de efectivo'),
(3, 'transferencia', 200.00, '2023-03-03', 'Transferencia a otra cuenta'),
(4, 'depósito', 400.00, '2023-04-04', 'Depósito adicional');

-- Inserciones en la tabla Empleados
INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) VALUES
('Luis', 'Ramirez', 'Calle 202', '123123123', 'luis.ramirez@example.com', '2020-05-01', 'Cajero', 1500.00, 1),
('Laura', 'Fernandez', 'Avenida 303', '321321321', 'laura.fernandez@example.com', '2021-06-01', 'Gerente', 2500.00, 2),
('Pedro', 'Gonzalez', 'Calle 404', '456456456', 'pedro.gonzalez@example.com', '2019-07-01', 'Asesor', 1800.00, 1),
('Sofia', 'Diaz', 'Boulevard 505', '654654654', 'sofia.diaz@example.com', '2022-08-01', 'Cajero', 1600.00, 2);

-- Inserciones en la tabla Sucursales
INSERT INTO Sucursales (nombre, direccion, telefono) VALUES
('Sucursal Centro', 'Calle Principal 1', '111111111'),
('Sucursal Norte', 'Avenida Secundaria 2', '222222222'),
('Sucursal Sur', 'Boulevard Tercero 3', '333333333'),
('Sucursal Este', 'Calle Cuarta 4', '444444444');

-- Inserciones en la tabla Productos Financieros
INSERT INTO ProductosFinancieros (nombre_producto, tipo_producto, descripcion, tasa_interes) VALUES
('Préstamo Personal', 'préstamo', 'Préstamo para uso personal', 5.00),
('Tarjeta de Crédito Oro', 'tarjeta de crédito', 'Tarjeta de crédito con beneficios exclusivos', 15.00),
('Seguro de Vida', 'seguro', 'Seguro de vida completo', 2.00),
('Préstamo Hipotecario', 'préstamo', 'Préstamo para compra de vivienda', 3.50);

-- Inserciones en la tabla Préstamos
INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) VALUES
(1, 10000.00, 5.00, '2023-01-01', '2028-01-01', 'activo'),
(2, 20000.00, 3.50, '2023-02-01', '2033-02-01', 'activo'),
(3, 15000.00, 4.00, '2023-03-01', '2028-03-01', 'pagado'),
(4, 25000.00, 3.00, '2023-04-01', '2033-04-01', 'activo');

-- Inserciones en la tabla Tarjetas de Crédito
INSERT INTO TarjetasCredito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) VALUES
(1, '1111222233334444', 5000.00, 1000.00, '2023-01-01', '2028-01-01', 'activa'),
(2, '5555666677778888', 10000.00, 2000.00, '2023-02-01', '2028-02-01', 'activa'),
(3, '9999000011112222', 7000.00, 1500.00, '2023-03-01', '2028-03-01', 'bloqueada'),
(4, '3333444455556666', 8000.00, 2500.00, '2023-04-01', '2028-04-01', 'activa');

-- Inserciones en la tabla Relación Clientes-Productos
INSERT INTO ClientesProductos (cliente_id, producto_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');