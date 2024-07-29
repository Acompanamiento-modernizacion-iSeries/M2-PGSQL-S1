CREATE TABLE Clientes(
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20),
    correo_eletronico VARCHAR(200) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    estado VARCHAR (10) NOT NULL CHECK(estado IN('ACTIVO','INACTIVO'))
);

CREATE TABLE Cuentas(
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id  INT REFERENCES Clientes(cliente_id),    
    numero_cuenta VARCHAR(40) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(10) NOT NULL CHECK(tipo_cuenta IN('CORRIENTE', 'AHORRO'),
    saldo DECIMAL (15,2) ,
    fecha_apertura DATE NOT NULL,
    estado VARCHAR (10) NOT NULL CHECK(estado IN('ACTIVO','CERRADA'))
);

CREATE TABLE Transacciones(
    transaccion_id  SERIAL PRIMARY KEY, 
    cuenta_id INT REFERENCES Cuentas(Cuenta_id),
    tipo_transaccion VARCHAR (15) NOT NULL CHECK(tipo_transaccion IN('DEPOSITO','RETIRO', 'TRANSFERENCIA')),
    monto DECIMAL (15,2) NOT NULL,
    fecha_transaccion TIMESTAMP NOT NULL,    
    descripcion VARCHAR (500) NOT NULL
);

CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	telefono VARCHAR(20) NOT NULL
	
);


CREATE TABLE Empleados(
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	telefono VARCHAR(20),
	correo_eletronico VARCHAR(200) UNIQUE NOT NULL,
	fecha_contratacion TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP,
	cargo VARCHAR(50) NOT NULL,
	Salario DECIMAL (15,2) NOT NULL,
	Sucursal_id INT REFERENCES Sucursales(sucursal_id)
);




CREATE TABLE Productos_Financieros ( 
	producto_id SERIAL PRIMARY KEY, 
	nombre_producto VARCHAR(100) NOT NULL, 
	tipo_producto VARCHAR(50) NOT NULL CHECK (tipo_producto IN ('PRESTAMO', 'TARJETA DE CREDITO', 'SEGURO')),
	descripcion TEXT, 
	tasa_interes DECIMAL(5, 2) 
); 

CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY, 
	cuenta_id INT REFERENCES Cuentas(cuenta_id), 
	monto DECIMAL(15, 2) NOT NULL, 
	tasa_interes DECIMAL(5, 2) NOT NULL, 
	fecha_inicio DATE NOT NULL, 
	fecha_fin DATE NOT NULL, 
	estado VARCHAR(20) NOT NULL CHECK (estado IN ('ACTIVO', 'PAGADO'))
);  


CREATE TABLE Tarjetas_de_Credito ( 
	tarjeta_id SERIAL PRIMARY KEY, 
	cuenta_id INT REFERENCES Cuentas(cuenta_id),
	numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
           limite_credito DECIMAL(15, 2) NOT NULL, 
	saldo_actual DECIMAL(15, 2) NOT NULL DEFAULT 0.00, 
	fecha_emision DATE NOT NULL, 
	fecha_vencimiento DATE NOT NULL, 
	estado VARCHAR(20) NOT NULL CHECK (estado IN ('ACTIVA', 'BLOQUEADA'))
 );

CREATE TABLE Relacion_Clientes_Productos ( 
	cliente_id INT REFERENCES Clientes(cliente_id), 
	producto_id INT REFERENCES Productos_Financieros(producto_id), 
	fecha_adquisicion DATE NOT NULL
);


INSERT INTO clientes(nombre,apellido,direccion,telefono,correo_eletronico, fecha_nacimiento,estado)
VALUES('Nestor','Ferreira','calle 100','573228768790','nestor@gmail.com', '19900225', 'ACTIVO');

INSERT INTO clientes(nombre,apellido,direccion,telefono,correo_eletronico, fecha_nacimiento,estado)
VALUES('Cesar','Perez','carrera 35','3003984526','cesar14@gmail.com', '19820614', 'ACTIVO');

INSERT INTO clientes(nombre,apellido,direccion,telefono,correo_eletronico, fecha_nacimiento,estado)
VALUES('Ana','Garces','calle 85','3046125896','anagarces@gmail.com', '20011012', 'ACTIVO');

INSERT INTO clientes(nombre,apellido,direccion,telefono,correo_eletronico, fecha_nacimiento,estado)
VALUES('Camila','Cano','circular 2','3502124875','camicano2@gmail.com', '19950518', 'INACTIVO');

SELECT * FROM Clientes

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,fecha_apertura,estado)
VALUES('1','00642831509','CORRIENTE',3000000,'20190125','ACTIVO');

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,fecha_apertura,estado)
VALUES('1','00342831509','AHORRO',650000,'20160125','ACTIVO');

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,fecha_apertura,estado)
VALUES('2','60142831509','CORRIENTE',33650000,'19990125','ACTIVO');

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,fecha_apertura,estado)
VALUES('3','00442831508','AHORRO',2000,'20190125','ACTIVO');

INSERT INTO Cuentas(cliente_id,numero_cuenta,tipo_cuenta,saldo,fecha_apertura,estado)
VALUES('4','00642831502','AHORRO',0,'20190125','CERRADA');

SELECT * FROM Cuentas


INSERT INTO Transacciones(cuenta_id,tipo_transaccion, monto,fecha_transaccion,descripcion)
VALUES(1, 'DEPOSITO','2500000','20231011','Deposito para pago');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion, monto,fecha_transaccion,descripcion)
VALUES(1, 'TRANSFERENCIA','500000','20240111','Transferencia para pago');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion, monto,fecha_transaccion,descripcion)
VALUES(3, 'RETIRO','50000','20220226','Retiro para pago');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion, monto,fecha_transaccion,descripcion)
VALUES(4, 'DEPOSITO','11000000','20201011','Deposito para pago');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion, monto,fecha_transaccion,descripcion)
VALUES(5, 'RETIRO','6000000','20201211','Retiro para pago');

SELECT * FROM Transacciones


INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES('Puerta del rio', 'Calle 20', '3609002');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES('Pichincha', 'Carrera 53', '3609003');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES('Central', 'Calle 50', '3609004');

INSERT INTO Sucursales(nombre, direccion, telefono)
VALUES('Tesoro', 'Transversal 4', '3609005');

SELECT * FROM Sucursales


INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_eletronico, fecha_contratacion,cargo,salario,sucursal_id)
VALUES('Omar','Castro','calle 40a','3008259756','omarcas@gmail.com', '19901224', 'Comercial', 2800000, 1);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_eletronico, fecha_contratacion,cargo,salario,sucursal_id)
VALUES('Sara','Cortez','carrera 40a','3008258541','sariscortez@gmail.com', '20021224', 'Cajera', 2133456.657, 2);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_eletronico, fecha_contratacion,cargo,salario,sucursal_id)
VALUES('Fredy','Garcia','calle 33','3248259756','garciafredy@gmail.com', '19791224', 'Jefe', 3500000, 3);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,correo_eletronico, fecha_contratacion,cargo,salario,sucursal_id)
VALUES('Cristina','Ocampo','carrera 33c','3158259000','cristiocampo@gmail.com', '19981108', 'Comercial', 2800000, 4);

select * from empleados


INSERT INTO Productos_Financieros ( nombre_producto,tipo_producto,descripcion,tasa_interes)
VALUES('Leasing habitacional', 'PRESTAMO', 'Prestamo de vivienda por leasing habitacional', 14.2);

INSERT INTO Productos_Financieros ( nombre_producto,tipo_producto,descripcion,tasa_interes)
VALUES('Credito hipotecario', 'PRESTAMO', 'Prestamo de vivienda por credito hipotecario', 10.2);

INSERT INTO Productos_Financieros ( nombre_producto,tipo_producto,descripcion,tasa_interes)
VALUES('Tarjeta AMEX PLATINIUM', 'TARJETA DE CREDITO', 'Tarjeta de credito American Express Plata', 16.152);

INSERT INTO Productos_Financieros ( nombre_producto,tipo_producto,descripcion,tasa_interes)
VALUES('Seguro hogar', 'SEGURO', 'Seguros para el hogar todo riesgo', 8.62);

select * from Productos_Financieros


INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES(1, 2000000, 1.12, '20200228', '20250912', 'ACTIVO');

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES(3, 35000000, 1.65, '20180228', '20220912', 'PAGADO');

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES(4, 70000000, 0.78, '20001218', '20090912', 'PAGADO');

INSERT INTO Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES(5, 650000, 1.1, '20200528', '20240912', 'ACTIVO');


select * from Prestamos

INSERT INTO Tarjetas_de_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES(1, '12345', 15000000, 10000000, '20210314', '20271230', 'ACTIVA');

INSERT INTO Tarjetas_de_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES(3, '6789', 1000000, 1000000, '20190314', '20251230', 'ACTIVA');

INSERT INTO Tarjetas_de_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES(4, '101112', 5000000, 1500000, '20030314', '20070923', 'BLOQUEADA');

INSERT INTO Tarjetas_de_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES(5, '131415', 55000000, 30000000, '20210514', '20271230', 'ACTIVA');

select * from Tarjetas_de_credito

INSERT INTO Relacion_Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES(1, 2, '20210417');

INSERT INTO Relacion_Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES(2, 3, '20190417');

INSERT INTO Relacion_Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES(3, 2, '20230417');

INSERT INTO Relacion_Clientes_Productos(cliente_id, producto_id, fecha_adquisicion)
VALUES(1, 4, '20220617');

select * from Relacion_Clientes_Productos