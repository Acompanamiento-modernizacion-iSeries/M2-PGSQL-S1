--         SISTEMA BANCARIO 

--SCRIPT CREADO POR: Juan Carlos Alvarez Cuartas



-------  TABLAS 

---- ESTADOS DEL CLIENTE:
CREATE TABLE Estados_Cliente(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- CLIENTES:
CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL, 
	direccion VARCHAR (80),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado INT REFERENCES Estados_Cliente(estado_id) NOT NULL	
);

---- TIPOS DE CUENTAS:
CREATE TABLE Tipo_Cuenta(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

---- ESTADOS DE LA CUENTA:
CREATE TABLE Estados_Cuenta(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- CUENTAS BANCARIAS:
CREATE TABLE Cuentas_Bancarias (
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta INT UNIQUE NOT NULL,
	tipo_cuenta INT REFERENCES Tipo_Cuenta(tipo_id) NOT NULL,
	saldo NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
	fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado INT REFERENCES Estados_Cuenta(estado_id) NOT NULL
);

---- TIPOS DE TRANSACCIONES:
CREATE TABLE Tipo_Transaccion(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- TRANSACCIONES:
CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	tipo_transaccion INT REFERENCES Tipo_Transaccion(tipo_id) NOT NULL,
	monto NUMERIC(15, 2) NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL,
	descripcion VARCHAR(200) NOT NULL
);

---- POSICIONES DE LOS EMPLEADOS:
CREATE TABLE Posiciones(
	posicion_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

---- SUCURSALES:
CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL,
	direccion VARCHAR (80) NOT NULL,
	telefono VARCHAR (20) NOT NULL
);

-- EMPLEADOS:
CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL, 
	direccion VARCHAR (80),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_contratacion TIMESTAMP NOT NULL,
	posicion INT REFERENCES Posiciones(posicion_id) NOT NULL,
	salario  NUMERIC(15, 2) NOT NULL,
	sucursal_id INT REFERENCES Sucursales(sucursal_id) NOT NULL
);

---- TIPOS DE PRODUCTOS:
CREATE TABLE Tipo_Producto(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- PRODUCTOS FINANCIEROS:
CREATE TABLE Productos_Financieros (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (50) NOT NULL,
	tipo_producto INT REFERENCES Tipo_Producto(tipo_id) NOT NULL,
	descripcion VARCHAR (200) NOT NULL,
	tasa_interes NUMERIC(7, 5) NOT NULL
);

---- ESTADOS DE LOS PRESTAMOS:
CREATE TABLE Estados_Prestamo(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- PRESTAMOS:
CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	monto NUMERIC(15, 2) NOT NULL, 
	tasa_interes NUMERIC(7, 5) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado INT REFERENCES Estados_Prestamo(estado_id) NOT NULL
);

---- ESTADOS DE LAS TARJETAS:
CREATE TABLE Estados_Tarjeta(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (80) NOT NULL
);

-- TARJETAS DE CREDITO:
CREATE TABLE Tarjetas_Credito (
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	numero_tarjeta INT UNIQUE NOT NULL, 
	limite_credito NUMERIC(15, 2) NOT NULL,
	saldo_actual NUMERIC(15, 2) NOT NULL,
	fecha_emision DATE NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	estado INT REFERENCES Estados_Tarjeta(estado_id) NOT NULL
);

-- CLIENTES PRODUCTOS(MUCHOS A MUCHOS ENTRE CLIENTES Y PRODUCTOS):
CREATE TABLE Clientes_Productos (
	cliente_id INT REFERENCES Clientes(cliente_id),
	producto_id INT REFERENCES Productos_Financieros(producto_id),
	fecha_adquisicion DATE NOT NULL,
	PRIMARY KEY (cliente_id, producto_id)
);

-----------------------------------------------------------------------
--INSERTAR DATOS EN LAS TABLAS YA CREADAS
-----------------------------------------------------------------------

--INSERTAR DATOS ESTADOS DEL CLIENTE
INSERT INTO Estados_Cliente(nombre)
VALUES ('Activo');

INSERT INTO Estados_Cliente(nombre)
VALUES ('Inactivo');

--INSERTAR DATOS CLIENTES
INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Carlos', 'Rodríguez', 'Calle 1 # 12-34', '1234567890', 'carlos.rodriguez@example.com', '1992-12-09', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('María', 'Gómez', 'Carrera 2 # 23-45', '2345678901', 'maria.gomez@example.com', '1997-03-27', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Pedro', 'López', 'Avenida 3 # 34-56', '3456789012', 'pedro.lopez@example.com', '1961-08-09', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Ana', 'Martínez', 'Diagonal 4 # 45-67', '4567890123', 'ana.martinez@example.com', '1993-02-19', 1 );

--INSERTAR DATOS TIPO CUENTAS
INSERT INTO Tipo_Cuenta(nombre)
VALUES ('Corriente');

INSERT INTO Tipo_Cuenta(nombre)
VALUES ('Ahorro');

--INSERTAR DATOS ESTADOS CUENTAS
INSERT INTO Estados_Cuenta(nombre)
VALUES ('Activa');

INSERT INTO Estados_Cuenta(nombre)
VALUES ('Cerrada');

--INSERTAR DATOS CUENTAS BANCARIAS
INSERT INTO Cuentas_Bancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, estado)
VALUES (1, 10987621, 2, 5500000, 1  );

INSERT INTO Cuentas_Bancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, estado)
VALUES (2, 11786521, 2, 1200000, 1  );

INSERT INTO Cuentas_Bancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, estado)
VALUES (3, 87654312, 1, 150000000, 1  );

INSERT INTO Cuentas_Bancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, estado)
VALUES (4, 5437688, 1, 10000, 2  );

----INSERTAR DATOS TIPOS TRANSACCIONES
INSERT INTO Tipo_Transaccion(nombre)
VALUES ('Depósito');

INSERT INTO Tipo_Transaccion(nombre)
VALUES ('Retiro');

INSERT INTO Tipo_Transaccion(nombre)
VALUES ('Transferencia');

--INSERTAR DATOS TRANSACCIONES
INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (1, 2, 300000, '2024-07-24 14:30:00', 'Retiro en cajero automático'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (2, 1, 150500, '2024-07-24 16:40:00', 'Depósito en sucursal'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (3, 3, 1000000, '2024-07-24 18:10:00', 'Transferencia vía app móvil'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (4, 3, 120000, '2024-07-24 20:30:00', 'Transferencia en sucursal física'  );

--INSERTAR DATOS POSICIONES EMPLEADOS
INSERT INTO Posiciones(nombre)
VALUES ('Gerente TI');

INSERT INTO Posiciones(nombre)
VALUES ('Asesor Financiero');

INSERT INTO Posiciones(nombre)
VALUES ('Cajero');

INSERT INTO Posiciones(nombre)
VALUES ('Gerente de Sucursal');

--INSERTAR DATOS SUCURSALES
INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Med

ellín', 'Calle 5 # 23-45', '3456781234'  );

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Bogotá', 'Carrera 6 # 34-56', '4567892345'  );

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Cali', 'Avenida 7 # 45-67', '5678903456'  );

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Cartagena', 'Diagonal 8 # 56-78', '6789014567'  );

--INSERTAR DATOS EMPLEADOS
INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Sofía', 'López', 'Calle 9 # 12-23', '7890123456', 'sofia.lopez@example.com', '2022-02-01 08:00:00', 1, 6000000, 1  );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Mateo', 'González', 'Carrera 10 # 23-34', '8901234567', 'mateo.gonzalez@example.com', '2022-03-15 09:00:00', 2, 3500000, 1  );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Valentina', 'Gómez', 'Avenida 11 # 34-45', '9012345678', 'valentina.gomez@example.com', '2022-04-20 10:00:00', 3, 2500000, 2  );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Gabriel', 'Pérez', 'Diagonal 12 # 45-56', '0123456789', 'gabriel.perez@example.com', '2022-05-25 11:00:00', 4, 5000000, 2  );

----INSERTAR DATOS TIPOS PRODUCTOS
INSERT INTO Tipo_Producto(nombre)
VALUES ('Tarjeta de crédito');

INSERT INTO Tipo_Producto(nombre)
VALUES ('Préstamo personal');

--INSERTAR DATOS PRODUCTOS FINANCIEROS
INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Tarjeta de Crédito Oro', 1, 'Tarjeta de crédito con beneficios exclusivos', 0.05000  );

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Préstamo Personal Premium', 2, 'Préstamo personal con tasas de interés preferenciales', 0.02000  );

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Tarjeta de Crédito Clásica', 1, 'Tarjeta de crédito con tasas competitivas', 0.03500  );

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Préstamo Personal Estándar', 2, 'Préstamo personal con tasas estándar del mercado', 0.04000  );

--INSERTAR DATOS ESTADOS PRESTAMOS
INSERT INTO Estados_Prestamo(nombre)
VALUES ('Pendiente');

INSERT INTO Estados_Prestamo(nombre)
VALUES ('Pagado');

INSERT INTO Estados_Prestamo(nombre)
VALUES ('Atrasado');

--INSERTAR DATOS PRESTAMOS
INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (1, 10000000, 0.05000, '2023-01-01', '2025-01-01', 1  );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (2, 5000000, 0.04000, '2022-06-15', '2024-06-15', 1  );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (3, 15000000, 0.03500, '2022-03-20', '2024-03-20', 1  );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (4, 8000000, 0.02000, '2021-10-10', '2023-10-10', 1  );

----INSERTAR DATOS ESTADOS TARJETAS
INSERT INTO Estados_Tarjeta(nombre)
VALUES ('Activa');

INSERT INTO Estados_Tarjeta(nombre)
VALUES ('Bloqueada');

--INSERTAR DATOS TARJETAS DE CREDITO
INSERT INTO Tarjetas_Credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (1, 1234567890123456, 5000000, 1000000, '2023-01-01', '2026-01-01', 1  );

INSERT INTO Tarjetas_Credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (2, 2345678901234567, 3000000, 500000, '2022-06-15', '2025-06-15', 1  );

INSERT INTO Tarjetas_Credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (3, 3456789012345678, 7000000, 2000000, '2022-03-20', '2025-03-20', 1  );

INSERT INTO Tarjetas_Credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (4, 4567890123456789, 4000000, 1000000, '2021-10-10', '2024-10-10', 2  );

--INSERTAR DATOS CLIENTES PRODUCTOS
INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (1, 1, '2022-01-01'  );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (2, 2, '2022-02-15'  );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (3, 3, '2022-03-10'  );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (4, 4, '2022-04-20'  );