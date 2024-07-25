-- CREACION BASE DATOS
CREATE DATABASE "SysBank"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE "SysBank"
    IS 'sistema bancario - taller postgreSQL  JMSL';
-- CREACION TABLAS 

create table Clientes (
 cliente_id SERIAL PRIMARY KEY,
 nombre VARCHAR (50) NOT NULL,
 apellido VARCHAR (50) NOT NULL, 
 direccion VARCHAR (100) , 
 telefono VARCHAR (20) ,	
 correo_electronico varchar(200) UNIQUE NOT NULL, 
 fecha_nacimiento DATE not null  ,
 estado varchar(20) check (estado  in ('ACTIVO','INACTIVO'))
);
create table Cuenta_bancaria (
	cuenta_id serial primary key ,
	cliente_id int references Clientes(cliente_id ) not null,
	numero_cuenta varchar(50) unique not null,
	tipo_cuenta varchar(50) check (tipo_cuenta in ('AHORROS','CORRIENTE')) not null,
	saldo money not null ,
	fecha_apertura  date not null , 
	estado varchar(20) check(estado in ('ACTIVA','CERRADA')) not null
);

create table Transacciones (
	transaccion_id serial primary key ,
	cuenta_id int  references Cuenta_bancaria(cuenta_id) not null,
	tipo_transaccion varchar(50) check(tipo_transaccion in ('Depósito','Retiro','Transferencia')) not null,
	monto money not null ,
	fecha_transaccion timestamp not null ,
	descripcion varchar(250) not null 
);

create table Sucursales (
	sucursal_id serial primary key ,
	nombre varchar(100) not null, 
	direccion varchar(200) ,
	telefono VARCHAR (20) 	
);

Create table Empleados (
 empleado_id SERIAL PRIMARY KEY,
 nombre VARCHAR (50) NOT NULL,
 apellido VARCHAR (50) NOT NULL, 
 direccion VARCHAR (100) , 
 telefono VARCHAR (20) ,	
 correo_electronico varchar(200) UNIQUE NOT NULL, 
 fecha_contratacion TIMESTAMP not null  ,
 posicion varchar(100)  , 
 salario money not null ,
 sucursal_id int references Sucursales(sucursal_id) not null 
);

Create table Productos_financieros (
	producto_id serial primary key ,
	nombre_producto varchar(100) not null, 
	tipo_producto varchar(50) not null check(tipo_producTo in ('Préstamo','Tarjeta de credito','Seguro')),
	descripcion varchar(200) not null,
	tasa_interes numeric(8,4) not null
);

create table Prestamos(
	prestamo_id serial primary key,
	cuenta_id int references Cuenta_bancaria(cuenta_id) not null, 
	monto money not null, 
	tasa_interes numeric(8,4) not null,
	fecha_inicio timestamp not null,
	fecha_fin timestamp not null,
	estado varchar check(estado in ('ACTIVO','PAGADO')) not null
);

create table Tarjeta_credito(
	tarjeta_id serial primary key ,
	cuenta_id int references Cuenta_bancaria(cuenta_id) not null, 
	numero_tarjeta varchar(30) unique not null ,  
	limite_credito money NOT NULL, 
	saldos_actual  money NOT NULL , 
	fecha_emision date  not null,
	fecha_vencimiento date  not null,
	estado varchar(20) not null check (estado in ('Activa', 'Bloqueda' ))
);

Create table Cliente_producto(
	cliente_id int references Clientes(cliente_id) not null,
	producto_id int references Productos_financieros(producto_id) not null,
	fecha_adquisicion date not null 
);
-- CREACION DATOS TABLAS

insert into clientes( nombre, apellido , direccion, telefono, correo_electronico , fecha_nacimiento , estado)
values('Karen', 'Valencia', 'carrera 4 con 1', 42522002 , 'Kavalen@gmail.com', '1999-10-02', 'ACTIVO' );

insert into clientes( nombre, apellido , direccion, telefono, correo_electronico , fecha_nacimiento , estado)
values('Mauricio', 'Sosa lopez', 'calle 1 con otro', 5252222 , 'jlopez9@gmail.com', '1983-09-28', 'ACTIVO' );

insert into clientes( nombre, apellido , direccion, telefono, correo_electronico , fecha_nacimiento , estado)
values('Fernando ', 'Perez A.', 'Avenida  1 de mayo', 3222444 , 'FerPer2@gmail.com', '2001-01-28', 'ACTIVO' );

insert into clientes( nombre, apellido , direccion, telefono, correo_electronico , fecha_nacimiento , estado)
values('Natalia ', 'Tejada Uribe', 'Diagonal 22 # 10', 7235154 , 'NataUri22@gmail.com', '2005-03-15', 'ACTIVO' );



insert into Sucursales( nombre, direccion , telefono)
values('Principal - Medellín  ', 'Calle 9a 23' , 5251210 ) ;


insert into Sucursales( nombre, direccion , telefono)
values('Ciudad central - Medellín ', 'Av 23 # 9' , 5251211 ) ;

insert into Sucursales( nombre, direccion , telefono)
values('Bogota ', 'Calle 59 # 10-23' , 5251212 ) ;

insert into Sucursales( nombre, direccion , telefono)
values('Cali ', 'Carrera 7 - 9a 213' , 5251213 ) ;

insert into Sucursales( nombre, direccion , telefono)
values('Barranquillla', 'Av Colombia - 15 -04' , 5251214 ) ;


insert into Empleados( nombre, apellido , direccion, telefono, correo_electronico , fecha_contratacion , posicion , salario , sucursal_id)
values('Carolina' , 'Urrego ', 'carrera 4 con 22', 42520011 , 'CaroUR11@gmail.com', '2020-01-15', 'Gerente Comercial' , 5000000 , 3 );

insert into Empleados( nombre, apellido , direccion, telefono, correo_electronico , fecha_contratacion , posicion , salario,  sucursal_id)
values('EUgenio ' , 'Rivera S.', 'Diagonal 22 #15-10', 42520012 , 'EUGERIVE@gmail.com', '2015-03-10', 'Director Administrativo' , 8000000 , 1 );
  
insert into Empleados( nombre, apellido , direccion, telefono, correo_electronico , fecha_contratacion , posicion , salario,  sucursal_id)
values('Valentina ' , 'Acosta Perez ' , 'Calle 12 -25 -89', 42520013 , 'ValeAperez@gmail.com', '2015-03-10', 'Analista de credito' , 3000000 , 1 );

insert into Empleados( nombre, apellido , direccion, telefono, correo_electronico , fecha_contratacion , posicion , salario,  sucursal_id)
values('Carlos ' , 'Valderrama ' , 'Calle 12 -25 -89', 42520014 , 'ValderramaC1gmail.com', '2019-04-01', 'Cajero ' , 3000000 , 5 );

insert into Empleados( nombre, apellido , direccion, telefono, correo_electronico , fecha_contratacion , posicion , salario,  sucursal_id)
values('Beatriz ' , 'Camargo Rios ' , 'Calle 86 -15 -13', 42520015 , 'beaCamargo@gmail.com', '2020-09-17', 'Gerente sucursal ' , 4000000 , 4 );



insert into Cuenta_Bancaria (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (1, 0010452889, 'AHORROS', 15000000, '2022-02-03', 'ACTIVA' );

insert into Cuenta_Bancaria (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (2, 0110452889, 'CORRIENTE', 15000000, '2022-02-03', 'ACTIVA' );

insert into Cuenta_Bancaria (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (3, 00212895623, 'AHORROS', 2121321, '2024-01-01', 'ACTIVA' );

insert into Cuenta_Bancaria (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (5, 01012895624, 'AHORROS', 0 , '1998-10-01', 'CERRADA' );

insert into Cuenta_Bancaria (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (1, 01712896624, 'CORRIENTE', 9500000, '2023-12-01', 'ACTIVA' );



insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('TARJETA DE CREDITO', 'Tarjeta de credito', 'Tarjeta de credito dorada', 11.5 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('CREDITO VEHICULO', 'Préstamo', 'Cartera comercial de consumo ', 4.3 );

insert into Productos_financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('CREDITO HIPOTECARIO', 'Préstamo', 'Cartera hipotecaria ', 7.3 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('SEGURO DE VIDA', 'Seguro', 'Seguro de vida por un años todo riesgo', 1.125 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('SEGURO DE VEHICULO', 'Seguro', 'Seguro vehiculo por un años cobertura al 85%', 0.125 );


insert into Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (1, 250000000, 8.025, '2024-01-01', '2030-01-01', 'ACTIVO');

insert into Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (3, 150000000, 8.500, '2022-01-01', '2030-01-01', 'PAGADO');

insert into Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (7, 50000000, 2.3, '2021-01-01', '2025-01-01', 'ACTIVO');

insert into Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (4, 350000000, 7.3, '2019-01-01', '2025-01-01', 'ACTIVO');



insert into Tarjeta_Credito (cuenta_id, numero_tarjeta, limite_credito, saldos_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, '430372961' , 40000000.00, 2200000.00, '2019-01-01', '2025-01-01', 'Bloqueda');
 
 insert into Tarjeta_Credito (cuenta_id, numero_tarjeta, limite_credito, saldos_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, '200330372961', 20000000.00, 5200000.00, '2024-01-01', '2025-01-01', 'Activa');
 
 insert into Tarjeta_Credito (cuenta_id, numero_tarjeta, limite_credito, saldos_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (6, '220372967099', 50000000.00, 2222.00, '2024-01-01', '2025-01-01', 'Bloqueda');
 
 insert into Tarjeta_Credito (cuenta_id, numero_tarjeta, limite_credito, saldos_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (7, '530372967099', 50000000.00, 2200000.00, '2024-01-01', '2025-01-01', 'Activa');
 

  insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (2, 1, '2024-01-01');
 
 insert into Cliente_Producto (cliente_id, producto_id, fecha_adquisicion) 
 values (3, 3, '2024-07-01');
 
 insert into Cliente_Producto (cliente_id, producto_id, fecha_adquisicion) 
 values (1, 1, '2023-01-01');
 
 insert into Cliente_Producto (cliente_id, producto_id, fecha_adquisicion) 
 values (3, 4, '2024-01-01');
 
  insert into Cliente_Producto (cliente_id, producto_id, fecha_adquisicion) 
 values (5, 4, '2024-01-01');
 
 insert into Cliente_Producto (cliente_id, producto_id, fecha_adquisicion) 
 values (1, 5, '2024-01-01');


insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (1, 'Depósito', 500000, '2024-07-02', 'Consignación en sucursal 1 ');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (4, 'Transferencia', 100000, '2024-06-28', 'Pago restaurate el gasto diario');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (1, 'Retiro', 12522, '2024-07-03', 'Retiro cajero electronico 2661 ');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (4, 'Depósito', 2000000, '2024-07-06', 'pago de nómina');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (3, 'Retiro', 300000, '2024-07-07', 'pago de seguros');


