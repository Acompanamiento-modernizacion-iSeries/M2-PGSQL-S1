-- Tabla Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('Activo', 'Inactivo'))
);

-- Tabla Sucursales
CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    fecha_contratacion DATE,
    posicion VARCHAR(100),
    salario DECIMAL(10, 2),
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id)
);

-- Tabla Cuentas Bancarias
CREATE TABLE Cuentas_Bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('Corriente', 'Ahorro')),
    saldo DECIMAL(12, 2),
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('Activa', 'Cerrada'))
);

-- Tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('Deposito', 'Retiro', 'Transferencia')),
    monto DECIMAL(12, 2),
    fecha_transaccion TIMESTAMP,
    descripcion TEXT
);

-- Tabla Productos Financieros
CREATE TABLE Productos_Financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('Prestamo', 'Tarjeta de Credito', 'Seguro')),
    descripcion TEXT,
    tasa_interes DECIMAL(5, 2)
);

-- Tabla Préstamos
CREATE TABLE Prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    monto DECIMAL(12, 2),
    tasa_interes DECIMAL(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) CHECK (estado IN ('Activo', 'Pagado'))
);

-- Tabla Tarjetas de Crédito
CREATE TABLE Tarjetas_Credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES Cuentas_Bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE,
    limite_credito DECIMAL(12, 2),
    saldo_actual DECIMAL(12, 2),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('Activa', 'Bloqueada'))
);

-- Tabla Relación Clientes-Productos
CREATE TABLE Relacion_Clientes_Productos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES Productos_Financieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);