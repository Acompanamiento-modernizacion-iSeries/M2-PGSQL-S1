
https://github.com/Acompanamiento-modernizacion-iSeries/M2-PGSQL-S1


CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	direccion VARCHAR(100),
	telefono VARCHAR(20),
	correo_electronico VARCHAR(200) unique NOT NULL,
	fecha_nacimiento TIMESTAMP,
	estado VARCHAR (8) NOT NULL CHECK (estado IN('activo','inactivo' ))
);
CREATE TABLE Cuentas (
	cuenta_id SERIAL PRIMARY KEY,	
	cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	numero_cuenta VARCHAR(12) unique NOT NULL,
	tipo_cuenta VARCHAR (10) NOT NULL CHECK (tipo_cuenta IN('ahorros','corriente','nomina', 'AFC' )),
	saldo INT NOT NULL,
	fecha_apertura TIMESTAMP,
	estado VARCHAR (8) NOT NULL CHECK (estado IN('activa','cerrada' ))
);
CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas(cuenta_id) NOT NULL,
	tipo_transaccion VARCHAR (20) NOT NULL CHECK (tipo_transaccion IN('Retiro','deposito','transferencia')),
	monto INTEGER NOT NULL CHECK (monto > 0), 
	fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	descripcion VARCHAR (500)
)
CREATE TABLE Sucursales (
	sucursal_id SERIAL PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (15) NOT NULL
)
CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL,
	apellido VARCHAR (50) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	telefono VARCHAR (15) NOT NULL,
	correo_electronico VARCHAR (100) NOT NULL,
	fecha_contratacion TIMESTAMP,
	posicion VARCHAR (50),
	salario INTEGER, 
	sucursal_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL
)


CREATE TABLE Productos (
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (100) NOT NULL,
	tipo_producto VARCHAR (20) NOT NULL CHECK (tipo_producto IN('Prestamo','tarjeta de credito','seguro')),
	descripcion VARCHAR (500),
	tasa_interes INTEGER NOT NULL
)

CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Sucursales(sucursal_id) NOT NULL,
	monto INTEGER NOT NULL,
	tasa_interes INTEGER NOT NULL,
	fecha_inicio TIMESTAMP,
	fecha_fin TIMESTAMP, 
	estado VARCHAR (20) NOT NULL CHECK (estado IN('activo','pagado'))
)

CREATE TABLE Tarjetas (
	tarjeta_id SERIAL PRIMARY KEY,
	cuenta_id INTEGER REFERENCES Cuentas(cuenta_id) NOT NULL,
	numero_tarjeta VARCHAR UNIQUE NOT NULL,
	limite_credito INTEGER NOT NULL,
	saldo_actual INTEGER NOT NULL,
	fecha_emision TIMESTAMP NOT NULL,
	fecha_vencimiento TIMESTAMP NOT NULL,
	estado VARCHAR (20) NOT NULL CHECK (estado IN('activa','bloqueada')),
)

CREATE TABLE Clientes_Productos (
	cliente_id INTEGER REFERENCES Clientes(cliente_id) NOT NULL,
	producto_id INTEGER REFERENCES Productos(producto_id) NOT NULL, 
	fecha_adquisicion TIMESTAMP
)


INSERT INTO Clientes (nombre, apellido, direccion, telefono, correo_electronico, fecha_nacimiento, estado)
VALUES 
    ('Juan', 'González', 'Calle Principal 123', '123-456-7890', 'juan.gonzalez@example.com', '1990-05-15', 'activo'),
    ('María', 'López', 'Av. Libertad 456', '234-567-8901', 'maria.lopez@example.com', '1985-08-22', 'activo'),
    ('Carlos', 'Martínez', 'Paseo del Sol 789', '345-678-9012', 'carlos.martinez@example.com', '1982-03-10', 'activo'),
    ('Ana', 'Rodríguez', 'Calle Mayor 321', '456-789-0123', 'ana.rodriguez@example.com', '1995-11-30', 'activo'),
    ('Pedro', 'Sánchez', 'Av. Central 654', '567-890-1234', 'pedro.sanchez@example.com', '1988-07-18', 'activo'),
    ('Laura', 'Gómez', 'Plaza España 987', '678-901-2345', 'laura.gomez@example.com', '1992-01-25', 'activo'),
    ('Javier', 'Díaz', 'Calle Estrella 741', '789-012-3456', 'javier.diaz@example.com', '1980-09-05', 'activo'),
    ('Sofía', 'Hernández', 'Paseo del Parque 852', '890-123-4567', 'sofia.hernandez@example.com', '1987-04-12', 'activo'),
    ('Daniel', 'Pérez', 'Av. del Mar 159', '901-234-5678', 'daniel.perez@example.com', '1993-06-20', 'activo'),
    ('Elena', 'Muñoz', 'Plaza Mayor 369', '012-345-6789', 'elena.munoz@example.com', '1984-12-08', 'activo');

INSERT INTO Cuentas (cliente_id, numero_cuenta, tipo_cuenta, saldo, fecha_apertura, estado)
VALUES
    (1, '1234567890', 'ahorros', 5000, '2023-01-15', 'activa'),
    (2, '2345678901', 'corriente', 8000, '2022-12-20', 'activa'),
    (3, '3456789012', 'nomina', 10000, '2023-02-28', 'activa'),
    (4, '4567890123', 'ahorros', 3000, '2023-03-10', 'activa'),
    (5, '5678901234', 'corriente', 12000, '2023-04-05', 'activa'),
    (6, '6789012345', 'nomina', 6000, '2023-05-15', 'activa'),
    (7, '7890123456', 'ahorros', 7000, '2023-06-20', 'activa'),
    (8, '8901234567', 'corriente', 15000, '2023-07-01', 'activa'),
    (9, '9012345678', 'nomina', 4000, '2023-08-12', 'activa'),
    (10, '0123456789', 'ahorros', 2000, '2023-09-25', 'activa');

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha_transaccion, descripcion)
VALUES
    (1, 'deposito', 1000, '2023-01-16', 'Depósito inicial'),
    (2, 'deposito', 1500, '2022-12-22', 'Depósito inicial'),
    (3, 'deposito', 2000, '2023-03-01', 'Depósito nómina'),
    (4, 'Retiro', 500, '2023-03-12', 'Retiro para gastos'),
    (5, 'deposito', 3000, '2023-04-08', 'Depósito de salario'),
    (6, 'Retiro', 1000, '2023-05-20', 'Retiro para compras'),
    (7, 'deposito', 1500, '2023-06-25', 'Depósito ahorros'),
    (8, 'Retiro', 2000, '2023-07-05', 'Retiro para emergencia'),
    (9, 'deposito', 800, '2023-08-15', 'Depósito nómina'),
    (10, 'Retiro', 500, '2023-09-30', 'Retiro para gastos personales');

INSERT INTO Sucursales (nombre, direccion, telefono)
VALUES
    ('Sucursal Central', 'Av. Principal 123', '123-456-7890'),
    ('Sucursal Norte', 'Av. Norte 456', '234-567-8901'),
    ('Sucursal Sur', 'Av. Sur 789', '345-678-9012'),
    ('Sucursal Este', 'Av. Este 321', '456-789-0123');

INSERT INTO Empleados (nombre, apellido, direccion, telefono, correo_electronico, fecha_contratacion, posicion, salario, sucursal_id)
VALUES
    ('Luis', 'Martínez', 'Calle Principal 789', '567-890-1234', 'luis.martinez@example.com', '2020-01-15', 'Cajero', 2500, 1),
    ('Ana', 'Gómez', 'Av. Libertad 159', '678-901-2345', 'ana.gomez@example.com', '2018-05-20', 'Gerente', 5000, 2),
    ('Juan', 'Pérez', 'Paseo del Sol 357', '789-012-3456', 'juan.perez@example.com', '2019-03-10', 'Asistente', 2000, 3),
    ('María', 'López', 'Plaza España 852', '890-123-4567', 'maria.lopez@example.com', '2021-07-05', 'Cajero', 2300, 4);

INSERT INTO Productos (nombre_producto, tipo_producto, descripcion, tasa_interes)
VALUES
    ('Préstamo Personal', 'Prestamo', 'Préstamo personal a tasa fija', 10),
    ('Tarjeta de Crédito Oro', 'tarjeta de credito', 'Tarjeta de crédito con beneficios premium', 15),
    ('Seguro de Vida', 'seguro', 'Seguro de vida con cobertura amplia', 5);

INSERT INTO Prestamos (cuenta_id, monto, tasa_interes, fecha_inicio, fecha_fin, estado)
VALUES
    (1, 5000, 10, '2023-01-15', '2023-12-15', 'activo'),
    (3, 8000, 8, '2023-02-28', '2023-12-28', 'activo'),
    (4, 10000, 12, '2023-04-05', '2024-04-05', 'activo');

INSERT INTO Tarjetas (cuenta_id, numero_tarjeta, limite_credito, saldo_actual, fecha_emision, fecha_vencimiento, estado)
VALUES
    (2, '1234567890123456', 5000, 0, '2022-12-20', '2025-12-20', 'activa'),
    (4, '2345678901234567', 8000, 0, '2023-03-10', '2026-03-10', 'activa'),
    (6, '3456789012345678', 10000, 0, '2023-05-15', '2026-05-15', 'activa');

INSERT INTO Clientes_Productos (cliente_id, producto_id, fecha_adquisicion)
VALUES
    (11, 1, '2023-01-16'),
    (12, 2, '2022-12-22'),
    (13, 3, '2023-03-01'),
    (14, 1, '2023-03-12'),
    (15, 2, '2023-04-08'),
    (16, 3, '2023-04-08')




