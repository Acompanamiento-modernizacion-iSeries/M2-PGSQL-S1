CREATE TABLE Clientes(
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Cuentas_bancarias(
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id  INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta VARCHAR (50) UNIQUE NOT NULL,
	tipo_cuenta VARCHAR (20) NOT NULL,
	saldo DECIMAL (15,2),
	fecha_apertura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Transacciones(
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	tipo_transaccion VARCHAR (20) NOT NULL,
	monto DECIMAL (15,2) NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	descripcion VARCHAR(2000)
);

CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (20)
);

CREATE TABLE Empleados(
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	posicion VARCHAR (50) NOT NULL,
	salario DECIMAL (15,2) NOT NULL,
	sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
);

CREATE TABLE Productos_financieros(
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (50) NOT NULL,
	tipo_producto VARCHAR (20) NOT NULL,
	descripcion VARCHAR (2000),
	tasa_interes INT NOT NULL
);

CREATE TABLE Prestamos(
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	monto DECIMAL (15,2) NOT NULL,
    tasa_interes INT NOT NULL,
	fecha_inicio TIMESTAMP NOT NULL,
	fecha_fin TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE TarjetasCredito(
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	numero_tarjeta INT NOT NULL UNIQUE,
	limite_credito DECIMAL (15,2) NOT NULL,
	saldo_actual DECIMAL (15,2) NOT NULL,
	fecha_emision TIMESTAMP NOT NULL,
	fecha_vencimiento TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Relacion_clientes_productos(
	cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	producto_id INTEGER REFERENCES Productos_financieros(producto_id) NOT NULL,
	fecha_adquisicion TIMESTAMP NOT NULL
);

INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('JHOHAN', 'ARGAEZ', 'KR1', '1234567890', 'JA@GMAIL.COM', '1990-01-01');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('DAVID', 'ARGAEZ', 'KR2', '1234567890', 'DA@GMAIL.COM', '1991-02-02');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('JHOHAN', 'MORENO', 'KR3', '1234567890', 'JM@GMAIL.COM', '1992-03-03');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('DAVID', 'MORENO', 'KR3', '1234567890', 'DM@GMAIL.COM', '1993-04-04');
	
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (1, '12345678901', 'corriente', '10.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (2, '12345678902', 'ahorro', '15.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (3, '12345678903', 'corriente', '20.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (4, '12345678904', 'ahorro', '30.00', CURRENT_TIMESTAMP);
	
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (1, 'depósito', '5.00', CURRENT_TIMESTAMP, 'Descripción transacción 1');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (2, 'retiro', '4.00', CURRENT_TIMESTAMP, 'Descripción transacción 2');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (3, 'transferencia', '3.00', CURRENT_TIMESTAMP, 'Descripción transacción 3');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (4, 'depósito', '9.00', CURRENT_TIMESTAMP, 'Descripción transacción 4');
	
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal A', 'Calle Principal 1', '1234567');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal B', 'Calle Principal 2', '1234568');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal C', 'Calle Principal 3', '1234569');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal D', 'Calle Principal 4', '1234560');
	
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan', 'Perez', 'Calle Principal 1', '1234567', 'juan.perez@gmail.com', 'Gerente de Ventas', 50000.00, 1);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan2', 'Perez2', 'Calle Principal 2', '1234568', 'juan2.perez2@gmail.com', 'Asistente Administrativo', 30000.00, 2);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan3', 'Perez3', 'Calle Principal 3', '1234569', 'juan3.perez3@gmail.com', 'Director de Operaciones', 70000.00, 3);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, corrCREATE TABLE Clientes(
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	fecha_nacimiento TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Cuentas_bancarias(
	cuenta_id SERIAL PRIMARY KEY,
	cliente_id  INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta VARCHAR (50) UNIQUE NOT NULL,
	tipo_cuenta VARCHAR (20) NOT NULL,
	saldo DECIMAL (15,2),
	fecha_apertura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Transacciones(
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	tipo_transaccion VARCHAR (20) NOT NULL,
	monto DECIMAL (15,2) NOT NULL,
	fecha_transaccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	descripcion VARCHAR(2000)
);

CREATE TABLE Sucursales(
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (20)
);

CREATE TABLE Empleados(
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100),
	telefono VARCHAR (20),
	correo_electronico VARCHAR (200) UNIQUE NOT NULL,
	posicion VARCHAR (50) NOT NULL,
	salario DECIMAL (15,2) NOT NULL,
	sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
);

CREATE TABLE Productos_financieros(
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (50) NOT NULL,
	tipo_producto VARCHAR (20) NOT NULL,
	descripcion VARCHAR (2000),
	tasa_interes INT NOT NULL
);

CREATE TABLE Prestamos(
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	monto DECIMAL (15,2) NOT NULL,
    tasa_interes INT NOT NULL,
	fecha_inicio TIMESTAMP NOT NULL,
	fecha_fin TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE TarjetasCredito(
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas_bancarias(cuenta_id) NOT NULL,
	numero_tarjeta INT NOT NULL UNIQUE,
	limite_credito DECIMAL (15,2) NOT NULL,
	saldo_actual DECIMAL (15,2) NOT NULL,
	fecha_emision TIMESTAMP NOT NULL,
	fecha_vencimiento TIMESTAMP NOT NULL,
	estado VARCHAR(10) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE Relacion_clientes_productos(
	cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	producto_id INTEGER REFERENCES Productos_financieros(producto_id) NOT NULL,
	fecha_adquisicion TIMESTAMP NOT NULL
);

INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('JHOHAN', 'ARGAEZ', 'KR1', '1234567890', 'JA@GMAIL.COM', '1990-01-01');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('DAVID', 'ARGAEZ', 'KR2', '1234567890', 'DA@GMAIL.COM', '1991-02-02');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('JHOHAN', 'MORENO', 'KR3', '1234567890', 'JM@GMAIL.COM', '1992-03-03');
INSERT INTO public.clientes(nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento)
	VALUES ('DAVID', 'MORENO', 'KR3', '1234567890', 'DM@GMAIL.COM', '1993-04-04');
	
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (1, '12345678901', 'corriente', '10.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (2, '12345678902', 'ahorro', '15.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (3, '12345678903', 'corriente', '20.00', CURRENT_TIMESTAMP);
INSERT INTO public.cuentas_bancarias(
	cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura)
	VALUES (4, '12345678904', 'ahorro', '30.00', CURRENT_TIMESTAMP);
	
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (1, 'depósito', '5.00', CURRENT_TIMESTAMP, 'Descripción transacción 1');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (2, 'retiro', '4.00', CURRENT_TIMESTAMP, 'Descripción transacción 2');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (3, 'transferencia', '3.00', CURRENT_TIMESTAMP, 'Descripción transacción 3');
INSERT INTO public.transacciones(
	cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
	VALUES (4, 'depósito', '9.00', CURRENT_TIMESTAMP, 'Descripción transacción 4');
	
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal A', 'Calle Principal 1', '1234567');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal B', 'Calle Principal 2', '1234568');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal C', 'Calle Principal 3', '1234569');
INSERT INTO public.Sucursales(
	nombre, direccion, telefono)
	VALUES ('Sucursal D', 'Calle Principal 4', '1234560');
	
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan', 'Perez', 'Calle Principal 1', '1234567', 'juan.perez@gmail.com', 'Gerente de Ventas', 50000.00, 1);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan2', 'Perez2', 'Calle Principal 2', '1234568', 'juan2.perez2@gmail.com', 'Asistente Administrativo', 30000.00, 2);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan3', 'Perez3', 'Calle Principal 3', '1234569', 'juan3.perez3@gmail.com', 'Director de Operaciones', 70000.00, 3);
INSERT INTO public.Empleados(
	nombre, apellido, direccion, telefono, correo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan4', 'Perez4', 'Calle Principal 4', '1234567', 'juan4.pere4z@gmail.com', 'Recepcionista', 10000.00, 1);

INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Libre inversión', 'préstamo', 'Préstamo con intereses mensuales', 3);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Visa', 'tarjeta de crédito', 'Tarjeta de crédito con intereses mensuales', 30);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Seguro de vida', 'seguro', 'Seguro anual', 5);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Libre inversión', 'préstamo', 'Préstamo con intereses mensuales', 4);
eo_electronico, posicion, salario, sucursal_id)
	VALUES ('Juan4', 'Perez4', 'Calle Principal 4', '1234567', 'juan4.pere4z@gmail.com', 'Recepcionista', 10000.00, 1);

INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Libre inversión', 'préstamo', 'Préstamo con intereses mensuales', 3);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Visa', 'tarjeta de crédito', 'Tarjeta de crédito con intereses mensuales', 30);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Seguro de vida', 'seguro', 'Seguro anual', 5);
INSERT INTO public.Productos_financieros(
	nombre_producto, tipo_producto, descripcion, tasa_interes)
	VALUES ('Libre inversión', 'préstamo', 'Préstamo con intereses mensuales', 4);

INSERT INTO public.Prestamos(
	cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin)
	VALUES (1, 150.00, 12, '2024-07-01', '2024-07-31');
INSERT INTO public.Prestamos(
	cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin)
	VALUES (2, 100.00, 12, '2024-08-01', '2024-08-30');
INSERT INTO public.Prestamos(
	cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin)
	VALUES (3, 90.00, 10, '2024-07-05', '2024-08-05');
INSERT INTO public.Prestamos(
	cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin)
	VALUES (4, 200.00, 9, '2024-08-01', '2024-08-30');

INSERT INTO public.TarjetasCredito(
	cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento)
	VALUES (1, 12345678, 5000.00, 0.00, '2024-07-01', '2028-07-01');
INSERT INTO public.TarjetasCredito(
	cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento)
	VALUES (2, 98765432, 8000.00, 0.00, '2024-07-01', '2028-07-01');
INSERT INTO public.TarjetasCredito(
	cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento)
	VALUES (3, 11112222, 3000.00, 0.00, '2024-07-01', '2028-07-01');
INSERT INTO public.TarjetasCredito(
	cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento)
	VALUES (4, 55556666, 1000.00, 0.00, '2024-07-01', '2028-07-01');
	
INSERT INTO public.Relacion_clientes_productos(
	cliente_id, producto_id, fecha_adquisicion)
	VALUES (1, 1, '2024-07-01');
INSERT INTO public.Relacion_clientes_productos(
	cliente_id, producto_id, fecha_adquisicion)
	VALUES (2, 2, '2024-06-01');
INSERT INTO public.Relacion_clientes_productos(
	cliente_id, producto_id, fecha_adquisicion)
	VALUES (3, 3, '2024-05-01');
INSERT INTO public.Relacion_clientes_productos(
	cliente_id, producto_id, fecha_adquisicion)
	VALUES (4, 4, '2024-04-01');