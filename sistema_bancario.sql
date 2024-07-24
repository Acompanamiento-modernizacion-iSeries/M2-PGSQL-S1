create table Clientes(
  cliente_id serial primary key,
  nombre varchar(50) not null,
  apellido varchar(50) not null,
  direccion varchar(100) ,
  telefono varchar(20) ,
  correo_electronico  varchar(100) not null,
  fecha_nacimiento timestamp not null,
  estado varchar(8) not null check (estado in('ACTIVO', 'INACTIVO')) 
);

insert into  Clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
values('Andres', 'Garcia', 'Calle 49B # 20-01', '3017540958', 'abadom54@gmail.com', '1986-09-26', 'ACTIVO'),
('Camilo', 'Vergas', 'Calle 57A # 31-70', '3152345678', 'Camvergas@gmail.com', '1990-01-12', 'ACTIVO'),
('Sara',   'Pineda', 'Calle 10A # 43-10', '3145674532', 'SaraPin@gmail.com', '1994-07-15', 'ACTIVO'),
('Margarita', 'Corrales', 'Calle 50E # 40-67', '3218976545', 'Margara@gmail.com', '1954-09-22', 'ACTIVO');

select * from clientes;


create table Cuentas_bancarias(
	cuenta_id serial primary key,
	cliente_id int references Clientes(cliente_id) not null,
	numero_cuenta varchar(16) unique not null,
	tipo_cuenta varchar(9) not null check (tipo_cuenta in('CORRIENTE', 'AHORRO')) ,
	saldo numeric(15, 2) not null,
	fecha_apertura timestamp not null,
	estado varchar(8) not null check (estado in('ACTIVA', 'CERRADA')) 
);

insert into Cuentas_bancarias(cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura , estado )
values(1, '5676096743257680','AHORRO', 789000.00, '2021-02-20', 'ACTIVA'),
      (1, '1324987429543103','CORRIENTE', 10500000.00, '2022-10-02', 'ACTIVA'),
      (2, '9021754378219988','AHORRO', 5000000.00, '2018-06-30', 'ACTIVA'),
      (3, '4512700876254849','AHORRO', 7500000.00, '2011-05-11', 'ACTIVA'),
      (4, '4473928464638738','AHORRO', 80000000.00, '2001-08-21', 'ACTIVA');
	  
select * from Cuentas_bancarias;

create table Transacciones(
	transaccion_id serial primary key,
	cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
	tipo_transaccion varchar(13) not null check (tipo_transaccion in('DEPOSITO', 'RETIRO', 'TRANSFERENCIA')),
	monto numeric (15, 2) not null,
	fecha_transaccion timestamp not null,
	descripcion varchar(100) not null
);

insert into Transacciones(cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
values(1, 'TRANSFERENCIA', 150000.00, '2024-06-05', 'Tranferencia a la moza'),
      (1, 'TRANSFERENCIA', 500000.00, '2023-02-10', 'Tranferencia para las uñas de la esposa'),
	  (1, 'RETIRO', 2000000.00, '2024-07-24', 'retiro desde la bomba de irak' ),	  
	  (2, 'TRANSFERENCIA', 200000.00, '2024-06-05', 'Transferencia para cambio sexo'),
      (2, 'TRANSFERENCIA', 75000.00, '2023-02-10', 'Transferencia para comprar las arepas'),	  
	  (3, 'RETIRO', 450000.00, '2024-07-24', 'Retiro desde corresponsal bancario' ),
	  (3, 'TRANSFERENCIA', 100000.00, '2024-07-24', 'Transferencia pago motel los coches' ),	  
	  (4, 'RETIRO', 300000.00, '2024-07-24', 'Retiro desde cajero bello' ),
	  (4, 'TRANSFERENCIA', 250000.00, '2024-07-24', 'Transferencia del sugar' ),  
	  (5, 'RETIRO', 90000000.00, '2024-07-24', 'Retiro desde cualquier lugar del mundo' ),
	  (5, 'TRANSFERENCIA', 8000000.00, '2024-07-24', 'Transferencia al mozo travesti' );
	  
select * from Transacciones;


create table Sucursales(
	sucursal_id  serial primary key,
	nombre varchar(50) not null,
	direccion varchar(100) not null,
	telefono varchar(20) not null
);

insert into Sucursales(nombre, direccion, telefono)
values('Medellín-metrallo', 'Dirección prueba 01', '(604)9998890'),
      ('Medellín-popular',    'Dirección prueba 02', '(604)4447700'),
	  ('Bogotá-corferias',    'Dirección prueba 03', '(604)3430000'),
      ('Bogotá-rolo-city',    'Dirección prueba 04', '(604)8880000'),
	  ('Cali-salsera',        'Dirección prueba 05', '(604)7770000'),
      ('Cali-mi niño',        'Dirección prueba 06', '(604)9890000'),
	  ('Barranquilla-la monda ', 'Dirección prueba 09', '(604)9990000'),
      ('Pasto-primero en saber pro ', 'Dirección prueba 10', '(604)9890000');

select * from Sucursales;

create table Empleados(
	empleado_id  serial primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	direccion varchar(100),
	telefono  varchar(20),
	correo_electronico  varchar(100) not null,
	fecha_contratacion timestamp not null,
	posicion varchar(20) not null,
	salario numeric (15, 2) not null,
	sucursal_id int references Sucursales(sucursal_id) not null
);

insert into Empleados(nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion,
					 posicion, salario, sucursal_id) 
values('El morocho', 'sanchez',           'Dirección Empleado prueba 07', '3125465434', 'morocho@yaho.com', '2022-01-01',
	  'CAJERO', 2500000.00, 1),
      ('Lady ',      'yuyeimy',           'Dirección Empleado prueba 01', '3026665555', 'lafacil@gmail.com', '2019-02-02',
	  'DIRECCIONADOR', 2000000.00, 2),
      ('El flaco',   'Anorexico',         'Dirección Empleado prueba 02', '3159806766', 'vitamina@hotmail.com', '2028-07-07',
	  'GERENTE DE ZONA', 10000000.00, 3),
      ('Matalocas',  'Bigon',             'Dirección Empleado prueba 03', '3001007676', 'Dicaprio@gmail.com', '2010-10-10',
	  'ASESOR COMERCIAL', 7000000.00, 4),
      ('El loco',    'Vargas',            'Dirección Empleado prueba 04', '3017659867', 'reloco@hotmail.com', '2024-07-24',
	  'ASESOR COMERCIAL', 7000000.00, 5),
      ('La bendecida', 'Sejas postizas',  'Dirección Empleado prueba 05', '3148889090', '5hijos@gmail.com', '2021-09-09',
	  'CAJERO', 2500000.00, 6),
      ('El enano',   'Martinez',          'Dirección Empleado prueba 06', '3057655555', 'grandulon@gmail.com', '2020-08-08',
	  'DIRECCIONADOR', 2000000.00, 7);

select * from Empleados;

create table Productos_financieros(
	producto_id serial primary key,
	nombre_producto varchar(50) not null,
	tipo_producto varchar(20) not null check (tipo_producto in('PRESTAMO', 'TARJETA DE CREDITO', 'SEGURO')),
	descripcion varchar(200) not null,
	tasa_interes decimal(9, 5) not null
);

insert into Productos_financieros(nombre_producto, tipo_producto, descripcion, tasa_interes)
values('CREDITO HIPOTECARIO', 'PRESTAMO', 'CREDITO PARA VIVIENDA VIS', 7.10),
      ('CREDITO LIBRE INVERSION', 'PRESTAMO', 'CREDITO LIBRE INVERSION', 10.0),
      ('LEASING FINNACIERO', 'PRESTAMO', 'CREDITO PARA ACTIVOS DE MAQUINARIA', 10.0),
      ('ARRENDAMIENTO OPERATIVO', 'PRESTAMO', 'CREDITO ACTIVOS DE TECNOLOGIA', 8.5),
      ('LEASING HABITACIONAL', 'PRESTAMO', 'CREDITO PARA VIVIENDA NO VIS', 10.0),
	  ('SEGURO VEHICULOS', 'SEGURO', 'SEGUROS PARA ACTIVOS DE IMPORTACION', 0.0),
	  ('SEGURO INCENDIOS', 'SEGURO', 'SEGURO DE INCENDIOS PARA INMUEBLES', 0.0),
	  ('TARJETA CREDITO GOLD', 'TARJETA DE CREDITO', 'TARJETA DE CREDITO CON CUPO DE 50.000.000', 9.5);
	  
select * from Productos_financieros;

create table Prestamos(
	prestamo_id serial primary key,
	cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
	monto numeric(15,2) not null,
	tasa_interes decimal(9,5) not null,
	fecha_inicio timestamp not null,
	fecha_fin timestamp not null,
	estado varchar(6) not null check (estado in('ACTIVO', 'PAGADO'))
);

insert into Prestamos(cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado )
values(1, 50000000.00, 10.9, '2021-02-01', '2025-02-01', 'ACTIVO'),
      (2, 200000000.00, 11.0, '2021-05-10', '2023-05-10', 'PAGADO'),
      (3, 100000000.00, 10.0, '2020-06-30', '2025-06-30', 'ACTIVO'),
      (4, 30000000.00, 11.0, '2019-03-15', '2024-03-15', 'PAGADO'),
      (5, 140000000.00, 9.7, '2023-08-01', '2025-08-01', 'ACTIVO');
	  
select * from Prestamos;

create table tarjetas_credito(
	tarjeta_id serial primary key,
	cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
	numero_tarjeta varchar(20) unique not null,
	limite_credito numeric (15,2) not null,
	saldo_actual  numeric (15,2) not null,
	fecha_emision  timestamp not null,
	fecha_vencimiento  timestamp not null,
	estado varchar(10) not null check (estado in('ACTIVA', 'BLOQUEADA'))
);

insert into tarjetas_credito(cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, 
							 fecha_vencimiento, estado  )
values(1, '9865672598670098', 50000000.00, 45000000.00, '2023-01-20', '2025-01-20', 'ACTIVA'),
      (2, '0909765678942735', 30000000.00, 25000000.00, '2022-03-04', '2024-03-04', 'BLOQUEADA'),
	  (3, '7678953476895655', 40000000.00, 39000000.00, '2021-04-10', '2025-04-10', 'ACTIVA'),
	  (4, '8767097656780916', 30000000.00, 18000000.00, '2024-03-04', '2026-03-04', 'ACTIVA');

select * from tarjetas_credito;

create table Relacion_cliente_producto(
	cliente_id int references Clientes(cliente_id),
	producto_id int references Productos_financieros(producto_id),
	fecha_adquisicion  timestamp not null,
	primary key(cliente_id, producto_id)
);

insert into Relacion_cliente_producto values(1, 1, '2023-12-01' ), 
                                            (2, 5, '2024-01-20' ), 
											(3, 8, '2021-10-15' ),
											(4, 4, '2022-10-05' );
select * from Relacion_cliente_producto;






