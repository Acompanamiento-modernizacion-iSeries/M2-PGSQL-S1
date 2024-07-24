create table Clientes (
cliente_id serial   primary key  , 
nombre varchar (50)    NOT NULL, 
apellido varchar (50)    NOT NULL, 
direccion varchar (100)    , 
telefono varchar (20)    , 
correo_electronico varchar (200)    UNIQUE NOT NULL, 
fecha_nacimiento date      , 
estado varchar (10)    NOT NULL check (estado IN('activo', 'inactivo') ) DEFAULT 'activo' 
)
;
create table Cuentas_Bancarias (
cuenta_id serial   primary key  , 
cliente_id int      REFERENCES Clientes(cliente_id) not null, 
numero_cuenta varchar (20)    UNIQUE NOT NULL, 
tipo_cuenta varchar (10)    NOT NULL check (tipo_cuenta IN('corriente', 'ahorro') ), 
saldo numeric (15, 2)    NOT NULL, 
fecha_apertura TIMESTAMP      DEFAULT CURRENT_TIMESTAMP, 
estado varchar (10)    NOT NULL check (estado IN('activo', 'cerrada') ) 
)
;
create table Transacciones (
transaccion_id serial   primary key  , 
cuenta_id int      REFERENCES Cuentas_Bancarias(cuenta_id) not null, 
tipo_transaccion varchar (15)    NOT NULL check (tipo_transaccion IN('depósito', 'retiro', 'transferencia') ), 
monto numeric (15, 2)    NOT NULL, 
fecha_transaccion TIMESTAMP      NOT NULL, 
descripcion varchar (200)    NOT NULL 
)
;
create table Sucursales (
sucursal_id serial   primary key  , 
nombre varchar (50)    NOT NULL, 
direccion varchar (100)    NOT NULL, 
telefono varchar (20)   
)
;
create table Empleados (
empleado_id serial   primary key  , 
nombre varchar (50)    NOT NULL, 
apellido varchar (50)    NOT NULL, 
direccion varchar (100)    , 
telefono varchar (20)    , 
correo_electronico varchar (200)    UNIQUE NOT NULL, 
fecha_contratacion date      NOT NULL, 
posicion varchar (20)    , 
salario numeric (15, 2)    NOT NULL, 
sucursal_id int      REFERENCES Sucursales(sucursal_id) not null
)
;



create table Productos_Financieros (
producto_id serial   primary key  , 
nombre_producto varchar (100)    NOT NULL, 
tipo_producto varchar (20)    NOT NULL check (tipo_producto IN('préstamo', 'tarjeta de crédito', 'seguro') ), 
descripcion varchar (200)    NOT NULL, 
tasa_interes numeric (7,5)    NOT NULL
)
;
create table Prestamos (
prestamo_id serial   primary key  , 
cuenta_id int      REFERENCES Cuentas_Bancarias(cuenta_id) not null, 
monto numeric (15,2)    NOT NULL, 
tasa_interes numeric (7,5)    NOT NULL, 
fecha_inicio date      NOT NULL, 
fecha_fin date      NOT NULL, 
estado varchar (10)       NOT NULL check (estado IN('activo', 'pagado') )
)
;
create table Tarjetas_de_Credito (
tarjeta_id serial   primary key  , 
cuenta_id int      REFERENCES Cuentas_Bancarias(cuenta_id) not null, 
numero_tarjeta numeric (17, 0)   UNIQUE NOT NULL, 
limite_credito numeric (15, 2)    NOT NULL, 
saldo_actual numeric (15, 2)    NOT NULL, 
fecha_emision date      NOT NULL, 
fecha_vencimiento date      NOT NULL, 
estado varchar      NOT NULL check (estado IN('activo', 'bloqueada') )
)
;
create table Relacion_Clientes_Productos (
cliente_id int      REFERENCES Clientes(cliente_id) not null, 
producto_id int      REFERENCES Productos_Financieros(producto_id) not null, 
fecha_adquisicion date      NOT NULL, 
 primary key  (cliente_id, producto_id)
)
;

insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento) values ('wbeimar', 'Lopera', 'cra 78 # 1090', '60435678','uno@gamil', '1974-06-08');
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento) values ('carmelo', 'zapata', 'cll 67 # 20', '604567909','dos@gamil', '1985-01-30' );
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento) values ('ana', 'jaramillo', 'cll 8 # 59', '604989789','tres@gamil', '1965-12-24' );
insert into Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento) values ('beatriz', 'CANO', 'cR1 17 # 76', '604345689','cuatro@gamil', '1990-04-12');

insert into Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) values (1, 4567,  'corriente', 154.89, '20240107','activo');
insert into Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) values (2, 78686, 'ahorro', 1234, '20240322','cerrada');
insert into Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) values (3, 7765,  'corriente', 7867, '20240517','activo');
insert into Cuentas_Bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) values (4, 890,   'ahorro', 987789, '20240208','activo');

insert into Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion,descripcion) values (1, 'depósito',1345,'2024-02-14','descrip1');
insert into Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion,descripcion) values (2, 'retiro', 3435,'2024-02-17', 'descrip2') ;
insert into Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion,descripcion) values (3, 'transferencia', 5657,'2024-05-24', 'descrip3');
insert into Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion,descripcion) values (4, 'depósito', 8763,'2024-06-11', 'descrip4');

insert into Sucursales (nombre, direccion, telefono) values ('centro Medellín','cra 34 #4545',604345699);
insert into Sucursales (nombre, direccion, telefono) values ('oriente Medellín','calle 12 #100',60439988);
insert into Sucursales (nombre, direccion, telefono) values ('sur Medellín','cra 3 #205',6044999888);
insert into Sucursales (nombre, direccion, telefono) values ('norte Medellín','calle 104 # 10',6043489898);


insert into Empleados (nombre,apellido,direccion,telefono,correo_electronico,fecha_contratacion,posicion,salario,sucursal_id) values ('PEDRO','GONZALES','cra 3 #45',604345699,'EMPLE1@GMAIL.COM', '20240201','JEFE', 5000000,1);
insert into Empleados (nombre,apellido,direccion,telefono,correo_electronico,fecha_contratacion,posicion,salario,sucursal_id) values ('CARLOTA','ZAPATA','calle 2 #160',60439988, 'EMPLE2@GMAIL.COM', '20240311', 'CAJERO',1000000,1);
insert into Empleados (nombre,apellido,direccion,telefono,correo_electronico,fecha_contratacion,posicion,salario,sucursal_id) values ('SUSANA','LOPEZ','cra 38 # 5',6044999888, 'EMPLE3@GMAIL.COM', '20240102', 'JEFE',5000000,3);
insert into Empleados (nombre,apellido,direccion,telefono,correo_electronico,fecha_contratacion,posicion,salario,sucursal_id) values ('EMILIO','JARAMILLO','calle 14 # 90',6043489898, 'EMPLE4@GMAIL.COM', '20240501','CAJERO',1000000,3);

insert into Productos_Financieros (nombre_producto,tipo_producto,descripcion,tasa_interes) values ('MASAHORRO','préstamo','MASUNO', 5.8);
insert into Productos_Financieros (nombre_producto,tipo_producto,descripcion,tasa_interes) values ('MENOSAHORRO','tarjeta de crédito', 'MINOSUNO',13.9);
insert into Productos_Financieros (nombre_producto,tipo_producto,descripcion,tasa_interes) values ('MASAHORRO2','préstamo', 'MASUNO2', 36.8989 );
insert into Productos_Financieros (nombre_producto,tipo_producto,descripcion,tasa_interes) values ('MASAHORRO3','seguro', 'MASUNO3', 2.6567);

insert into Prestamos (cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,estado) values (1,434.89, 34.678,'20240228', '20440228','activo');
insert into Prestamos (cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,estado) values (3,7675, 16.9887,'20240308', '20240308','pagado');
insert into Prestamos (cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,estado) values (1,1909,8.78,'20240508', '20250508','activo');
insert into Prestamos (cuenta_id,monto,tasa_interes,fecha_inicio,fecha_fin,estado) values (2,8765,6.67,'20240621', '20260621','activo');

insert into Tarjetas_de_Credito (cuenta_id,numero_tarjeta,limite_credito,saldo_actual,fecha_emision,fecha_vencimiento,estado) values (1,353434, 125000000,105000000,'20240621','20260621','activo');
insert into Tarjetas_de_Credito (cuenta_id,numero_tarjeta,limite_credito,saldo_actual,fecha_emision,fecha_vencimiento,estado) values (2,124112, 225000000,205000000,'20240621','20270621','bloqueada');
insert into Tarjetas_de_Credito (cuenta_id,numero_tarjeta,limite_credito,saldo_actual,fecha_emision,fecha_vencimiento,estado) values (3,232323, 325000000,305000000,'20240621','20280621','activo');
insert into Tarjetas_de_Credito (cuenta_id,numero_tarjeta,limite_credito,saldo_actual,fecha_emision,fecha_vencimiento,estado) values (4,555454, 450000000,405000000,'20240621','20290621','activo');

insert into Relacion_Clientes_Productos (cliente_id,producto_id,fecha_adquisicion) values (1,1,'20240111');
insert into Relacion_Clientes_Productos (cliente_id,producto_id,fecha_adquisicion) values (2,1,'20240315');
insert into Relacion_Clientes_Productos (cliente_id,producto_id,fecha_adquisicion) values (3,2,'20240412');
insert into Relacion_Clientes_Productos (cliente_id,producto_id,fecha_adquisicion) values (4,4,'20240301');


