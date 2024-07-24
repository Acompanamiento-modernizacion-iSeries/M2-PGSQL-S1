-- Database: sistema_bancario

CREATE DATABASE sistema_bancario
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create Table:

CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

CREATE TABLE Cuentas_Bancarias (
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta VARCHAR (50) UNIQUE NOT NULL,
	tipo_cuenta VARCHAR (10) NOT NULL CHECK (tipo_cuenta IN ('CORRIENTE', 'AHORRO')),
	saldo MONEY NOT NULL, 
	fecha_apertura TIMESTAMP NOT NULL,
	estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVA', 'CERRADA'))
);

CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	tipo_transaccion VARCHAR (20) NOT NULL CHECK (tipo_transaccion IN ('depósito', 'retiro', 'transferencia')),
	monto MONEY NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL,
	descripcion VARCHAR (50)
);

CREATE TABLE Sucursales (
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20)
);

CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_contratacion DATE NOT NULL,
	posicion VARCHAR (50) NOT NULL,
	salario MONEY NOT NULL,
	sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
);

CREATE TABLE Productos_Financieros (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (50) NOT NULL,
	tipo_producto VARCHAR (20) NOT NULL CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')),
	descripcion VARCHAR (50),
	tasa_interes NUMERIC NOT NULL
);

CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	monto MONEY NOT NULL,
	tasa_interes NUMERIC NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVO', 'PAGADO'))
);

CREATE TABLE Tarjetas_Credito (
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id) NOT NULL,
	numero_tarjeta VARCHAR (50) UNIQUE NOT NULL,
	limite_credito MONEY NOT NULL,
	saldo_actual MONEY NOT NULL,
	fecha_emision DATE NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	estado VARCHAR (10) NOT NULL CHECK (estado IN ('ACTIVA', 'BLOQUEADA'))
);

CREATE TABLE Relacion_Clientes_Productos (
	cliente_id INTEGER REFERENCES Clientes(cliente_id),
	producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
	fecha_adquisicion DATE NOT NULL,
	PRIMARY KEY (cliente_id,producto_id)
);

-- Insert Into

SELECT * FROM Clientes;

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,estado)
VALUES ('Katerine', 'Zuleta','CL 587 # 58 - 50','3258794','KateZuleta@gmail.com','19/07/1991','ACTIVO');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,estado)
VALUES ('Tatiana', 'Velez','CL 87 # 52 - 35','3250094','TatiVelez@gmail.com','12/05/1985','ACTIVO');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,estado)
VALUES ('Jaime', 'Castillo','CL 90A # 52B - 30','4250094','JaiCast@gmail.com','12/05/1988','INACTIVO');

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,estado)
VALUES ('Jorge', 'Hernandez','CL 36 Sur # 85D - 54','4250447','JorgeH@gmail.com','27/05/1980','ACTIVO');


SELECT * FROM Cuentas_Bancarias;

INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES ('1', '25418793587','AHORRO','5600000','24/07/2024','ACTIVA');

INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES ('2', '65847789500','CORRIENTE','3250500','24/07/2024','ACTIVA');

INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES ('3', '25478996640','AHORRO','2657','24/07/2024','CERRADA');

INSERT INTO Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES ('4', '36984455014','CORRIENTE','4900300','24/07/2024','ACTIVA');
	

SELECT * FROM Transacciones;

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES ('1','transferencia', '500000', '24/07/2024 14:20:00', 'pago factura');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion)
VALUES ('1','retiro', '200000', '24/07/2024 12:15:08');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES ('6','transferencia', '150000', '24/07/2024 08:20:30', 'pago factura');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion)
VALUES ('8','retiro', '100000', '24/07/2024 15:45:10');


SELECT * FROM Sucursales;

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('CC Arkadia','CR 48 # 39 -52', '2589936');

INSERT INTO Sucursales (nombre)
VALUES ('AV Guayabal');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('CC Arkadia','CR 48 # 39 -52', '2589936');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES ('CC Mayorca','CR 75 # 25A - 32', '5896714');


SELECT * FROM Empleados;

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id )
VALUES ('Catalina','Lopez', 'CR 55 # 25 - 88','5220014', 'cata123@gmail.com', '15/07/2021', 'caja', '3000000', '1');

INSERT INTO Empleados (nombre, apellido, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id )
VALUES ('Oscar','Restrepo', 'OscarR1@gmail.com', '10/01/2020', 'caja', '3000000', '3');

INSERT INTO Empleados (nombre, apellido, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id )
VALUES ('Carol','Bedoya', 'carolBe@gmail.com', '05/03/2020', 'caja', '3000000', '4');

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id )
VALUES ('Lina','Ramirez', 'CR 566 # 42 - 18','2561044', 'Linita@gmail.com', '25/09/2021', 'atencion al cliente', '3200000', '2');


SELECT * FROM Productos_Financieros;

INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, tasa_interes)
VALUES ('Visa','tarjeta de crédito','1.02');

INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, tasa_interes)
VALUES ('libre inversion','préstamo','0.99');

INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, tasa_interes)
VALUES ('MasterCard','tarjeta de crédito','1.18');

INSERT INTO Productos_Financieros (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES ('Seguro','seguro', 'seguro de vida', '1.14');


SELECT * FROM Prestamos;

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES ('1', '785200', '1.02', '25/07/2022', '25/07/2027','PAGADO');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES ('6', '1698000', '1.14', '10/05/2022', '10/05/2027','ACTIVO');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES ('7', '963400', '1.14', '01/08/2022', '01/08/2027','ACTIVO');

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES ('8', '612500', '0.99', '18/01/2022', '18/01/2027','PAGADO');


SELECT * FROM Tarjetas_Credito;

INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES ('1', '1254788966301455', '20000000','8000000', '01/01/2023','01/01/2026', 'ACTIVA');

INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES ('6', '3366024872658974', '15000000','5000000', '20/08/2023','01/01/2026', 'ACTIVA');

INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES ('7', '2255501003698833', '35000000','10000000', '01/07/2021','01/07/2024', 'BLOQUEADA');

INSERT INTO Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES ('8', '9874555147790365', '10000000','2000000', '11/06/2021','11/06/2025', 'ACTIVA');


SELECT * FROM Relacion_Clientes_Productos;

INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES ('1','2', '14/06/2024');

INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES ('1','3', '05/01/2020');

INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES ('4','2', '11/08/2021');

INSERT INTO Relacion_Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES ('3','3', '21/03/2022');
