----------------------------------------------------------------------
--TALLER 1
--SCRIPT CREADO POR: JUAN PABLO VALDERRAMA PELÁEZ
--BASE DE DATOS SISTEMA BANCARIO 
-----------------------------------------------------------------------
--CREACIÓN DE TABLAS 
-----------------------------------------------------------------------

----TABLA ESTADOS DEL CLIENTE:
CREATE TABLE Estados_Cliente(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA CLIENTES:
CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL, 
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado INT REFERENCES Estados_Cliente(estado_id) NOT NULL	
);

----TABLA TIPOS DE CUENTAS:
CREATE TABLE Tipo_Cuenta(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

----TABLA ESTADOS DE LA CUENTA:
CREATE TABLE Estados_Cuenta(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA CUENTAS BANCARIAS:
CREATE TABLE Cuentas_Bancarias (
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta INT UNIQUE NOT NULL,
	tipo_cuenta INT REFERENCES Tipo_Cuenta(tipo_id) NOT NULL,
	saldo NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
	fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	estado INT REFERENCES Estados_Cuenta(estado_id) NOT NULL
);

----TABLA TIPOS DE TRANSACCIONES:
CREATE TABLE Tipo_Transaccion(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA TRANSACCIONES:
CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	tipo_transaccion INT REFERENCES Tipo_Transaccion(tipo_id) NOT NULL,
	monto NUMERIC(15, 2) NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL,
	descripcion VARCHAR(200) NOT NULL
);

----TABLA POSICIONES DE LOS EMPLEADOS:
CREATE TABLE Posiciones(
	posicion_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

----TABLA SUCURSALES:
CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (20) NOT NULL
);

--TABLA EMPLEADOS:
CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL, 
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_contratacion TIMESTAMP NOT NULL,
	posicion INT REFERENCES Posiciones(posicion_id) NOT NULL,
	salario  NUMERIC(15, 2) NOT NULL,
	sucursal_id INT REFERENCES Sucursales(sucursal_id) NOT NULL
);

----TABLA TIPOS DE PRODUCTOS:
CREATE TABLE Tipo_Producto(
	tipo_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA PRODUCTOS FINANCIEROS:
CREATE TABLE Productos_Financieros (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (50) NOT NULL,
	tipo_producto INT REFERENCES Tipo_Producto(tipo_id) NOT NULL,
	descripcion VARCHAR (200) NOT NULL,
	tasa_interes NUMERIC(7, 5) NOT NULL
);

----TABLA ESTADOS DE LOS PRESTAMOS:
CREATE TABLE Estados_Prestamo(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA PRESTAMOS:
CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	monto NUMERIC(15, 2) NOT NULL, 
	tasa_interes NUMERIC(7, 5) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado INT REFERENCES Estados_Prestamo(estado_id) NOT NULL
);

----TABLA ESTADOS DE LAS TARJETAS:
CREATE TABLE Estados_Tarjeta(
	estado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL
);

--TABLA TARJETAS DE CREDITO:
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

--TABLA CLIENTES PRODUCTOS(MUCHOS A MUCHOS ENTRE CLIENTES Y PRODUCTOS):
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
VALUES ('Juan Pablo', 'Valderrama', 'Cra 59 # 70', '3104657711', 'jvalderr@gmail.com', '1992-12-09', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Daniela', 'De Leon', 'Calle 80 # 45-32', '3145678899', 'deleon@gmail.com', '1997-03-27', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Diana', 'Pelaez', 'Kra 43 ', '3206543311', 'dpelaez@gmail.com', '1961-08-09', 1 );

INSERT INTO Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES ('Samuel', 'Suaza', 'Calle 75 # 45-18', '3228765431', 'ssuaza@gmail.com', '1993-02-19', 1 );

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
VALUES (1, 2, 300000, '2024-07-24 14:30:00', 'Retiro en cajero electrónico Medellín'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (2, 1, 150500, '2024-07-24 16:40:00', 'Depósito en sucursal'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (3, 3, 1000000, '2024-07-24 18:10:00', 'Transacción desde app'  );

INSERT INTO Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES (4, 3, 120000, '2024-07-24 20:30:00', 'Transacción desde sucursal fisica'  );

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
VALUES ('Medellín', 'Carrera 50 # 89-98 piso 2', '4449876');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Cali', 'Centro comercial Santa Maria local 289', '5109876');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Bogotá', 'Kra 18 Tr 67-12', '5267655');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES ('Barranquilla', 'Calle 90 # 90-77 ', '3256788');

--INSERTAR DATOS EMPLEADOS
INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Wilmar', 'Franco', 'Calle 18 #89-90', '3239981616', 'wfranco@gmail.com', '2008-07-24 20:30:00', 1, 7800000, 2 );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Camila', 'Lopez', 'Calle 28 #60-44 piso 3', '3189876541', 'clopez@gmail.com', '2018-03-21 18:00:00', 2, 3500000, 1 );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Manuela', 'Castro', 'Kra 56 #78-22', '3145672211', 'mcastro@gmail.com', '2020-01-01 08:00:00', 3, 2800000, 3 );

INSERT INTO Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES ('Esteban', 'Cardona', 'Carrera 78 # 89-22', '3104368787', 'ecardona@gmail.com', '2004-07-01 10:30:00', 4, 6200000, 4 );

--INSERTAR DATOS TIPO PRODUCTOS
INSERT INTO Tipo_Producto(nombre)
VALUES ('Préstamo');

INSERT INTO Tipo_Producto(nombre)
VALUES ('Tarjeta de crédito');

INSERT INTO Tipo_Producto(nombre)
VALUES ('Seguro');

--INSERTAR DATOS PRODUCTOS FINANCIEROS
INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Crédito Ya', 1, 'Crédito de libre inversión y rápida aprobación', 2.5);

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Crédito Vehículo', 1, 'Crédito para que compres el vehículo de tus sueños', 1.8);

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Tarjeta de crédito viajero', 2, 'Tarjeta de crédito especial para viajeros frecuentes, acumula millas', 1.2);

INSERT INTO Productos_Financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Seguro todo riesgo', 3, 'Seguro todo riesgo cobertura 100%', 3.3);

--INSERTAR DATOS ESTADOS PRESTAMOS
INSERT INTO Estados_prestamo(nombre)
VALUES ('Activo');

INSERT INTO Estados_prestamo(nombre)
VALUES ('Pagado');

--INSERTAR DATOS PRESTAMOS
INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (1, 1000000, 2.5, '2024-07-01', '2028-07-01', 1 );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (2, 2500000, 2.3, '2022-06-01', '2029-06-01', 1 );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (3, 55000000, 3.5, '2015-02-01', '2022-02-01', 2 );

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES (4, 12200000, 1.5, '2002-05-15', '2012-05-15', 2 );

--INSERTAR DATOS ESTADOS TARJETAS
INSERT INTO Estados_Tarjeta(nombre)
VALUES ('Activa');

INSERT INTO Estados_Tarjeta(nombre)
VALUES ('Bloqueda');

--INSERTAR DATOS TARJETAS DE CREDITO
INSERT INTO Tarjetas_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (1, 55566221, 12000000, 2500000, '2022-01-01', '2028-01-01', 1  );

INSERT INTO Tarjetas_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (2, 55577712, 5000000, 4000000, '2021-06-01', '2030-06-01', 1  );

INSERT INTO Tarjetas_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (3, 55511121, 10000000, 0, '2012-02-01', '2020-02-01', 2  );

INSERT INTO Tarjetas_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES (4, 55599977, 3000000, 0, '2001-01-01', '2005-01-01', 2  );

--INSERTAR DATOS CLIENTES PRODUCTOS
INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (1, 2, '2022-12-09' );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (1, 4, '2022-12-20' );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (2, 1, '2018-11-01' );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (3, 2, '2015-01-09' );

INSERT INTO Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES (4, 3, '2020-12-12' );

-----------------------------------------------------------------------
--CONSULTAR DATOS CREADOS
-----------------------------------------------------------------------
SELECT * FROM Estados_Cliente;
SELECT * FROM Clientes;
SELECT * FROM Tipo_Cuenta;
SELECT * FROM Estados_Cuenta;
SELECT * FROM Cuentas_Bancarias;
SELECT * FROM Tipo_Transaccion;
SELECT * FROM Transacciones;
SELECT * FROM Posiciones;
SELECT * FROM Sucursales;
SELECT * FROM Empleados;
SELECT * FROM Tipo_Producto;
SELECT * FROM Productos_Financieros;
SELECT * FROM Estados_Prestamo;
SELECT * FROM Prestamos;
SELECT * FROM Estados_Tarjeta;
SELECT * FROM Tarjetas_Credito;
SELECT * FROM Clientes_Productos;
