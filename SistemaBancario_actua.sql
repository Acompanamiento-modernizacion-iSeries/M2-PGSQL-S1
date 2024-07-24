-- Tabla de clientes
create table Clientes (
cliente_id SERIAL PRIMARY KEY,
nombre VARCHAR(100) not null,
apellido VARCHAR (100) not null,
direccion VARCHAR (100) not null,
telefono varchar (20) not null,
correo_electronico VARCHAR (200) UNIQUE NOT NULL,
fecha_nacimiento date not null,
estado varchar (20) not null check (estado in ('activo', 'inactivo'))	
);

-- Cuentas Bancarias
create table Cuentas_Bancarias (
cuenta_id SERIAL PRIMARY KEY,
cliente_id INT REFERENCES Clientes (cliente_id)	NOT NULL,
numero_cuenta INT UNIQUE NOT NULL,
tipo_cuenta varchar (20) not null check (tipo_cuenta in ('corriente', 'ahorro')),
saldo numeric (15,2) not null,
fecha_apertura date not null,
estado varchar (20) not null check (estado in ('activa', 'cerrada'))
);

--- Transacciones
Create table Transacciones (
transaccion_id SERIAL PRIMARY KEY,
cuenta_id INT REFERENCES Cuentas_Bancarias (cuenta_id) NOT NULL,
tipo_transaccion varchar (20) not null check (tipo_transaccion in ('depósito', 'retiro', 
'transferencia')) ,
monto numeric (15,2) not null,
fecha_transaccion date not null,
descripcion VARCHAR (100) not null	
);

--Sucursales
create table Sucursales (
sucursal_id SERIAL PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
direccion VARCHAR (200) NOT NULL,
telefono varchar (20) not null	
);

--- Tabla Empleados
create table Empleados (
empleado_id SERIAL PRIMARY KEY,
nombre VARCHAR(100) not null,
apellido VARCHAR (100) not null,
direccion VARCHAR (100) not null,
telefono varchar (20) not null,
correo_electronico VARCHAR (200) UNIQUE NOT NULL,
fecha_contratacion date not null,
posicion varchar (100) not null,
salario numeric (15,2) not null,	
sucursal_id int REFERENCES Sucursales (sucursal_id) NOT NULL
);

-- TABLA Productos Financieros
CREATE TABLE Productos_Financieros (
producto_id SERIAL PRIMARY KEY,
nombre_producto VARCHAR (100) NOT NULL,
tipo_producto varchar (50) not null check (tipo_producto in ('préstamo', 'tarjeta de crédito', 
'seguro')),	
descripcion VARCHAR (200) NOT NULL,
tasa_interes numeric (5,4) not null
);


-- Préstamos
CREATE TABLE Préstamos (
prestamo_id SERIAL PRIMARY KEY,
cuenta_id int REFERENCES Cuentas_Bancarias (cuenta_id) NOT NULL,
monto numeric (15,2) not null,
tasa_interes numeric (5,4) not null,
fecha_inicio date not nulL,
fecha_fin date not nulL,
estado varchar (20) not null check (estado in ('activo', 'pagado'))	
);

-- Tarjetas de Crédito
Create table Tarjetas_Credito (
tarjeta_id SERIAL PRIMARY KEY,
cuenta_id int REFERENCES Cuentas_Bancarias (cuenta_id) NOT NULL,
numero_tarjeta int UNIQUE NOT NULL,
limite_credito numeric (15,2) not null,
saldo_actual numeric (15,2) not null,
fecha_emision date not null,
fecha_vencimiento date not null,
estado varchar (20) not null check (estado in ('activa', 'bloqueada'))	
);

-- tabla Clientes-Productos
create table Clientes_Productos (
cliente_id int REFERENCES Clientes (cliente_id) NOT NULL,
producto_id	int REFERENCES Productos_Financieros (producto_id) NOT NULl,
fecha_adquisicion date not null	,
primary key (cliente_id, producto_id)   	
);

insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,
					  estado) values ('Beatriz', 'Jimenez', 'Calle 44 Prado', 1233666, 'bjimenez_85@hotmail.com', '2000-01-05',  
														'activo');
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,
					  estado) values ('Martha', 'Grisales', 'Calle 45 Miraflores', 128978, 'mgrisales@hotmail.com', '1980-01-05',  
										'activo');
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,
					  estado) values ('Pedro', 'Montoya', 'Calle 70 - 89 Chapinero', 987896, 'pmontoya@gmail.com', '2010-10-01',  
										'activo');
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,
					  estado) values ('Adrian', 'Ramirez', 'Calle 89- 45 Bosques Verdes', 75634589, 'aramirez@gmail.com', '2010-10-01',  
										'inactivo');

insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento,
					  estado) values ('Aura', 'Arias', 'Calle 12 - 50 Poblado', 4575796, 'aarias@gmail.com', '1998-10-01',  
										'activo');
insert into Cuentas_Bancarias (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (2, 0010452889, 'corriente', 15000000, '2022-02-03', 'activa' );

insert into Cuentas_Bancarias (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (3, 00212895623, 'ahorro', 250000000, '2024-01-01', 'activa' );

insert into Cuentas_Bancarias (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (4, 01012895624, 'ahorro', 750000000, '1998-10-01', 'cerrada' );

insert into Cuentas_Bancarias (cliente_id , numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado )
values (5, 01712896624, 'ahorro', 950000000, '2023-12-01', 'activa' );

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (1, 'depósito', 500000, '2024-07-02', 'abono a pago de debito automatico');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (2, 'retiro', 10000000, '2024-06-28', 'pago de gastos');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (3, 'depósito', 20000000, '2024-07-06', 'pago de nómina');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (4, 'depósito', 30000000, '2024-07-07', 'pago de seguros');

insert into Transacciones  (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values (4, 'retiro', 130000000, '2024-07-08', 'pago de fiesta fin año');

insert into Sucursales (nombre , direccion, telefono) values ('Carabobo', 'Plaza de Botero', 45789639);
insert into Sucursales (nombre , direccion, telefono) values ('Poblado', 'Calle 10 29-59', 4569678);
insert into Sucursales (nombre , direccion, telefono) values ('Guayaquil', 'Calle 78 12-40', 45789123);
insert into Sucursales (nombre , direccion, telefono) values ('Salitre', 'Bogota parque de la 93', 789123);

insert into Empleados (nombre, apellido, direccion , telefono, correo_electronico, fecha_contratacion,
					  posicion , salario, sucursal_id) values 
					  ('Juan', 'Perez', 'Calle 11 -23-45', 4556565, 'jperez@gmail.com', '2020-07-08',
					   'Gerente',  4500000.00,  1);
					   
insert into Empleados (nombre, apellido, direccion , telefono, correo_electronico, fecha_contratacion,
					  posicion , salario, sucursal_id) values 
					  ('Juan', 'Montoya', 'Calle 12 -23-45', 14556565, 'jmontoya@hotmail.com', '2020-07-10',
					   'Adminsitrador',  14500000.00,  2);
					   
insert into Empleados (nombre, apellido, direccion , telefono, correo_electronico, fecha_contratacion,
					  posicion , salario, sucursal_id) values 
					  ('Alicia', 'Rua', 'Carrera 12 #23-46', 84556565, 'arua@hotmail.com', '2021-08-10',
					   'Auxiliar',  7800000.00,  4);
					   
insert into Empleados (nombre, apellido, direccion , telefono, correo_electronico, fecha_contratacion,
					  posicion , salario, sucursal_id) values 
					  ('Felix', 'Grille', 'Cra 12 #48-46', 236987, 'fgrille@gmail.com', '2022-10-10',
					   'Jefe operativo',  17800000.00,  1);

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('CDT', 'préstamo', 'Producto_Cartera', 5.8 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('LIBRANZA', 'seguro', 'Producto_Cartera', 6.8 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('Tarjeta_credito', 'tarjeta de crédito', 'Cartera', 4.0 );

insert into Productos_Financieros
(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('Credito_hipote', 'préstamo', 'Cartera', 4.3 );


insert into Préstamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (1, 250000000, 8.0, '2024-01-01', '2030-01-01', 'activo');

insert into Préstamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (3, 150000000, 8.3, '2022-01-01', '2030-01-01', 'pagado');

insert into Préstamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (2, 50000000, 2.3, '2021-01-01', '2025-01-01', 'activo');

insert into Préstamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
values (4, 350000000, 7.3, '2019-01-01', '2025-01-01', 'activo');

insert into Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, 530372961, 40000000.00, 1200000.00, '2019-01-01', '2025-01-01', 'activa');
 
 
 insert into Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, 430372961, 40000000.00, 2200000.00, '2019-01-01', '2025-01-01', 'bloqueada');
 
 insert into Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, 330372961, 20000000.00, 5200000.00, '2024-01-01', '2025-01-01', 'activa');
 
 insert into Tarjetas_Credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual , 
							 fecha_emision, fecha_vencimiento, estado)
 values (4, 530372967, 50000000.00, 2200000.00, '2024-01-01', '2025-01-01', 'activa');
 
 
 insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (2, 1, '2024-01-01');
 
 insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (2, 2, '2024-07-01');
 
 insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (3, 3, '2023-01-01');
 
 insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (4, 1, '2024-01-01');
 
  insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (4, 4, '2024-01-01');
 
 insert into Clientes_Productos (cliente_id, producto_id, fecha_adquisicion) 
 values (4, 3, '2024-01-01');
 
 




		
										