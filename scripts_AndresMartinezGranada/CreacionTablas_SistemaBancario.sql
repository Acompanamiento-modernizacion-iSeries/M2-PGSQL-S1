CREATE TABLE Clientes (
	cliente_id SERIAL PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(8) CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE Cuentas_Bancarias (
	cuenta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(15) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(9) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo NUMERIC(15, 2) DEFAULT 0,
    fecha_apertura DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(7) CHECK (estado IN ('activa', 'cerrada'))
);

CREATE TABLE Transacciones (
	transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(13) CHECK (tipo_transaccion IN ('deposito', 'retiro', 'transferencia')),
    monto NUMERIC(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR (200) NOT NULL
);

CREATE TABLE Sucursales (
	sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(30) 
);

CREATE TABLE Empleados (
	empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50) UNIQUE NOT NULL,
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    posicion VARCHAR(50),
    salario NUMERIC(15, 2),
    sucursal_id INT REFERENCES Sucursales(sucursal_id)
);

CREATE TABLE Productos_Financieros (
	producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    tipo_producto VARCHAR(20) CHECK (tipo_producto IN ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion VARCHAR (200) NOT NULL,
    tasa_interes NUMERIC(4, 2)
);

CREATE TABLE Prestamos (
	prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    monto NUMERIC(15, 2) NOT NULL,
    tasa_interes NUMERIC(4, 2),
    fecha_inicio DATE DEFAULT CURRENT_DATE,
    fecha_fin DATE,
    estado VARCHAR(6) CHECK (estado IN ('activo', 'pagado'))
);

CREATE TABLE Tarjetas_Credito (
	tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito NUMERIC(15, 2),
    saldo_actual NUMERIC(15, 2) DEFAULT 0,
    fecha_emision DATE DEFAULT CURRENT_DATE,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(9) CHECK (estado IN ('activa', 'bloqueada'))
);

CREATE TABLE Relacion_Clientes_Productos (
	cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE, PRIMARY KEY (cliente_id, producto_id)
);