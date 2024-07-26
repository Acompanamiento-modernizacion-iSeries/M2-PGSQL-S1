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

create table Cuentas_bancarias(
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
    cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
    tipo_transaccion varchar(15) not null check (tipo_transaccion in ('depósito', 'retiro', 'transferencia')),
    monto numeric(10, 2) not null,
    fecha_transaccion timestamp not null,
    descripcion text
);

create table Sucursales(
    sucursal_id serial primary key,
    nombre varchar(100) not null,
    direccion varchar(100) not null,
    telefono varchar(20) not null
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
    salario numeric(10, 2) not null,
    sucursal_id int references Sucursales(sucursal_id) not null
);


create table Productos_financieros(
    producto_id serial primary key,
    nombre_producto varchar(100) not null,
    tipo_producto varchar(50) not null check (tipo_producto in ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion varchar(200) not null,
    tasa_interes numeric(5, 2) not null
);

create table Prestamos(
    prestamo_id serial primary key,
    cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
    monto numeric(10, 2) not null check (monto > 0),
    tasa_interes numeric(5, 2) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    estado varchar(10) not null check (estado in ('activo', 'pagado'))
);

create table Tarjetas_credito(
    tarjeta_id serial primary key,
    cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
    numero_tarjeta varchar(20) unique not null,
    limite_credito numeric(10, 2) not null check (limite_credito > 0),
    saldo_actual numeric(10, 2) not null check (saldo_actual >= 0),
    fecha_emision date not null,
    fecha_vencimiento date not null,
    estado varchar(10) not null check (estado in ('activa', 'bloqueada'))
);

create table Clientes_productos(
    cliente_id int references Clientes(cliente_id) not null,
    producto_id int references Productos_financieros(producto_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, producto_id)
);

create table Clientes_tarjetas(
    cliente_id int references Clientes(cliente_id) not null,
    tarjeta_id int references Tarjetas_credito(tarjeta_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, tarjeta_id)
);

create table Clientes_prestamos(
    cliente_id int references Clientes(cliente_id) not null,
    prestamo_id int references Prestamos(prestamo_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, prestamo_id)
);

create table Clientes_cuentas(
    cliente_id int references Clientes(cliente_id) not null,
    cuenta_id int references Cuentas_bancarias(cuenta_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, cuenta_id)
);

create table Clientes_transacciones(
    cliente_id int references Clientes(cliente_id) not null,
    transaccion_id int references Transacciones(transaccion_id) not null,
    fecha_adquisicion date not null,
    primary key (cliente_id, transaccion_id)
);

INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', '555-1234', 'juan.perez@example.com', '1980-01-15', 'activo'),
('Ana', 'Gómez', 'Avenida Siempreviva 742', '555-5678', 'ana.gomez@example.com', '1990-06-22', 'activo'),
('Luis', 'Martínez', 'Boulevard de los Sueños 101', '555-9101', 'luis.martinez@example.com', '1985-03-30', 'inactivo'),
('María', 'Rodríguez', 'Calle de la Luna 456', '555-1122', 'maria.rodriguez@example.com', '1995-11-05', 'activo');

INSERT INTO Cuentas_bancarias (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado) VALUES
(1, '1234567890', 'ahorro', 1000.00, '2020-01-01', 'activa'),
(2, '2345678901', 'corriente', 2000.00, '2021-02-02', 'activa'),
(3, '3456789012', 'ahorro', 3000.00, '2022-03-03', 'activa'),
(4, '4567890123', 'corriente', 4000.00, '2023-04-04', 'cerrada');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion) VALUES
(1, 'depósito', 500.00, '2023-01-01 10:00:00', 'Depósito inicial'),
(2, 'retiro', 200.00, '2023-02-01 11:00:00', 'Retiro en efectivo'),
(3, 'transferencia', 300.00, '2023-03-01 12:00:00', 'Transferencia a otra cuenta'),
(4, 'depósito', 400.00, '2023-04-01 13:00:00', 'Depósito adicional');

INSERT INTO Sucursales (nombre, direccion, telefono) VALUES
('Sucursal Centro', 'Calle Principal 123', '555-7788'),
('Sucursal Norte', 'Avenida del Norte 456', '555-8899'),
('Sucursal Sur', 'Boulevard del Sur 789', '555-9900'),
('Sucursal Este', 'Camino del Este 101', '555-0011');

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id) VALUES
('Carlos', 'Hernández', 'Calle del Sol 789', '555-3344', 'carlos.hernandez@example.com', '2020-05-15 08:00:00', 'Gerente', 50000.00, 1),
('Laura', 'Fernández', 'Avenida de las Flores 321', '555-4455', 'laura.fernandez@example.com', '2021-06-25 09:00:00', 'Cajero', 30000.00, 2),
('Pedro', 'González', 'Boulevard de los Reyes 654', '555-5566', 'pedro.gonzalez@example.com', '2022-07-10 10:00:00', 'Asesor', 40000.00, 3),
('Sofía', 'López', 'Callejón de los Milagros 987', '555-6677', 'sofia.lopez@example.com', '2023-08-20 11:00:00', 'Contador', 45000.00, 4);

INSERT INTO Productos_financieros (nombre_producto, tipo_producto, descripcion, tasa_interes) VALUES
('Préstamo Personal', 'prestamo', 'Préstamo a tasa fija', 5.00),
('Tarjeta de Crédito Oro', 'tarjeta de credito', 'Tarjeta con beneficios exclusivos', 15.00),
('Seguro de Vida', 'seguro', 'Cobertura completa de vida', 2.50),
('Préstamo Hipotecario', 'prestamo', 'Préstamo para vivienda', 3.50);

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado) VALUES
(1, 5000.00, 5.00, '2023-01-01', '2028-01-01', 'activo'),
(2, 10000.00, 5.50, '2023-02-01', '2028-02-01', 'activo'),
(3, 15000.00, 6.00, '2023-03-01', '2028-03-01', 'pagado'),
(4, 20000.00, 6.50, '2023-04-01', '2028-04-01', 'activo');

INSERT INTO Tarjetas_credito (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado) VALUES
(1, '1234123412341234', 5000.00, 1000.00, '2023-01-01', '2028-01-01', 'activa'),
(2, '2345234523452345', 10000.00, 2000.00, '2023-02-01', '2028-02-01', 'activa'),
(3, '3456345634563456', 15000.00, 3000.00, '2023-03-01', '2028-03-01', 'bloqueada'),
(4, '4567456745674567', 20000.00, 4000.00, '2023-04-01', '2028-04-01', 'activa');

INSERT INTO Clientes_productos (cliente_id, producto_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');

INSERT INTO Clientes_tarjetas (cliente_id, tarjeta_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');

INSERT INTO Clientes_prestamos (cliente_id, prestamo_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');

INSERT INTO Clientes_cuentas (cliente_id, cuenta_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');

INSERT INTO Clientes_transacciones (cliente_id, transaccion_id, fecha_adquisicion) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-01'),
(3, 3, '2023-03-01'),
(4, 4, '2023-04-01');









