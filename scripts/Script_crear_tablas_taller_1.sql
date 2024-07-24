-- Tabla Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(10) CHECK (estado IN ('activo', 'inactivo'))
);

-- Tabla Cuentas Bancarias
CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(10) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo NUMERIC(15, 2) DEFAULT 0,
    fecha_apertura DATE NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('activa', 'cerrada'))
);

-- Tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(15) CHECK (tipo_transaccion IN ('deposito', 'retiro', 'transferencia')),
    monto NUMERIC(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR (200) NOT NULL
);

-- Tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    posicion VARCHAR(50),
    salario NUMERIC(15, 2),
    sucursal_id INT REFERENCES Sucursales(sucursal_id)
);

-- Tabla Productos Financieros
CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    tipo_producto VARCHAR(20) CHECK (tipo_producto IN ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion VARCHAR (200) NOT NULL,
    tasa_interes NUMERIC(5, 2)
);

-- Tabla Préstamos
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    monto NUMERIC(15, 2) NOT NULL,
    tasa_interes NUMERIC(5, 2),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(10) CHECK (estado IN ('activo', 'pagado'))
);

-- Tabla Tarjetas de Crédito
CREATE TABLE Tarjetas_De_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INT REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE NOT NULL,
    limite_credito NUMERIC(15, 2),
    saldo_actual NUMERIC(15, 2) DEFAULT 0,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('activa', 'bloqueada'))
);

-- Tabla Relación Clientes-Productos
CREATE TABLE Relacion_Clientes_Productos (
    cliente_id INT REFERENCES Clientes(cliente_id),
    producto_id INT REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE NOT NULL,
    PRIMARY KEY (cliente_id, producto_id)
);

ALTER TABLE Cuentas_Bancarias 
ADD COLUMN empleado_id INT REFERENCES Empleados (empleado_id) NOT NULL;