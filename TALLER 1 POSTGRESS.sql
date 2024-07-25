CREATE TABLE Clientes(
	cliente_id SERIAL PRIMARY KEY,
	nombre Varchar(200) NOT NULL,
	apellido Varchar(200) NOT NULL,
    direccion Varchar(300),
	telefono Varchar(10) NOT NULL,
	correo_electronico Varchar(300) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	estado Varchar(10) NOT NULL  
	CHECK(estado IN('Activo','Inactivo'))
);

CREATE TABLE CuentasBancarias(
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta Varchar(100) UNIQUE NOT NULL,
	tipo_cuenta Varchar(10) NOT NULL  
	CHECK(tipo_cuenta IN('Corriente','Ahorro')),
 	saldo NUMERIC(19,2) NOT NULL,
    fecha_apertura DATE NOT NULL,
	estado Varchar(10) NOT NULL  
	CHECK(estado IN('Activa','Cerrada'))
);
		  
CREATE TABLE Transacciones(
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INT REFERENCES CuentasBancarias(cuenta_id) NOT NULL,
	tipo_transaccion Varchar(15) NOT NULL  
	CHECK(tipo_transaccion IN('Deposito','Retiro','transferencia')),
	monto NUMERIC(19,2) NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL,
	descripcion VARCHAR(300)
);


CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre Varchar(200) NOT NULL,
	direccion Varchar(200) NOT NULL,
	telefono Varchar(20) NOT NULL
	
);
CREATE TABLE Empleados(
	empleado_id SERIAL PRIMARY KEY,
	nombre Varchar(200) NOT NULL,
	apellido Varchar(200) NOT NULL,
	direccion Varchar(400),
	telefono Varchar(20),
	correo_electronico Varchar(20) NOT NULL,
	fecha_contratacion DATE NOT NULL,
	posicion Varchar(50) NOT NULL,
	salario NUMERIC(13,2) NOT NULL,
	sucursal_id INT REFERENCES Sucursales(sucursal_id) NOT NULL
	
);

CREATE TABLE ProductosFinancieros(
	producto_id SERIAL PRIMARY KEY,
	nombre_producto Varchar(100) NOT NULL,
	tipo_producto Varchar(100) NOT NULL,
	descripcion Varchar(200) NOT NULL,
	tasa_interes NUMERIC(10,6) NOT NULL
	
);
	
CREATE TABLE Prestamos(
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id  INT REFERENCES CuentasBancarias(cuenta_id ) NOT NULL,
	monto NUMERIC(19,2) NOT NULL,
	tasa_interes NUMERIC(10,6) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado Varchar(10) NOT NULL  
	CHECK(estado IN('Activo','Pagado'))
	
);
	
CREATE TABLE TarjetasdeCredito(
	tarjeta_id  SERIAL PRIMARY KEY,
	cuenta_id  INT REFERENCES CuentasBancarias(cuenta_id ) NOT NULL,
	numero_tarjeta VARCHAR(20) NOT NULL,
	limite_credito NUMERIC(19,2) NOT NULL,
	saldo_actual NUMERIC(19,2) NOT NULL,
	fecha_emision DATE NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	estado Varchar(10) NOT NULL  
	CHECK(estado IN('Activa','Bloqueada'))
);

CREATE TABLE ClientesProductos(
	cliente_id INT REFERENCES Clientes(cliente_id) NOT NULL,
	producto_id INT REFERENCES ProductosFinancieros(producto_id) NOT NULL,
	fecha_adquisicion DATE NOT NULL
	
);

INSERT INTO Clientes(nombre,apellido,telefono,correo_electronico,
fecha_nacimiento,estado)
VALUES('Juan','Zapata','215432124','juan@gmail.com',current_date,
'Activo');	

INSERT INTO Clientes(nombre,apellido,telefono,correo_electronico,
fecha_nacimiento,estado)
VALUES('Juan','Duque','32494353','duque@gmail.com',current_date,
'Activo');					

INSERT INTO Clientes(nombre,apellido,telefono,correo_electronico,
fecha_nacimiento,estado)
VALUES('Juan','Garcia','215432124','garcia@gmail.com',current_date,
'Activo');					

INSERT INTO Clientes(nombre,apellido,telefono,correo_electronico,
fecha_nacimiento,estado)
VALUES('Juan','Salazar','215432124','sala@gmail.com',current_date,
'Inactivo');

INSERT INTO CuentasBancarias(cliente_id,numero_cuenta,tipo_cuenta,
saldo,fecha_apertura,estado)
VALUES(1,'3541322342','Ahorro',15454212.23,current_date,'Activa');

INSERT INTO CuentasBancarias(cliente_id,numero_cuenta,tipo_cuenta,
saldo,fecha_apertura,estado)
VALUES(2,'8745612154','Ahorro',32146.23,current_date,'Activa');

INSERT INTO CuentasBancarias(cliente_id,numero_cuenta,tipo_cuenta,
saldo,fecha_apertura,estado)
VALUES(3,'456127982','Corriente',3159666.23,current_date,'Activa');

INSERT INTO CuentasBancarias(cliente_id,numero_cuenta,tipo_cuenta,
saldo,fecha_apertura,estado)
VALUES(4,'7541215400','Corriente',0.23,current_date,'Cerrada');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto,
fecha_transaccion,descripcion)
VALUES(1,'Deposito',354234.00,current_date,'Deposito Bajo Monto ALM');

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto,
fecha_transaccion)
VALUES(2,'Retiro',346178.00,current_date);

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto,
fecha_transaccion)
VALUES(3,'transferencia',154689.00,current_date);

INSERT INTO Transacciones(cuenta_id,tipo_transaccion,monto,
fecha_transaccion)
VALUES(4,'Deposito',8454.00,current_date);

INSERT INTO Sucursales(nombre,direccion,telefono)
VALUES('EL POBLADO','CALLE 10','3244222');

INSERT INTO Sucursales(nombre,direccion,telefono)
VALUES('BUENOS AIRES','CALLE 45','8421315');

INSERT INTO Sucursales(nombre,direccion,telefono)
VALUES('ENVIGADO','CALLE 48F SUR','2654568');

INSERT INTO Sucursales(nombre,direccion,telefono)
VALUES('EL RETIRO','PARUQE PRINCIPAL','984751');

INSERT INTO Empleados(nombre,apellido,direccion,telefono,
correo_electronico,fecha_contratacion,posicion,salario,sucursal_id)
VALUES('Juan','Zapata','Calle 100','3543545','jd@gmail.com',
current_date,'LIDER LINEA',545421.12,1);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,
correo_electronico,fecha_contratacion,posicion,salario,sucursal_id)
VALUES('Juan','Duque','Calle 200','3543545','d@gmail.com',
current_date,'LIDER AREA',32316.12,2);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,
correo_electronico,fecha_contratacion,posicion,salario,sucursal_id)
VALUES('Juan','Garcia','Calle 300','3543545','jd@gmail.com',
current_date,'LIDER EVC',745654.12,3);

INSERT INTO Empleados(nombre,apellido,direccion,telefono,
correo_electronico,fecha_contratacion,posicion,salario,sucursal_id)
VALUES('Juan','Zapata','Calle 400','3543545','jd@gmail.com',
current_date,'LIDER ENTORNO',956454.12,4);

INSERT INTO ProductosFinancieros(nombre_producto,tipo_producto,
descripcion,tasa_interes)
VALUES('Libranza','Credito','Libranza para empleados',5454.31224);

INSERT INTO ProductosFinancieros(nombre_producto,tipo_producto,
descripcion,tasa_interes)
VALUES('Master Card','Tarjeta','Libranza para empleados',6554.4567);

INSERT INTO ProductosFinancieros(nombre_producto,tipo_producto,
descripcion,tasa_interes)
VALUES('Sura','Seguro','Libranza para empleados',6545.21546);

INSERT INTO ProductosFinancieros(nombre_producto,tipo_producto,
descripcion,tasa_interes)
VALUES('VISA','Tarjeta','Libranza para empleados',6554.6487);


INSERT INTO Prestamos(cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,
estado)
VALUES(1,84651321.21,4785.2154,CURRENT_DATE,CURRENT_DATE + interval '1 year',
'Activo');

INSERT INTO Prestamos(cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,
estado)
VALUES(2,456782.21,4785.2154,CURRENT_DATE,CURRENT_DATE + interval '2 year',
'Activo');

INSERT INTO Prestamos(cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,
estado)
VALUES(3,145687.21,4785.2154,CURRENT_DATE,CURRENT_DATE + interval '3 year',
'Activo');

INSERT INTO Prestamos(cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,
estado)
VALUES(4,6554879.21,4785.2154,CURRENT_DATE,CURRENT_DATE + interval '4 year',
'Activo');

INSERT INTO TarjetasdeCredito(cuenta_id,numero_tarjeta,limite_credito,
saldo_actual,fecha_emision,fecha_vencimiento,estado) VALUES(
1,'5461254678964',999999999999,999999912.33,CURRENT_DATE,CURRENT_DATE + 
interval '4 year',
'Bloqueada');


INSERT INTO TarjetasdeCredito(cuenta_id,numero_tarjeta,limite_credito,
saldo_actual,fecha_emision,fecha_vencimiento,estado) VALUES(
2,'5461254678965',999999999999,8945454.33,CURRENT_DATE,CURRENT_DATE + 
interval '5 year',
'Bloqueada');

INSERT INTO TarjetasdeCredito(cuenta_id,numero_tarjeta,limite_credito,
saldo_actual,fecha_emision,fecha_vencimiento,estado) VALUES(
3,'5461254678966',999999999999,312545.33,CURRENT_DATE,CURRENT_DATE + 
interval '6 year',
'Bloqueada');

INSERT INTO TarjetasdeCredito(cuenta_id,numero_tarjeta,limite_credito,
saldo_actual,fecha_emision,fecha_vencimiento,estado) VALUES(
4,'5461254678967',999999999999,1248564.33,CURRENT_DATE,CURRENT_DATE + 
interval '7 year',
'Bloqueada');


INSERT INTO ClientesProductos(cliente_id,producto_id,fecha_adquisicion)
VALUES(1,1,CURRENT_DATE);

INSERT INTO ClientesProductos(cliente_id,producto_id,fecha_adquisicion)
VALUES(2,2,CURRENT_DATE);

INSERT INTO ClientesProductos(cliente_id,producto_id,fecha_adquisicion)
VALUES(3,3,CURRENT_DATE);

INSERT INTO ClientesProductos(cliente_id,producto_id,fecha_adquisicion)
VALUES(4,4,CURRENT_DATE);