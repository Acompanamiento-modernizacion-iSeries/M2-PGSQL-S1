--TALLER 1: POSTGRESQL - AUTOR: William J. Sanchez G.

--Se crea primero tabla clientes

CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado CHAR (10) NOT NULL 
)

--Luego se crea tabla cuentas con la referencia del cliente_id

CREATE TABLE Cuentas (
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta VARCHAR (50) UNIQUE NOT NULL,
	tipo_cuenta VARCHAR (10) NOT NULL,
	saldo NUMERIC (15,2) NOT NULL,
	fecha_apertura DATE NOT NULL,
	estado VARCHAR (10) NOT NULL
)

--Luego se crea tabla transacciones con la referencia de cuentas_id

CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas(cuenta_id) NOT NULL,
	tipo_transaccion VARCHAR (20) NOT NULL,
	monto NUMERIC (15,2) NOT NULL,
	fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	descripcion VARCHAR (300) NOT NULL
)

--Luego se crea tabla sucursales para luego poder referenciar al empleado
CREATE TABLE Sucursales (
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (20) NOT NULL
)

--Luego se crea tabla Empleados con la referencia de sucursal_id

CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_contratacion DATE NOT NULL,
	posicion VARCHAR (50) NOT NULL,
	salario NUMERIC (15,2) NOT NULL,
 	sucursal_id INT REFERENCES Sucursales(sucursal_id) NOT NULL 
)

--Luego se crea tabla productos 

CREATE TABLE Productos (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (100) NOT NULL,
	tipo_producto VARCHAR (20) NOT NULL,
	descripcion VARCHAR (200) NOT NULL,
	tasa_interes NUMERIC (5,4) NOT NULL
)

--Luego se crea tabla prestamos con la referencia de la cuenta_id

CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas(cuenta_id) NOT NULL, 
	monto NUMERIC (15,2) NOT NULL,
	tasa_interes NUMERIC (5,4) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado VARCHAR (10) NOT NULL
)

--Luego se crea la tabla tarjetas credito con la referencia de la cuenta id

CREATE TABLE Tarjetacred (
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES Cuentas(cuenta_id) NOT NULL, 
	numero_tarjeta VARCHAR (19) UNIQUE NOT NULL,
	limite_credito NUMERIC (15,2) NOT NULL,
	saldo_actual NUMERIC (15,2) NOT NULL,
	fecha_emision DATE NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	estado VARCHAR (10) NOT NULL
)

-- Luego se crea la tabla relacion Clientes-Productos

CREATE TABLE Clienteproduc (
	cliente_id INT REFERENCES Clientes(cliente_id),
	producto_id INT REFERENCES Productos(producto_id),
	fecha_adquisicion DATE NOT NULL,
	PRIMARY KEY (cliente_id, producto_id)
)

-- Insert para tabla clientes

INSERT INTO Clientes(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_nacimiento,estado)
VALUES ('William', 'Sanchez', 'InAltezza', '32425555', 'william11@gmail.com',
	   '1995-03-07','activo')


INSERT INTO Clientes(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_nacimiento,estado)
VALUES ('Mayra', 'Gonzalez', 'Carrera 2 #49', '765425555', 'mayra11@gmail.com',
	   '1996-01-30','activo')


INSERT INTO Clientes(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_nacimiento,estado)
VALUES ('Julian', 'Quintero', 'Motavita', '7654625555', 'juldav@gmail.com',
	   '1998-07-30','inactivo')


INSERT INTO Clientes(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_nacimiento,estado)
VALUES ('Lina', 'Gonzalez', 'Las Quintas', '768764255', 'lingm@gmail.com',
	   '2000-05-13','activo')


--Insert para tabla cuentas bancarias

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,
					fecha_apertura,estado)
VALUES (1,'AB435466-456-355', 'Ahorro', 800000.00, 
	   '2004-05-13','activa')

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,
					fecha_apertura,estado)
VALUES (3,'CD456466-456-355', 'Corriente', 5000000.00, 
	   '2012-03-13','activa')

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,
					fecha_apertura,estado)
VALUES (2,'45646446-456-355', 'Ahorro', 000000.00, 
	   '2021-03-13','cerrada')

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,
					fecha_apertura,estado)
VALUES (4,'GF6-6446-456-355', 'Ahorro', 84000000.00, 
	   '2022-12-13','Activa')

--Insert para tabla transacciones 

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto
				   ,descripcion)
VALUES (4, 'depósito', 40000.00, 'Deposito en sucursal')

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto
				   ,descripcion)
VALUES (6, 'retiro', 500000.00, 'Retiro en cajero centro')
	   
INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto
				   ,descripcion)
VALUES (3, 'transferencia', 70000.00, 'Transferencia a Nequi')


 INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto
				   ,descripcion)
VALUES (6, 'depósito', 700000.00, 'Depósito por cajero multiservicios')


--Insert para tabla sucursales

 INSERT INTO Sucursales(nombre,direccion,telefono)
				   
VALUES ('Sucursal Centro', 'Carrera 10 #18','455464')

 INSERT INTO Sucursales(nombre,direccion,telefono)
				   
VALUES ('Sucursal Medellin', 'Carrera 3 #3','3455464')

INSERT INTO Sucursales(nombre,direccion,telefono)
				   
VALUES ('Sucursal Bogota', 'Carrera 13 #3','34555464')

 INSERT INTO Sucursales(nombre,direccion,telefono)
				   
VALUES ('Sucursal Cali', 'Carrera 1 #23','367555464')


--Insert para tabla empleados

 INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_contratacion,posicion,salario,sucursal_id)
VALUES ('William', 'Gamboa', 'Cali', '3223435555', 'william12@gmail.com',
	   '2022-03-07','Ing Software',5000000.00,4)
 
INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_contratacion,posicion,salario,sucursal_id)
VALUES ('Andres', 'Llinas', 'Bogota Calle 2', '3223345555', 'andres12@gmail.com',
	   '2022-03-07','Ing Software',5000000.00,4)
 
INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_contratacion,posicion,salario,sucursal_id)
VALUES ('Alberto', 'Contreras', 'Medellin Calle 3', '32345555', 'alberto32@gmail.com',
	   '2021-04-17','Analista',3000000.00,2)

INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_electronico,
					fecha_contratacion,posicion,salario,sucursal_id)
VALUES ('Daniel', 'Velandia', 'Bogota Calle 13', '34345555', 'daniel2@gmail.com',
	   '2023-06-17','Analista',2500000.00,3)


-- Insert para Productos Financieros

INSERT INTO Productos(nombre_producto,tipo_producto,descripcion,tasa_interes)
					  
VALUES ('prestamos bancolombia', 'préstamo', 'Prestamos del banco de colombia',
	   2.5525)
 
INSERT INTO Productos(nombre_producto,tipo_producto,descripcion,tasa_interes)
					  
VALUES ('seguros bancolombia', 'seguro', 'Seguros del banco de colombia',
	   1.5525)

INSERT INTO Productos(nombre_producto,tipo_producto,descripcion,tasa_interes)
					  
VALUES ('tarjetas de credito bancolombia', 'Tarjeta de Crédito', 'T.C del banco de colombia',
	   1.2425)

INSERT INTO Productos(nombre_producto,tipo_producto,descripcion,tasa_interes)
					  
VALUES ('prestamos davivienda', 'préstamo', 'prestamo del banco davivienda',
	   3.2425)

-- Insert para tablas tarjetas de credito

INSERT INTO Tarjetacred(cuenta_id,numero_tarjeta,limite_credito,
						saldo_actual,fecha_emision,fecha_vencimiento,estado) 
					  
VALUES (3, '1243-3435-3355-3553', 5000000.00, 2500000.00,'2022-04-13','2026-07-12','Activa'
	   )

INSERT INTO Tarjetacred(cuenta_id,numero_tarjeta,limite_credito,
						saldo_actual,fecha_emision,fecha_vencimiento,estado) 
					  
VALUES (5, '2345-4567-8900-3534', 4000000.00, 1500000.00,'2020-04-13','2027-07-12','Activa'
	   )

INSERT INTO Tarjetacred(cuenta_id,numero_tarjeta,limite_credito,
						saldo_actual,fecha_emision,fecha_vencimiento,estado) 
					  
VALUES (6, '1245-6767-8670-3674', 6000000.00, 3500000.00,'2019-09-13','2026-07-12','Activa'
	   )

INSERT INTO Tarjetacred(cuenta_id,numero_tarjeta,limite_credito,
						saldo_actual,fecha_emision,fecha_vencimiento,estado) 
					  
VALUES (5, '1285-3467-7870-1274', 7000000.00, 4500000.00,'2020-09-13','2027-07-12','Activa'
	   )


-- Insert para tabla Relación Clientes-Productos

INSERT INTO Clienteproduc(cliente_id,producto_id,fecha_adquisicion)					  
VALUES (2,3,'2020-09-13')

INSERT INTO Clienteproduc(cliente_id,producto_id,fecha_adquisicion)					  
VALUES (3,4,'2021-10-13')

INSERT INTO Clienteproduc(cliente_id,producto_id,fecha_adquisicion)					  
VALUES (4,2,'2022-10-13')

INSERT INTO Clienteproduc(cliente_id,producto_id,fecha_adquisicion)					  
VALUES (3,1,'2013-11-12')




