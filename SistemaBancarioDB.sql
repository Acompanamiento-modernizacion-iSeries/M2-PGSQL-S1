-- Sistema Bancario
-- Base de datos para un sistema bancario con las siguientes tablas:
-- Clientes: Informacion de los clientes del banco
-- CuentasBancarias: Informacion de las cuentas bancarias
-- Transacciones: Informacion de las transacciones realizadas
-- Empleados: Informacion de los empleados del banco
-- Sucursales: Informacion de las sucursales del banco
-- ProductosFinancieros: Informacion de los productos financieros
-- Prestamos: Informacion de los prestamos
-- TarjetasCredito: Informacion de las tarjetas de credito
-- ClientesProductos: Relacion entre clientes y productos financieros
-- ClientesTarjetas: Relacion entre clientes y tarjetas de credito
-- ClientesPrestamos: Relacion entre clientes y prestamos
-- ClientesCuentas: Relacion entre clientes y cuentas bancarias
-- ClientesTransacciones: Relacion entre clientes y transacciones

-- Borramos la base de datos si existe
drop database if exists sistema_bancario;

-- Eliminacion de tablas en cascada
drop table if exists ClientesTransacciones;
drop table if exists ClientesCuentas;
drop table if exists ClientesPrestamos;
drop table if exists ClientesTarjetas;
drop table if exists ClientesProductos;
drop table if exists TarjetasCredito;
drop table if exists Prestamos;
drop table if exists ProductosFinancieros;
drop table if exists Sucursales;
drop table if exists Empleados;
drop table if exists Transacciones;
drop table if exists CuentasBancarias;
drop table if exists Clientes;

create table Clientes(
    cliente_id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(100),
    telefono varchar(20),
    correo_electronico varchar(200) unique not null,
    fecha_nacimiento date not null,
    estado varchar(10) not null check (estado in ('activo', 'inactivo'))
);

create table CuentasBancarias(
    cuenta_id serial primary key,
    cliente_id int references Clientes(cliente_id) not null,
    numero_cuenta varchar(20) unique not null,
    tipo_cuenta varchar(10) not null check (tipo_cuenta in ('corriente', 'ahorro')),
    saldo numeric(10, 2) not null check (saldo >= 0),
    fecha_apertura date not null,
    estado varchar(10) not null check (estado in ('activa', 'cerrada'))
);

create table Transacciones(
    transaccion_id serial primary key,
    cuenta_id int references CuentasBancarias(cuenta_id) not null,
    tipo_transaccion varchar(15) not null check (tipo_transaccion in ('deposito', 'retiro', 'transferencia')),
    monto numeric(10, 2) not null check (monto > 0),
    fecha_transaccion timestamp not null,
    descripcion varchar(200)
);

create table Empleados(
    empleado_id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(100),
    telefono varchar(20),
    correo_electronico varchar(200) unique not null,
    fecha_contratacion timestamp not null,
    posicion varchar(50) not null,
    salario numeric(10, 2) not null check (salario > 0),
    sucursal_id int references Sucursales(sucursal_id) not null
);

create table Sucursales(
    sucursal_id serial primary key,
    nombre varchar(100) not null,
    direccion varchar(100) not null,
    telefono varchar(20) not null
);

create table ProductosFinancieros(
    producto_id serial primary key,
    nombre_producto varchar(100) not null,
    tipo_producto varchar(50) not null check (tipo_producto in ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion varchar(200) not null,
    tasa_interes numeric(5, 2) not null check (tasa_interes > 0)
);

create table Prestamos(
    prestamo_id serial primary key,
    cuenta_id int references CuentasBancarias(cuenta_id) not null,
    monto numeric(10, 2) not null check (monto > 0),
    tasa_interes numeric(5, 2) not null check (tasa_interes > 0),
    fecha_inicio date not null,
    fecha_fin date not null,
    estado varchar(10) not null check (estado in ('activo', 'pagado'))
);

create table TarjetasCredito(
    tarjeta_id serial primary key,
    cuenta_id int references CuentasBancarias(cuenta_id) not null,
    numero_tarjeta varchar(20) unique not null,
    limite_credito numeric(10, 2) not null check (limite_credito > 0),
    saldo_actual numeric(10, 2) not null check (saldo_actual >= 0),
    fecha_emision date not null,
    fecha_vencimiento date not null,
    estado varchar(10) not null check (estado in ('activa', 'bloqueada'))
);

create table ClientesProductos(
    cliente_id int references Clientes(cliente_id) not null,
    producto_id int references ProductosFinancieros(producto_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, producto_id)
);

create table ClientesTarjetas(
    cliente_id int references Clientes(cliente_id) not null,
    tarjeta_id int references TarjetasCredito(tarjeta_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, tarjeta_id)
);

create table ClientesPrestamos(
    cliente_id int references Clientes(cliente_id) not null,
    prestamo_id int references Prestamos(prestamo_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, prestamo_id)
);

create table ClientesCuentas(
    cliente_id int references Clientes(cliente_id) not null,
    cuenta_id int references CuentasBancarias(cuenta_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, cuenta_id)
);

create table ClientesTransacciones(
    cliente_id int references Clientes(cliente_id) not null,
    transaccion int references Transacciones(transaccion_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, transaccion_id)
);

-- insertar datos de prueba pero tener en cuenta para la informacion de personas, los personajes de Dragon Ball Z
insert into Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) values
('Goku', 'Son', 'Kame House', '123456789', 'elverdaderosupersayain@dgbz.com' , '1984-04-16', 'activo'),
('Vegeta', 'Prince', 'Planeta Vegeta', '987654321', 'todossonbichos@dgbz.com', '1984-12-03', 'activo'),
('Gohan', 'Son', 'Kame House', '123456789', 'amorypaz@dgbz.com', '1990-05-18', 'activo'),
('Trunks', 'Brief', 'Capsule Corp', '987654321', 'solocalle@dgbz.com', '1993-05-12', 'activo'),
('Goten', 'Son', 'Kame House', '123456789', 'memiman@dgbz.com', '1994-03-12', 'activo'),
('Piccolo', '', 'Namek', '987654321', 'sabiduria@dgbz.com', '1984-04-16', 'activo'),
('Krillin', '', 'Kame House', '123456789', 'nomedejenmorir@dgbz.com', '1984-04-16', 'activo'),
('Yamcha', '', 'Desierto', '987654321', 'dejadodelado@dgbz.com', '1984-04-16', 'activo'),
('Tenshinhan', '', 'Kame House', '123456789', 'venciagoku@dgbz.com', '1984-04-16', 'activo'),
('Chaoz', '', 'Kame House', '987654321', 'littlebaby@dgbz.com', '1984-04-16', 'activo'),
('Bulma', 'Brief', 'Capsule Corp', '123456789', 'todosquierenconmigo@dgbz.com', '1984-04-16', 'activo');

insert into CuentasBancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) values
(1, '1234567890', 'corriente', 1000.00, '2020-01-01', 'activa'),
(2, '2345678901', 'ahorro', 500.00, '2020-01-01', 'activa'),
(3, '3456789012', 'corriente', 2000.00, '2020-01-01', 'activa'),
(4, '4567890123', 'ahorro', 1500.00, '2020-01-01', 'activa'),
(5, '5678901234', 'corriente', 3000.00, '2020-01-01', 'activa'),
(6, '6789012345', 'ahorro', 2500.00, '2020-01-01', 'activa'),
(7, '7890123456', 'corriente', 4000.00, '2020-01-01', 'activa'),
(8, '8901234567', 'ahorro', 3500.00, '2020-01-01', 'activa'),
(9, '9012345678', 'corriente', 5000.00, '2020-01-01', 'activa'),
(10, '0123456789', 'ahorro', 4500.00, '2020-01-01', 'activa');

insert into Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion) values
(1, 'deposito', 1000.00, '2020-01-01 12:00', 'Deposito inicial'),
(2, 'deposito', 500.00, '2020-01-01 12:00', 'Deposito inicial'),
(3, 'deposito', 2000.00, '2020-01-01 12:00', 'Deposito inicial'),
(4, 'deposito', 1500.00, '2020-01-01 12:00', 'Deposito inicial'),
(5, 'deposito', 3000.00, '2020-01-01 12:00', 'Deposito inicial'),
(6, 'deposito', 2500.00, '2020-01-01 12:00', 'Deposito inicial'),
(7, 'deposito', 4000.00, '2020-01-01 12:00', 'Deposito inicial'),
(8, 'deposito', 3500.00, '2020-01-01 12:00', 'Deposito inicial'),
(9, 'deposito', 5000.00, '2020-01-01 12:00', 'Deposito inicial'),
(10, 'deposito', 4500.00, '2020-01-01 12:00', 'Deposito inicial');

-- en empleados vamos a agregar personajes secundarios de dgbz y los correos se formaran asi: empleado1@secundario.com, empleado2@secundario.com ...ABORT
insert into Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) values
('Mr', 'Popo', 'Kame House', '123456789', 'empleado1@secundario.com' , '1984-04-16', 'Cuidador', 1000.00, 1),
('Oolong', '', 'Kame House', '123456789', 'empleado2@secundario.com' , '1984-04-16', 'Cocinero', 1000.00, 1),
('Puar', '', 'Kame House', '123456789', 'empleado3@secundario.com' , '1984-04-16', 'Asistente', 1000.00, 1),
('Yajirobe', '', 'Kame House', '123456789', 'empleado4@secundario.com' , '1984-04-16', 'Cuidador', 1000.00, 1),
('Korin', '', 'Kame House', '123456789', 'empleado5@secundario.com' , '1984-04-16', 'Cuidador', 1000.00, 1),
('Rey', 'Kai', 'Planeta Kaio', '123456789', 'empleado6@secundario.com' , '1984-04-16', 'Entrenador', 1000.00, 2),
('Kaiosama', '', 'Planeta Kaio', '123456789', 'empleado7@secundario.com' , '1984-04-16', 'Entrenador', 1000.00, 2);

insert into Sucursales(nombre, direccion, telefono) values
('Kame House', 'Isla Tortuga', '123456789'),
('Planeta Kaio', 'Planeta Kaio', '123456789');

insert into ProductosFinancieros(nombre_producto, tipo_producto, descripcion, tasa_interes) values
('Prestamo Personal', 'prestamo', 'Prestamo personal para cualquier necesidad', 10.00),
('Tarjeta de Credito', 'tarjeta de credito', 'Tarjeta de credito para compras', 15.00),
('Seguro de Vida', 'seguro', 'Seguro de vida para proteccion', 5.00);

insert into Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) values
(1, 1000.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(2, 500.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(3, 2000.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(4, 1500.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(5, 3000.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(6, 2500.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(7, 4000.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(8, 3500.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(9, 5000.00, 10.00, '2020-01-01', '2021-01-01', 'activo'),
(10, 4500.00, 10.00, '2020-01-01', '2021-01-01', 'activo');

insert into TarjetasCredito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) values
(1, '1234567890123456', 1000.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(2, '2345678901234567', 500.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(3, '3456789012345678', 2000.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(4, '4567890123456789', 1500.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(5, '5678901234567890', 3000.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(6, '6789012345678901', 2500.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(7, '7890123456789012', 4000.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(8, '8901234567890123', 3500.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(9, '9012345678901234', 5000.00, 0.00, '2020-01-01', '2021-01-01', 'activa'),
(10, '0123456789012345', 4500.00, 0.00, '2020-01-01', '2021-01-01', 'activa');

insert into ClientesProductos(cliente_id, producto_id, fecha_adquisicion) values
(1, 1, '2020-01-01'),
(2, 2, '2020-01-01'),
(3, 1, '2020-01-01'),
(4, 2, '2020-01-01'),
(5, 1, '2020-01-01'),
(6, 2, '2020-01-01'),
(7, 1, '2020-01-01'),
(8, 2, '2020-01-01'),
(9, 1, '2020-01-01'),
(10, 2, '2020-01-01');

insert into ClientesTarjetas(cliente_id, tarjeta_id, fecha_adquisicion) values
(1, 1, '2020-01-01'),
(2, 2, '2020-01-01'),
(3, 3, '2020-01-01'),
(4, 4, '2020-01-01'),
(5, 5, '2020-01-01'),
(6, 6, '2020-01-01'),
(7, 7, '2020-01-01'),
(8, 8, '2020-01-01'),
(9, 9, '2020-01-01'),
(10, 10, '2020-01-01');

insert into ClientesPrestamos(cliente_id, prestamo_id, fecha_adquisicion) values
(1, 1, '2020-01-01'),
(2, 2, '2020-01-01'),
(3, 3, '2020-01-01'),
(4, 4, '2020-01-01'),
(5, 5, '2020-01-01'),
(6, 6, '2020-01-01'),
(7, 7, '2020-01-01'),
(8, 8, '2020-01-01'),
(9, 9, '2020-01-01'),
(10, 10, '2020-01-01');

insert into ClientesCuentas(cliente_id, cuenta_id, fecha_adquisicion) values
(1, 1, '2020-01-01'),
(2, 2, '2020-01-01'),
(3, 3, '2020-01-01'),
(4, 4, '2020-01-01'),
(5, 5, '2020-01-01'),
(6, 6, '2020-01-01'),
(7, 7, '2020-01-01'),
(8, 8, '2020-01-01'),
(9, 9, '2020-01-01'),
(10, 10, '2020-01-01');

insert into ClientesTransacciones(cliente_id, transaccion, fecha_adquisicion) values
(1, 1, '2020-01-01'),
(2, 2, '2020-01-01'),
(3, 3, '2020-01-01'),
(4, 4, '2020-01-01'),
(5, 5, '2020-01-01'),
(6, 6, '2020-01-01'),
(7, 7, '2020-01-01'),
(8, 8, '2020-01-01'),
(9, 9, '2020-01-01'),
(10, 10, '2020-01-01');